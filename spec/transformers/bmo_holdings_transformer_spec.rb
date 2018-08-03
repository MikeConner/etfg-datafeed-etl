# frozen_string_literal: true

RSpec.describe BmoHoldingsTransformer do
  def get_data_from_csv(file)
    rows = []
    CSV.foreach(file, headers: true, liberal_parsing: true) do |row|
      rows << row.to_hash
    end
    rows
  end

  it 'transforms holdings files correctly' do
    holdings_file_path = File.join(
      File.dirname(__FILE__), '../fixtures/bmo/ETFDailyHoldings-20180725.test.csv'
    )
    bmo_holdings = BmoHoldingsTransformer.new(target_date: '20180725')
    rows = get_data_from_csv(holdings_file_path)

    first_new_row = bmo_holdings.process(rows.first)
    expect(first_new_row[:ticker]).to eq 'BANK'
    expect(first_new_row[:instrument_type]).to eq 'Equity'
    expect(first_new_row[:name]).to eq 'AOZORA BANK LTD'
    expect(first_new_row[:sedol]).to eq 'B1G1854'
    expect(first_new_row[:cusip]).to be_blank
    expect(first_new_row[:security_id]).to eq '8304 JP'
    expect(first_new_row[:quantity_per_paramount]).to eq '200'
    expect(first_new_row[:etfg_date]).to eq Date.new(2018,7,25)

    last_new_row = bmo_holdings.process(rows.last)
    expect(last_new_row[:ticker]).to eq 'BANK'
    expect(last_new_row[:instrument_type]).to eq 'Equity'
    expect(last_new_row[:name]).to eq 'BAWAG GROUP AG'
    expect(last_new_row[:sedol]).to eq 'BZ1GZ06'
    expect(last_new_row[:cusip]).to be_blank
    expect(last_new_row[:security_id]).to eq 'BG AV'
    expect(last_new_row[:quantity_per_paramount]).to eq '90'
    expect(last_new_row[:etfg_date]).to eq Date.new(2018,7,25)
  end
end
