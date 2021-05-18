defmodule IneedthisWeb.Image.Comment.HistoryController do
  use IneedthisWeb, :controller

  alias Ineedthis.Versions.Version
  alias Ineedthis.Versions
  alias Ineedthis.Images.Image
  alias Ineedthis.Repo
  import Ecto.Query

  plug IneedthisWeb.CanaryMapPlug, index: :show
  plug :load_and_authorize_resource, model: Image, id_name: "image_id", persisted: true

  plug IneedthisWeb.LoadCommentPlug

  def index(conn, _params) do
    image = conn.assigns.image
    comment = conn.assigns.comment

    versions =
      Version
      |> where(item_type: "Comment", item_id: ^comment.id)
      |> order_by(desc: :created_at)
      |> limit(25)
      |> Repo.all()
      |> Versions.load_data_and_associations(comment)

    render(conn, "index.html",
      title: "Comment History for comment #{comment.id} on image #{image.id}",
      versions: versions
    )
  end
end
