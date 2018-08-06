# frozen_string_literal: true

class BmoBasketsDestination
  def initialize(connect_url)
    @conn = PG.connect(connect_url)
    @conn.prepare('insert_pg_stmt',
      'INSERT INTO bmo_baskets(
        etfg_date, fund_ticker, fund_account_number, fund_name,
        units_outstanding, nav, project_cash_amount, dist_price_adj, fx_rate,
        mer, prescribed_number_of_units, caf, name, ticker, shares_per_basket,
        price, number_of_shares, sedol)
      VALUES ($1, $2, $3, $4, $5, $6, $7, $8);')
  end

  def write(row)
    @conn.exec_prepared('insert_pg_stmt', row)
  rescue PG::Error => ex
    puts ex.message
  end

  def close
    @conn.close
    @conn = nil
  end
end
