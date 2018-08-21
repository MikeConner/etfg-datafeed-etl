# frozen_string_literal: true

RSpec.describe BarclaysEtnsEodTransformer do
  it 'transforms etns eod files correctly' do
    etns_eod_filepath = File.join(
      File.dirname(__FILE__), '../fixtures/barclays/ETNs_EOD_20180726.test.csv'
    )
    rows = []
    control = Kiba.parse do
      source CSVSource, etns_eod_filepath, headers: true, skip_blanks: true
      transform BarclaysEtnsEodTransformer, target_date: '20180726'
      transform do |row|
        rows << row
      end
    end

    Kiba.run(control)

    expect(rows.size).to eq 10

    expect(rows.first[:cusip]).to eq '06738C778'
    expect(rows.first[:isin]).to eq 'US06738C7781'
    expect(rows.first[:ticker]).to eq 'DJP'
    expect(rows.first[:date]).to eq Date.new(2018,7,26)
    expect(rows.first[:indicative_value].to_f).to eq 23.615
    expect(rows.first[:etfg_date]).to eq Date.new(2018,7,26)

    expect(rows.last[:cusip]).to eq '06739F184'
    expect(rows.last[:isin]).to eq 'GB00B1WPBD95'
    expect(rows.last[:ticker]).to eq 'EROTF'
    expect(rows.last[:date]).to eq Date.new(2018,7,26)
    expect(rows.last[:indicative_value].to_f).to eq 42.9404
    expect(rows.last[:etfg_date]).to eq Date.new(2018,7,26)
  end
end
