defmodule Utils do
  def file_to_int_list(filepath) do
    File.read(filepath)
      |> elem(1)
      |> String.replace("\n", "")
      |> String.graphemes
      |> Enum.map(fn(x) -> String.to_integer(x) end)
  end
end
