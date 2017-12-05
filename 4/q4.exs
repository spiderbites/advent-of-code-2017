defmodule Q4 do
  Code.require_file "../utils.exs", __DIR__

  def alphabetize(str) do
    String.split(str, "")
      |> Enum.sort
      |> Enum.join
  end

  def p1 do
    Utils.file_to_2d_string_array("input.txt")
      |> Enum.map(fn(passphrase) -> Utils.array_counts(passphrase) end)
      |> Enum.map(fn(countMap) -> Map.values(countMap) end)
      |> Enum.reject(fn(counts) -> Enum.any?(counts, fn(count) -> count > 1 end) end)
      |> length
      |> IO.inspect
  end

  def p2 do
    Utils.file_to_2d_string_array("input.txt")
      |> Enum.map(fn(passphrase) -> Enum.map(passphrase, fn(word) -> alphabetize(word) end) end)
      |> Enum.map(fn(passphrase) -> Utils.array_counts(passphrase) end)
      |> Enum.map(fn(countMap) -> Map.values(countMap) end)
      |> Enum.reject(fn(counts) -> Enum.any?(counts, fn(count) -> count > 1 end) end)
      |> length
      |> IO.inspect
  end
end

Q4.p1()
Q4.p2()

