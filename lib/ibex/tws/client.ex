defmodule Ibex.Tws.Client do
  @moduledoc """
  Handles the TCP connection to the Interactive Brokers Trader Workstation (TWS) API.

  This module encapsulates the functionality to connect to the TWS API, manage the TCP connection,
  and process incoming and outgoing messages. Thus abstracts away from other higher-level modules
  who can use this.
  Supports connecting to both paper trading and live environments by switching the port number.

  ## Example

      {:ok, pid} = Ibex.Tws.Client.start_link(host: "127.0.0.1", port: 7497)
      # Now the client is ready to send and receive messages with the TWS API.


      # Inside your fetcher process or wherever you decide to initiate the request, you would call:

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

  @doc """
  ### Handles sending a request to the TWS API.
  Designed to be non-blocking and asynchronous. Uses `GenServer.cast/2`
  (one-way messaging) to handle the request allowing the caller to
  continue without waiting for a response. The response to the request,
  if any, will be handled by other callbacks in this GenServer module
  such as `handle_info/2`.


  ### Parameters:
  - `{:send_request, request_data}`: A tuple where `:send_request` is the action to be performed and `request_data` is the data to be sent to the TWS API.
  - `%{socket: socket} = state`: The current state of the GenServer, including the socket connection to the TWS API.

  ### Returns:
  - `{:noreply, state}`: Indicates that no immediate reply is expected, and the state is potentially updated.
  """
  def handle_cast({:send_request, request_data}, %{socket: socket} = state)
      when not is_nil(socket) do
    request_message = Ibex.Tws.Protocol.encode(request_data)

    if request_message == nil do
      Logger.error("Encoded request message is nil.")
      {:noreply, state}
    else
      case :gen_tcp.send(socket, request_message) do
        :ok ->
          {:noreply, state}

        {:error, reason} ->
          Logger.error("Failed to send request: #{inspect(reason)}")
          {:stop, :send_error, state}
      end
    end
  end

  # Public API to send a request
  def send_request(pid, request_data) do
    GenServer.cast(pid, {:send_request, request_data})
  end
end
