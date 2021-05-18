defmodule IneedthisWeb.Topic.SubscriptionController do
  use IneedthisWeb, :controller

  alias Ineedthis.Forums.Forum
  alias Ineedthis.Topics

  plug IneedthisWeb.CanaryMapPlug, create: :show, delete: :show

  plug :load_and_authorize_resource,
    model: Forum,
    id_name: "forum_id",
    id_field: "short_name",
    persisted: true

  plug IneedthisWeb.LoadTopicPlug, [show_hidden: true] when action in [:delete]
  plug IneedthisWeb.LoadTopicPlug when action in [:create]

  def create(conn, _params) do
    topic = conn.assigns.topic
    user = conn.assigns.current_user

    case Topics.create_subscription(topic, user) do
      {:ok, _subscription} ->
        render(conn, "_subscription.html",
          forum: conn.assigns.forum,
          topic: topic,
          watching: true,
          layout: false
        )

      {:error, _changeset} ->
        render(conn, "_error.html", layout: false)
    end
  end

  def delete(conn, _params) do
    topic = conn.assigns.topic
    user = conn.assigns.current_user

    case Topics.delete_subscription(topic, user) do
      {:ok, _subscription} ->
        render(conn, "_subscription.html",
          forum: conn.assigns.forum,
          topic: topic,
          watching: false,
          layout: false
        )

      {:error, _changeset} ->
        render(conn, "_error.html", layout: false)
    end
  end
end
