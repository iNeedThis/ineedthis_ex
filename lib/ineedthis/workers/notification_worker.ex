defmodule Ineedthis.NotificationWorker do
  @modules %{
    "Comments" => Ineedthis.Comments,
    "Galleries" => Ineedthis.Galleries,
    "Images" => Ineedthis.Images,
    "Posts" => Ineedthis.Posts,
    "Topics" => Ineedthis.Topics
  }

  def perform(module, args) do
    @modules[module].perform_notify(args)
  end
end
