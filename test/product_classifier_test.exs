defmodule WildWestStore.ProductClassifierTest do
  use ExUnit.Case
  alias WildWestStore.ProductClassifier

  describe "decode correct type and imported flag." do
    test "success - books" do
      for item <- ["book", "magazines"] do
        assert prod = ProductClassifier.classify(item)
        assert Map.get(prod, :type) == :book
        assert Map.get(prod, :is_imported) == false
      end
    end

    for item <- ["box of chocolates", "nooodles"] do
      test "success - food element: #{item}" do
        prod =
          unquote(item)
          |> ProductClassifier.classify()

        assert Map.get(prod, :type) == :food
        assert Map.get(prod, :is_imported) == false
      end
    end

    for item <- ["imported box of chocolates", "imported cheese"] do
      test "success - imported product: #{item}" do
        prod =
          unquote(item)
          |> ProductClassifier.classify()

        assert Map.get(prod, :type) == :food
        assert Map.get(prod, :is_imported) == true
      end
    end

    for item <- ["headache tablet", "medicines"] do
      test "success - medical equipment: #{item}" do
        prod =
          unquote(item)
          |> ProductClassifier.classify()

        assert Map.get(prod, :type) == :medicine
        assert Map.get(prod, :is_imported) == false
      end
    end

    for item <- ["bottle of perfume", "music cd"] do
      test "success -  other element: #{item}" do
        prod =
          unquote(item)
          |> ProductClassifier.classify()

        assert Map.get(prod, :type) == :other
        assert Map.get(prod, :is_imported) == false
      end
    end
  end
end
