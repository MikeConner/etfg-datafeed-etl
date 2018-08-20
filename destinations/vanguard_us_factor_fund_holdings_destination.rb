# frozen_string_literal: true

class VanguardUsFactorFundHoldingsDestination
  def initialize(connect_url)
    @conn = PG.connect(connect_url)
    @conn.prepare('insert_pg_stmt',
      'INSERT INTO feed.vanguard_us_factor_fund_holdings (
        fund_ticker, fund_name, fund_id, as_of_date, asset_type, holding_name,
        ticker, isin, percent_of_fund, market_value, shares, etfg_date)
      VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12);')
  end

  def write(row)
    @conn.exec_prepared('insert_pg_stmt',
      [
        row[:fund_ticker],
        row[:fund_name],
        row[:fund_id],
        row[:as_of_date],
        row[:asset_type],
        row[:holding_name],
        row[:ticker],
        row[:isin],
        row[:percent_of_fund],
        row[:market_value],
        row[:shares],
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
