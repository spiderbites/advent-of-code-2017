defmodule Q2 do
  Code.require_file "../utils.exs", __DIR__

  def min_max_diff(array) do
    Enum.max(array) - Enum.min(array)
  end

  def find_divisible([]), do: nil

  def find_divisible([_ | []]), do: nil

  def find_divisible([head | tail]) do
    result = Q2.get_div_if_even(head, hd(tail))
    if result do
      result
    else
      [_ | tailtail] = tail
      Q2.find_divisible([head] ++ tailtail) || Q2.find_divisible(tail)
    end
  end

  def get_div_if_even(n, m) do
    cond do
      rem(n, m) === 0 ->
        div(n, m)
      rem(m, n) === 0 ->
        div(m, n)
      true ->
        nil
    end
  end

  def p1 do
    Utils.file_to_2d_int_array("input.txt")
      |> Enum.map(fn(innerArray) -> Q2.min_max_diff(innerArray) end)
      |> Enum.sum
      |> IO.inspect
  end

  def p2 do
    Utils.file_to_2d_int_array("input.txt")
      |> Enum.map(fn(innerArray) -> Q2.find_divisible(innerArray) end)
      |> Enum.sum
      |> IO.inspect
  end
end

Q2.p1()
Q2.p2()
