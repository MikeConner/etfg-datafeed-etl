# frozen_string_literal: true

class VanguardCadEtfnavDestination
  def initialize(connect_url)
    @conn = PG.connect(connect_url)
    @conn.prepare('insert_pg_stmt',
      'INSERT INTO vanguard_cad_etfnav (
        ticker, isin, sedol, cusip, description, trade_date,
        nav, status, shares_in_creation_units, application_value,
        sum_of_market_value, actualcash, etfg_date)
      VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13);')
  end

  def write(row)
    @conn.exec_prepared('insert_pg_stmt',
      [
        row[:ticker],
        row[:isin],
        row[:sedol],
        row[:cusip],
        row[:description],
        row[:trade_date],
        row[:nav],
        row[:status],
        row[:shares_in_creation_units],
        row[:application_value],
        row[:sum_of_market_value],
        row[:actualcash],
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