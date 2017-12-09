defmodule Q8 do
  Code.require_file "../utils.exs", __DIR__

  def build_register_map do
    Utils.file_to_string_array("input.txt") |> Enum.reduce(%{}, &add_register/2)
  end

  def add_register(line, map) do
    [r1, _, _, _, r2, _, _] = String.split(line)
    map = Map.put_new(map, r1, 0)
    Map.put_new(map, r2, 0)
  end

  @change_function %{
    "dec" => &-/2,
    "inc" => &+/2
  }

  @comparison_operators %{
    ">=" => &>=/2,
    "<=" => &<=/2,
    ">" => &>/2,
    "<" => &</2,
    "==" => &==/2,
    "!=" => &!=/2
  }

  def run_instruction(instruction, registers) do
    [receiver_key, func, change_amount, _, condition_key, comparison_operator, comparison_amount] = String.split(instruction)

    func = @change_function[func]
    comparison_func = @comparison_operators[comparison_operator]
    change_amount = String.to_integer(change_amount)
    comparison_amount = String.to_integer(comparison_amount)

    if comparison_func.(registers[condition_key], comparison_amount) do
      value = func.(registers[receiver_key], change_amount)
      registers = Map.put(registers, receiver_key, value)
      if value > Map.get(registers, :max_val) do
        Map.put(registers, :max_val, value)
      else
        registers
      end
    else
      registers
    end
  end

  def process_instructions(registers) do
    Utils.file_to_string_array("input.txt") |> Enum.reduce(registers, &run_instruction/2)
  end

  def p1 do
    registers = build_register_map()
    process_instructions(registers)
      |> Map.values
      |> Enum.max
      |> IO.inspect
  end

  def p2 do
    registers = build_register_map()
    registers = Map.put(registers, :max_val, 0)
    process_instructions(registers)
      |> Map.get(:max_val)
      |> IO.inspect
  end
end

Q8.p1()
Q8.p2()
