defmodule Calculations.SigFigs do

  def multSigFigs(aList) do
    #x = nil
    #Enum.each(aList, fn ele -> if(getdigits(ele) < x) do x = ele end end)
    Enum.reduce(aList, nil, fn ele, accum -> getSmallest(ele, accum) end)
  end

  def addSigFigs(aList) do
    Enum.reduce(aList, nil, fn ele, accum -> getSmallestFull(ele, accum) end)
  end


  def getFullDigits(aNum) when is_float(aNum) do
    [wholeNum, decimals] = String.split(Float.to_string(aNum), ".")
    String.length(wholeNum) + String.length(decimals)
  end
  def getFullDigits(aNum) do
    Enum.reduce(Integer.digits(aNum), 0, fn _, accum -> accum + 1 end)
  end




  def getSmallest(num, accum) do
    with(digits <- getDigits(num)) do
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




  def getDigits(num) when is_float(num) do
    [_, decimals] = String.split(Float.to_string(num), ".")
    String.length(decimals)
  end
  def getDigits(_), do: 0
end
