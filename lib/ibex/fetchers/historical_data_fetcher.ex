defmodule Ibex.Fetchers.HistoricalDataFetcher do
  use GenServer

  @moduledoc """
  Fetches historical data from the TWS API, managing requests to adhere to API constraints.
  """

  # Public API

  @doc """
  Starts the HistoricalDataFetcher process.
  """
  def start_link(args) do
    GenServer.start_link(__MODULE__, args)
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
    # Initialize state if needed
    {:ok, %{}}
  end

  @impl true
  def handle_cast({:fetch_historical_data, contract, opts}, state) do
    # Assume `send_request/3` is a function that sends a request to the TWS API
    # and handles the response, possibly asynchronously.
    send_request(contract, opts)

    {:noreply, state}
  end

  # Private Functions

  defp send_request(contract, opts) do
    # Here, you would implement the logic to format your request according to TWS API needs,
    # respecting the pacing and limitations as documented by TWS.
    # This is a placeholder for where you'd interact with Ibex.Tws.Client or similar.

    # Example placeholder logic:
    request_id = :erlang.unique_integer([:positive])
    formatted_request = format_request(contract, opts)

    # Log the request for debugging purposes
    Logger.info("Sending historical data request ##{request_id}")

    # Assuming `Ibex.Tws.Client.request_historical_data/3` exists and is implemented correctly.
    Ibex.Tws.Client.request_historical_data(request_id, formatted_request)
  end

  defp format_request(contract, opts) do
    # Convert `contract` and `opts` into the format expected by the TWS API.
    # This function should return the request in a way that `Ibex.Tws.Client` can directly use.
    #
    # This is highly dependent on your TWS Client implementation and the TWS API documentation.
    #
    # Return a placeholder for the sake of this example:
    %{contract: contract, opts: opts}
  end
end
