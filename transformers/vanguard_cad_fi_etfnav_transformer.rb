# frozen_string_literal: true

class VanguardCadFiEtfnavTransformer
  include DataFormatter

  def initialize(target_date:)
    @target_date = target_date
  end

  def process(row)
    return if row['NAV'].blank?
    new_row = {
      ticker: row['TICKER'],
      isin: row['ISIN'],
      sedol: row['SEDOL'],
      cusip: (row['CUSIP'] == '-') ? nil : row['CUSIP'],
      description: row['Description'],
      basket_type: row['Basket Type'],
      trade_date: Date.strptime(row['Trade Date'], '%m/%d/%Y'),
      nav: row['NAV'],
      status: row['Status'],
      shares_in_creation_units: row['Shares in Creation Units'],
      application_value: row['Application Value'],
      sum_of_market_value: row['Sum Of Market Value'],
      actualcash: row['ActualCash'],
      etfg_date: Date.parse(@target_date)
    }
  end
end
