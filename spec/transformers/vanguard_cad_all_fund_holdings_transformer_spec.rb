# frozen_string_literal: true

RSpec.describe VanguardCadAllFundHoldingsTransformer do
  it 'gets data from all fund holdings file correctly' do
    all_fund_holdings_filepath = File.join(
      File.dirname(__FILE__), '../fixtures/vanguard_cad/All_Fund_Holding_20180726.test.csv'
    )
    rows = []
    control = Kiba.parse do
      source VanguardCadAllFundHoldingsSource, all_fund_holdings_filepath
      transform VanguardCadAllFundHoldingsTransformer, target_date: '20180726'
      transform do |row|
        rows << row
      end
    end

    Kiba.run(control)

    expect(rows.size).to eq 50

    # First row contain single maturity_date
    first_row = rows.first
    expect(first_row[:fund_ticker]).to eq 'VA'
    expect(first_row[:fund_name]).to eq 'FTSE Developed Asia Pacific All Cap Index ETF'
    expect(first_row[:as_of_date]).to eq Date.new(2018, 6, 30)
    expect(first_row[:holding_name]).to eq 'Samsung Electronics Co. Ltd.'
    expect(first_row[:maturity_date_start]).to eq Date.new(2019, 10, 1)
    expect(first_row[:maturity_date_end]).to eq Date.new(2019, 10, 1)
    expect(first_row[:etfg_date]).to eq Date.new(2018,7,26)

    # Second row contain range of maturity_date
    second_row = rows[1]
    expect(second_row[:fund_ticker]).to eq 'VA'
    expect(second_row[:fund_name]).to eq 'FTSE Developed Asia Pacific All Cap Index ETF'
    expect(second_row[:as_of_date]).to eq Date.new(2018, 6, 30)
    expect(second_row[:holding_name]).to eq 'Toyota Motor Corp.'
    expect(second_row[:maturity_date_start]).to eq Date.new(2023, 9, 15)
    expect(second_row[:maturity_date_end]).to eq Date.new(2040, 9, 20)
    expect(second_row[:etfg_date]).to eq Date.new(2018,7,26)

    last_row = rows.last
    expect(last_row[:fund_ticker]).to eq 'VVO'
    expect(last_row[:fund_name]).to eq 'Global Minimum Volatility ETF'
    expect(last_row[:as_of_date]).to eq Date.new(2018, 3, 31)
    expect(last_row[:maturity_date_start]).to be_blank
    expect(last_row[:maturity_date_end]).to be_blank
    expect(last_row[:holding_name]).to eq 'Other'
  end
end
