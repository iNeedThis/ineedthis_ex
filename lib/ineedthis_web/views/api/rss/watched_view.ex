defmodule IneedthisWeb.Api.Rss.WatchedView do
  use IneedthisWeb, :view

  alias IneedthisWeb.ImageView

  def last_build_date do
    DateTime.utc_now()
    |> DateTime.to_iso8601()
  end

  def medium_url(image) do
    image
    |> ImageView.thumb_urls(false)
    |> Map.get(:medium)
  end
end
