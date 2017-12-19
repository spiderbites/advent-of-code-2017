defmodule Q7 do
  Code.require_file "../utils.exs", __DIR__

  def partition_parents_and_children(line, { parents, children }) do
    cond do
      String.contains?(line, "->") ->
        [program, new_children] = String.split(line, "->")
        [parent, _] = String.split(program)
        new_children = String.split(new_children, ",") |> Enum.map(fn x -> String.trim(x) end)
        { [parent | parents], new_children ++ children  }
      true ->
        [child, _] = String.split(line)
        { parents, [child | children] }
    end
  end

  def add_weight(line, weights) do
    [program, _] = String.split(line, ")")
    [name, weight] = String.split(program)
    weight = String.replace(weight, ~r/[\(]/, "") |> String.to_integer
    Map.put(weights, name, weight)
  end

  def add_relationship(line, relationships) do
    cond do
      String.contains?(line, "->") ->
        [program, children] = String.split(line, "->")
        [parent, _] = String.split(program)
        children = String.split(children, ",") |> Enum.map(fn x -> String.trim(x) end)
        Map.put(relationships, parent, children)
      true -> # ignore leaf nodes
        relationships
    end
  end

  def weigh(node, weights, relationships) do
    if Map.has_key?(relationships, node) do
      children = relationships[node]
      parent_weight = weights[node]
      childrens_weight = Enum.map(children, fn(child) -> weigh(child, weights, relationships) end) |> Enum.sum
      parent_weight + childrens_weight
    else
      weights[node]
    end
  end

  def find_first_balanced_subtree(node, weights, relationships) do
    children = relationships[node]
    stack_weights = Enum.map(children, fn(child) -> weigh(child, weights, relationships) end)
    if length(Enum.uniq(stack_weights)) == 1 do
      children_weights = Enum.map(children, fn(child) -> weights[child] end)
      { node, children_weights, stack_weights }
    else
      index = find_odd_one_out(stack_weights)
      find_first_balanced_subtree(Enum.at(children, index), weights, relationships)
    end
  end

  def find_odd_one_out(list) do
    counts = Enum.reduce(list, %{}, fn (item, acc) ->
      if acc[item] do
        Map.put(acc, item, acc[item] + 1)
      else
        Map.put(acc, item, 1)
      end
    end)
    Enum.find_index(list, fn (item) -> counts[item] == 1 end)
  end

  def p1 do
    {parents, children} = Utils.file_to_string_array("input.txt")
      |> Enum.reduce({ [], [] }, &partition_parents_and_children/2)

    MapSet.difference(MapSet.new(parents), MapSet.new(children))
    |> IO.inspect
  end

  def p2 do
    file = Utils.file_to_string_array("input.txt")
    weights = Enum.reduce(file, %{}, &add_weight/2)
    relationships = Enum.reduce(file, %{}, &add_relationship/2)
    # IO.inspect relationships
    # IO.inspect weights
    root = MapSet.to_list(p1()) |> Enum.at(0)

    balanced_node = find_first_balanced_subtree(root, weights, relationships) |> IO.inspect

    # root_children = relationships[root]
    # root_children_stack_weights = Enum.map(root_children, fn(child) -> weigh(child, weights, relationships) end)
    # root_children_weights = Enum.map(root_children, fn(child) -> weights[child] end)


    # IO.inspect root_children
    # IO.inspect root_children_stack_weights
    # IO.inspect root_children_weights, charlists: :as_lists


    # IO.inspect find_odd_one_out([1, 1, 2, 1])

  end
end

# Q7.p1()
Q7.p2()
