# frozen_string_literal: true

RSpec.describe BarclaysCalendarLetnsEodTransformer do
  it 'transforms calendar letns eod files correctly' do
    calendar_letns_filepath = File.join(
      File.dirname(__FILE__), '../fixtures/barclays/CALENDAR_LETNs_EOD_20180726.test.csv'
    )
    rows = []
    control = Kiba.parse do
      source CSVSource, calendar_letns_filepath, headers: true, skip_blanks: true
      transform BarclaysCalendarLetnsEodTransformer, target_date: '20180726'
      transform do |row|
        rows << row
      end
    end

    Kiba.run(control)

    expect(rows.size).to eq 5

    expect(rows.first[:cusip]).to eq '06740P874'
    expect(rows.first[:isin]).to eq 'US06740P8749'
    expect(rows.first[:ticker]).to eq 'EMLBF'
    expect(rows.first[:date]).to eq Date.new(2018,7,26)
    expect(rows.first[:indicative_value].to_f).to eq 126.9397
    expect(rows.first[:etfg_date]).to eq Date.new(2018,7,26)

    expect(rows.last[:cusip]).to eq '06740P601'
    expect(rows.last[:isin]).to eq 'US06740P6016'
    expect(rows.last[:ticker]).to eq 'SFLAF'
    expect(rows.last[:date]).to eq Date.new(2018,7,26)
    expect(rows.last[:indicative_value].to_f).to eq 306.1824
    expect(rows.last[:etfg_date]).to eq Date.new(2018,7,26)
  end
end