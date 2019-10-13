defmodule Chemulations do
  @moduledoc """
  This it the main driver for the program.
  """
  import Calculations.StandardDeviation, only: [findSD: 2]
  import Calculations.SigFigs, only: [multSigFigs: 1]


  @doc """
  calcSD: integer(optional) list-of-integers/floats -> float
  Purpose: calculates the SD of a geven set of numbers. If the optional arg
    is not supplied then Sigfigs are used in the answer

    ## Examples
      iex> Chemulations.calcSD([10, 20, 40, -10])
      21.0

      iex> Chemulations.calcSD(10, [10, 20, 40, -10])
      20.8166599947
  """
  def calcSD(d, aList) when is_list(aList) and is_integer(d), do: findSD(aList, d)
  def calcSD(_, _), do: throw "Please insert the correct args: calcSD(LIST) or calcSD(INT, LIST)"
  def calcSD(aList) when is_list(aList), do: findSD(aList, multSigFigs(aList))
  def calcSD(_), do: throw "Please insert the correct args: calcSD(LIST) or calcSD(INT, LIST)"

end
