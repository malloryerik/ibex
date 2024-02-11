defmodule Ibex.Tws.Client do
  use GenServer
  require Logger

  # IP address in tuple format for localhost
  @ip {127, 0, 0, 1}
  # Default port for TWS API paper trading; live is 7496
  @port 7497

  # Public API to start the GenServer
  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  # GenServer Callbacks

  def init(_opts) do
    # Asynchronously trigger connection setup
    send(self(), :connect)
    {:ok, %{socket: nil}}
  end

  def handle_info(:connect, state) do
    Logger.info("Connecting to TWS API at #{:inet.ntoa(@ip)}:#{@port}")

    case :gen_tcp.connect(@ip, @port, [:binary, packet: :raw, active: false]) do
      {:ok, socket} ->
        Logger.info("Successfully connected to TWS API.")
        {:noreply, Map.put(state, :socket, socket)}

      {:error, reason} ->
        Logger.error("Failed to connect: #{inspect(reason)}")
        {:stop, :connect_error, state}
    end
  end

  # Handle incoming TCP messages
  def handle_info({:tcp, _socket, data}, state) do
    Logger.info("Received data: #{inspect(data)}")
    {:noreply, state}
  end

  def handle_info({:tcp_closed, _socket}, state) do
    Logger.info("TCP connection closed")
    {:stop, :normal, state}
  end

  def handle_info({:tcp_error, _socket, reason}, state) do
    Logger.error("TCP error: #{inspect(reason)}")
    {:stop, :normal, state}
  end

  # Additional functionality for sending messages to TWS could be added here
end
