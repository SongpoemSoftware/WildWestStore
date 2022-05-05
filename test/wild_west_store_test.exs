defmodule WildWestStoreTest do
  use ExUnit.Case

  @input_only_non_imported_items """
  1	book	at	12.49
  1	music	CD	at	14.99
  1	chocolate	bar	at	0.85
  """

  @output_only_non_imported_items """
  1 book: 12.49
  1 music CD: 16.49
  1 chocolate bar: 0.85
  Sales Taxes: 1.50
  Total: 29.83
  """

  @only_imported_items_input """
  1 imported box of chocolates at 10.00
  1 imported bottle of perfume at 47.50
  """

  @only_imported_items_output """
  1 imported box of chocolates: 10.50
  1 imported bottle of perfume: 54.65
  Sales Taxes: 7.65
  Total: 65.15
  """

  # describe "Summary with Sales tax and Total included" do
  #   test "success - output result contains fields Sales Taxes and Total", %{
  #     only_non_imported_items: %{input: input, output: _output}
  #   } do
  #     assert WildWestStore.purchase(input) =~ "Sales Taxes"
  #     assert WildWestStore.purchase(input) =~ "Total"
  #   end

  #   test "success - output result contains correct sales tax", %{
  #     only_non_imported_items: %{input: input, output: _output}
  #   } do
  #     assert WildWestStore.purchase(input) =~ "Sales Taxes"
  #     assert WildWestStore.purchase(input) =~ "Total"
  #   end
  # end

  describe "Summary response has expected numbers" do
    setup do
      %{
        ni_input: @input_only_non_imported_items,
        i_input: @only_imported_items_input
      }
    end

    for line <- String.split(@output_only_non_imported_items, "\n") do
      test "success - non imported item: #{line} ",
           %{ni_input: input} do
        assert WildWestStore.purchase(input) =~ unquote(line)
      end
    end

    for line <- String.split(@only_imported_items_output, "\n") do
      test "success - imported item: #{line} ",
           %{i_input: input} do
        assert WildWestStore.purchase(input) =~ unquote(line)
      end
    end
  end
end
