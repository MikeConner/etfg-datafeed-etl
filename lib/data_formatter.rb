# frozen_string_literal: true

module DataFormatter
  def cleanup_data(data)
    data.match?(/=\"(.*)\"/) ? data.match(/=\"(.*)\"/)[1] : data
  end
end
