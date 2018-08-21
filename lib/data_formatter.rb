# frozen_string_literal: true

module DataFormatter
  def cleanup_data(data)
    data.match?(/=\"(.*)\"/) ? data.match(/=\"(.*)\"/)[1] : data
  end

  # Change dash(-) to nil before save into database
  def convert_dash_to_nil(row)
    if row.is_a?(Array)
      row.map! {|e| e == '-' ? nil : e }
    elsif row.is_a?(Hash)
      row.transform_values! {|v| v == '-' ? nil : v }
    end
  end

  # Correct date format to date object
  def manipulate_maturity_date(maturity_date)
    return [nil, nil] if maturity_date.blank?
    date_start, date_end = maturity_date.split(' - ')
    if date_end.nil?
      return [Date.strptime(date_start, '%d-%b-%Y'),
              Date.strptime(date_start, '%d-%b-%Y')]
    end
    [Date.strptime(date_start, '%d-%b-%Y'), Date.strptime(date_end, '%d-%b-%Y')]
  end
end
