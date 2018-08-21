# frozen_string_literal: true

class BarclaysCalendarLetnsEodTransformer
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
      closing_participation: row['Closing Participation'],
      closing_note_financing_level: row['Closing Note Financing Level'],
      closing_note_t_bills_amount: row['Closing Note T-Bills Amount'],
      closing_note_index_exposure: row['Closing Note Index Exposure'],
      next_closing_note_financing_level: row['Next Closing Note Financing Level'],
      next_closing_note_t_bills_amount: row['Next Closing Note T-Bills Amount'],
      equity_allocation: row['Equity Allocation'],
      vol_allocation: row['Vol Allocation'],
      short_vxx_shares: row['Short VXX Shares'],
      vxx_closing_nav: row['VXX Closing NAV'],
      accrued_fees: row['Accrued Fees'],
      accrued_interest: row['Accrued Interest'],
      etfg_date: Date.parse(@target_date)
    }
  end
end