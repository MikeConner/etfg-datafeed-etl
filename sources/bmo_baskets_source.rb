# frozen_string_literal: true

class BmoBasketsSource
  def initialize(file)
    @file = file
  end

  def each
    CSV.foreach(@file, encoding:'iso-8859-1:utf-8') do |row|
      next if row[0].nil?

      if row[0] == 'Ticker'
        yield(@common_row) if @common_row && !@has_holdings_info
        @common_row = nil
        @common_row_is_next = true
        @has_holdings_info = false
        next
      end

      if @common_row_is_next
        @common_row = row
        @common_row_is_next = false
        next
      end

      if row[0] == 'Name' && row[1] == 'Ticker'
        @has_holdings_info = true
        next
      elsif @common_row && !@has_holdings_info
        yield(@common_row)
      end

      if row[0] =~ /^(Open Currency|Basket|All information|By accessing|In no event)/
        @common_row = nil
        next
      end

      yield(@common_row + row) if @common_row
    end
  end
end
