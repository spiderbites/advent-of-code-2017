# https://stackoverflow.com/questions/29668635/how-can-we-easily-time-function-calls-in-elixir

defmodule Benchmark do
  def measure(function) do
    function
    |> :timer.tc
    |> elem(0)
    |> Kernel./(1_000_000)
  end

  def measure_and_return(function) do
    {time, value} = function |> :timer.tc
    time = time |> Kernel./(1_000_000)
    { value, time }
  end
end