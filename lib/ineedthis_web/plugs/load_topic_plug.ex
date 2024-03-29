defmodule IneedthisWeb.LoadTopicPlug do
  alias Ineedthis.Topics.Topic
  alias Ineedthis.Repo

  import Plug.Conn, only: [assign: 3]
  import Canada.Can, only: [can?: 3]
  import Ecto.Query

  def init(opts),
    do: opts

  def call(%{assigns: %{forum: forum}} = conn, opts) do
    param = Keyword.get(opts, :param, "topic_id")
    show_hidden = Keyword.get(opts, :show_hidden, false)

    Topic
    |> where(forum_id: ^forum.id, slug: ^to_string(conn.params[param]))
    |> preload([:user, :forum, :deleted_by, :locked_by, poll: :options])
    |> Repo.one()
    |> maybe_hide_topic(conn, show_hidden)
  end

  defp maybe_hide_topic(nil, conn, _show_hidden),
    do: IneedthisWeb.NotFoundPlug.call(conn)

  defp maybe_hide_topic(%{hidden_from_users: false} = topic, conn, _show_hidden),
    do: assign(conn, :topic, topic)

  defp maybe_hide_topic(topic, %{assigns: %{current_user: user}} = conn, show_hidden) do
    case show_hidden or can?(user, :show, topic) do
      true -> assign(conn, :topic, topic)
      false -> IneedthisWeb.NotAuthorizedPlug.call(conn)
    end
  end
end
