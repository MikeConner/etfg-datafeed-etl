# frozen_string_literal: true

class VanguardCadAllFundHoldingsDestination
  def initialize(connect_url)
    @conn = PG.connect(connect_url)
    @conn.prepare('insert_pg_stmt',
      'INSERT INTO feed.vanguard_cad_all_fund_holdings (
        fund_ticker, fund_name, fund_id, as_of_date, equity_holdings_count,
        bond_holdings_count, short_term_reserve_count, listed_currency,
        listed_currency_symbol, fund_currency, fund_currency_symbol,
        asset_type, holding_name, ticker, cusip, sedol, isin, percent_of_fund,
        sector, country, security_depository_receipt_type, market_value,
        face_amount, coupon_rate, maturity_date_start, maturity_date_end,
        shares, currency_code, currency_symbol, etfg_date)
      VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15,
        $16, $17, $18, $19, $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $30);')
  end

  def write(row)
    @conn.exec_prepared('insert_pg_stmt',
      [
        row[:fund_ticker],
        row[:fund_name],
        row[:fund_id],
        row[:as_of_date],
        row[:equity_holdings_count],
        row[:bond_holdings_count],
        row[:short_term_reserve_count],
        row[:listed_currency],
        row[:listed_currency_symbol],
        row[:fund_currency],
        row[:fund_currency_symbol],
        row[:asset_type],
        row[:holding_name],
        row[:ticker],
        row[:cusip],
        row[:sedol],
        row[:isin],
        row[:percent_of_fund],
        row[:sector],
        row[:country],
        row[:security_depository_receipt_type],
        row[:market_value],
        row[:face_amount],
        row[:coupon_rate],
        row[:maturity_date_start],
        row[:maturity_date_end],
        row[:shares],
        row[:currency_code],
        row[:currency_symbol],
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
