defmodule Ibex.Tws.Protocol do
  @moduledoc """
  Encodes and decodes the TWS API message protocol in binary.
  """

  @sep <<0>>
  @default_encoding :utf8
  @max_int Integer.MAX_VALUE
  @max_double 1.7976931348623157e308
  @true_value 1
  @false_value 0
  @invalid_symbol_error "Invalid symbol"
  @padding_size 4
  @message_type_query 100
  @message_type_response 200
  @delimiter ";"

  def encode(parts), do: Enum.map(parts, &encode_part/1) |> Enum.join(@sep)

  defp encode_part(part) when is_integer(part), do: Integer.to_string(part)
  defp encode_part(part) when is_float(part), do: Float.to_string(part)
  defp encode_part(part) when is_boolean(part), do: if(part, do: "1", else: "0")
  defp encode_part(part) when is_nil(part), do: ""
  defp encode_part(part) when is_binary(part), do: part
  # Extend with more specific cases as needed

  def decode(message) do
    message
    |> String.split(@delimiter)
    |> Enum.map(&convert_part/1)
    |> structure_data
  end

  defp convert_part(part) do
    cond do
      String.contains?(part, ".") -> String.to_float(part)
      String.match?(part, ~r/^\d+$/) -> String.to_integer(part)
      part == "true" -> true
      part == "false" -> false
      true -> part
    end
  end

  defp structure_data(parts) do
    # Example of structuring data, adjust based on your needs
    %{
      type: Enum.at(parts, 0),
      data: Enum.slice(parts, 1..-1)
    }
  end
end

# def send_message(socket, message) do
#   case :gen_tcp.send(socket, message) do
#     :ok -> :ok
#     {:error, reason} -> {:error, reason}
#   end
# end

# alias Ibex.Tws.Builder

# {:ok, socket} = :gen_tcp.connect('localhost', 4001, [active: false])
# message = Builder.build_message(["Hello", 123, true])
# Builder.send_message(socket, message)
