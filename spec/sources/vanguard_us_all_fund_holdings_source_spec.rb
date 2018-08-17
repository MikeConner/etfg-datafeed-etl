# frozen_string_literal: true

RSpec.describe VanguardUsAllFundHoldingsSource do
  it 'gets data from all fund holdings file correctly' do
    all_fund_holdings_filepath = File.join(
      File.dirname(__FILE__), '../fixtures/vanguard/All_Fund_Holding_20180726.test.csv'
    )
    rows = []
    control = Kiba.parse do
      source VanguardUsAllFundHoldingsSource, all_fund_holdings_filepath
      transform do |row|
        rows << row
      end
    end

    Kiba.run(control)

    expect(rows.size).to eq 15

    fund_ticker, fund_name, as_of_date, asset_type, holding_name =
      rows.first.values_at(0, 1, 3, 11, 12)
    expect(fund_ticker).to eq 'VNQ'
    expect(fund_name).to eq 'Real Estate ETF'
    expect(as_of_date).to eq '30-Jun-2018'
    expect(asset_type).to eq 'EQUITY'
    expect(holding_name).to eq 'Community Healthcare Trust Inc.'

    fund_ticker, fund_name, as_of_date, asset_type, holding_name =
      rows.last.values_at(0, 1, 3, 11, 12)
    expect(fund_ticker).to eq 'VWOB'
    expect(fund_name).to eq 'Em Mkt Gov Bond ETF'
    expect(as_of_date).to eq '30-Jun-2018'
    expect(asset_type).to eq 'DEBT'
    expect(holding_name).to eq 'State of Qatar'
  end
end
