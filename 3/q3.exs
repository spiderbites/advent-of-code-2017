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

  @next_direction %{
    :R => :U,
    :U => :L,
    :L => :D,
    :D => :R
  }

  @move_func %{
    :R => &Q3.right/1,
    :U => &Q3.up/1,
    :L => &Q3.left/1,
    :D => &Q3.down/1
  }

  def p1 do
    walk_spiral(1, [0,0], :R, 1, 1, 1)
      |> Enum.map(fn(x) -> abs(x) end)
      |> Enum.sum
      |> IO.inspect
  end

  # args are...
  # num: the step number
  # coords: the coords for this step
  # direction: current direction we're moving in
  # remaining_steps: num steps remaining for this direction
  # ringsize: number of steps on this edge of the spiral
  # iteration: 1 or 2, the time through for this ringsize
  # (for part 2) map: a map of values for each coord, where m,n can be accessed at map[m][n]

  # Reached the @input location, return its coords
  def walk_spiral(@input, coords, _, _, _, _) do
    coords
  end

  # finished moving in direction first time for ringsize
  def walk_spiral(num, coords, direction, 0, ringsize, 1) do
    walk_spiral(num, coords, @next_direction[direction], ringsize, ringsize, 2)
  end

  # finished moving in direction second time for ringsize
  def walk_spiral(num, coords, direction, 0, ringsize, 2) do
    walk_spiral(num, coords, @next_direction[direction], ringsize + 1, ringsize + 1, 1)
  end

  # continuing in direction
  def walk_spiral(num, coords, direction, remaining_steps, ringsize, iteration) do
    walk_spiral(num + 1, @move_func[direction].(coords), direction, remaining_steps - 1, ringsize, iteration)
  end



  # finished moving in direction first time for ringsize
  def walk_spiral_p2(num, coords, direction, 0, ringsize, 1, map) do
    walk_spiral_p2(num, coords, @next_direction[direction], ringsize, ringsize, 2, map)
  end

  # finished moving in direction second time for ringsize
  def walk_spiral_p2(num, coords, direction, 0, ringsize, 2, map) do
    walk_spiral_p2(num, coords, @next_direction[direction], ringsize + 1, ringsize + 1, 1, map)
  end

  # continuing in direction
  def walk_spiral_p2(num, coords, direction, remaining_steps, ringsize, iteration, map) do
    value = sum_surrounding(coords, map)
    if value > @input do
      value
    else
      map = Utils.set_in(map, coords, value)
      walk_spiral_p2(num + 1, @move_func[direction].(coords), direction, remaining_steps - 1, ringsize, iteration, map)
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
    walk_spiral_p2(2, [1,0], :U, 1, 1, 2, %{0 => %{0 => 1}})
      |> IO.inspect
  end
end

Q3.p1()
Q3.p2()
