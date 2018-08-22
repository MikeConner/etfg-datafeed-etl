# frozen_string_literal: true

RSpec.describe BarclaysLetnsEodTransformer do
  it 'transforms letns eod files correctly' do
    letns_eod_filepath = File.join(
      File.dirname(__FILE__), '../fixtures/barclays/LETNs_EOD_20180726.test.csv'
    )
    rows = []
    control = Kiba.parse do
      source CSVSource, letns_eod_filepath, headers: true, skip_blanks: true
      transform BarclaysLetnsEodTransformer, target_date: '20180726'
      transform do |row|
        rows << row
      end
    end

    Kiba.run(control)

    expect(rows.size).to eq 5

    expect(rows.first[:cusip]).to eq '06746Q256'
    expect(rows.first[:isin]).to eq 'US06746Q2562'
    expect(rows.first[:ticker]).to eq 'FFEU'
    expect(rows.first[:date]).to eq Date.new(2018, 7, 26)
    expect(rows.first[:indicative_value].to_f).to eq 101.4816
    expect(rows.first[:rebalancing_trigger_level].to_f).to eq 1286.4172
    expect(rows.first[:termination_trigger_level].to_f).to eq 1125.6151
    expect(rows.first[:monthly_factor]).to be_nil
    expect(rows.first[:etfg_date]).to eq Date.new(2018, 7, 26)

    expect(rows.last[:cusip]).to eq '06742W570'
    expect(rows.last[:isin]).to eq 'US06742W5702'
    expect(rows.last[:ticker]).to eq 'TAPR'
    expect(rows.last[:date]).to eq Date.new(2018, 7, 26)
    expect(rows.last[:indicative_value].to_f).to eq 27.8138
    expect(rows.last[:rebalancing_trigger_level]).to be_nil
    expect(rows.last[:termination_trigger_level]).to be_nil
    expect(rows.last[:monthly_factor].to_f).to eq 0.008582363
    expect(rows.last[:etfg_date]).to eq Date.new(2018, 7, 26)
  end
end
