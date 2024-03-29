defmodule IneedthisWeb.SiteNoticePlug do
  @moduledoc """
  This plug stores the current site-wide notices.

  ## Example

      plug IneedthisWeb.SiteNoticePlug
  """

  alias Plug.Conn
  alias Ineedthis.SiteNotices

  @doc false
  @spec init(any()) :: any()
  def init(opts), do: opts

  @doc false
  @spec call(Plug.Conn.t(), any()) :: Plug.Conn.t()
  def call(conn, _opts) do
    notices = SiteNotices.active_site_notices()

    conn
    |> Conn.assign(:site_notices, notices)
  end
end
