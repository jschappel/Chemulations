defmodule Calculations.StandardDeviation do
  @moduledoc """
  This module handles the calculations for calculating the Standard Deviation of a set of numbers
  """

  alias Decimal, as: D # Import the decimal class

  @doc """
  findSD: tuple list-of-integer/floats -> flaot
  Purpose: Calculates the SD of a given set of numbers

  ## Examples
      iex> Calculations.SigFigs.findSD([10, 20, 40, -10], [Avg: 10], 3)
      21.0

      iex> Calculations.SigFigs.findSD(10, [10, 20, 40, -10], [Avg: 10], 12)
      20.8166599947
  """
  def findSD(avg, aList, rounding) do
    with(len = length(aList)) do

      # set the rounding context
      D.set_context(%D.Context{D.get_context | precision: rounding})

      # find the numberator of the equation
      numerator =
        convertToX2(avg[:Avg], aList)
        |> List.foldl(0, fn x, y -> D.add(x, y) end)

      # calculate the rest of the equation and return value as a flaot
      inner = D.div(numerator, len - 1)
      [SD: D.sqrt(inner)]
    end
  end


  @doc """
  findAvg: array-of-integer/float integer -> list-of-tuple
  Purpose: finds the avg of the array
  """
  def findAvg(aList, rounding) do
    D.set_context(%D.Context{D.get_context | precision: rounding})
    avgHelper(aList, 0, length(aList))
  end
  defp avgHelper([], accum, length) when is_float(accum), do: [Avg: D.div(D.from_float(accum), length)]
  defp avgHelper([], accum, length), do: [Avg: D.div(accum, length)]
  defp avgHelper([first | rest], accum, length) do
    avgHelper(rest, accum + first, length)
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
