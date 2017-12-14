defmodule Q13 do

  def build_firewall(filepath) do
    File.read(filepath)
      |> elem(1)
      |> String.split("\n")
      |> Enum.reduce(%{}, &add_layer_to_map/2)
  end

  def add_layer_to_map(line, map) do
    [depth, range] = String.split(line, ": ")
    Map.put(map, String.to_integer(depth), %{range: String.to_integer(range), scanner_pos: 0, scanner_direction: 0})
  end

  def move_scanners(firewall) do
    Enum.reduce(Map.keys(firewall), firewall, fn (layer, acc) -> Map.update!(acc, layer, &move_scanner/1) end)
  end

  # at top, turn around
  def move_scanner(%{range: range, scanner_pos: 0, scanner_direction: 1}) do
    %{range: range, scanner_pos: 1, scanner_direction: 0}
  end

  # at bottom, turn around
  def move_scanner(%{range: range, scanner_pos: scanner_pos, scanner_direction: 0}) when range - 1 == scanner_pos do
    %{range: range, scanner_pos: scanner_pos - 1, scanner_direction: 1}
  end

  # moving down
  def move_scanner(%{range: range, scanner_pos: scanner_pos, scanner_direction: 0}) do
    %{range: range, scanner_pos: scanner_pos + 1, scanner_direction: 0}
  end

  # moving up
  def move_scanner(%{range: range, scanner_pos: scanner_pos, scanner_direction: 1}) do
    %{range: range, scanner_pos: scanner_pos - 1, scanner_direction: 1}
  end

  def move(curr_layer, _, _, severity, max_layer) when curr_layer > max_layer do
    severity
  end

  def move(curr_layer, curr_depth, firewall, severity, max_layer) do
    layer_severity = get_severity(firewall[curr_layer], curr_depth, curr_layer)
    move(curr_layer + 1, curr_depth, move_scanners(firewall), severity + layer_severity, max_layer)
  end

  def get_severity(nil, _, _), do: 0

  def get_severity(%{range: range, scanner_direction: _, scanner_pos: scanner_pos}, curr_depth, curr_layer) do
    if scanner_pos == curr_depth do
      layer_severity(range, curr_layer)
    else
      0
    end
  end

  def layer_severity(range, depth) do
    range * depth
  end

  def max_layer(firewall) do
    Map.keys(firewall) |> Enum.max
  end


  ##### P2

  def build_firewall_p2(filepath) do
    File.read(filepath)
      |> elem(1)
      |> String.split("\n")
      |> Enum.reduce(%{}, &add_layer_to_map_p2/2)
  end

  def add_layer_to_map_p2(line, map) do
    [layer, range] = String.split(line, ": ")
    Map.put(map, String.to_integer(layer), String.to_integer(range))
  end

  def move_p2(picoseconds, firewall) do
    IO.inspect {"picoseconds", picoseconds}
    if Enum.all?(firewall, fn({layer, range}) -> relation(picoseconds, layer, range) end) do
      picoseconds
    else
      move_p2(picoseconds + 1, firewall)
    end
  end

  # Relation to determine whether a layer at some depth with a given range will container a
  # scanner when the the packet crosses it.
  #
  # The packet crosses the layer at time: picoseconds + depth
  # 2 * (range - 1) gives the frequency with which the scanner is at the top of each layer.
  def relation(picoseconds, depth, range) do
    rem(picoseconds + depth, 2 * (range - 1)) != 0
  end

  def p1() do
    firewall = build_firewall("input.txt")
    max_layer = max_layer(firewall)
    move(0, 0, firewall, 0, max_layer)
  end

  def p2() do
    firewall = build_firewall_p2("input.txt")
    move_p2(0, firewall)
  end

end

Q13.p1() |> IO.inspect
Q13.p2() |> IO.inspect
