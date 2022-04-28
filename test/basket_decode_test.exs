defmodule WildWestStore.BasketDecodeTest do
  use ExUnit.Case
  alias WildWestStore.Basket

  describe "single line" do
    test "success - decodes book" do
      input = """
            1 book at 12.49
      """

      assert output = Basket.decode(input)
      assert Map.get(output, :quantity) == 1
      # assert Map.get(output, :type) == :book
      assert Map.get(output, :is_imported) == false
      assert Map.get(output, :price) == 12.49
    end

    test "success - decodes line item imported chocolate" do
      input = """
      1 box of imported chocolates at 11.2
      """

      assert output = Basket.decode(input)
      assert Map.get(output, :quantity) == 1
      assert Map.get(output, :is_imported) == true
      assert Map.get(output, :price) == 11.2
    end

    test "success - decodes line item music CD" do
      input = """
      1 music CD at 14.99
      """

      assert output = Basket.decode(input)
      assert Map.get(output, :quantity) == 1
      assert Map.get(output, :is_imported) == false
      assert Map.get(output, :price) == 14.99
    end
  end

  describe "a paragraph" do
    test "success - decodes all line items" do
      input = """
      1 book at 12.49
      1 music CD at 14.99
      1 chocolate bar at 0.85
      """

      # assert output = Basket.decode(input)
      # assert Map.get(output, :quantity) == 1
      # assert Map.get(output, :is_imported) == false
      # assert Map.get(output, :price) == 11.2
    end
  end
end
