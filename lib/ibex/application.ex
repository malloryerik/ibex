defmodule Ibex.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  @paper_port 7497
  # @live_port 7496
  # TODO Connected with TODO on lib/ibex/tws/client.ex, enable easy and **clear, obvious** switching between paper and live accounts.

  use Application

  @impl true
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