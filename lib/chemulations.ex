defmodule Chemulations do
  @moduledoc """
  This it the main driver for the program.
  """
  import Calculations.StandardDeviation, only: [findSD: 3, findAvg: 2]
  import Calculations.TableFormatter, only: [create_table: 2]
  import Calculations.RSD, only: [findRSD: 3, findPRSD: 2]
  import Calculations.SigFigs, only: [multSigFigs: 1]
  import Calculations.FileEditor, only: [writeToFile: 1]




  @doc """
  calcAll: integer(optional) list-of-integers/floats -> float
  Purpose: calculates the Avg, SD, RSD, %RSD of a given set of numbers and displays
    then in a table. If the optional arg is not supplied then Sigfigs are used in the
    answer.

    ## Examples
      iex> Chemulations.calcAll([10, 20, 40, -10])
      Avg | SD | RSD | PRSD
      ----+----+---- +-----
      15  | 21 | 1  | 139

      iex> Chemulations.calcAll([10, 20, 40, -10], 10)
      Avg | SD          | RSD         | PRSD
      ----+-------------+-------------+------------
      15  | 20.81665999 | 1.387777333 | 138.7777333
  """
  def calcAll(aList, rounding) when is_list(aList) and is_integer(rounding) do
    with avg = findAvg(aList, rounding),
    sd = findSD(avg, aList, rounding),
    rsd = findRSD(sd, avg, rounding),
    prsd = findPRSD(rsd, rounding) do
      create_table([:Avg, :SD, :RSD, :PRSD], [List.flatten([avg, sd, rsd, prsd])])
    end
  end
  def calcAll(_, _), do: throw "Please insert the correct args: calcAll(LIST) or calcAll(INT, LIST)"
  def calcAll(aList) when is_list(aList)do
    with rounding = multSigFigs(aList),
    avg = findAvg(aList, rounding),
    sd = findSD(avg, aList, rounding),
    rsd = findRSD(sd, avg, rounding),
    prsd = findPRSD(rsd, rounding) do
      create_table([:Avg, :SD, :RSD, :PRSD], [List.flatten([avg, sd, rsd, prsd])])
    end
  end
  def calcAll(_), do: throw "Please insert the correct args: calcAll(LIST) or calcAll(INT, LIST)"

  @doc """
  calcSD: integer(optional) list-of-integers/floats -> float
  Purpose: calculates the SD of a given set of numbers. If the optional arg
    is not supplied then Sigfigs are used in the answer

    ## Examples
      iex> Chemulations.calcSD([10, 20, 40, -10])
      21.0

      iex> Chemulations.calcSD([10, 20, 40, -10], 10)
      20.8166599947
  """
  def calcSD(aList, rounding) when is_list(aList) and is_integer(rounding) do
    sd = findAvg(aList, rounding)
    |> findSD(aList, rounding)
    Decimal.to_float(sd[:SD])
  end
  def calcSD(_, _), do: throw "Please insert the correct args: calcSD(LIST) or calcSD(INT, LIST)"
  def calcSD(aList) when is_list(aList) do
    with rounding = multSigFigs(aList) do
      findAvg(aList, rounding)
      |> findSD(aList, rounding)
    end
  end
  def calcSD(_), do: throw "Please insert the correct args: calcSD(LIST) or calcSD(INT, LIST)"


  @doc """
  calcRSD: integer(optional) list-of-integers/floats -> float
  Purpose: calculates the RSD of a given set of numbers. If the optional arg
    is not supplied then Sigfigs are used in the answer

    ## Examples
      iex> Chemulations.calcRSD([10, 20, 40, -10])
      [RSD: 1.4]

      iex> Chemulations.calcRSD([10, 20, 40, -10], 10)
      [RSD: 1.387777333]
  """
  def calcRSD(aList, rounding) when is_list(aList) and is_integer(rounding) do
    with avg = findAvg(aList, rounding) do
      findSD(avg, aList, rounding)
      |> findRSD(avg, rounding)
    end
  end
  def calcRSD(_, _), do: throw "Please insert the correct args: calcRSD(LIST) or calcRSD(INT, LIST)"
  def calcRSD(aList) when is_list(aList) do
    IO.puts("STILL NEEDS TO BE IMPLIMENTED")
  end
  def calcRSD(_), do: throw "Please insert the correct args: calcRSD(LIST) or calcRSD(INT, LIST)"



  def excelAll(aList, rounding) when is_list(aList) do
    with avg = findAvg(aList, rounding),
    sd = findSD(avg, aList, rounding),
    rsd = findRSD(sd, avg, rounding),
    prsd = findPRSD(rsd, rounding),
    dataList = [[:Avg, :StandardDeviation, :RelativeSD, :PercentRelativeSD], [ Decimal.to_float(avg[:Avg]),  Decimal.to_float(sd[:SD]),  Decimal.to_float(rsd[:RSD]),  Decimal.to_float(prsd[:PRSD]) ] ] do
      case writeToFile(dataList) do
        :ok -> IO.puts("File was sucessfully created")
        _ -> IO.puts("There was an error creating the file")
      end
    end
  end
  def excelAll(_, _), do: throw "Please insert the correct args: excelALl(LIST) or excelALl(INT, LIST)"
  def excelAll(aList) when is_list(aList) do
    IO.puts("STILL NEEDS TO BE IMPLIMENTED")
  end
  def excelAll(_), do: throw "Please insert the correct args: excelALl(LIST) or excelALl(INT, LIST)"
end
