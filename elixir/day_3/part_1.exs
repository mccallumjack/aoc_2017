defmodule Runner do

  def run(num) do
    matrix = Enum.to_list(1..num) |> wrap
    # print_matrix matrix
    IO.puts distance_to_middle(matrix, num)
  end

  def distance_to_middle(matrix, num) do
    {root_x, root_y} = coordinates(matrix, 1)
    {num_x, num_y} = coordinates(matrix, num)

    IO.puts root_x
    IO.puts root_y

    IO.puts num_x
    IO.puts num_y

    abs(root_x - num_x) + abs(root_y - num_y)
  end

  def coordinates(matrix, num) do
    y = Enum.find_index(matrix, fn(l) -> Enum.member?(l, num) end)
    x = Enum.at(matrix, y) |> Enum.find_index(fn(m) -> m == num end)

    {x, y}
  end

  # (direction, list, matrix)
  def wrap([list_head | list_tail]), do: wrap(:right, List.wrap(list_tail), [[list_head]])
  def wrap(_, [], matrix) do
    matrix
  end

  def wrap(:left, [list_head | list_tail], matrix) do
    direction = change_direction(matrix,  :left, :down)

    [matrix_head | matrix_tail] = matrix

    wrap(direction, list_tail, [[list_head] ++ matrix_head] ++ matrix_tail)
  end

  def wrap(:down, [list_head | list_tail], matrix) do
    direction = change_direction(matrix, :down, :right)

    wrap(direction, list_tail, prepend_to_row_with_target(matrix, list_head, length(List.first matrix)))
  end

  def wrap(:right, [list_head | list_tail], matrix) do
    direction = change_direction(matrix, :right, :up)

    wrap(direction, list_tail, append_to_last_row(matrix, list_head))
  end

  def wrap(:up, [list_head | list_tail], matrix) do
    direction = change_direction(matrix, :up, :left)

    wrap(direction, list_tail, append_to_row_with_target(matrix, list_head, length(List.last matrix)))
  end

  def change_direction(matrix, current, changed) do
    cond do
      length(List.first matrix) == length(List.last matrix) -> changed
      true                                                  -> current
    end
  end

  # Find the first one that is less than the target number and prepend number to it
  def prepend_to_row_with_target(list, num, number), do: prepend_to_row_with_target(list, num, [], number)
  def prepend_to_row_with_target([], num, processed, _number), do: processed ++ [[num]]
  def prepend_to_row_with_target([head | tail], num, processed, number) do
    cond do
      length(head) < number -> processed ++ [[num] ++ head] ++ tail
      true                  -> prepend_to_row_with_target(tail, num, processed ++ [head], number)
    end
  end

  # Find the first one that is less than the target number and append number to it
  def append_to_row_with_target(list, num, number), do: append_to_row_with_target(Enum.reverse(list), num, [], number)
  def append_to_row_with_target([], num, processed, _number), do: Enum.reverse(processed ++ [[num]])
  def append_to_row_with_target([head | tail], num, processed, number) do
    cond do
      length(head) < number -> Enum.reverse(processed ++ [head ++ [num]] ++ tail)
      true                  -> append_to_row_with_target(tail, num, processed ++ [head], number)
    end
  end

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
