defmodule SigfigsTest do
  use ExUnit.Case

  alias Calculations.SigFigs, as: CS

  @data1 [1.23, 1.224, 45.898, 0.887]
  @data2 [1.23456, 1.224, 45.898, 0.85]
  @data3 [1.23, 1.224, 45.898, 67]

  test "Get sigfigs for multiplication" do
    assert 2 = CS.multSigFigs(@data1)
    assert 2 = CS.multSigFigs(@data2)
    assert 0 = CS.multSigFigs(@data3)
  end

  test "Get sigfigs for addition" do
    assert 3 = CS.addSigFigs(@data1)
    assert 3 = CS.addSigFigs(@data2)
    assert 2 = CS.addSigFigs(@data3)
  end
end
