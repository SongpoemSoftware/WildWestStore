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

    title =
      if imported_flag do
        prepare_title(string, "imported ")
      else
        prepare_title(string, "")
      end

    %Product{type: type, is_imported: imported_flag, title: title}
  end

  def prepare_title(string, prefix \\ "") do
    flag = "imported"

    suffix =
      string
      |> String.split(flag, trim: true)
      |> Enum.map(&String.trim(&1))
      |> Enum.join(" ")

    prefix <> suffix
  end
end
