defmodule Ibex.IbexFetchers do
  @moduledoc """
  Provides functionalities to start and manage data fetcher processes.
  """

  alias Ibex.Supervisors.FetchersSupervisor
  alias Ibex.Fetchers.HistoricalDataFetcher

  @doc """
  Starts a HistoricalDataFetcher process with the given contract and options.
  """
  def start_historical_data_fetcher(contract, opts) do
    # This structure is expected in HistoricalDataFetcher
    args = %{contract: contract, opts: opts}

    # If you're considering passing a name, make sure it's part of the args map
    # args = %{contract: contract, opts: opts, name: :some_unique_name}

    case DynamicSupervisor.start_child(FetchersSupervisor, {HistoricalDataFetcher, args}) do
      {:ok, pid} -> {:ok, pid}
      {:error, {:already_started, pid}} -> {:ok, pid}
      {:error, _} = error -> error
    end
  end
end
