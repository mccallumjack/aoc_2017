defmodule Runner do
  alias Runner

  def checksum do
    file = "input.txt"

    file
    |> File.stream!
    |> Stream.map(&handle_line/1)
    |> Enum.to_list
    |> Enum.sum
  end

  def handle_line(line) do
    line
    |> String.split(~r{\s}, trim: true)
    |> Enum.map(&String.to_integer/1)
    |> range
  end

  def range([head | tail]), do: range(tail, head, head)
  def range([], min, max), do: min - max
  def range([head | tail], min, max) when head > max, do: range(tail, min, head)
  def range([head | tail], min, max) when head < min, do: range(tail, head, max)
  def range([_head | tail], min, max), do: range(tail, min, max)

end
