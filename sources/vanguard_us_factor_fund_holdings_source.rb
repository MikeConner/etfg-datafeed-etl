# frozen_string_literal: true

class VanguardUsFactorFundHoldingsSource
  COMMON_ROW_LABELS = [
    'TICKER',
    'FUND NAME',
    'Fund Id',
    'As of date'
  ].freeze

  def initialize(file)
    @file = file
  end

  def each
    # From this csv, we will get error 'Unquoted fields do not allow \r or \n'
    # when using simple CSV.foreach, we have to replace \r before parsing
    csv_text = File.read(@file).delete("\r")
    CSV.parse(csv_text) do |row|
      next if row.blank?

      # Reset fund information when find new one or footer text
      if row[0] == 'TICKER' || row[0] =~ /^(The information)/
        @common_row = []
        @has_holdings_info = false
      end

      if COMMON_ROW_LABELS.include?(row[0])
        @common_row << row[1]
        next
      end

      if row[1] == 'Asset type' && row[2] == 'Holding name'
        @has_holdings_info = true
        next
      end

      if @common_row && @has_holdings_info
        row.shift
        yield(@common_row + row)
      end
    end
  end
end
