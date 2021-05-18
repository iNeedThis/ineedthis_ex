defmodule IneedthisWeb.Post.PreviewController do
  use IneedthisWeb, :controller

  alias IneedthisWeb.TextileRenderer
  alias Ineedthis.Posts.Post
  alias Ineedthis.Repo

  def create(conn, params) do
    user = preload_awards(conn.assigns.current_user)
    body = to_string(params["body"])
    anonymous = params["anonymous"] == true

    post = %Post{user: user, body: body, anonymous: anonymous}
    rendered = TextileRenderer.render_one(post, conn)

    render(conn, "create.html", layout: false, post: post, body: rendered)
  end

  defp preload_awards(nil), do: nil

  defp preload_awards(user) do
    Repo.preload(user, awards: :badge)
  end
end
