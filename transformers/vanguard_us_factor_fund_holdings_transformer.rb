# frozen_string_literal: true

class VanguardUsFactorFundHoldingsTransformer
  include DataFormatter

  def initialize(target_date:)
    @target_date = target_date
  end

  def process(row)
    row = convert_dash_to_nil(row)
    new_row = {
      fund_ticker: row[0],
      fund_name: row[1],
      fund_id: row[2],
      as_of_date: Date.strptime(row[3], '%d-%b-%Y'),
      asset_type: row[4],
      holding_name: row[5],
      ticker: row[6],
      isin: row[7],
      percent_of_fund: row[8],
      market_value: row[9],
      shares: row[10],
      etfg_date: Date.parse(@target_date)
    }
  end
end
