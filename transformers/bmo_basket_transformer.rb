# frozen_string_literal: true

class BmoBasketTransformer
  attr_accessor :current_common_row,
                :common_row_was_used,
                :common_row_is_next,
                :file_path,
                :row_extraction_active,
                :rows

  BMO_BASKET_ROW = Struct.new(
    :etfg_date,
    :fund_ticker,
    :fund_account_number,
    :fund_name,
    :unit_outstanding,
    :nav,
    :proj_cash_amount,
    :dist_price_adj,
    :fx_rate,
    :mer,
    :prescribed_number_of_units,
    :caf,
    :name,
    :ticker,
    :shares_per_basket,
    :price,
    :number_of_shares,
    :sedol
  )

  def self.call(file_path)
    new(file_path).run
  end

  def initialize(file_path)
    @rows = []
    @file_path = file_path
  end

  def run
    CSV.foreach(file_path, encoding:'iso-8859-1:utf-8') do |row|
      set_current_common_row(row)
      extract_row(row)
    end
    extract_unused_common_row

    rows.map { |r| transform_row(r) }
  end

  private

  def set_current_common_row(row)
    # The word 'Ticker' in the first column indicates the next row in the csv
    # will be shared among subsequent rows of data.
    if row[0] == 'Ticker'
      self.common_row_is_next = true
      return
    end

    return unless common_row_is_next

    extract_unused_common_row
    self.current_common_row = row
    self.common_row_is_next = false
  end

  def extract_row(row)
    return if activate_row_extraction(row)
    return if deactivate_row_extraction(row)
    return unless row_extraction_active
    full_row = current_common_row.dup.concat(row)
    # Remove trailing nil values
    full_row.pop until full_row.last
    rows.push(full_row)
    self.common_row_was_used = true
  end

  def activate_row_extraction(row)
    return if row_extraction_active
    # The word 'Name' and 'Ticker' in the first and second columns respectively
    # indicate the next row in the csv will contain rows that should be
    # extracted and combined with the current common row.
    self.row_extraction_active = row[0] == 'Name' && row[1] == 'Ticker'
  end

  def deactivate_row_extraction(row)
    return unless row_extraction_active
    return unless row[0].blank?
    self.row_extraction_active = false
  end

  def extract_unused_common_row
    return unless current_common_row

    if common_row_was_used
      self.common_row_was_used = false
      return
    end
    rows.push(current_common_row.dup)
  end

  def transform_row(row)
    BMO_BASKET_ROW.new(file_date, *row)
  end

  def file_date
    @file_date ||= Date.iso8601(file_path[/baskets\.(\d{8})\./, 1])
  end
end
