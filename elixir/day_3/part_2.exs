defmodule Runner do

  def run(num) do
    matrix = Enum.to_list(1..num) |> wrap
    print_matrix matrix
    IO.puts distance_to_middle(matrix, num)
  end

  def distance_to_middle(matrix, num) do
    {root_x, root_y} = coordinates(matrix, 1)
    {num_x, num_y} = coordinates(matrix, num)

    abs(root_x - num_x) + abs(root_y - num_y)
  end

  def coordinates(matrix, num) do
    y = Enum.find_index(matrix, fn(l) -> Enum.member?(l, num) end)
    x_row = Enum.at(matrix, y)
    x = x_row |> Enum.find_index(fn(m) -> m == num end)

    root_length = length(Enum.at(matrix, div(length(matrix), 2)))
    y_length = length(Enum.at(matrix, y))

    if x_row == List.first matrix do
      {x + abs(y_length - root_length), y}
    else
      {x, y}
    end
  end

  # (direction, list, matrix)
  def wrap([list_head | list_tail]), do: wrap(:right, List.wrap(list_tail), [[list_head]])
  def wrap(_, [], matrix), do: matrix
  def wrap(direction, [list_head | list_tail], matrix), do: wrap(change_direction(matrix, direction), list_tail, apply(Runner, direction, [matrix, list_head]))

  # These create the new matrix based on which direction we are moving
  def left([matrix_head | matrix_tail], list_head), do: [[list_head] ++ matrix_head] ++ matrix_tail
  def down(matrix, list_head),                      do: prepend_to_row_with_target(matrix, list_head, length(List.first matrix))
  def right(matrix, list_head),                     do: append_to_last_row(matrix, list_head)
  def up(matrix, list_head),                        do: append_to_row_with_target(matrix, list_head, length(List.last matrix))

  # Calculate if a direction change is needed each time
  def change_direction(matrix, current) do

    clockwise_sequence = %{
      left: :down,
      down: :right,
      right: :up,
      up: :left
    }

    cond do
      length(List.first matrix) == length(List.last matrix) -> clockwise_sequence[current]
      true                                                  -> current
    end
  end

  def calculate_number(num, matrix) do

  end

  # Find the first one that is less than the target number and prepend number to it
  def prepend_to_row_with_target(list, num, number), do: prepend_to_row_with_target(list, num, [], number)
  def prepend_to_row_with_target([], num, processed, _number), do: processed ++ [[num]]
  def prepend_to_row_with_target([head | tail], num, processed, number) when length(head) < number, do: processed ++ [[num] ++ head] ++ tail
  def prepend_to_row_with_target([head | tail], num, processed, number), do: prepend_to_row_with_target(tail, num, processed ++ [head], number)

  # Find the first one that is less than the target number and append number to it
  def append_to_row_with_target(list, num, number), do: append_to_row_with_target(Enum.reverse(list), num, [], number)
  def append_to_row_with_target([], num, processed, _number), do: Enum.reverse(processed ++ [[num]])
  def append_to_row_with_target([head | tail], num, processed, number) when length(head) < number, do: Enum.reverse(processed ++ [head ++ [num]] ++ tail)
  def append_to_row_with_target([head | tail], num, processed, number), do: append_to_row_with_target(tail, num, processed ++ [head], number)

  def append_to_last_row(matrix, num) do
    [head | tail] = Enum.reverse matrix

    Enum.reverse(tail) ++ [head ++ [num]]
  end

  def print_matrix(matrix) do
    max_l = List.flatten(matrix) |> Enum.max |> Integer.to_string |> String.length

    for x <- matrix do
      IO.puts Enum.map(x, fn(y) -> Integer.to_string(y) |> String.pad_leading(max_l, " ") end) |> Enum.join("  -  ")
    end

    :ok
  end
end
