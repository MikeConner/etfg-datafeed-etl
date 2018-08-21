# frozen_string_literal: true

RSpec.describe VanguardCadFiEtfnavTransformer do
  it 'transforms holdings files correctly' do
    fi_etfnav_filepath = File.join(
      File.dirname(__FILE__), '../fixtures/vanguard_cad/FI_ETFNAV_20180726.test.csv'
    )
    rows = []
    control = Kiba.parse do
      source CSVSource, fi_etfnav_filepath, headers: true
      transform VanguardCadFiEtfnavTransformer, target_date: '20180726'
      transform do |row|
        rows << row
      end
    end

    Kiba.run(control)

    expect(rows.size).to eq 16

    expect(rows.first[:ticker]).to eq 'VAB'
    expect(rows.first[:isin]).to eq 'CA92203E1016'
    expect(rows.first[:sedol]).to eq 'B6QHK17'
    expect(rows.first[:cusip]).to be_blank
    expect(rows.first[:basket_type]).to eq 'Redeem'
    expect(rows.first[:trade_date]).to eq Date.new(2018,7,26)
    expect(rows.first[:nav].to_f).to eq 24.8191
    expect(rows.first[:actualcash].to_f).to eq 52121.63
    expect(rows.first[:etfg_date]).to eq Date.new(2018,7,26)

    expect(rows.last[:ticker]).to eq 'VSG'
    expect(rows.last[:isin]).to eq 'CA92207Y1034'
    expect(rows.last[:sedol]).to eq 'BD8KRS9'
    expect(rows.last[:cusip]).to be_blank
    expect(rows.last[:basket_type]).to eq 'Create'
    expect(rows.last[:trade_date]).to eq Date.new(2018,7,26)
    expect(rows.last[:nav].to_f).to eq 24.2109
    expect(rows.last[:actualcash].to_f).to eq 16019.18
    expect(rows.last[:etfg_date]).to eq Date.new(2018,7,26)
  end
end
