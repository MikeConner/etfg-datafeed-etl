# frozen_string_literal: true

RSpec.describe VanguardUsFactorFundHoldingsSource do
  it 'gets data from factor fund holdings file correctly' do
    factor_fund_holdings_filepath = File.join(
      File.dirname(__FILE__), '../fixtures/vanguard/Factor_Fund_Holdings_20180726.test.csv'
    )
    rows = []
    control = Kiba.parse do
      source VanguardUsFactorFundHoldingsSource, factor_fund_holdings_filepath
      transform do |row|
        rows << row
      end
    end

    Kiba.run(control)

    expect(rows.size).to eq 3849

    fund_ticker, fund_name, as_of_date, asset_type, holding_name =
      rows.first.values_at(0, 1, 3, 4, 5)
    expect(fund_ticker).to eq 'VFLQ'
    expect(fund_name).to eq 'US Liquidity Factor ETF'
    expect(as_of_date).to eq '25-Jul-2018'
    expect(asset_type).to eq 'EQUITY'
    expect(holding_name).to eq 'MOODY\'S CORP'

    fund_ticker, fund_name, as_of_date, asset_type, holding_name =
      rows.last.values_at(0, 1, 3, 4, 5)
    expect(fund_ticker).to eq 'VFVA'
    expect(fund_name).to eq 'US Value Factor ETF'
    expect(as_of_date).to eq '25-Jul-2018'
    expect(asset_type).to eq 'EQUITY'
    expect(holding_name).to eq 'COMTECH TELECOMMUNICATIONS'
  end
end
