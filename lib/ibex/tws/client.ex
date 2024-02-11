defmodule Ibex.Tws.Client do
  use GenServer
  require Logger

  @paper_port 7497
  # @live_port 7496
  # TODO implement easy switching between paper and live accounts,
  # and **make it clear which is being used**.

  # https://interactivebrokers.github.io/tws-api/connection.html

  # Next Steps
  # Sending and Receiving Messages: Extend this module to include functions for sending requests to TWS and handling responses. Format the messages according to the TWS API specification and parse incoming messages.
  # Handling EWrapper Interface: Implement the logic to handle callbacks from TWS (e.g., market data, order updates). This may involve decoding the messages received over the TCP connection and invoking the appropriate Elixir functions in response.
  # Error Handling: Implement robust error handling, especially for scenarios like connection loss or receiving malformed messages.

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  # Callbacks

  @impl true
  def init(opts) do
    state = %{host: opts[:host] || "127.0.0.1", port: opts[:port] || @paper_port, socket: nil}
    {:ok, state, {:continue, :connect}}
  end

  # # Connect to TWS with :gen_tcp -- https://www.erlang.org/doc/man/gen_tcp.html ; https://hexdocs.pm/elixir/task-and-gen-tcp.html
  # defp connect(host, port) do
  #   case :gen_tcp.connect(host, port, [:binary, packet: :line, active: false]) do
  #     {:ok, socket} ->
  #       GenServer.cast(__MODULE__, {:connected, socket})

  #     {:error, _} = error ->
  #       GenServer.cast(__MODULE__, {:connect_error, error})
  #   end
  # end

  @impl true
  def handle_continue(:connect, state) do
    case :gen_tcp.connect(state.host, state.port, [:binary, packet: :raw, active: false]) do
      {:ok, socket} ->
        Logger.info("Successfully connected to TWS API.")
        {:noreply, Map.put(state, :socket, socket)}

      {:error, _} = error ->
        Logger.error("TCP Connection Error: #{inspect(error)}")
        {:stop, :connect_error, state}
    end
  end

  # Handle connection
  @impl true
  def handle_cast({:connected, socket}, state) do
    {:noreply, Map.put(state, :socket, socket)}
  end

  @impl true
  def handle_cast({:connect_error, error}, state) do
    IO.inspect(error,
      label:
        "TCP Connection Error -- sent from lib/ibex/tws/client.ex handle_cast({:connect_error}"
    )

    {:stop, :connect_error, state}
  end

  # Additional callbacks for sending/receiving messages
  # @impl true
  # def handle_call(:pop, _from, state) do
  #   [to_caller | new_state] = state
  #   {:reply, to_caller, new_state}
  # end
end
