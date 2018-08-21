# frozen_string_literal: true

class BmoHoldingsTransformer
  include DataFormatter

  def initialize(target_date:)
    @target_date = target_date
  end

  def process(row)
    row = convert_dash_to_nil(row)
    new_row = {
      ticker: row['Ticker'],
      instrument_type: row['InstrumentType'],
      name: row['Name'],
      sedol: cleanup_data(row['SEDOL']),
      cusip: cleanup_data(row['CUSIP']),
      security_id: cleanup_data(row['SecurityID']),
      quantity_per_paramount: row['Quantity/ParAmount'],
      etfg_date: Date.parse(@target_date)
    }
  end
end
