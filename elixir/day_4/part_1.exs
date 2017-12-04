defmodule Runner do

  def run do
    File.stream!("input.txt") 
    |> Stream.map(&split_into_lines/1)
    |> Stream.filter(&check_uniqueness/1)
    |> Enum.to_list
    |> length
  end

  def split_into_lines(string), do: string |> String.trim |> String.split(" ")
  def check_uniqueness(line), do: Enum.uniq(line) == line
end

IO.puts Runner.run
