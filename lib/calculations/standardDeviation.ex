defmodule Calculations.StandardDeviation do
  @moduledoc """
  This module handles the calculations for calculating the Standard Deviation of a set of numbers
  """

  alias Decimal, as: D # Import the decimal class

  @doc """
  findSD: list-of-integer/floats -> flaot
  Purpose: Calculates the SD of a given set of numbers

  ## Examples
      iex> Calculations.SigFigs.findSD([10, 20, 40, -10])
      21.0

      iex> Calculations.SigFigs.findSD(10, [10, 20, 40, -10])
      20.8166599947
  """
  def findSD(aList, rounding) do
    with(len = length(aList)) do

      # set the rounding context
      D.set_context(%D.Context{D.get_context | precision: rounding})

      # find the numberator of the equation
      numerator = avg(aList, 0, len)
      |> convertToX2(aList)
      |> List.foldl(0, fn x, y -> D.add(x, y) end)

      # calculate the rest of the equation and return value as a flaot
      inner = D.div(numerator, len - 1)
      D.sqrt(inner)
      |> D.to_float()
    end
  end


  @doc """
  avg: array-of-integer/float integer integer -> integer
  Purpose: finds the avg of the array
  """
  def avg([], accum, length) when is_float(accum), do: D.div(D.from_float(accum), length)
  def avg([], accum, length), do: D.div(accum, length)
  def avg( [first | rest], accum, length) do
    avg(rest, accum + first, length)
  end


  @doc """
  convertToX2: integer(avg) list intger(rounding place) -> list
  Purpose: When given a list calculates the (x-avg)^2 for each element in the list.
  """
  def convertToX2(_, []), do: []
  def convertToX2(avg, [first | rest]) when is_float(first) do
    with(num = D.sub(D.from_float(first), avg)) do
      val = D.mult(num, num)
      [val | convertToX2(avg, rest)]
    end
  end
  def convertToX2(avg, [first | rest]) do
    with(num = D.sub(first, avg)) do
      val = D.mult(num, num)
      [val | convertToX2(avg, rest)]
    end
  end
end
