defmodule Ibex.Application do
  #

  @moduledoc """
  Entry point for the Ibex application.

  This module stands up the application's supervision tree, which includes starting the TWS Client
  and potentially other workers or supervisors as the application grows.

  Currently, it configures and starts the TWS Client for connecting to the Interactive Brokers Trader Workstation API,
  defaulting to a paper trading connection.

  Soon we'll use configurable port numbers (as module attributes) to switch between paper trading (`@paper_port`) and live trading (`@live_port`).

  **The difference between paper and live accounts must designed to be obvious and unmistakable in any GUI or other end user application. Users must never have to guess if they are live or on a simulator.**


  https://hexdocs.pm/elixir/Application.html

  IBKR TWS API docs: https://interactivebrokers.github.io/tws-api
  """

  @paper_port 7497
  # @live_port 7496
  # TODO Connected with TODO on lib/ibex/tws/client.ex, enable easy and **clear, obvious** switching between paper and live accounts.

  use Application

  @impl true
  @doc """
  Starts the application's supervision tree.

  Called automatically when the application starts, `start\2` initializes the supervision tree.
  Currently that includes the TWS Client connected to a paper trading account.

  ## Parameters
  - `_type`: The start type provided by the runtime system (not used).
  - `_args`: Command line arguments passed to the application (not used).

  ## Returns
  - The PID of the root supervisor.
  """
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: Ibex.Worker.start_link(arg)
      {Ibex.Tws.Client, [host: "127.0.0.1", port: @paper_port]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Ibex.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
