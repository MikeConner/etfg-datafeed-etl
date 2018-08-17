# frozen_string_literal: true

class VanguardUsAllFundHoldingsSource
  COMMON_ROW_LABELS = [
    'TICKER',
    'FUND NAME',
    'Fund Id',
    'As of date',
    'Equity holdings count',
    'Bond holdings count',
    'Short term reserve count',
    'Listed currency',
    'Listed currency symbol',
    'Fund currency',
    'Fund currency symbol'
  ].freeze

  def initialize(file)
    @file = file
  end

  def each
    CSV.foreach(@file) do |row|
      next if row.blank?

      # Reset fund information when find new one or footer text
      if row[0] == 'TICKER' || row[0] =~ /^(Your|CGS)/
        @common_row = []
        @has_holdings_info = false
      end

      if COMMON_ROW_LABELS.include?(row[0])
        @common_row << row[1]
        next
      end

      if row[1] == 'Asset type' && row[2] == 'Holding name'
        @has_holdings_info = true
        next
      end

      if @common_row && @has_holdings_info
        row.shift
        yield(@common_row + row)
      end
    end
  end
end
