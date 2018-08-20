# frozen_string_literal: true

RSpec.describe VanguardUsFiEtfnavTransformer do
  it 'transforms holdings files correctly' do
    fi_etfnav_filepath = File.join(
      File.dirname(__FILE__), '../fixtures/vanguard/FI_ETFNAV_20180726.test.csv'
    )
    rows = []
    control = Kiba.parse do
      source CSVSource, fi_etfnav_filepath, headers: true
      transform VanguardUsFiEtfnavTransformer, target_date: '20180726'
      transform do |row|
        rows << row
      end
    end

    Kiba.run(control)

    expect(rows.size).to eq 10

    expect(rows.first[:ticker]).to eq 'BIV'
    expect(rows.first[:isin]).to be_blank
    expect(rows.first[:sedol]).to be_blank
    expect(rows.first[:cusip]).to eq '921937819'
    expect(rows.first[:basket_type]).to eq 'Create/Redeem'
    expect(rows.first[:trade_date]).to eq Date.new(2018,7,26)
    expect(rows.first[:nav].to_f).to eq 80.62
    expect(rows.first[:actualcash].to_f).to eq 28035.32
    expect(rows.first[:etfg_date]).to eq Date.new(2018,7,26)

    expect(rows.last[:ticker]).to eq 'VCLT'
    expect(rows.last[:isin]).to be_blank
    expect(rows.last[:sedol]).to be_blank
    expect(rows.last[:cusip]).to eq '92206C813'
    expect(rows.last[:basket_type]).to eq 'Create/Redeem'
    expect(rows.last[:trade_date]).to eq Date.new(2018,7,26)
    expect(rows.last[:nav].to_f).to eq 88.12
    expect(rows.last[:actualcash].to_f).to eq 65307.2
    expect(rows.last[:etfg_date]).to eq Date.new(2018,7,26)
  end
end
