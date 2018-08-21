# frozen_string_literal: true

class BarclaysEtnsEodTransformer
  def initialize(target_date:)
    @target_date = target_date
  end

  def process(row)
    new_row = {
      cusip: row['Cusip'],
      isin: row['ISIN'],
      ticker: row['Ticker'],
      date: Date.strptime(row['Date'], '%m/%d/%Y'),
      name: row['Name'],
      indicative_value: row['Indicative Value'],
      shares_outstanding: row['Shares Outstanding'],
      index_value: row['Index Value'],
      coupon: row['Coupon'],
      market_capitalization: row['Market Capitalization'],
      etfg_date: Date.parse(@target_date)
    }
  end
end
