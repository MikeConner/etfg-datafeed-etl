# frozen_string_literal: true

RSpec.describe BmoBasketsSource do
  it 'gets data from baskets files correctly' do
    baskets_file_path = File.join(
      File.dirname(__FILE__), '../fixtures/bmo/baskets.20180725.test.csv'
    )
    rows = []
    control = Kiba.parse do
      source BmoBasketsSource, baskets_file_path
      transform do |row|
        rows << row
      end
    end

    Kiba.run(control)

    expect(rows.size).to eq 10

    # NOTE: The first row is a fund with holdings data
    fund_ticker, fund_account_number, holdings_name, holdings_ticker =
      rows.first.values_at(0, 1, 11, 12)
    expect(fund_ticker).to eq('BANK')
    expect(fund_account_number).to eq('JH291')
    expect(holdings_name).to eq('REGIONS FINANCIAL CORP')
    expect(holdings_ticker).to eq('RF US')

    # NOTE: The last row is a fund with *no* holdings data
    fund_ticker, fund_account_number, holdings_name, holdings_ticker =
      rows.last.values_at(0, 1, 11, 12)
    expect(fund_ticker).to eq('ZTS.U')
    expect(fund_account_number).to eq('JH285')
    expect(holdings_name).to be_nil
    expect(holdings_ticker).to be_nil
  end
end
