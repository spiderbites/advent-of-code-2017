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

  # Set a value in a nested map, up to two levels deep
  # creates the intermediary map if necessary
  def set_in(data, [k1, k2], value) do
    if Map.has_key?(data, k1) do
      put_in(data, [k1, k2], value)
    else
      put_in(data, [k1], %{k2 => value})
    end
  end

  def get_nested(data, [hd | []], default) do
    data[hd] || default
  end

  def get_nested(data, [hd | tl], default) do
    Utils.get_nested(data[hd], tl, default)
  end
end
