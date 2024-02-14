defmodule Ibex.Fetchers.HistoricalDataFetcher do
  use GenServer
  require Logger

  @moduledoc """
  Fetches historical data from the TWS API, managing requests to adhere to API constraints.
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

    Logger.info("Sending historical data request ##{request_id}")

    case send_request(request_id, formatted_request) do
      :ok ->
        Logger.info("Request ##{request_id} sent successfully.")

      {:error, reason} ->
        Logger.error("Request ##{request_id} failed: #{reason}")
    end

    # Update state with the request status. This is a placeholder for actual state management.
    new_state = Map.put(state, request_id, :sent)
    {:noreply, new_state}
  end

  # Private Functions

  defp send_request(_request_id, formatted_request) do
    # Placeholder for sending the request. Replace this with actual code to interact with Ibex.Tws.Client.
    Logger.debug("Formatted request: #{inspect(formatted_request)}")

    # Simulating a request send operation. Replace with actual API call.
    :ok
  end

  defp format_request(contract, opts) do
    # Placeholder for request formatting logic. Adapt this based on your requirements and the TWS API documentation.
    %{contract: contract, opts: opts}
  end
end
