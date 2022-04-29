defmodule WildWestStore.Basket do
  alias WildWestStore.CartItem

  def decode(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
    |> Enum.map(&decode_line(&1))

    # |> Enum.map(&CartItem.from_line(&1))
  end

  defp decode_line(line) do
    CartItem.from_line(line)
  end
end
