defmodule IneedthisWeb.Topic.Post.HideController do
  use IneedthisWeb, :controller

  alias Ineedthis.Posts.Post
  alias Ineedthis.Posts

  plug IneedthisWeb.CanaryMapPlug, create: :hide, delete: :hide

  plug :load_and_authorize_resource,
    model: Post,
    id_name: "post_id",
    persisted: true,
    preload: [:topic, topic: :forum]

  def create(conn, %{"post" => post_params}) do
    post = conn.assigns.post
    user = conn.assigns.current_user

    case Posts.hide_post(post, post_params, user) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post successfully hidden.")
        |> redirect(
          to:
            Routes.forum_topic_path(conn, :show, post.topic.forum, post.topic, post_id: post.id) <>
              "#post_#{post.id}"
        )

      {:error, _changeset} ->
        conn
        |> put_flash(:error, "Unable to hide post!")
        |> redirect(
          to:
            Routes.forum_topic_path(conn, :show, post.topic.forum, post.topic, post_id: post.id) <>
              "#post_#{post.id}"
        )
    end
  end

  def delete(conn, _params) do
    post = conn.assigns.post

    case Posts.unhide_post(post) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post successfully unhidden.")
        |> redirect(
          to:
            Routes.forum_topic_path(conn, :show, post.topic.forum, post.topic, post_id: post.id) <>
              "#post_#{post.id}"
        )

      {:error, _changeset} ->
        conn
        |> put_flash(:error, "Unable to unhide post!")
        |> redirect(
          to:
            Routes.forum_topic_path(conn, :show, post.topic.forum, post.topic, post_id: post.id) <>
              "#post_#{post.id}"
        )
    end
  end
end
