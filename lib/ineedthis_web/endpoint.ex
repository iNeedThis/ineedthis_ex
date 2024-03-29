defmodule IneedthisWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :ineedthis

  @session_options [
    store: :cookie,
    extra: "SameSite=Lax",
    key: "_ineedthis_key",
    signing_salt: "signed cookie",
    encryption_salt: "authenticated encrypted cookie"
  ]

  socket "/socket", IneedthisWeb.UserSocket,
    websocket: true,
    longpoll: false

  socket "/live", Phoenix.LiveView.Socket,
    websocket: [connect_info: [session: @session_options]]

  # Overwrite remote_ip based on X-Forwarded-For
  plug RemoteIp

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phx.digest
  # when deploying your static files in production.
  plug Plug.Static,
    at: "/",
    from: :ineedthis,
    gzip: false,
    only: ~w(css fonts images js favicon.ico robots.txt)

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    plug Phoenix.CodeReloader
  end

  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  plug Plug.Parsers,
    parsers: [:urlencoded, {:multipart, length: 125_000_000}, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head

  # The session will be stored in the cookie and signed,
  # this means its contents can be read but not tampered with.
  # Set :encryption_salt if you would also like to encrypt it.
  plug Plug.Session, @session_options

  plug IneedthisWeb.RenderTimePlug
  plug IneedthisWeb.ReferrerPlug
  plug IneedthisWeb.LastIpPlug
  plug IneedthisWeb.Router
end
