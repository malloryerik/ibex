defmodule Ibex.Tws.Client do
  @moduledoc """
  Handles the TCP connection to the Interactive Brokers Trader Workstation (TWS) API.

  This module encapsulates the functionality to connect to the TWS API, manage the TCP connection,
  and process incoming and outgoing messages. It supports connecting to both paper trading and live
  environments by switching the port number.

  ## Example

      {:ok, pid} = Ibex.Tws.Client.start_link(host: "127.0.0.1", port: 7497)
      # Now the client is ready to send and receive messages with the TWS API.


  In your fetcher process or wherever you decide to initiate the request, you would call:

      Ibex.Tws.Client.send_request(client_pid, request_data)

  """

  use GenServer
  require Logger

  # IP address in tuple format for localhost
  @ip {127, 0, 0, 1}
  # Default port for TWS API paper trading; live is 7496
  # add `@live_port 7496` and way to **clearly and obviously** switch between paper and live.
  @paper_port 7497

  @spec start_link(any()) :: :ignore | {:error, any()} | {:ok, pid()}
  @doc """
  Starts the GenServer that handles the connection to TWS API.

  ## Parameters
  - `opts`: Opts for starting the GenServer. Can include the host and port.

  ## Returns
  - PID of the started GenServer on success
  """
  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  # GenServer Callbacks

  @impl true
  def init(_opts) do
    # Asynchronously trigger connection setup
    send(self(), :connect)
    {:ok, %{socket: nil}}
  end

  @impl true
  def handle_info(:connect, state) do
    Logger.info("Connecting to TWS API at #{:inet.ntoa(@ip)}:#{@paper_port}")

    case :gen_tcp.connect(@ip, @paper_port, [:binary, packet: :raw, active: false]) do
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

  @impl true
  def handle_cast({:send_request, request_data}, %{socket: socket} = state)
      when not is_nil(socket) do
    request_message = format_request(request_data)
    :ok = :gen_tcp.send(socket, request_message)
    {:noreply, state}
  end

  defp format_request(_request_data) do
    # This function should turn your request data into a string or binary
    # that matches the TWS API's expected format for a historical data request.
    # This is highly dependent on the TWS API documentation.
  end

  # Public API to send a request
  def send_request(pid, request_data) do
    GenServer.cast(pid, {:send_request, request_data})
  end
end
