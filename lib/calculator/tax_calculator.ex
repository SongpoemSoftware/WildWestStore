defmodule WildWestStore.TaxCalculator do
  @moduledoc """
    This calculator only Sales tax amount.
    One product or a list of products
  """
  alias WildWestStore.CartItem

  @basic_tax 10
  @tax_on_imported 5
  @round_to 0.05

  # basic on all except books, food, medical
  # imported on all

  # aggregator not need here
  # def calculate(products) when is_list(products) do
  #   Enum.reduce(products, 0, fn prod, amount -> calculate(prod) + amount end)
  # end

  def calculate(
        %CartItem{type: type, is_imported: is_imported, quantity: quantity, price: price} =
          _line_item
      ) do
    tax_percent =
      case {type, is_imported} do
        {:food, true} -> @tax_on_imported
        {:food, false} -> 0
        {:book, true} -> @tax_on_imported
        {:book, false} -> 0
        {:medical_product, true} -> @tax_on_imported
        {:medical_product, false} -> 0
        {_, true} -> @basic_tax + @tax_on_imported
        {_, false} -> @basic_tax
      end

    (quantity * tax_percent * price / 100)
    |> round_off
  end

  # round off to nearest 0.05
  defp round_off(number) do
    round(number)
  end
end
