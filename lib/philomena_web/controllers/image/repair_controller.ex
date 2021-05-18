defmodule IneedthisWeb.Image.RepairController do
  use IneedthisWeb, :controller

  alias Ineedthis.Images.Image
  alias Ineedthis.Images

  plug IneedthisWeb.CanaryMapPlug, create: :hide
  plug :load_and_authorize_resource, model: Image, id_name: "image_id", persisted: true

  def create(conn, _params) do
    Images.repair_image(conn.assigns.image)
    Images.purge_files(conn.assigns.image, conn.assigns.image.hidden_image_key)

    conn
    |> put_flash(:info, "Repair job enqueued.")
    |> redirect(to: Routes.image_path(conn, :show, conn.assigns.image))
  end
end
