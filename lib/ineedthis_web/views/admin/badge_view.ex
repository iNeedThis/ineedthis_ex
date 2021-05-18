defmodule IneedthisWeb.Admin.BadgeView do
  use IneedthisWeb, :view

  alias IneedthisWeb.ProfileView

  defp badge_image(badge, options),
    do: ProfileView.badge_image(badge, options)
end
