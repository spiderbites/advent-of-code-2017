# note: using map - faster still

defmodule Q5 do
  Code.require_file "../utils.exs", __DIR__

  def jump(map, position, steps) do
    if position > map_size(map) - 1 do
      steps
    else
      value = map[position]
      jump(Map.put(map, position, value + 1), position + value, steps + 1)
    end
  end

  def jump_p2(map, position, steps) do
    if position > map_size(map) - 1 do
      steps
    else
      %{^position => value} = map
      if value >= 3 do
        jump_p2(Map.put(map, position, value - 1), position + value, steps + 1)
      else
        jump_p2(Map.put(map, position, value + 1), position + value, steps + 1)
      end
    end
  end

  def p1 do
    Utils.file_to_int_array("input.txt")
      |> Utils.list_to_map
      |> jump(0, 0)
      |> IO.inspect
  end

  def p2 do
    Utils.file_to_int_array("input.txt")
      |> Utils.list_to_map
      |> jump_p2(0, 0)
      |> IO.inspect
  end
end

Q5.p1()
Q5.p2()

# Code.require_file "../benchmark.exs", __DIR__
# IO.inspect Benchmark.measure(fn -> Q5.p1() end)
# IO.inspect Benchmark.measure(fn -> Q5.p2() end)

