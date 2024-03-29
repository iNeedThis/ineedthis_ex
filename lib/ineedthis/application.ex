defmodule Ineedthis.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Start the Ecto repository
      Ineedthis.Repo,

      # Background queueing system
      Ineedthis.ExqSupervisor,

      # Starts a worker by calling: Ineedthis.Worker.start_link(arg)
      # {Ineedthis.Worker, arg},
      {Redix, name: :redix, host: Application.get_env(:ineedthis, :redis_host)},
      {Phoenix.PubSub,
       [
         name: Ineedthis.PubSub,
         adapter: Phoenix.PubSub.Redis,
         host: Application.get_env(:ineedthis, :redis_host),
         node_name: valid_node_name(node())
       ]},

      # Start the endpoint when the application starts
      IneedthisWeb.AdvertUpdater,
      IneedthisWeb.UserFingerprintUpdater,
      IneedthisWeb.UserIpUpdater,
      IneedthisWeb.Telemetry,
      IneedthisWeb.Endpoint,

      # Connection drainer for SIGTERM
      {Plug.Cowboy.Drainer, refs: [IneedthisWeb.Endpoint.HTTP]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Ineedthis.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    IneedthisWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  # Redis adapter really really wants you to have a unique node name,
  # so just fake one if iex is being started
  defp valid_node_name(node) when node in [nil, :nonode@nohost],
    do: Base.encode16(:crypto.strong_rand_bytes(6))

  defp valid_node_name(node), do: node
end
