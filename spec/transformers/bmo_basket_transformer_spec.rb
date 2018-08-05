# frozen_string_literal: true

RSpec.describe BmoBasketTransformer do
  it 'transforms basket files correctly' do
    basket_file_path = File.join(
      File.dirname(__FILE__), '../fixtures/bmo/baskets.20180725.test.csv'
    )
    rows = BmoBasketTransformer.(basket_file_path)
    expect(rows.size).to eq 10
    # NOTE: The first row is a fund with holdings data
    first_row = rows.first
    expect(first_row.etfg_date).to eq Date.new(2018,7,25)
    expect(first_row.fund_ticker).to eq('BANK')
    expect(first_row.fund_account_number).to eq('JH291')
    expect(first_row.ticker).to eq('RF US')
    # NOTE: The last row is a fund with *no* holdings data
    last_row = rows.last
    expect(last_row.fund_ticker).to eq('ZTS.U')
    expect(last_row.ticker).to be_nil
  end
end
