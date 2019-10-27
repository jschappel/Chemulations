defmodule SD_Test do
  use ExUnit.Case

  alias Calculations.StandardDeviation, as: SD
  alias Decimal, as: D
  import Calculations.SigFigs, only: [multSigFigs: 1, addSigFigs: 1]

  @data1 [10, 20, 40, -10]
  @data2 [1.23, 2.001, 4.503, 6.987]
  @data3 [-20, 20.4, 67.567, 87]

  test "Calculating the avg for a list of numbers" do
    D.set_context(%D.Context{D.get_context | precision: 3})

    assert 15.0 = D.to_float(SD.avg(@data1, 0, length(@data1)))
    assert 3.68 = D.to_float(SD.avg(@data2, 0, length(@data2)))
    assert 38.7 = D.to_float(SD.avg(@data3, 0, length(@data3)))
  end

#  test "Calculate the standard deviation with sigfigs" do
#    assert 21.0 = SD.findSD(@data1, multSigFigs(@data1))
#    assert 2.61 = SD.findSD(@data2, multSigFigs(@data2))
#    assert 48.0 = SD.findSD(@data3, multSigFigs(@data3))
#  end

  test "Calculate the standard deviation to 10 decimal places" do
    assert 20.81665999 = SD.findSD(@data1, 10)
    assert 2.609924568 = SD.findSD(@data2, 10)
    assert 48.12056635 = SD.findSD(@data3, 10)
  end
end
