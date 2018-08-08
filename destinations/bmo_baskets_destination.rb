# frozen_string_literal: true

class BmoBasketsDestination
  def initialize(connect_url)
    @conn = PG.connect(connect_url)
    @conn.prepare('insert_pg_stmt',
      'INSERT INTO bmo_baskets(
        fund_ticker, fund_account_number, fund_name,
        units_outstanding, nav, project_cash_amount, dist_price_adj, fx_rate,
        mer, prescribed_number_of_units, caf, name, ticker, shares_per_basket,
        price, number_of_shares, sedol, etfg_date)
      VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9,
              $10, $11, $12, $13, $14, $15, $16, $17, $18);')
  end

  def write(row)
    @conn.exec_prepared('insert_pg_stmt',
      [
        row[:fund_ticker],
        row[:fund_account_number],
        row[:fund_name],
        row[:units_outstanding],
        row[:nav],
        row[:project_cash_amount],
        row[:dist_price_adj],
        row[:fx_rate],
        row[:mer],
        row[:prescribed_number_of_units],
        row[:caf],
        row[:name],
        row[:ticker],
        row[:shares_per_basket],
        row[:price],
        row[:number_of_shares],
        row[:sedol],
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
