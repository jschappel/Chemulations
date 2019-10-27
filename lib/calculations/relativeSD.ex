defmodule Calculations.RSD do
  @moduledoc """
  This module handles the calculations for calculating the Relatiive Standard Deviation of a set of numbers
  """
  alias Decimal, as: D

  @doc """
  findRSD: float float integer -> flaot
    sd: standard deviation
    avg: avg
    rounding: arbitrary number of fractional digits
  Purpose: Calculates the relative standard deviation of the sample set
  """
  def findRSD(sd, avg, rounding) do
    D.set_context(%D.Context{D.get_context | precision: rounding})
    D.div(sd,avg)
  end


  @doc """
  findPRSD: float integer -> float
    rsd: relative standard deviation
    rounding: arbitrary number of fractional digits
  Purpose: Calculates the percent relative standard deviation of the sample set
  """
  def findPRSD(rsd, rounding) do
    D.set_context(%D.Context{D.get_context | precision: rounding})
    D.mult(res, 100)
  end
end
