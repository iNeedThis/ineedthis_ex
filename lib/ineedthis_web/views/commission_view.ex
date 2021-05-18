defmodule IneedthisWeb.CommissionView do
  use IneedthisWeb, :view

  alias Ineedthis.Commissions.Commission

  def categories, do: [[key: "-", value: ""] | Commission.categories()]
  def types, do: Commission.types()
end
