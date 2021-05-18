defmodule IneedthisWeb.Profile.Commission.ItemView do
  use IneedthisWeb, :view

  alias Ineedthis.Commissions.Commission

  def types, do: Commission.types()
end
