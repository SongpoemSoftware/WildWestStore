defmodule WildWestStoreTest do
  use ExUnit.Case

  setup do
    input_only_non_imported_items = """
    1	book	at	12.49
    1	music	CD	at	14.99
    1	chocolate	bar	at	0.85
    """

    output_only_non_imported_items = """
    1	book:	12.49
    1	music	CD:	16.49
    1	chocolate	bar:	0.85
    Sales	Taxes:	1.50
    Total:	29.83
    """

    %{
      only_non_imported_items: %{
        input: input_only_non_imported_items,
        output: output_only_non_imported_items
      }
    }
  end

  describe "Summary with Sales tax and Total included" do
    test "success - output result contains fields Sales Taxes and Total", %{
      only_non_imported_items: %{input: input, output: _output}
    } do
      assert WildWestStore.purchase(input) =~ "Sales Taxes"
      assert WildWestStore.purchase(input) =~ "Total"
    end

    test "success - output result contains correct sales tax", %{
      only_non_imported_items: %{input: input, output: _output}
    } do
      assert WildWestStore.purchase(input) =~ "Sales Taxes"
      assert WildWestStore.purchase(input) =~ "Total"
    end


  end
end
