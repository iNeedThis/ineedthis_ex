defmodule IneedthisWeb.Topic.Post.HistoryController do
  use IneedthisWeb, :controller

  alias Ineedthis.Versions.Version
  alias Ineedthis.Versions
  alias Ineedthis.Forums.Forum
  alias Ineedthis.Repo
  import Ecto.Query

  plug IneedthisWeb.CanaryMapPlug, index: :show

  plug :load_and_authorize_resource,
    model: Forum,
    id_name: "forum_id",
    id_field: "short_name",
    persisted: true

  plug IneedthisWeb.LoadTopicPlug
  plug IneedthisWeb.LoadPostPlug

  def index(conn, _params) do
    topic = conn.assigns.topic
    post = conn.assigns.post

    versions =
      Version
      |> where(item_type: "Post", item_id: ^post.id)
      |> order_by(desc: :created_at)
      |> limit(25)
      |> Repo.all()
      |> Versions.load_data_and_associations(post)

    render(conn, "index.html",
      title: "Post History for Post #{post.id} - #{topic.title} - Forums",
      versions: versions
    )
  end
end
