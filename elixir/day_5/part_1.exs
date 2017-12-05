defmodule Runner do
  def run do
    "input.txt" |> read_into_int_lines |> advance
  end

  def read_into_int_lines(input), do: File.read!(input) |> String.split("\n", trim: true) |> Enum.map(&String.to_integer/1)

  def advance(list), do: advance(list, 0, 0)
  def advance(list, index, steps) when index >= length(list), do: steps
  def advance(list, index, steps) do 
    val = Enum.at list, index

    advance(List.replace_at(list, index, val + 1), index + val, steps + 1)
  end
end

IO.puts(Runner.run)
