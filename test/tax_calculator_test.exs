defmodule WildWestStore.TaxCalculatorTest do
  use ExUnit.Case
  alias WildWestStore.TaxCalculator
  alias WildWestStore.CartItem

  describe "zero service tax for exempted product, locally. Single quantity" do
    setup do
      %{
        item: %CartItem{
          title: "something",
          type: :book,
          quantity: 1,
          price: 100,
          is_imported: false
        }
      }
    end

    test "Product - food", %{item: item} do
      type = :food
      item = %CartItem{item | type: type}
      assert TaxCalculator.calculate(item) == 0
    end

    test "Product - book", %{item: item} do
      type = :book
      item = %CartItem{item | type: type}
      assert TaxCalculator.calculate(item) == 0
    end

    test "Product - medical_product", %{item: item} do
      type = :medical_product
      item = %CartItem{item | type: type}
      assert TaxCalculator.calculate(item) == 0
    end
  end

  describe "zero service tax for exempted product, locally. multiple quantity" do
    setup do
      %{
        item: %CartItem{
          title: "something",
          type: :book,
          quantity: 2,
          price: 100,
          is_imported: false
        }
      }
    end

    test "Product - food", %{item: item} do
      type = :food
      item = %CartItem{item | type: type}
      assert TaxCalculator.calculate(item) == 0
    end

    test "Product - book", %{item: item} do
      type = :book
      item = %CartItem{item | type: type}
      assert TaxCalculator.calculate(item) == 0
    end

    test "Product - medical_product", %{item: item} do
      type = :medical_product
      item = %CartItem{item | type: type}
      assert TaxCalculator.calculate(item) == 0
    end
  end

  describe "correct service tax for non-exempt product, locally." do
    setup do
      %{
        item: %CartItem{
          title: "something",
          type: :foo,
          quantity: 2,
          price: 100,
          is_imported: false
        }
      }
    end

    test "Product - food", %{item: item} do
      item = %CartItem{item | price: 100, quantity: 1}
      assert TaxCalculator.calculate(item) == 10
    end

    test "Product - medical_product", %{item: item} do
      item = %CartItem{item | price: 100, quantity: 3}
      assert TaxCalculator.calculate(item) == 30
    end
  end

  describe "correct service tax for non-exempt product, imported." do
    setup do
      %{
        item: %CartItem{
          title: "something",
          type: :foo,
          quantity: 2,
          price: 100,
          is_imported: true
        }
      }
    end

    test "Product - exempted", %{item: item} do
      item = %CartItem{item | price: 100, quantity: 1, type: :food}
      assert TaxCalculator.calculate(item) == 10
    end

    test "Product - non-exempted", %{item: item} do
      item = %CartItem{item | price: 100, quantity: 1, type: :perfume}
      assert TaxCalculator.calculate(item) == 15
    end

    test "Product - medical_product", %{item: item} do
      item = %CartItem{item | price: 100, quantity: 3}
      assert TaxCalculator.calculate(item) == 45
    end
  end

  describe "tax exempted product" do
    test "success - non imported item, quantity one" do
      item = %CartItem{
        title: "Chocolates",
        type: :food,
        quantity: 1,
        price: 100,
        is_imported: false
      }

      assert TaxCalculator.calculate(item) == 0
    end

    test "success - non imported item, quantity two" do
      item = %CartItem{
        title: "Chocolates",
        type: :food,
        quantity: 2,
        price: 100,
        is_imported: false
      }

      assert TaxCalculator.calculate(item) == 0
    end

    test "success - imported item, quantity one" do
      item = %CartItem{
        title: "Chocolates",
        type: :food,
        quantity: 1,
        price: 100,
        is_imported: true
      }

      assert TaxCalculator.calculate(item) == 5.0
    end

    test "success - imported item, quantity two" do
      item = %CartItem{
        title: "Chocolates",
        type: :food,
        quantity: 2,
        price: 100,
        is_imported: true
      }

      assert TaxCalculator.calculate(item) == 10.0
    end

    test "success - roundoff" do
      item = %CartItem{
        title: "Chocolates",
        type: :food,
        quantity: 1,
        price: 1.2,
        is_imported: true
      }

      assert TaxCalculator.calculate(item) == 0.05
    end
  end

  describe "tax non-exempted product" do
    test "success - non imported item, quantity one" do
      item = %CartItem{
        title: "Chocolates",
        type: :perfume,
        quantity: 1,
        price: 100,
        is_imported: false
      }

      assert TaxCalculator.calculate(item) == 10
    end

    test "success - non imported item, quantity two" do
      item = %CartItem{
        title: "Chocolates",
        type: :perfume,
        quantity: 2,
        price: 100,
        is_imported: false
      }

      assert TaxCalculator.calculate(item) == 20
    end

    test "success - imported item, quantity one" do
      item = %CartItem{
        title: "Chocolates",
        type: :perfume,
        quantity: 1,
        price: 100,
        is_imported: true
      }

      assert TaxCalculator.calculate(item) == 15.0
    end

    test "success - imported item, quantity two" do
      item = %CartItem{
        title: "Chocolates",
        type: :perfume,
        quantity: 2,
        price: 100,
        is_imported: true
      }

      assert TaxCalculator.calculate(item) == 30.0
    end

    test "roundoff" do
      item = %CartItem{
        title: "Chocolates",
        type: :perfume,
        quantity: 2,
        price: 1.7,
        is_imported: true
      }

      assert TaxCalculator.calculate(item) == 0.50
    end
  end
end
