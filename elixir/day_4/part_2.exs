defmodule Runner do

  def run do
    File.stream!("input.txt") 
    |> Stream.map(&split_into_lines/1)
    |> Stream.filter(&check_uniqueness/1)
    |> Enum.to_list
    |> length
  end

  def split_into_lines(string), do: string |> String.trim |> String.split(" ")

  def check_uniqueness(line) do
    sorted_line = sort_words(line)
    Enum.uniq(sorted_line) == sorted_line
  end

  def sort_words(line) do
    Enum.map(line, fn (x) ->
      x |> String.graphemes |> Enum.sort |> Enum.join
    end)
  end
end

IO.puts Runner.run
