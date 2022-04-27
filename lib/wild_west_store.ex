defmodule WildWestStore do
  @moduledoc """
  Big Bills Shop, Wild West Store operations.
  """

  @doc """
  returns a receipt with items including the tax
  """
  def purchase(input) do
    input
  end

end

defmodule WildWestStore.CartItem do
  @enforce_keys [:type, :price]

  defstruct product: nil,
            type: nil,
            is_imported: false,
            price: 0,
            quantity: 1
end
