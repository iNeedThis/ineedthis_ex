defmodule IneedthisWeb.Profile.DetailController do
  use IneedthisWeb, :controller

  alias Ineedthis.UserNameChanges.UserNameChange
  alias Ineedthis.ModNotes.ModNote
  alias IneedthisWeb.TextileRenderer
  alias Ineedthis.Polymorphic
  alias Ineedthis.Users.User
  alias Ineedthis.Repo
  import Ecto.Query

  plug IneedthisWeb.CanaryMapPlug, index: :show_details

  plug :load_and_authorize_resource,
    model: User,
    id_field: "slug",
    id_name: "profile_id",
    persisted: true

  def index(conn, _params) do
    user = conn.assigns.user

    mod_notes =
      ModNote
      |> where(notable_type: "User", notable_id: ^user.id)
      |> order_by(desc: :id)
      |> preload(:moderator)
      |> Repo.all()
      |> Polymorphic.load_polymorphic(notable: [notable_id: :notable_type])

    mod_notes =
      mod_notes
      |> TextileRenderer.render_collection(conn)
      |> Enum.zip(mod_notes)

    name_changes =
      UserNameChange
      |> where(user_id: ^user.id)
      |> order_by(desc: :id)
      |> Repo.all()

    render(conn, "index.html",
      title: "Profile Details for User `#{user.name}'",
      mod_notes: mod_notes,
      name_changes: name_changes
    )
  end
end
