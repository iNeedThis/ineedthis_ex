defmodule Ineedthis.Repo.Migrations.AddDurationToImages do
  use Ecto.Migration

  def change do
    alter table("images") do
      add :image_duration, :float
    end

    # After successful migration:
    #   alias Ineedthis.Elasticsearch
    #   alias Ineedthis.Images.Image
    #   Elasticsearch.update_mapping!(Image)
  end
end
