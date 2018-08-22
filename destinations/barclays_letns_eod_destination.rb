# frozen_string_literal: true

class BarclaysLetnsEodDestination
  def initialize(connect_url)
    @conn = PG.connect(connect_url)
    @conn.prepare('insert_pg_stmt',
      'INSERT INTO feed.barclays_letns_eod(
        cusip, isin, ticker, date, name, indicative_value, shares_outstanding,
        index_value, coupon, market_capitalization, closing_participation,
        closing_note_financing_level, closing_note_t_bills_amount,
        closing_note_index_exposure, next_closing_note_financing_level,
        next_closing_note_t_bills_amount, equity_allocation, vol_allocation,
        short_vxx_shares, vxx_closing_nav, accrued_fees, accrued_interest,
        rebalancing_trigger_level, termination_trigger_level, index_roll_cost,
        monthly_factor, etfg_date)
      VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15,
              $16, $17, $18, $19, $20, $21, $22, $23, $24, $25, $26, $27);')
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
        row[:closing_participation],
        row[:closing_note_financing_level],
        row[:closing_note_t_bills_amount],
        row[:closing_note_index_exposure],
        row[:next_closing_note_financing_level],
        row[:next_closing_note_t_bills_amount],
        row[:equity_allocation],
        row[:vol_allocation],
        row[:short_vxx_shares],
        row[:vxx_closing_nav],
        row[:accrued_fees],
        row[:accrued_interest],
        row[:rebalancing_trigger_level],
        row[:termination_trigger_level],
        row[:index_roll_cost],
        row[:monthly_factor],
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
