defmodule WildWestStore.RecieptPrinterTest do
  use ExUnit.Case
  alias WildWestStore.CartItem
  alias WildWestStore.RecieptPrinter

  describe "reciept for single line item" do
    setup do
      %{
        items: [
          %CartItem{
            type: :book,
            price: 100
          }
        ],
        imported_items: [
          %CartItem{
            title: "imported bottle of perfume",
            type: :book,
            is_imported: true,
            price: 100
          }
        ]
      }
    end

    test "success - contains Sales tax and Total field", %{items: items} do
      assert RecieptPrinter.print(items) =~ "Service tax"
      assert RecieptPrinter.print(items) =~ "Total"
    end

    test "success - mentions imported as first word", %{imported_items: items} do
      assert RecieptPrinter.print(items) =~ "1 imported bottle of perfume"
    end
  end
end
