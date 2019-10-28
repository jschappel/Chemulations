defmodule Calculations.TableFormatter do

  alias Decimal, as: D

  @doc """
  create_table:
  """
  def create_table(headers, rows) do
    with data_by_columns = split_into_columns(rows, headers),
    column_widths = width_of(data_by_columns, headers),
    format = format_for(column_widths) do
      puts_one_line_in_columns(headers, format)
      IO.puts(seperator(column_widths))
      puts_in_columns(data_by_columns, format)
    end
  end


  @doc """
  split_into_columns: list-of-atoms list-of-tuples -> list
  Purpose: Splits the rows and headers into seperate parts for the table to
    print
  """
  def split_into_columns(rows, headers) do
    for header <- headers do
      for row <- rows, do: printable(row[header])
    end
  end


  @doc """
  Purpose: Converts the given value to a string for the table to print
  """
  def printable(str) when is_binary(str), do: str
  def printable(str) when is_atom(str), do: to_string(str)
  def printable(str), do: D.to_string(str)


  @doc """
  width_of: list-of-strings -> string
  Purpose: returns the string that has the most characters in the list
  """
  def width_of(columns, headers) do
    index = 0
    for column <- columns do

      colw = Enum.map(column, fn x -> String.length(x) end)
      |> Enum.max()

      header = Enum.fetch!(headers, index) |> Atom.to_string()
      if colw >= String.length(header) do
        index = index + 1
        colw
      else
        index = index + 1
        String.length(header)
      end
    end
  end


  @doc """
  format_for: list -> string
  Purpose: creates the header row
  """
  def format_for(column_width) do
    Enum.map_join(column_width, " | ", fn width -> "~-#{width}s" end) <> "~n"
  end


  @doc """
  Purpose: Formats the headers
  """
  def puts_one_line_in_columns(fields, format) do
    :io.format(format, fields)
  end


  @doc """
  seperator: list -> stirng
  Purpose: creates the row seperator row inder the columns
  """
  def seperator(column_widths) do
    Enum.map_join(column_widths, "-+-", fn width -> List.duplicate("-", width) end)
  end

  @doc """
  Purpose: puts the data into the columns
  """
  def puts_in_columns(data_by_columns, format) do
    List.zip(data_by_columns)
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.each(&puts_one_line_in_columns(&1, format))
  end

end
