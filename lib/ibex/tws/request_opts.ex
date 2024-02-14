defmodule Ibex.Tws.RequestOpts do
  @moduledoc """
  Constructs opts maps for various TWS API requests, ensuring they adhere to expected formats and values.
  """

  @doc """
  Creates a opts map for historical data requests with default values and allows overriding.

  Example:

        opts = Ibex.Tws.RequestOpts.historical_data_opts(durationStr: "2 W", whatToShow: "HISTORICAL_VOLATILITY")
        contract = Ibex.Tws.Contracts.fx_contract("EUR", "USD")

        Ibex.IbexFetchers.start_historical_data_fetcher(contract, opts)

  ## Valid Duration String units
  Unit	Description
  S   	Seconds
  D	    Day
  W   	Week
  M	    Month
  Y	    Year


  ## Valid Bar Sizes
  Size
  1 secs	5 secs	10 secs	15 secs	30 secs
  1 min	  2 mins	3 mins	5 mins	10 mins	15 mins	20 mins	30 mins
  1 hour	2 hours	3 hours	4 hours	8 hours
  1 day
  1 week
  1 month

  ## Historical Data Types

  See https://interactivebrokers.github.io/tws-api/historical_bars.html#hd_request

  All different kinds of historical data are returned in the form of candlesticks and as such the values return represent the state of the market during the period covered by the candlestick.

  Type
  TRADES
  MIDPOINT
  BID
  ASK
  BID_ASK
  ADJUSTED_LAST
  HISTORICAL_VOLATILITY
  OPTION_IMPLIED_VOLATILITY
  FEE_RATE
  YIELD_BID
  YIELD_ASK
  YIELD_BID_ASK
  YIELD_LAST
  SCHEDULE
  AGGTRADES


  """
  def historical_data_opts(overrides \\ %{}) do
    defaults = %{
      # Use current time if empty
      endDateTime: "",
      durationStr: "1 M",
      barSizeSetting: "1 day",
      whatToShow: "TRADES",
      useRTH: true,
      # 1 for yyyyMMdd format
      formatDate: 1
    }

    Enum.into(overrides, defaults)
  end
end
