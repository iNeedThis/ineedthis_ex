defmodule IneedthisWeb.Image.SubscriptionController do
  use IneedthisWeb, :controller

  alias Ineedthis.Images.Image
  alias Ineedthis.Images

  plug IneedthisWeb.CanaryMapPlug, create: :show, delete: :show
  plug :load_and_authorize_resource, model: Image, id_name: "image_id", persisted: true

  def create(conn, _params) do
    image = conn.assigns.image
    user = conn.assigns.current_user

    case Images.create_subscription(image, user) do
      {:ok, _subscription} ->
        render(conn, "_subscription.html", image: image, watching: true, layout: false)

      {:error, _changeset} ->
        render(conn, "_error.html", layout: false)
    end
  end

  def delete(conn, _params) do
    image = conn.assigns.image
    user = conn.assigns.current_user

    case Images.delete_subscription(image, user) do
      {:ok, _subscription} ->
        render(conn, "_subscription.html", image: image, watching: false, layout: false)

      {:error, _changeset} ->
        render(conn, "_error.html", layout: false)
    end
  end
end
