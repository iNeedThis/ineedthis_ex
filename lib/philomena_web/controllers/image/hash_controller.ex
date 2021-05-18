defmodule IneedthisWeb.Image.HashController do
  use IneedthisWeb, :controller

  alias Ineedthis.Images.Image
  alias Ineedthis.Images

  plug IneedthisWeb.CanaryMapPlug, delete: :hide
  plug :load_and_authorize_resource, model: Image, id_name: "image_id", persisted: true

  def delete(conn, _params) do
    {:ok, image} = Images.remove_hash(conn.assigns.image)

    conn
    |> put_flash(:info, "Successfully cleared hash.")
    |> redirect(to: Routes.image_path(conn, :show, image))
  end
end
