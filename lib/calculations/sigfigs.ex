defmodule Calculations.SigFigs do

  @doc """
  multSigFigs: list-of-floats -> number
  Purpose: When given a list will determine the number of sigfigs to use when multipling or dividing
  """
  def multSigFigs(aList) do
    Enum.reduce(aList, nil, fn ele, accum -> getSmallest(ele, accum) end)
  end

  @doc """
  addSigFigs: list-of-floats -> number
  Purpose: When given a list will determine the number of sigfigs to use when adding or substracting
  """
  def addSigFigs(aList) do
    Enum.reduce(aList, nil, fn ele, accum -> getSmallestFull(ele, accum) end)
  end


  @doc """
  getFullDigits: float -> number
  Purpose: When given a number will determin the amount of sigigs that it has
  """
  def getFullDigits(aNum) when is_float(aNum) do
    [wholeNum, decimals] = String.split(Float.to_string(aNum), ".")
    String.length(wholeNum) + String.length(decimals)
  end
  def getFullDigits(aNum) do
    Enum.reduce(Integer.digits(aNum), 0, fn _, accum -> accum + 1 end)
  end


  @doc """
  TODO: UPDATE COMMENT
  getsmallest: flaot accumulator -> number
  Purpose: returns the of sigfigs for multiplication/ddevision
  """
  def getSmallest(num, accum) do
    with(digits <- getDecimalDigits(num)) do
      if(digits < accum) do
        digits
      else
        accum
      end
    end
  end

  def getSmallestFull(num, accum) do
    with(digits <- getFullDigits(num)) do
      if(digits < accum) do
        digits
      else
        accum
      end
    end
  end

  @doc """
  getDecimalDigits: float -> number
  Prupose: finds the number of decimal digits in a float
  """
  def getDecimalDigits(num) when is_float(num) do
    [_, decimals] = String.split(Float.to_string(num), ".")
    String.length(decimals)
  end
  def getDecimalDigits(_), do: 0
end
