defmodule WildWestStore do
  alias WildWestStore.{Basket, RecieptPrinter}

  @moduledoc """
  Big Bills Shop, Wild West Store operations.
  """

  @doc """
  returns a receipt with items including the tax
  """
  def purchase(input) do
    input
    |> Basket.decode()
    |> RecieptPrinter.print()
    |> String.trim()
  end
end

defmodule WildWestStore.CartItem do
  @enforce_keys [:type, :price]

  defstruct title: "some prod",
            type: nil,
            is_imported: false,
            price: 0,
            quantity: 1

  def from_line(string) do
    list = String.split(string)
    [quantity | remaining] = list
    {price_string, without_price} = List.pop_at(remaining, -1)
    {price_float, _} = Float.parse(price_string)
    {_, without_price_and_at} = List.pop_at(without_price, -1)
    title = Enum.join(without_price_and_at, " ")
    is_imported = Enum.member?(without_price_and_at, "imported")

    %__MODULE__{
      quantity: String.to_integer(quantity),
      title: title,
      type: :book,
      price: price_float,
      is_imported: is_imported
    }
  end

  def add_service_tax_to_item(%__MODULE__{} = _item) do
  end
end
