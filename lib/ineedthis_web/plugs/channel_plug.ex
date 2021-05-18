defmodule IneedthisWeb.ChannelPlug do
  alias Plug.Conn
  alias Ineedthis.Channels.Channel
  alias Ineedthis.Repo
  import Ecto.Query

  def init([]), do: []

  def call(conn, _opts) do
    live_channels =
      Channel
      |> where(is_live: true)
      |> Repo.aggregate(:count, :id)

    conn
    |> Conn.assign(:live_channels, live_channels)
  end
end
