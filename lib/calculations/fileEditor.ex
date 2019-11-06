defmodule Calculations.FileEditor do

  @file_name "excel.txt" # The name of the file

  @doc """
  writetoFile: list-of-lists([ [:headers], [row1], [row2], ...]) -> atom
  Purpose: writes the data to a csv file located at the root of the project (calculations)
  """
  def writeToFile([headers | data]) do
    with headers = String.trim(createHeaders(headers)) <> "\n",
         pid = openFile() do
          File.write(@file_name, headers, [:line])
          writeData(data)
          File.close(pid)
          :ok
    end
  end



  # openfile: nil -> Process ID
  # Purpose: Creates a new file called excel.txt at the top level of the program directory.
  #   If the file already exists then the current file is deleated and a new file is created.
  defp openFile do
    case File.exists?(@file_name) do
      true -> File.open(@file_name, [:write])
      _ -> File.open(@file_name, [:append])
    end
  end


  # createHeaders: list-of-atoms -> string
  # Purpose: creates a csv string for all the headers
  defp createHeaders([]), do: ""
  defp createHeaders([first | rest]) do
    Atom.to_string(first) <> " " <> createHeaders(rest)
  end



  # writeData: list-of-lists-of-data -> nil
  # Purpose: Writes each list of data to the file.
  defp writeData([]), do: nil
  defp writeData([first | rest]) do
    with line = String.trim(writeLine(first)) <> "\n" do
      File.write(@file_name, line, [:append, :line])
      writeData(rest)
    end

  end


  # writeLine: list-of-data -> string
  # Purpose: When given a list of data will appeden it all to a string(csv format)
  defp writeLine([]), do: ""
  defp writeLine([first | rest]) when is_float(first), do: Float.to_string(first) <> " " <> writeLine(rest)
  defp writeLine([first | rest]) when is_integer(first), do: Integer.to_string(first) <> " " <> writeLine(rest)
  defp writeLine([first | rest]), do: first <> " " <> writeLine(rest)


end
