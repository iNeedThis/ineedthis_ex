defmodule IneedthisWeb.Forum.SubscriptionController do
  use IneedthisWeb, :controller

  alias Ineedthis.Forums.Forum
  alias Ineedthis.Forums

  plug IneedthisWeb.CanaryMapPlug, create: :show, delete: :show

  plug :load_and_authorize_resource,
    model: Forum,
    id_name: "forum_id",
    id_field: "short_name",
    persisted: true

  def create(conn, _params) do
    forum = conn.assigns.forum
    user = conn.assigns.current_user

    case Forums.create_subscription(forum, user) do
      {:ok, _subscription} ->
        render(conn, "_subscription.html", forum: forum, watching: true, layout: false)

      {:error, _changeset} ->
        render(conn, "_error.html", layout: false)
    end
  end

  def delete(conn, _params) do
    forum = conn.assigns.forum
    user = conn.assigns.current_user

    case Forums.delete_subscription(forum, user) do
      {:ok, _subscription} ->
        render(conn, "_subscription.html", forum: forum, watching: false, layout: false)

      {:error, _changeset} ->
        render(conn, "_error.html", layout: false)
    end
  end
end
