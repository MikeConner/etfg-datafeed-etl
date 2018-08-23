# frozen_string_literal: true

class BarclaysEtnsEodDestination
  def initialize(connect_url)
    @conn = PG.connect(connect_url)
    @conn.prepare('insert_pg_stmt',
      'INSERT INTO feed.barclays_etns_eod(
        cusip, isin, ticker, date, name, indicative_value, shares_outstanding,
        index_value, coupon, market_capitalization, etfg_date)
      VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11);')
  end

  def write(row)
    @conn.exec_prepared('insert_pg_stmt',
      [
        row[:cusip],
        row[:isin],
        row[:ticker],
        row[:date],
        row[:name],
        row[:indicative_value],
        row[:shares_outstanding],
        row[:index_value],
        row[:coupon],
        row[:market_capitalization],
        row[:etfg_date]
      ]
    )
  rescue PG::Error => ex
    puts ex.message
  end

  def close
    @conn.close
    @conn = nil
  end
end
