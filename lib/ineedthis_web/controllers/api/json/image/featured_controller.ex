defmodule IneedthisWeb.Api.Json.Image.FeaturedController do
  use IneedthisWeb, :controller

  alias Ineedthis.ImageFeatures.ImageFeature
  alias Ineedthis.Images.Image
  alias Ineedthis.Interactions
  alias Ineedthis.Repo
  import Ecto.Query

  def show(conn, _params) do
    user = conn.assigns.current_user

    featured_image =
      Image
      |> join(:inner, [i], f in ImageFeature, on: [image_id: i.id])
      |> where([i], i.hidden_from_users == false)
      |> order_by([_i, f], desc: f.created_at)
      |> limit(1)
      |> preload([:user, :intensity, tags: :aliases])
      |> Repo.one()

    case featured_image do
      nil ->
        conn
        |> put_status(:not_found)
        |> text("")
        |> halt()

      _ ->
        interactions = Interactions.user_interactions([featured_image], user)

        conn
        |> put_view(IneedthisWeb.Api.Json.ImageView)
        |> render("show.json", image: featured_image, interactions: interactions)
    end
  end
end
