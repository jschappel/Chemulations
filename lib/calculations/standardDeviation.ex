defmodule Calculations.StandardDeviation do

  import Calculations.SigFigs, only: [multSigFigs: 1, addSigFigs: 1]

  @doc """
  findSDWithSig: list -> float
  Purpose: finds the standard deviation with sigfigs included
  """
  def findSDWithSig(aList) when is_list(aList) do
    with(msig <- multSigFigs(aList)) do
      numerator = avg(aList, 0, length(aList), msig)
      |> convertToX2(aList, msig)
      |> List.foldl(0, fn x, y -> x + y end)
      i = Float.round(numerator / (length(aList) -1), msig)
      Float.round(:math.sqrt(i), msig)
    end
  end

  @doc """
  findSDWithSig: list -> float
  Purpose: finds the standard deviation to 10 decimal places
  """
  def findSD(aList) do
    with(msig <- 10) do
      numerator = avg(aList, 0, length(aList), msig)
      |> convertToX2(aList, msig)
      |> List.foldl(0, fn x, y -> x + y end)
      i = Float.round(numerator / (length(aList) -1), msig)
      Float.round(:math.sqrt(i), msig)
    end
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
  def convertToX2(_, [], sigFig), do: []
  def convertToX2(avg, [first | rest], sigFig) do
    val = Float.round(:math.pow(first - avg, 2), sigFig)
    [val | convertToX2(avg, rest, sigFig)]
  end

end
