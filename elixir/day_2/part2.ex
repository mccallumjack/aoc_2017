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
    |> Enum.sort(&(&1 >= &2))
    |> first_divisible
  end

  def first_divisible([head | tail]), do: first_divisible(head, tail, tail)
  def first_divisible(num, [head | _tail], _orig_list) when rem(num, head) == 0, do: num / head
  def first_divisible(num, [_head | tail], orig_list), do: first_divisible(num, tail, orig_list)
  def first_divisible(_num, [], [head | tail]), do: first_divisible(head, tail, tail)
end
