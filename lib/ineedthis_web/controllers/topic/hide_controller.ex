defmodule IneedthisWeb.Topic.HideController do
  import Plug.Conn
  use IneedthisWeb, :controller

  alias Ineedthis.Forums.Forum
  alias Ineedthis.Topics.Topic
  alias Ineedthis.Topics

  plug IneedthisWeb.CanaryMapPlug, create: :show, delete: :show

  plug :load_and_authorize_resource,
    model: Forum,
    id_name: "forum_id",
    id_field: "short_name",
    persisted: true

  plug IneedthisWeb.LoadTopicPlug
  plug IneedthisWeb.CanaryMapPlug, create: :hide, delete: :hide
  plug :authorize_resource, model: Topic, persisted: true

  def create(conn, %{"topic" => topic_params}) do
    topic = conn.assigns.topic
    deletion_reason = topic_params["deletion_reason"]
    user = conn.assigns.current_user

    case Topics.hide_topic(topic, deletion_reason, user) do
      {:ok, topic} ->
        conn
        |> put_flash(:info, "Topic successfully hidden!")
        |> redirect(to: Routes.forum_topic_path(conn, :show, topic.forum, topic))

      {:error, _changeset} ->
        conn
        |> put_flash(:error, "Unable to hide the topic!")
        |> redirect(to: Routes.forum_topic_path(conn, :show, topic.forum, topic))
    end
  end

  def delete(conn, _opts) do
    topic = conn.assigns.topic

    case Topics.unhide_topic(topic) do
      {:ok, topic} ->
        conn
        |> put_flash(:info, "Topic successfully restored!")
        |> redirect(to: Routes.forum_topic_path(conn, :show, topic.forum, topic))

      {:error, _changeset} ->
        conn
        |> put_flash(:error, "Unable to restore the topic!")
        |> redirect(to: Routes.forum_topic_path(conn, :show, topic.forum, topic))
    end
  end
end
