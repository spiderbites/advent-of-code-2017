defmodule Q9 do
  Code.require_file "../utils.exs", __DIR__

  # at end of stream, return score
  def parse_stream([], _, score, garbage_count) do
    {score, garbage_count}
  end

  # beginning of group, push onto stack
  def parse_stream([ "{" | tail], stack, score, garbage_count) do
    parse_stream(tail, ["{" | stack], score, garbage_count)
  end

  # end of group, remove from stack
  # score is the size of the stack (current nesting level)
  def parse_stream([ "}" | tail], stack, score, garbage_count) do
    stack_size = length(stack)
    [_ | stack_tail] = stack
    parse_stream(tail, stack_tail, score + stack_size, garbage_count)
  end

  # cancel character: remove it and next char from stream
  def parse_stream([ "!" | tail], stack, score, garbage_count) do
    [_ | tailtail] = tail
    parse_stream(tailtail, stack, score, garbage_count)
  end

  # garbage start
  def parse_stream([ "<" | tail], stack, score, garbage_count) do
    {rest, count} = find_garbage_end(tail, 0)
    parse_stream(rest, stack, score, garbage_count + count)
  end

  # any other character
  def parse_stream([ _ | tail], stack, score, garbage_count) do
    parse_stream(tail, stack, score, garbage_count)
  end

  # cancel character: remove it and next char from stream
  def find_garbage_end([ "!" | tail ], count) do
    [_ | tailtail] = tail
    find_garbage_end(tailtail, count)
  end

  # end of garbage
  def find_garbage_end([ ">" | tail ], count) do
    {tail, count}
  end

  # inside garbage, continue...
  def find_garbage_end([_ | tail], count) do
    find_garbage_end(tail, count + 1)
  end

  def run_sample do
    File.read("sample.txt")
    |> elem(1)
    |> String.split("\n")
    |> Enum.map(fn(line) -> String.split(line, "") |> Enum.reject(fn(el) -> el == "" end) end)
    |> Enum.map(fn(stream) -> parse_stream(stream, [], 0, 0) end)
    |> Enum.map(&IO.inspect/1)
  end

  def run do
    File.read("input.txt")
    |> elem(1)
    |> String.split("")
    |> parse_stream([], 0, 0)
    |> IO.inspect
  end
end

Q9.run()