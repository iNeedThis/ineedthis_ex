defmodule IneedthisWeb.AdvertView do
  use IneedthisWeb, :view

  def advert_image_url(%{image: image}) do
    advert_url_root() <> "/" <> image
  end

  def advert_image_url(_), do: nil

  defp advert_url_root do
    Application.get_env(:ineedthis, :advert_url_root)
  end
end
