defmodule Utils do
  def file_to_1d_int_array(filepath) do
    File.read(filepath)
      |> elem(1)
      |> String.replace("\n", "")
      |> String.graphemes
      |> Enum.map(fn(x) -> String.to_integer(x) end)
  end

  def file_to_2d_int_array(filepath) do
    File.read(filepath)
      |> elem(1)
      |> String.split("\n")
      |> Enum.map(fn(s) -> String.split(s) end)
      |> Enum.map(fn(innerArray) -> Enum.map(innerArray, fn(x) -> String.to_integer(x) end) end)
  end
end
