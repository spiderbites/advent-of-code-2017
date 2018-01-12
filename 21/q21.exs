defmodule Q21 do

  # @init ".#...####"

  @init "#..#........#..#"

  @inputpath "sample.txt"
  @size_2_rule_length 20
  @size_3_rule_length 34

  def build_rule(line) do
    [rule, result] = String.split(line, " => ")
    %{String.split(rule, "/") => String.split(result, "/")}
  end

  def build_rule_book() do
    lines = File.read(@inputpath)
    |> elem(1)
    |> String.split("\n")

    size_2_rules = Enum.filter(lines, fn(line) -> String.length(line) == @size_2_rule_length end)
    size_3_rules = Enum.filter(lines, fn(line) -> String.length(line) == @size_3_rule_length end)

    { Enum.map(size_2_rules, &build_rule/1), Enum.map(size_3_rules, &build_rule/1) }
  end


  def chunk_grid(grid, length) when length <= 9, do: grid

  def chunk_grid(grid, length) do
    grid_size = cond do
      rem(String.length(grid), 2) == 0 -> 2
      rem(String.length(grid), 3) == 0 -> 3
    end

    chunk_amt = div(length, grid_size)

    # ab cd ef gh ij kl mn op
    # 02
    # 13
    # 46
    # 57

    # abef
    # cdgh
    # ijmn
    # klop

    chunked = String.split(grid, "", trim: true)
    |> Enum.chunk_every(grid_size)
    |> Enum.with_index()


    for n <- grid_size..length do
      Enum.take_while(chunked, fn({_, index}) -> rem(2, index) == 0 and index < n end)
    end

    # |> Enum.map(&Enum.join(&1))


  end

  def p1 do
    # build_rule_book()
    chunk_grid(@init, String.length(@init))
    |> IO.inspect
  end
end

Q21.p1()