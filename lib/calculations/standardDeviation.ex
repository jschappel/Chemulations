defmodule Calculations.StandardDeviation do
  @moduledoc """
  This module handles the calculations for calculating the Standard Deviation of a set of numbers
  """

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
    # find the numberator of the equation
    numerator = avg(aList, 0, length(aList), rounding)
    |> convertToX2(aList, rounding)
    |> List.foldl(0, fn x, y -> x + y end)

    i = Float.round(numerator / (length(aList) -1), rounding)
    Float.round(:math.sqrt(i), rounding)
  end



  @doc """
  avg: array-of-integer integer integer integer -> integer
  Purpose: finds the avg of the array
  """
  def avg([], accum, length, sigFigs), do: Float.round(accum/length, sigFigs)
  def avg( [first | rest], accum, length, sigFigs) do
    avg(rest, accum + first, length, sigFigs)
  end


  @doc """
  convertToX2: integer(avg) list intger(rounding place) -> list
  Purpose: When given a list calculates the (x-avg)^2 for each element in the list.
  """
  def convertToX2(_, [], _), do: []
  def convertToX2(avg, [first | rest], sigFig) do
    val = Float.round(:math.pow(first - avg, 2), sigFig)
    [val | convertToX2(avg, rest, sigFig)]
  end

end
