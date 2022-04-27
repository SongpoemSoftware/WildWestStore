defmodule WildWestStore.TaxCalculatorTest do
  use ExUnit.Case
  alias WildWestStore.TaxCalculator
  alias WildWestStore.CartItem

  describe "tax exempted product" do
    test "success - non imported item, quantity one" do
      item = %CartItem{
        product: "Chocolates",
        type: :food,
        quantity: 1,
        price: 100,
        is_imported: false
      }

      assert TaxCalculator.calculate(item) == 0
    end

    test "success - non imported item, quantity two" do
      item = %CartItem{
        product: "Chocolates",
        type: :food,
        quantity: 2,
        price: 100,
        is_imported: false
      }

      assert TaxCalculator.calculate(item) == 0
    end

    test "success - imported item, quantity one" do
      item = %CartItem{
        product: "Chocolates",
        type: :food,
        quantity: 1,
        price: 100,
        is_imported: true
      }

      assert TaxCalculator.calculate(item) == 5.0
    end

    test "success - imported item, quantity two" do
      item = %CartItem{
        product: "Chocolates",
        type: :food,
        quantity: 2,
        price: 100,
        is_imported: true
      }

      assert TaxCalculator.calculate(item) == 10.0
    end

    test "success - roundoff" do
      item = %CartItem{
        product: "Chocolates",
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
        product: "Chocolates",
        type: :perfume,
        quantity: 1,
        price: 100,
        is_imported: false
      }

      assert TaxCalculator.calculate(item) == 10
    end

    test "success - non imported item, quantity two" do
      item = %CartItem{
        product: "Chocolates",
        type: :perfume,
        quantity: 2,
        price: 100,
        is_imported: false
      }

      assert TaxCalculator.calculate(item) == 20
    end

    test "success - imported item, quantity one" do
      item = %CartItem{
        product: "Chocolates",
        type: :perfume,
        quantity: 1,
        price: 100,
        is_imported: true
      }

      assert TaxCalculator.calculate(item) == 15.0
    end

    test "success - imported item, quantity two" do
      item = %CartItem{
        product: "Chocolates",
        type: :perfume,
        quantity: 2,
        price: 100,
        is_imported: true
      }

      assert TaxCalculator.calculate(item) == 30.0
    end

    test "roundoff" do
      item = %CartItem{
        product: "Chocolates",
        type: :perfume,
        quantity: 2,
        price: 1.7,
        is_imported: true
      }

      assert TaxCalculator.calculate(item) == 0.50
    end
  end
end
