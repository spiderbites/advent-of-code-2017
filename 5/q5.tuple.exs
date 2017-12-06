# note: using tuple - much faster

defmodule Q5 do
  Code.require_file "../utils.exs", __DIR__

  def jump(tuple, position, steps) do
    if position > tuple_size(tuple) - 1 do
      steps
    else
      value = elem(tuple, position)
      jump(put_elem(tuple, position, value + 1), position + value, steps + 1)
    end
  end

  def jump_p2(tuple, position, steps) do
    if position > tuple_size(tuple) - 1 do
      steps
    else
      value = elem(tuple, position)
      if value >= 3 do
        jump_p2(put_elem(tuple, position, value - 1), position + value, steps + 1)
      else
        jump_p2(put_elem(tuple, position, value + 1), position + value, steps + 1)
      end
    end
  end

  def p1 do
    Utils.file_to_int_array("input.txt")
      |> List.to_tuple
      |> jump(0, 0)
      |> IO.inspect
  end

  def p2 do
    Utils.file_to_int_array("input.txt")
      |> List.to_tuple
      |> jump_p2(0, 0)
      |> IO.inspect
  end
end

Q5.p1()
Q5.p2()

# Code.require_file "../benchmark.exs", __DIR__
# IO.inspect Benchmark.measure(fn -> Q5.p1() end)
# IO.inspect Benchmark.measure(fn -> Q5.p2() end)

