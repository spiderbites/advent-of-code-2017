defmodule Q14 do
  use Bitwise
  Code.require_file "../10/q10.exs", __DIR__

  @input "vbqugkhl-"
  # @input "flqrgnkx-"

  @used "#"
  @free "."

  def bitcount(0, count) do
    count
  end

  # Returns the number of ones in a binary number
  # https://en.wikipedia.org/wiki/Hamming_weight#cite_note-Wegner_1960-10
  def bitcount(b, count) do
    bitcount(b &&& (b - 1), count + 1)
  end

  def run_bitcount(input, num) do
    input <> Integer.to_string(num)
    |> to_charlist
    |> Q10.knot_hash()
    |> Base.decode16!(case: :lower)
    |> :binary.bin_to_list
    |> Enum.map(&bitcount(&1, 0))
    |> Enum.sum
  end

  def build_grid_row(input, num) do
    blah = input <> Integer.to_string(num)
    |> to_charlist
    |> Q10.knot_hash()
    |> String.split("", trim: true)
    |> Enum.map(&Integer.parse(&1, 16))
    |> Enum.map(&elem(&1, 0))
    |> Enum.map(&binary_string(&1))
    |> Enum.map(&String.pad_leading(&1, 4, "."))
    |> Enum.join
    |> String.split("", trim: true)
  end

  def build_grid() do
    Enum.to_list 0..127 |> Enum.map(&build_grid_row(@input, &1))
  end

  def binary_string(b) when b == 0, do: @free

  def binary_string(b) when b == 1, do: @used

  def binary_string(b) do
    chr = case rem(b, 2) do
      0 -> @free
      1 -> @used
    end
    binary_string(div(b, 2)) <> chr
  end

  def p1 do
    Enum.to_list 0..127
    |> Enum.map(&run_bitcount(@input, &1))
    |> Enum.sum
    |> IO.inspect
  end

  def p2 do
    build_grid()
    |> IO.inspect(limit: :infinity)
  end
end

# Q14.p1()
Q14.p2()
