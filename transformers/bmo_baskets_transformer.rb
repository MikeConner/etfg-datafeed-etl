# frozen_string_literal: true

class BmoBasketsTransformer
  def initialize(target_date:)
    @target_date = target_date
  end

  def process(row)
    new_row = {
      fund_ticker: row[0],
      fund_account_number: row[1],
      fund_name: row[2],
      units_outstanding: row[3],
      nav: row[4],
      project_cash_amount: row[5],
      dist_price_adj: row[6],
      fx_rate: row[7],
      mer: row[8],
      prescribed_number_of_units: row[9],
      caf: row[10],
      name: row[11],
      ticker: row[12],
      shares_per_basket: row[13],
      price: row[14],
      number_of_shares: row[15],
      sedol: row[16],
      etfg_date: Date.parse(@target_date)
    }
  end
end
