# frozen_string_literal: true

RSpec.describe VanguardUsEtfnavTransformer do
  it 'transforms holdings files correctly' do
    etfnav_filepath = File.join(
      File.dirname(__FILE__), '../fixtures/vanguard/ETFNAV_20180726.test.csv'
    )
    rows = []
    control = Kiba.parse do
      source CSVSource, etfnav_filepath, headers: true
      transform VanguardUsEtfnavTransformer, target_date: '20180726'
      transform do |row|
        rows << row
      end
    end

    Kiba.run(control)

    expect(rows.size).to eq 10

    expect(rows.first[:ticker]).to eq 'IVOG'
    expect(rows.first[:isin]).to be_blank
    expect(rows.first[:sedol]).to be_blank
    expect(rows.first[:cusip]).to eq '921932869'
    expect(rows.first[:trade_date]).to eq Date.new(2018,7,26)
    expect(rows.first[:nav].to_f).to eq 142.57
    expect(rows.first[:actualcash].to_f).to eq 735.23
    expect(rows.first[:etfg_date]).to eq Date.new(2018,7,26)

    expect(rows.last[:ticker]).to eq 'VBR'
    expect(rows.last[:isin]).to be_blank
    expect(rows.last[:sedol]).to be_blank
    expect(rows.last[:cusip]).to eq '922908611'
    expect(rows.last[:trade_date]).to eq Date.new(2018,7,26)
    expect(rows.last[:nav].to_f).to eq 139.62
    expect(rows.last[:actualcash].to_f).to eq 382.75
    expect(rows.last[:etfg_date]).to eq Date.new(2018,7,26)
  end
end
