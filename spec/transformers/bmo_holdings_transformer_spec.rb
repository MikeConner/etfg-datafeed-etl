# frozen_string_literal: true

RSpec.describe BmoHoldingsTransformer do
  it 'transforms holdings files correctly' do
    holdings_filepath = File.join(
      File.dirname(__FILE__), '../fixtures/bmo/ETFDailyHoldings-20180725.test.csv'
    )
    rows = []
    control = Kiba.parse do
      source CSVSource, holdings_filepath, headers: true, liberal_parsing: true
      transform BmoHoldingsTransformer, target_date: '20180725'
      transform do |row|
        rows << row
      end
    end

    Kiba.run(control)

    expect(rows.size).to eq 29

    expect(rows.first[:ticker]).to eq 'BANK'
    expect(rows.first[:instrument_type]).to eq 'Equity'
    expect(rows.first[:name]).to eq 'AOZORA BANK LTD'
    expect(rows.first[:sedol]).to eq 'B1G1854'
    expect(rows.first[:cusip]).to be_blank
    expect(rows.first[:security_id]).to eq '8304 JP'
    expect(rows.first[:quantity_per_paramount]).to eq '200'
    expect(rows.first[:etfg_date]).to eq Date.new(2018,7,25)

    expect(rows.last[:ticker]).to eq 'BANK'
    expect(rows.last[:instrument_type]).to eq 'Equity'
    expect(rows.last[:name]).to eq 'BAWAG GROUP AG'
    expect(rows.last[:sedol]).to eq 'BZ1GZ06'
    expect(rows.last[:cusip]).to be_blank
    expect(rows.last[:security_id]).to eq 'BG AV'
    expect(rows.last[:quantity_per_paramount]).to eq '90'
    expect(rows.last[:etfg_date]).to eq Date.new(2018,7,25)
  end
end
