defmodule WildWestStore.RecieptPrinter do
  alias WildWestStore.CartItem
  alias WildWestStore.TaxCalculator
  alias WildWestStore.RecieptItem

  def print(%CartItem{} = item) do
    print([item])
  end

  def print(list) do
    # combined_service_tax = aggregate_tax_amount(items_with_service_tax)
    # total_amount = make_total_amount(items_with_service_tax)
    # print_items =
    #   Enum.reduce(items_with_service_tax, "", fn item, acc ->
    #     "#{acc}\n #{print_one(item)}"
    #   end)
    list
    |> Enum.map(fn %CartItem{} = item ->
      %RecieptItem{cart_item: item, service_tax: TaxCalculator.calculate(item)}
    end)
    |> print_all_items
    |> print_total_service_charge
    |> print_total_amount
  end

  defp print_total_service_charge({items, str}) do
    total_service_charges =
      Enum.reduce(items, 0, fn %RecieptItem{service_tax: tax}, total -> tax + total end)

    {items, "#{str} \n Sales Taxes: #{total_service_charges}"}
  end

  defp print_total_amount({items, str}) do
    total_amount =
      Enum.reduce(items, 0, fn %RecieptItem{
                                 service_tax: tax,
                                 cart_item: %CartItem{price: price, quantity: quantity}
                               },
                               total ->
        price * quantity + tax + total
      end)

    "#{str} \n Total: #{total_amount}"
  end

  defp print_all_items(items_with_service_tax) do
    {items_with_service_tax,
     Enum.reduce(items_with_service_tax, "", fn %RecieptItem{} = ri, acc ->
       "#{acc}\n #{print_one(ri)}"
     end)}
  end

  def print_one(
        %RecieptItem{
          cart_item: %CartItem{title: title, price: price, quantity: quantity},
          service_tax: service_tax
        } = _item
      ) do
    "#{quantity} #{title}: #{quantity * price + service_tax}"
  end
end
