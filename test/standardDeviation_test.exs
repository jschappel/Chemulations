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
    x = SD.findAvg(@data1, 3)
    y = SD.findAvg(@data2, 3)
    z = SD.findAvg(@data3, 3)

    assert 15.0 = D.to_float(x[:Avg])
    assert 3.68 = D.to_float(y[:Avg])
    assert 38.7 = D.to_float(z[:Avg])
  end

  test "Calculate the standard deviation to 10 decimal places" do
    x = SD.findSD(SD.findAvg(@data1, 10), @data1, 10)
    y = SD.findSD(SD.findAvg(@data2, 10), @data2, 10)
    z = SD.findSD(SD.findAvg(@data3, 10), @data3, 10)

    assert 20.81665999 = D.to_float(x[:SD])
    assert 2.609924568 = D.to_float(y[:SD])
    assert 48.12056635 = D.to_float(z[:SD])
  end
end
