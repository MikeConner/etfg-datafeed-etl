# frozen_string_literal: true

RSpec.describe VanguardUsAllFundHoldingsTransformer do
  it 'gets data from all fund holdings file correctly' do
    all_fund_holdings_filepath = File.join(
      File.dirname(__FILE__), '../fixtures/vanguard/All_Fund_Holding_20180726.test.csv'
    )
    rows = []
    control = Kiba.parse do
      source VanguardUsAllFundHoldingsSource, all_fund_holdings_filepath
      transform VanguardUsAllFundHoldingsTransformer, target_date: '20180726'
      transform do |row|
        rows << row
      end
    end

    Kiba.run(control)

    expect(rows.size).to eq 15

    first_row = rows.first
    expect(first_row[:fund_ticker]).to eq 'VNQ'
    expect(first_row[:fund_name]).to eq 'Real Estate ETF'
    expect(first_row[:as_of_date]).to eq Date.new(2018, 6, 30)
    expect(first_row[:holding_name]).to eq 'Community Healthcare Trust Inc.'
    expect(first_row[:maturity_date_start]).to be_nil
    expect(first_row[:maturity_date_end]).to be_nil
    expect(first_row[:etfg_date]).to eq Date.new(2018,7,26)

    second_row = rows[1]
    expect(first_row[:fund_ticker]).to eq 'VNQ'
    expect(first_row[:fund_name]).to eq 'Real Estate ETF'
    expect(first_row[:as_of_date]).to eq Date.new(2018, 6, 30)
    expect(second_row[:holding_name]).to eq 'Winthrop Realty Trust'
    expect(second_row[:maturity_date_start]).to eq Date.new(2018, 11, 15)
    expect(second_row[:maturity_date_end]).to eq Date.new(2045, 11, 15)
    expect(second_row[:etfg_date]).to eq Date.new(2018,7,26)

    last_row = rows.last
    expect(last_row[:fund_ticker]).to eq 'VWOB'
    expect(last_row[:fund_name]).to eq 'Em Mkt Gov Bond ETF'
    expect(last_row[:as_of_date]).to eq Date.new(2018, 6, 30)
    expect(last_row[:holding_name]).to eq 'State of Qatar'
    expect(last_row[:maturity_date_start]).to eq Date.new(2048, 4, 23)
    expect(last_row[:maturity_date_end]).to eq Date.new(2048, 4, 23)
  end
end
