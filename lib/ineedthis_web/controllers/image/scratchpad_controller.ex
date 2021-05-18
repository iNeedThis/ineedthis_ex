defmodule IneedthisWeb.Image.ScratchpadController do
  use IneedthisWeb, :controller

  alias Ineedthis.Images.Image
  alias Ineedthis.Images

  plug IneedthisWeb.CanaryMapPlug, edit: :hide, update: :hide
  plug :load_and_authorize_resource, model: Image, id_name: "image_id", persisted: true

  def edit(conn, _params) do
    changeset = Images.change_image(conn.assigns.image)
    render(conn, "edit.html", title: "Editing Moderation Notes", changeset: changeset)
  end

  def update(conn, %{"image" => image_params}) do
    {:ok, image} = Images.update_scratchpad(conn.assigns.image, image_params)

    conn
    |> put_flash(:info, "Successfully updated moderation notes.")
    |> redirect(to: Routes.image_path(conn, :show, image))
  end
end
