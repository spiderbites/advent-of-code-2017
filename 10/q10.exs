defmodule Q10 do
  use Bitwise

  def run(length, {list, current_position, skip_size, list_length}) do
    after_reverse = circular_reverse(list, list_length, current_position, length)
    current_position = rem(current_position + length + skip_size, list_length)
    {after_reverse, current_position, skip_size + 1, list_length}
  end

  def circular_reverse(list, list_length, start, size) do
    if start + size < list_length do
      Enum.reverse_slice(list, start, size)
    else
      back_length = list_length - start
      front_length = size - back_length

      back_piece = Enum.slice(list, start..-1)

      front_piece = case front_length do
        0 -> []
        _ -> Enum.slice(list, 0..front_length-1)
      end

      middle_piece = Enum.slice(list, front_length..start-1)

      reversed = Enum.reverse(back_piece ++ front_piece)
      new_back_piece = Enum.slice(reversed, 0..back_length-1)
      new_front_piece = Enum.slice(reversed, back_length..-1)

      new_front_piece ++ middle_piece ++ new_back_piece
    end
  end

  def p1 do
    list = Enum.to_list 0..255
    lengths = File.read("input.txt") |> elem(1) |> String.split(",") |> Enum.map(&String.to_integer/1)
    list_length = 256
    end_state = Enum.reduce(lengths, {list, 0, 0, list_length}, &Q10.run/2)
    end_list = elem(end_state, 0)
    IO.inspect Enum.at(end_list, 0) * Enum.at(end_list, 1)
  end

  # end of rounds
  def compute_sparse_hash(_, list, _, _, _, 64) do
    list
  end

  def compute_sparse_hash(lengths, list, current_position, skip_size, list_length, round) do
    {list, current_position, skip_size, _} = Enum.reduce(lengths, {list, current_position, skip_size, list_length}, &Q10.run/2)
    compute_sparse_hash(lengths, list, current_position, skip_size, list_length, round + 1)
  end

  def compute_dense_hash(list) do
    Enum.chunk_every(list, 16)
    |> Enum.map(fn(chunk) -> Enum.reduce(chunk, &bxor/2) end)
  end

  def p2 do
    list = Enum.to_list 0..255
    lengths = File.read("input.txt") |> elem(1) |> to_charlist |> Enum.concat([17, 31, 73, 47, 23])
    compute_sparse_hash(lengths, list, 0, 0, 256, 0)
    |> compute_dense_hash()
    |> Enum.map(fn(x) -> Base.encode16(<<x>>, case: :lower) end)
    |> Enum.join
    |> IO.inspect
  end
end

Q10.p1()
Q10.p2()
