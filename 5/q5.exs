# note: using list - slow AF

defmodule Q5 do
  Code.require_file "../utils.exs", __DIR__

  def jump(array, position, steps) do
    if position > length(array) - 1 do
      steps
    else
      value = Enum.at(array, position)
      jump(List.replace_at(array, position, value + 1), position + value, steps + 1)
    end
  end

  def jump_p2(array, position, steps) do
    if position > length(array) - 1 do
      steps
    else
      value = Enum.at(array, position)
      if value >= 3 do
        jump_p2(List.replace_at(array, position, value - 1), position + value, steps + 1)
      else
        jump_p2(List.replace_at(array, position, value + 1), position + value, steps + 1)
      end
    end
  end

  def p1 do
    Utils.file_to_int_array("input.txt")
      |> jump(0, 0)
      |> IO.inspect
  end

  def p2 do
    Utils.file_to_int_array("input.txt")
    |> jump_p2(0, 0)
    |> IO.inspect
  end
end

Q5.p1()
Q5.p2()

# Code.require_file "../benchmark.exs", __DIR__
# IO.inspect Benchmark.measure(fn -> Q5.p1() end)
# IO.inspect Benchmark.measure(fn -> Q5.p2() end)

