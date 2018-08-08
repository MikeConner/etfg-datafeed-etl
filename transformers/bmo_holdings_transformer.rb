# frozen_string_literal: true

class BmoHoldingsTransformer
  include DataFormatter

  def initialize(target_date:)
    @target_date = target_date
  end

  def process(row)
    new_row = {}
    new_row[:ticker] = row['Ticker']
    new_row[:instrument_type] = row['InstrumentType']
    new_row[:name] = row['Name']
    new_row[:sedol] = cleanup_data(row['SEDOL'])
    new_row[:cusip] = cleanup_data(row['CUSIP'])
    new_row[:security_id] = cleanup_data(row['SecurityID'])
    new_row[:quantity_per_paramount] = row['Quantity/ParAmount']
    new_row[:etfg_date] = Date.parse(@target_date)
    new_row
  end
end
