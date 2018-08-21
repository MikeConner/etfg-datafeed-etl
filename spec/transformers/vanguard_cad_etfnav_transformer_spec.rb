# frozen_string_literal: true

RSpec.describe VanguardCadEtfnavTransformer do
  it 'transforms holdings files correctly' do
    etfnav_filepath = File.join(
      File.dirname(__FILE__), '../fixtures/vanguard_cad/ETFNAV_20180726.test.csv'
    )
    rows = []
    control = Kiba.parse do
      source CSVSource, etfnav_filepath, headers: true
      transform VanguardCadEtfnavTransformer, target_date: '20180726'
      transform do |row|
        rows << row
      end
    end

    Kiba.run(control)

    expect(rows.size).to eq 24

    expect(rows.first[:ticker]).to eq 'VA'
    expect(rows.first[:isin]).to eq 'CA92206N1087'
    expect(rows.first[:sedol]).to eq 'BYXJBV9'
    expect(rows.first[:cusip]).to be_blank
    expect(rows.first[:trade_date]).to eq Date.new(2018,7,26)
    expect(rows.first[:nav].to_f).to eq 35.1823
    expect(rows.first[:actualcash].to_f).to eq 5943.18
    expect(rows.first[:etfg_date]).to eq Date.new(2018,7,26)

    expect(rows.last[:ticker]).to eq 'VXC'
    expect(rows.last[:isin]).to eq 'CA92206Q1019'
    expect(rows.last[:sedol]).to eq 'BYXJBW0'
    expect(rows.last[:cusip]).to be_blank
    expect(rows.last[:trade_date]).to eq Date.new(2018,7,26)
    expect(rows.last[:nav].to_f).to eq 37.6878
    expect(rows.last[:actualcash].to_f).to eq 241.66
    expect(rows.last[:etfg_date]).to eq Date.new(2018,7,26)
  end
end
