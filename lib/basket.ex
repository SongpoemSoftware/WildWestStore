defmodule WildWestStore.Basket do
  alias WildWestStore.CartItem

  def decode(line) do
    CartItem.from_line(line)
  end
end
