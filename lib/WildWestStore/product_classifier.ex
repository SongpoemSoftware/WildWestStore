defmodule WildWestStore.ProductClassifier do
  alias WildWestStore.Product

  # @spec classify: str :: %Product{}
  @food ["food", "chocolate", "nooodle", "pizza", "cheese"]
  @book ["book", "magazine"]
  @medicine ["medicine", "tablet"]
  @imported ["imported"]

  def classify(string) do
    type =
      cond do
        String.contains?(string, @food) -> :food
        String.contains?(string, @book) -> :book
        String.contains?(string, @medicine) -> :medicine
        true -> :other
      end

    imported_flag = String.contains?(string, @imported)

    %Product{type: type, is_imported: imported_flag, title: string}
  end
end
