defmodule IneedthisWeb.Image.UploaderController do
  use IneedthisWeb, :controller

  alias Ineedthis.Images.Image
  alias Ineedthis.Images
  alias Ineedthis.Repo

  plug :verify_authorized
  plug :load_resource, model: Image, id_name: "image_id", persisted: true

  def update(conn, %{"image" => image_params}) do
    {:ok, image} = Images.update_uploader(conn.assigns.image, image_params)

    Images.reindex_image(image)

    image = Repo.preload(image, user: [awards: :badge])
    changeset = Images.change_image(image)

    conn
    |> put_view(IneedthisWeb.ImageView)
    |> render("_uploader.html", layout: false, image: image, changeset: changeset)
  end

  defp verify_authorized(conn, _opts) do
    case Canada.Can.can?(conn.assigns.current_user, :show, :ip_address) do
      true -> conn
      _false -> IneedthisWeb.NotAuthorizedPlug.call(conn)
    end
  end
end
