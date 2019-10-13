defmodule CalculationsTest do
  use ExUnit.Case
  doctest Calculations

  test "greets the world" do
    assert Calculations.hello() == :world
  end
end
