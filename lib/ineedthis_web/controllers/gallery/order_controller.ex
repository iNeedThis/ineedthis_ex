defmodule IneedthisWeb.Gallery.OrderController do
  use IneedthisWeb, :controller

  alias Ineedthis.Galleries.Gallery
  alias Ineedthis.Galleries

  plug IneedthisWeb.FilterBannedUsersPlug

  plug IneedthisWeb.CanaryMapPlug, update: :edit
  plug :load_and_authorize_resource, model: Gallery, id_name: "gallery_id", persisted: true

  def update(conn, %{"image_ids" => image_ids}) when is_list(image_ids) do
    gallery = conn.assigns.gallery

    Galleries.reorder_gallery(gallery, image_ids)

    json(conn, %{})
  end
end
