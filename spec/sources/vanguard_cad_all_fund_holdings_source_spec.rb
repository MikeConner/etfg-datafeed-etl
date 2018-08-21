# frozen_string_literal: true

RSpec.describe VanguardCadAllFundHoldingsSource do
  it 'gets data from all fund holdings file correctly' do
    all_fund_holdings_filepath = File.join(
      File.dirname(__FILE__), '../fixtures/vanguard_cad/All_Fund_Holding_20180726.test.csv'
    )
    rows = []
    control = Kiba.parse do
      source VanguardCadAllFundHoldingsSource, all_fund_holdings_filepath
      transform do |row|
        rows << row
      end
    end

    Kiba.run(control)

    expect(rows.size).to eq 50

    fund_ticker, fund_name, as_of_date, holding_name =
      rows.first.values_at(0, 1, 3, 12)
    expect(fund_ticker).to eq 'VA'
    expect(fund_name).to eq 'FTSE Developed Asia Pacific All Cap Index ETF'
    expect(as_of_date).to eq '30-Jun-2018'
    expect(holding_name).to eq 'Samsung Electronics Co. Ltd.'

    fund_ticker, fund_name, as_of_date, holding_name =
      rows.last.values_at(0, 1, 3, 12)
    expect(fund_ticker).to eq 'VVO'
    expect(fund_name).to eq 'Global Minimum Volatility ETF'
    expect(as_of_date).to eq '31-Mar-2018'
    expect(holding_name).to eq 'Other'
  end
end
