defmodule WildWestStore.RecieptPrinterTest do
  use ExUnit.Case
  alias WildWestStore.CartItem
  alias WildWestStore.RecieptPrinter

  setup do
    %{
      items_single: [
        %CartItem{
          type: :book,
          price: 100,
          quantity: 1
        },
        %CartItem{
          type: :food,
          price: 50,
          quantity: 1
        },
        %CartItem{
          type: :medical_product,
          price: 50,
          quantity: 1
        }
      ],
      items_multiple: [
        %CartItem{
          type: :book,
          price: 100,
          quantity: 2
        },
        %CartItem{
          type: :food,
          price: 50,
          quantity: 3
        },
        %CartItem{
          type: :medical_product,
          price: 50,
          quantity: 5
        }
      ],
      imported_items_single: [
        %CartItem{
          title: "imported bottle of perfume",
          type: :perfume,
          is_imported: true,
          price: 200,
          quantity: 1
        },
        %CartItem{
          title: "box of imported dates",
          type: :food,
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
          price: 200,
          quantity: 5
        },
        %CartItem{
          title: "box of imported dates",
          type: :food,
          is_imported: true,
          price: 100,
          quantity: 2
        }
      ]
    }
  end

  describe "reciept for single line item, non-imported" do
    test "success - contains correct total Sales tax", %{
      items_single: items
    } do
      assert RecieptPrinter.print(items) =~ "Sales Taxes: 0"
    end

    test "success - contains correct Total Amount", %{
      items_single: items
    } do
      assert RecieptPrinter.print(items) =~ "Total: 200"
    end
  end

  describe "reciept for single line item, imported." do
    test "success - contains Sales tax and Total field", %{items_single: items} do
      assert RecieptPrinter.print(items) =~ "Sales Taxes"
      assert RecieptPrinter.print(items) =~ "Total"
    end

    test "success - mentions imported as first word", %{imported_items_single: items} do
      assert RecieptPrinter.print(items) =~ "1 imported bottle of perfume"
    end

    test "success - contains correct amout of Sales tax", %{
      imported_items_single: items
    } do
      assert RecieptPrinter.print(items) =~ "Sales Taxes: 35"
    end

    test "success - contains correct Total Amount", %{
      imported_items_single: items
    } do
      assert RecieptPrinter.print(items) =~ "Total: 335"
    end
  end

  describe "reciept for multiple line item, non-imported." do
    test "success - contains correct Total Amount", %{
      items_multiple: items
    } do
      assert RecieptPrinter.print(items) =~ "Total: 600"
    end

    test "success - contains correct Sales tax", %{
      items_multiple: items
    } do
      assert RecieptPrinter.print(items) =~ "Sales Taxes: 0"
    end
  end

  describe "reciept for multiple line item, imported." do
    test "success - mentions imported as first word", %{imported_items_single: items} do
      assert RecieptPrinter.print(items) =~ "1 imported bottle of perfume"
      assert RecieptPrinter.print(items) =~ "1 imported box of dates"
    end

    test "success - contains correct amout of Sales tax", %{
      imported_items_multiple: items
    } do
      assert RecieptPrinter.print(items) =~ "Sales Taxes: 160"
    end

    test "success - contains correct Total Amount", %{
      imported_items_multiple: items
    } do
      assert RecieptPrinter.print(items) =~ "Total: 1360"
    end
  end
end
