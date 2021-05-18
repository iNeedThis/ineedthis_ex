defmodule IneedthisWeb.Api.Json.ImageController do
  use IneedthisWeb, :controller

  alias Ineedthis.Images.Image
  alias Ineedthis.Images
  alias Ineedthis.Interactions
  alias Ineedthis.Repo
  import Ecto.Query

  plug IneedthisWeb.ScraperCachePlug
  plug IneedthisWeb.ApiRequireAuthorizationPlug when action in [:create]
  plug IneedthisWeb.UserAttributionPlug when action in [:create]

  plug IneedthisWeb.ScraperPlug,
       [params_name: "image", params_key: "image"] when action in [:create]

  def show(conn, %{"id" => id}) do
    user = conn.assigns.current_user

    image =
      Image
      |> where(id: ^id)
      |> preload([:user, :intensity, tags: :aliases])
      |> Repo.one()

    case image do
      nil ->
        conn
        |> put_status(:not_found)
        |> text("")

      _ ->
        interactions = Interactions.user_interactions([image], user)

        render(conn, "show.json", image: image, interactions: interactions)
    end
  end

  def create(conn, %{"image" => image_params}) do
    attributes = conn.assigns.attributes

    case Images.create_image(attributes, image_params) do
      {:ok, %{image: image}} ->
        IneedthisWeb.Endpoint.broadcast!(
          "firehose",
          "image:create",
          IneedthisWeb.Api.Json.ImageView.render("show.json", %{image: image, interactions: []})
        )

        render(conn, "show.json", image: image, interactions: [])

      {:error, :image, changeset, _} ->
        conn
        |> put_status(:bad_request)
        |> render("error.json", changeset: changeset)
    end
  end
end
