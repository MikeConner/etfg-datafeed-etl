# frozen_string_literal: true

class VanguardUsAllFundHoldingsTransformer
  include DataFormatter

  def initialize(target_date:)
    @target_date = target_date
  end

  def process(row)
    row = convert_dash_to_nil(row)
    maturity_date_start, maturity_date_end = manipulate_maturity_date(row[24])
    new_row = {
      fund_ticker: row[0],
      fund_name: row[1],
      fund_id: row[2],
      as_of_date: Date.strptime(row[3], '%d-%b-%Y'),
      equity_holdings_count: row[4],
      bond_holdings_count: row[5],
      short_term_reserve_count: row[6],
      listed_currency: row[7],
      listed_currency_symbol: row[8],
      fund_currency: row[9],
      fund_currency_symbol: row[10],
      asset_type: row[11],
      holding_name: row[12],
      ticker: row[13],
      cusip: row[14],
      sedol: row[15],
      isin: row[16],
      percent_of_fund: row[17],
      sector: row[18],
      country: row[19],
      security_depository_receipt_type: row[20],
      market_value: row[21],
      face_amount: row[22],
      coupon_rate: row[23],
      maturity_date_start: maturity_date_start,
      maturity_date_end: maturity_date_end,
      shares: row[25],
      currency_code: row[26],
      currency_symbol: row[27],
      etfg_date: Date.parse(@target_date)
    }
  end
end
