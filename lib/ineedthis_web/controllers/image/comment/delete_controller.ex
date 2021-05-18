defmodule IneedthisWeb.Image.Comment.DeleteController do
  use IneedthisWeb, :controller

  alias Ineedthis.Comments.Comment
  alias Ineedthis.Comments

  plug IneedthisWeb.CanaryMapPlug, create: :hide
  plug :load_and_authorize_resource, model: Comment, id_name: "comment_id", persisted: true

  def create(conn, _params) do
    comment = conn.assigns.comment

    case Comments.destroy_comment(comment) do
      {:ok, comment} ->
        Comments.reindex_comment(comment)

        conn
        |> put_flash(:info, "Comment successfully destroyed!")
        |> redirect(
          to: Routes.image_path(conn, :show, comment.image_id) <> "#comment_#{comment.id}"
        )

      {:error, _changeset} ->
        conn
        |> put_flash(:error, "Unable to destroy comment!")
        |> redirect(
          to: Routes.image_path(conn, :show, comment.image_id) <> "#comment_#{comment.id}"
        )
    end
  end
end
