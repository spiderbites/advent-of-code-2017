defmodule Q11 do
  Code.require_file "../utils.exs", __DIR__

  def subtract_from_max(map, k1, k2) do
    {a, b} = {map[k1], map[k2]}
    if a >= b do
      map = Map.put(map, k1, a - b)
      Map.put(map, k2, 0)
    else
      map = Map.put(map, k1, 0)
      Map.put(map, k2, b - a)
    end
  end

  # steps in opposite directions cancel themselves out
  def factor_opposites(step_map) do
    step_map = subtract_from_max(step_map, "n", "s")
    step_map = subtract_from_max(step_map, "nw", "se")
    step_map = subtract_from_max(step_map, "ne", "sw")
    step_map
  end

  # steps can be simplified by replacing with the middle step
  def simplify({k1, k2, mid}, step_map) do
    min = min(step_map[k1], step_map[k2])
    Map.merge(step_map, %{ k1 => step_map[k1] - min, k2 => step_map[k2] - min, mid => step_map[mid] + min })
  end

  def simplify_all(step_map) do
    simplifications = [
      {"ne", "s", "se"},
      {"se", "sw", "s"},
      {"s", "nw", "sw"},
      {"sw", "n", "nw"},
      {"nw", "ne", "n"},
      {"n", "se", "ne"}
    ]
    Enum.reduce(simplifications, step_map, &simplify/2)
  end

  def read_input do
    File.read("input.txt")
    |> elem(1)
    |> String.split(",")
  end

  def shortest_distance(step_map) do
    step_map
    |> factor_opposites
    |> simplify_all
    |> Map.values
    |> Enum.sum
  end

  def find_longest(step, {step_map, furthest}) do
    step_map = Map.put(step_map, step, step_map[step] + 1)
    distance = shortest_distance(step_map)
    {step_map, max(distance, furthest)}
  end

  def p1 do
    counts = read_input() |> Utils.array_counts()
    initial = %{"ne" => 0, "n" => 0, "nw" => 0, "se" => 0, "s" => 0, "sw" => 0}
    Map.merge(initial, counts)
    |> shortest_distance
    |> IO.inspect
  end

  def p2 do
    input = read_input()
    furthest = -1
    step_map = %{"ne" => 0, "n" => 0, "nw" => 0, "se" => 0, "s" => 0, "sw" => 0}

    Enum.reduce(input, {step_map, furthest}, &find_longest/2)
    |> elem(1)
    |> IO.inspect
  end

end

Q11.p1()
Q11.p2()