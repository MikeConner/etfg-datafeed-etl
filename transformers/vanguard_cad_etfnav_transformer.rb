# frozen_string_literal: true

class VanguardCadEtfnavTransformer
  include DataFormatter

  def initialize(target_date:)
    @target_date = target_date
  end

  def process(row)
    return if row['NAV'].blank?
    row = convert_dash_to_nil(row)
    new_row = {
      ticker: row['TICKER'],
      isin: row['ISIN'],
      sedol: row['SEDOL'],
      cusip: row['CUSIP'],
      description: row['Description'],
      trade_date: Date.strptime(row['Trade Date'], '%m/%d/%Y'),
      nav: row['NAV'],
      status: row['Status'],
      shares_in_creation_units: row['Shares in Creation Units'],
      application_value: row['Application Value'],
      sum_of_market_value: row['Sum Of Market Value'],
      actualcash: row['Actual Cash'],
      etfg_date: Date.parse(@target_date)
    }
  end
end
