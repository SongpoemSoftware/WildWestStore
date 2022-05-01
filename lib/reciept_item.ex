defmodule WildWestStore.RecieptItem do
  @enforce_keys [:cart_item, :service_tax]

  defstruct cart_item: nil, service_tax: 0
end
