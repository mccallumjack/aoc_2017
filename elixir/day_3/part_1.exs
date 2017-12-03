defmodule Runner do
  def run(num) do
    side_length = num |> sq_rt |> Float.ceil |> round
    distance_to_mid = div(side_length, 2)
    distance_to_mid_of_side = distance_from_center(side_length, num)

    IO.puts distance_to_mid
    IO.puts distance_to_mid_of_side

    distance_to_mid + distance_to_mid_of_side
  end

  def sq(num), do: num * num
  def sq_rt(num), do: :math.sqrt(num)

  def distance_from_center(length, num) do
    sm_sq = sq(length - 2)

    index = rem(num - sm_sq, length - 1)
    center_index = div(length, 2)

    abs(center_index - index)
  end

end

# IO.puts System.argv() |> List.first |> String.to_integer |> Runner.run
