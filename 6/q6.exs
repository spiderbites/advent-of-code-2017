defmodule Q6 do
  Code.require_file "../utils.exs", __DIR__

  def serialize_distribution(map) do
    Map.values(map)
    |> Enum.join(":")
  end

  def seen_distribution?(distributions, current) do
    Map.has_key?(distributions, current)
  end

  def distribute(banks, _, _, 0), do: banks

  def distribute(banks, num_banks, num_banks, num_blocks) do
    distribute(banks, num_banks, 0, num_blocks)
  end

  def distribute(banks, num_banks, index, num_blocks) do
    %{^index => value} = banks
    distribute(Map.put(banks, index, value + 1), num_banks, index + 1, num_blocks - 1)
  end

  def run_distribute(banks, num_banks) do
    index = max_value_index(banks)
    %{^index => num_blocks} = banks
    banks = Map.put(banks, index, 0)
    distribute(banks, num_banks, index + 1, num_blocks)
  end

  def cycle(banks, num_banks, distributions, steps) do
    if seen_distribution?(distributions, serialize_distribution(banks)) do
      {steps, banks}
    else
      distributions = Map.put(distributions, serialize_distribution(banks), 1)
      banks = run_distribute(banks, num_banks)
      cycle(banks, num_banks, distributions, steps + 1)
    end
  end

  def cycle_until_state(banks, num_banks, steps, match_state) do
    if serialize_distribution(banks) == match_state do
      steps
    else
      banks = run_distribute(banks, num_banks)
      cycle_until_state(banks, num_banks, steps + 1, match_state)
    end
  end

  def max_value_index(banks) do
    Map.keys(banks)
    |> Enum.sort
    |> Enum.max_by(fn(x) -> banks[x] end)
  end

  def p1 do
    banks = Utils.file_to_int_array_tabs("input.txt")
    |> Utils.list_to_map

    cycle(banks, map_size(banks), %{}, 0)
    |> elem(0)
    |> IO.inspect
  end

  def p2 do
    banks = Utils.file_to_int_array_tabs("input.txt")
    |> Utils.list_to_map

    {_, match_state} = cycle(banks, map_size(banks), %{}, 0)
    banks = run_distribute(match_state, map_size(match_state))
    cycle_until_state(banks, map_size(banks), 1, serialize_distribution(match_state))
    |> IO.inspect
  end
end

Q6.p1()
Q6.p2()
