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
            price: 100,
            quantity: 1
          }
        ],
        items_multiple: [
          %CartItem{
            type: :book,
            price: 100,
            quantity: 5
          }
        ],
        imported_items: [
          %CartItem{
            title: "imported bottle of perfume",
            type: :perfume,
            is_imported: true,
            price: 100,
            quantity: 1
          }
        ],
        imported_items_multiple: [
          %CartItem{
            title: "imported bottle of perfume",
            type: :perfume,
            is_imported: true,
            price: 100,
            quantity: 5
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

    test "success - contains correct amout of Sales tax for single quantity", %{
      items: items,
      imported_items: imported_items
    } do
      assert RecieptPrinter.print(items) =~ "Service tax: 0"
      assert RecieptPrinter.print(imported_items) =~ "Service tax: 15"
    end

    test "success - contains correct Total Amount for single quantity", %{
      items: items,
      imported_items: imported_items
    } do
      assert RecieptPrinter.print(items) =~ "Total: 100"
      assert RecieptPrinter.print(imported_items) =~ "Total: 115"
    end

    test "success - contains correct Total Amount for multiple quantity", %{
      items_multiple: items,
      imported_items_multiple: imported_items
    } do
      assert RecieptPrinter.print(items) =~ "Total: 500"
      assert RecieptPrinter.print(imported_items) =~ "Total: 575"
    end
  end
end
