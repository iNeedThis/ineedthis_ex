defmodule IneedthisWeb.Profile.CommissionView do
  use IneedthisWeb, :view

  alias Ineedthis.Commissions.Commission

  def categories, do: Commission.categories()

  def current?(%{id: id}, %{id: id}), do: true
  def current?(_user1, _user2), do: false
end
