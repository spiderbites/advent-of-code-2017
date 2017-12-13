defmodule Q12 do
  def parse_line(line) do
    [source, connections] = String.split(line, " <-> ")
    connections = String.split(connections, ", ")
    {source, connections}
  end

  def add_to_graph({source, connections}, graph) do
    Map.put(graph, source, connections)
  end

  def build_graph(filepath) do
    File.read(filepath) |> elem(1)
    |> String.split("\n")
    |> Enum.map(&parse_line/1)
    |> Enum.reduce(%{}, &add_to_graph/2)
  end

  def bfs(_, {_, []}, seen) do
    seen
  end

  def bfs(graph, {node, [head | tail]}, seen) do
    result1 = cond do
      MapSet.member?(seen, head) -> MapSet.new
      true -> bfs(graph, {head, graph[head]}, MapSet.put(seen, head))
    end

    result2 = bfs(graph, {node, tail}, MapSet.put(seen, head))

    MapSet.union(result1, result2)
  end

  def find_all_groups(graph) do
    nodes = Map.keys(graph)
    Enum.reduce(nodes, MapSet.new, &add_group({&1, graph}, &2))
  end

  def add_group({node, graph}, groups) do
    group = bfs(graph, {node, graph[node]}, MapSet.new)
      |> MapSet.to_list
      |> Enum.sort
    MapSet.put(groups, group)
  end

  def p1 do
    graph = build_graph("input.txt")
    reachable = bfs(graph, {"0", graph["0"]}, MapSet.new)
    IO.inspect MapSet.size(reachable)
  end

  def p2 do
    graph = build_graph("input.txt")
    find_all_groups(graph)
    |> MapSet.size
    |> IO.inspect
  end
end

Q12.p1()
Q12.p2()