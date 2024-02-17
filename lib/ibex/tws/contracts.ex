defmodule Ibex.Tws.Contracts do
  alias Ibex.Tws.Contracts.ContinuousFuturesContract

  defmodule FxContract do
    defstruct symbol: nil, secType: "CASH", currency: nil, exchange: "IDEALPRO"
  end

  defmodule FuturesContract do
    defstruct symbol: nil,
              secType: "FUT",
              currency: nil,
              exchange: nil,
              lastTradeDateOrContractMonth: nil,
              multiplier: "1"
  end

  defmodule ContinuousFuturesContract do
    defstruct symbol: nil, secType: "CONTFUT", currency: nil, exchange: nil
  end

  defmodule FuturesOptionContract do
    defstruct symbol: nil,
              secType: "FOP",
              currency: nil,
              exchange: nil,
              lastTradeDateOrContractMonth: nil,
              strike: nil,
              right: nil,
              multiplier: "100"
  end

  defmodule StockContract do
    defstruct symbol: nil, secType: "STK", currency: nil, exchange: nil, primaryExch: nil
  end

  defmodule CryptoContract do
    defstruct symbol: nil, secType: "CRYPTO", currency: nil, exchange: "PAXOS"
  end

  # Example function to create an FX contract struct
  def fx_contract(symbol, currency) do
    %FxContract{symbol: symbol, currency: currency}
  end

  # Add similar functions for other contract types...

  def futures_contract(
        symbol,
        currency,
        exchange,
        last_trade_date_or_contract_month,
        multiplier \\ "5"
      ) do
    %FuturesContract{
      symbol: symbol,
      currency: currency,
      exchange: exchange,
      lastTradeDateOrContractMonth: last_trade_date_or_contract_month,
      multiplier: multiplier
    }
  end

  def continuous_futures_contract(symbol, currency, exchange) do
    %ContinuousFuturesContract{
      symbol: symbol,
      secType: "CONTFUT",
      currency: currency,
      exchange: exchange
    }
  end
end

# defmodule Ibex.Tws.Contracts do
#   @moduledoc """
#   Constructs contract opts for various financial instruments for the TWS API.
#   Opts are a parameter for data request functions, following contract.
#   They concern things like timeframe, dates, data type (bid, ask, trade, etc.),
#   ## Example:

#       contract = Ibex.Tws.Contracts.fx_contract("EUR", "USD")
#       opts = Ibex.Tws.RequestOpts.historical_data_opts(durationStr: "2 W", whatToShow: "BID")

#       Ibex.IbexFetchers.start_historical_data_fetcher(contract, opts)

#   """

#   @doc """
#   Constructs contract opts for spot FX pairs.
#   `symbol` is the nominator.
#   `currency` is the denominator.

#   So for EUR/USD we'd have:

#       Tws.Contracts.fx_contract("EUR", "USD")

#   and for USD/JPY:

#       Tws.Contracts.fx_contract("USD", "JPY")
#   """
#   def fx_contract(symbol, currency) do
#     %{
#       symbol: symbol,
#       secType: "CASH",
#       currency: currency,
#       exchange: "IDEALPRO"
#     }
#   end

#   @spec futures_contract(any(), any(), any(), any()) :: %{
#           currency: any(),
#           exchange: any(),
#           lastTradeDateOrContractMonth: any(),
#           multiplier: any(),
#           secType: <<_::24>>,
#           symbol: any()
#         }
#   @doc """
#   Constructs contract opts for a futures contract.

#   ## Example:

#       futures_contract = Ibex.Tws.Contracts.futures_contract("ES", "USD", "GLOBEX", "202412", "50")

#     Note that "202312" means "ES December 2024" or, in futures terminology, ESZ4.

#   ## Parameters
#   - symbol: The IBKR symbol of the futures contract. Might differ from other brokers.
#   - currency: The currency in which the future is denominated. ("USD", "EUR", "JPY", "AUD", etc.)
#   - exchange: The exchange where the future is traded.
#   - last_trade_date_or_contract_month:  'YYYYMM' format for the last trading date or contract month.
#   - multiplier: The contract point multiplier, specifying the size of the contract.

#   ## Returns
#   - A map representing the contract opts required by TWS.
#   """
#   def futures_contract(
#         symbol,
#         currency,
#         exchange,
#         last_trade_date_or_contract_month,
#         multiplier \\ "1"
#       ) do
#     %{
#       symbol: symbol,
#       secType: "FUT",
#       currency: currency,
#       exchange: exchange,
#       lastTradeDateOrContractMonth: last_trade_date_or_contract_month,
#       multiplier: multiplier
#     }
#   end

#   @doc """
#   Constructs contract details for a continuous futures contract, which are **only valid for historical data,** not realtime data.

#   As of this writing, it's unclear exactly how the continuous contracts are specified.
#   Does IBKR use an open interest threshold, a calendrical roll date, or some other mechanism to stitch together multiple contracts?

#   ## Parameters
#   - symbol: The symbol of the underlying asset.
#   - currency: The currency in which the continuous futures is denominated.
#   - exchange: The exchange where the continuous futures is traded.

#   ## Returns
#   - A map representing the contract opts required by TWS for a continuous futures contract.

#   ## Example:

#       continuous_futures_contract = Ibex.Tws.Contracts.continuous_futures_contract("ES", "USD", "GLOBEX")

#   """
#   def continuous_futures_contract(symbol, currency, exchange) do
#     %{
#       symbol: symbol,
#       secType: "CONTFUT",
#       currency: currency,
#       exchange: exchange
#     }
#   end

#   @doc """
#   Constructs contract details for a futures option contract.

#   ## Parameters
#   - symbol: The symbol of the underlying futures contract.
#   - currency: The currency in which the futures option is denominated.
#   - exchange: The exchange where the futures option is traded.
#   - last_trade_date_or_contract_month: The expiration date of the futures option in 'YYYYMM' format.
#   - strike: The strike price of the option.
#   - right: The type of option ("C" for Call, "P" for Put).
#   - multiplier: The contract multiplier, specifying the size of the contract.

#   ## Returns
#   - A map representing the contract details required by TWS.

#   ## Example

#       futures_option_contract = Ibex.Tws.Contracts.futures_option_contract("ES", "USD", "GLOBEX", "202212", 4000, "C", "50")

#   """
#   def futures_option_contract(
#         symbol,
#         currency,
#         exchange,
#         last_trade_date_or_contract_month,
#         strike,
#         right,
#         multiplier \\ "100"
#       ) do
#     %{
#       symbol: symbol,
#       secType: "FOP",
#       currency: currency,
#       exchange: exchange,
#       lastTradeDateOrContractMonth: last_trade_date_or_contract_month,
#       strike: strike,
#       right: right,
#       multiplier: multiplier
#     }
#   end

#   @doc """
#   Constructs contract opts for Stocks, including support for specifying primary exchange.
#   """
#   def stock_contract(symbol, currency, exchange, primary_exchange \\ nil) do
#     %{
#       symbol: symbol,
#       secType: "STK",
#       currency: currency,
#       exchange: exchange,
#       primaryExch: primary_exchange
#     }
#   end

#   @doc """
#   Constructs contract opts for Cryptocurrency.
#   """
#   def crypto_contract(symbol, currency) do
#     %{
#       symbol: symbol,
#       secType: "CRYPTO",
#       currency: currency,
#       exchange: "PAXOS"
#     }
#   end

#   # TODO Functions for bonds, stock options, etc., following the same pattern.
# end
