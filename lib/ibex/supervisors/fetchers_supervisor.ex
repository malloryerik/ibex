defmodule Ibex.Supervisors.FetchersSupervisor do
  use DynamicSupervisor

  @moduledoc """
  Supervises dynamic data fetcher processes.
  """

  def start_link(opts \\ []) do
    DynamicSupervisor.start_link(__MODULE__, :ok, Keyword.put(opts, :name, __MODULE__))
  end

  @impl true
  def init(:ok) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end
end
