defmodule Q10 do

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
      front_piece = Enum.slice(list, 0..front_length-1)
      middle_piece = Enum.slice(list, front_length..start-1)

      reversed = Enum.reverse(back_piece ++ front_piece)
      new_back_piece = Enum.slice(reversed, 0..back_length-1)
      new_front_piece = Enum.slice(reversed, back_length..-1)

      new_front_piece ++ middle_piece ++ new_back_piece
    end
  end

  def p1 do
    list = Enum.to_list 0..255
    lengths = [31,2,85,1,80,109,35,63,98,255,0,13,105,254,128,33]
    list_length = 256
    end_state = Enum.reduce(lengths, {list, 0, 0, list_length}, &Q10.run/2)
    end_list = elem(end_state, 0)
    IO.inspect Enum.at(end_list, 0) * Enum.at(end_list, 1)
  end

end

Q10.p1()