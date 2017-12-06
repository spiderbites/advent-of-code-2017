defmodule Day05b do

    def to_char_array(input), do: String.split(input, "\n", trim: true)

    def to_integer(input), do: Enum.map(input, &String.to_integer/1)

    def read_input(input \\ "input.txt") do
      case File.read(input) do
        {:ok, body} -> body
        {:error, reason} -> IO.inspect reason
      end
    end

    def jump(_, _, position, steps) when (position < 0), do: steps
    def jump(_, instruction_length, position, steps) when (position >= instruction_length), do: steps
    def jump(list, instruction_length, position, steps) do
      current_instruction = list[position]
      jump(modify(list, position, current_instruction), instruction_length, position + current_instruction, (steps + 1))
    end

    def modify(list, position, current_instruction) when current_instruction >= 3, do: Map.put(list, position, current_instruction - 1)
    def modify(list, position, current_instruction) when current_instruction < 3, do: Map.put(list, position, current_instruction + 1)

    def solve do
      input = read_input()
              |> to_char_array
              |> to_integer
              |> Enum.with_index
              |> Enum.reduce(
                   %{},
                   fn ({number, index}, acc) -> Map.put(acc, index, number)end
                 )

      jump(input, Enum.count(input), 0, 0)
    end
  end

Code.require_file "../benchmark.exs", __DIR__
IO.inspect Benchmark.measure(fn -> Day05b.solve end)