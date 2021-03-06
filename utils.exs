defmodule Utils do
  def file_to_1d_int_array(filepath) do
    File.read(filepath)
      |> elem(1)
      |> String.replace("\n", "")
      |> String.graphemes
      |> Enum.map(fn(x) -> String.to_integer(x) end)
  end

  def file_to_int_array(filepath) do
    File.read(filepath)
      |> elem(1)
      |> String.split("\n")
      |> Enum.map(fn(item) -> String.to_integer(item) end)
  end

  def file_to_int_array_whitespace(filepath) do
    File.read(filepath)
    |> elem(1)
    |> String.split()
    |> Enum.map(fn(item) -> String.to_integer(item) end)
  end

  def file_to_2d_int_array(filepath) do
    File.read(filepath)
      |> elem(1)
      |> String.split("\n")
      |> Enum.map(fn(s) -> String.split(s) end)
      |> Enum.map(fn(innerArray) -> Enum.map(innerArray, fn(x) -> String.to_integer(x) end) end)
  end

  def file_to_string_array(filepath) do
    File.read(filepath)
     |> elem(1)
     |> String.split("\n")
  end

  def file_to_2d_string_array(filepath) do
    File.read(filepath)
      |> elem(1)
      |> String.split("\n")
      |> Enum.map(fn(s) -> String.split(s) end)
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

  # Get a value nested map value, or a default value sif it doesn't exist
  # Like lodash.get
  def get_nested(data, [hd | []], default) do
    data[hd] || default
  end

  def get_nested(data, [hd | tl], default) do
    if data[hd] do
      get_nested(data[hd], tl, default)
    else
      default
    end
  end

  def array_counts(list) do
    Enum.reduce(list, %{}, fn(item, acc) -> Map.update(acc, item, 1, &(&1 + 1)) end)
  end

  def list_to_map(list) do
    0..length(list)-1 |> Stream.zip(list) |> Enum.into(%{})
  end
end
