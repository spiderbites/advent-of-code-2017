defmodule Q1 do
  Code.require_file "../utils.exs", __DIR__

  def nums_match(a, b) do
    if a === b do
      a
    else
      0
    end
  end

  def get_halfway_index(index, list_len) do
    rem(index + div(list_len, 2), list_len)
  end

  def p1 do
    nums = Utils.file_to_int_list("input.txt")
    wraparound_num = Q1.nums_match(hd(nums), List.last(nums))
    nums
      |> Enum.chunk_every(2, 1, :discard)
      |> Enum.map(fn(x) -> Q1.nums_match(hd(x), List.last(x)) end)
      |> Enum.sum
      |> Kernel.+(wraparound_num)
      |> IO.puts
  end

  def p2 do
    nums = Utils.file_to_int_list("input.txt")
    list_len = length(nums)
    nums
      |> Enum.with_index
      |> Enum.map(fn({num, index}) -> Q1.nums_match(num, Enum.at(nums, Q1.get_halfway_index(index, list_len))) end)
      |> Enum.sum
      |> IO.puts
  end
end

Q1.p1()
Q1.p2()
