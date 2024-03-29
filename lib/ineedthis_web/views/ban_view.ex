defmodule IneedthisWeb.BanView do
  use IneedthisWeb, :view

  def active?(ban) do
    ban.enabled and DateTime.diff(ban.valid_until, DateTime.utc_now()) > 0
  end
end
