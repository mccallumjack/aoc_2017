defmodule Runner do
  alias Runner

  def checksum do
    file = "input.txt"

    file
    |> File.stream!
    |> Stream.map(&handle_line/1)
    |> Stream.map(&filter/1)
    |> Enum.to_list
    |> Enum.sum
  end

  def handle_line(line) do
    line
    |> String.split(~r{\s}, trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  def filter(list) do
    list
    |> Enum.min_max
    |> range
  end

  def range({min, max}), do: max - min
end
