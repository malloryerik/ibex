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
end
