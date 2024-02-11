defmodule IbexTest do
  use ExUnit.Case
  doctest Ibex

  test "greets the world" do
    assert Ibex.hello() == :world
  end
end
