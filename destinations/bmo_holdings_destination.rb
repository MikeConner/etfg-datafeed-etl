# frozen_string_literal: true

class BmoHoldingsDestination
  def initialize(connect_url)
    @conn = PG.connect(connect_url)
    @conn.prepare('insert_pg_stmt',
      'INSERT INTO bmo_daily_holdings(
        ticker, instrument_type, name, sedol, cusip,
        security_id, quantity_per_paramount, etfg_date)
      VALUES ($1, $2, $3, $4, $5, $6, $7, $8);')
  end

  def write(row)
    @conn.exec_prepared('insert_pg_stmt',
      [
        row[:ticker],
        row[:instrument_type],
        row[:name],
        row[:sedol],
        row[:cusip],
        row[:security_id],
        row[:quantity_per_paramount],
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
