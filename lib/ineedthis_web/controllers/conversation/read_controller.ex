defmodule IneedthisWeb.Conversation.ReadController do
  use IneedthisWeb, :controller

  alias Ineedthis.Conversations.Conversation
  alias Ineedthis.Conversations

  plug IneedthisWeb.CanaryMapPlug, create: :show, delete: :show

  plug :load_and_authorize_resource,
    model: Conversation,
    id_field: "slug",
    id_name: "conversation_id",
    persisted: true

  def create(conn, _params) do
    conversation = conn.assigns.conversation
    user = conn.assigns.current_user

    {:ok, _conversation} = Conversations.mark_conversation_read(conversation, user)

    conn
    |> put_flash(:info, "Conversation marked as read.")
    |> redirect(to: Routes.conversation_path(conn, :show, conversation))
  end

  def delete(conn, _params) do
    conversation = conn.assigns.conversation
    user = conn.assigns.current_user

    {:ok, _conversation} = Conversations.mark_conversation_read(conversation, user, false)

    conn
    |> put_flash(:info, "Conversation marked as unread.")
    |> redirect(to: Routes.conversation_path(conn, :index))
  end
end
