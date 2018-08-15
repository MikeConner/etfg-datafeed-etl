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
end
