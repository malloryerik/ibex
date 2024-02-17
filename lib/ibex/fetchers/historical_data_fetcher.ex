defmodule Ibex.Fetchers.HistoricalDataFetcher do
  use GenServer
  require Logger
  require IO

  alias Ibex.Tws.Contracts
  alias Ibex.Tws.Client

  @moduledoc """
  Fetches historical data from the TWS API, managing requests to adhere to API constraints.

  ## Example
      {:ok, pid} = Ibex.Fetchers.HistoricalDataFetcher.start_link(%{})
      contract = Tws.Contracts.futures_contract("ES", "USD", "GLOBEX", "202406", "50")
      opts = Tws.RequestOpts.historical_data_opts(%{durationStr: "1 W", barSizeSetting: "1 hour"})

      Ibex.Fetchers.HistoricalDataFetcher.fetch_historical_data(pid, contract, opts)

  """

  # Public API

  @doc """
  Starts the HistoricalDataFetcher process.
  """
  def start_link(args) do
    name_option =
      case Map.fetch(args, :name) do
        # No name provided, proceed without naming the process
        :error -> []
        # Name provided, use it to name the process
        {:ok, name} -> [name: name]
      end

    GenServer.start_link(__MODULE__, args, name_option)
  end

  @doc """
  Initiates a request for historical data.
  """
  def fetch_historical_data(pid, contract, opts) do
    GenServer.cast(pid, {:fetch_historical_data, contract, opts})
  end

  # GenServer Callbacks

  @impl true
  def init(_args) do
    {:ok, %{}}
  end

  @impl true
  def handle_cast({:fetch_historical_data, contract, opts}, state) do
    request_id = :erlang.unique_integer([:positive])

    formatted_request = format_request(contract, opts)

    IO.puts("Sending historical data request #{request_id}")
    __MODULE__.send_request(request_id, formatted_request)

    IO.puts("Request #{request_id} sent successfully.")

    # Update state with the request status. This is a placeholder for actual state management.
    new_state = Map.put(state, request_id, :sent)
    {:noreply, new_state}
  end

  # Private Functions

  def send_request(request_id, formatted_request) do
    :ok = Ibex.Tws.Client.send_request(:ibex_tws_request, formatted_request)
    Logger.info("Request #{request_id} sent successfully.")
    :ok
  end

  defp format_request(contract, opts) do
    request_parts = [
      # Request type
      "HISTORICAL_DATA",
      contract.symbol,
      contract.secType,
      contract.currency,
      contract.exchange,
      opts.durationStr,
      opts.barSizeSetting,
      opts.whatToShow,
      # Use regular trading hours
      "1",
      # Format date in readable format
      "1"
    ]

    Ibex.Tws.Protocol.encode(request_parts)
  end
end
