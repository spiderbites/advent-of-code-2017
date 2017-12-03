# Spiral movement pattern
## R1, U1, L2, D2, R3, U3, L4, D4, ...

defmodule Q3 do
  Code.require_file "../utils.exs", __DIR__

  @input 265149

  def right([x, y]) do
    [x+1, y]
  end

  def up([x, y]) do
    [x, y+1]
  end

  def left([x, y]) do
    [x-1, y]
  end

  def down([x, y]) do
    [x, y-1]
  end

  def next_direction('R'), do: 'U'
  def next_direction('U'), do: 'L'
  def next_direction('L'), do: 'D'
  def next_direction('D'), do: 'R'

  def coords_func('R'), do: &Q3.right/1
  def coords_func('U'), do: &Q3.up/1
  def coords_func('L'), do: &Q3.left/1
  def coords_func('D'), do: &Q3.down/1

  # end state
  def next(@input, coords, _, _, _, _) do
    coords
  end

  # finished moving in direction
  def next(num, coords, direction, 0, ringsize, 1) do
    next(num, coords, Q3.next_direction(direction), ringsize, ringsize, 2)
  end

  def next(num, coords, direction, 0, ringsize, 2) do
    next(num, coords, Q3.next_direction(direction), ringsize + 1, ringsize + 1, 1)
  end

  # continuing in direction
  def next(num, coords, direction, remaining_steps, ringsize, iteration) do
    next(num + 1, Q3.coords_func(direction).(coords), direction, remaining_steps - 1, ringsize, iteration)
  end

  def p1 do
    Q3.next(1, [0,0], 'R', 1, 1, 1)
      |> Enum.map(fn(x) -> abs(x) end)
      |> Enum.sum
      |> IO.inspect
  end

  # finished moving in direction
  def p2next(num, coords, direction, 0, ringsize, 1, map) do
    p2next(num, coords, Q3.next_direction(direction), ringsize, ringsize, 2, map)
  end

  def p2next(num, coords, direction, 0, ringsize, 2, map) do
    p2next(num, coords, Q3.next_direction(direction), ringsize + 1, ringsize + 1, 1, map)
  end

  # continuing in direction
  def p2next(num, coords, direction, remaining_steps, ringsize, iteration, map) do
    value = Q3.sum_surrounding(coords, map)
    if value > @input do
      value
    else
      [x, y] = coords
      map = Utils.set_in(map, [x, y], value)
      p2next(num + 1, Q3.coords_func(direction).(coords), direction, remaining_steps - 1, ringsize, iteration, map)
    end
  end

  def sum_surrounding([x, y], map) do
    Utils.get_nested(map, [x+1, y], 0) +
    Utils.get_nested(map, [x-1, y], 0) +
    Utils.get_nested(map, [x, y+1], 0) +
    Utils.get_nested(map, [x, y-1], 0) +
    Utils.get_nested(map, [x+1, y+1], 0) +
    Utils.get_nested(map, [x-1, y+1], 0) +
    Utils.get_nested(map, [x+1, y-1], 0) +
    Utils.get_nested(map, [x-1, y-1], 0)
  end

  def p2 do
    Q3.p2next(2, [1,0], 'U', 1, 1, 2, %{0 => %{0 => 1}})
      |> IO.inspect
  end
end

Q3.p1()
Q3.p2()
