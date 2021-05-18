defmodule Ineedthis.IndexWorker do
  @modules %{
    "Comments" => Ineedthis.Comments,
    "Galleries" => Ineedthis.Galleries,
    "Images" => Ineedthis.Images,
    "Posts" => Ineedthis.Posts,
    "Reports" => Ineedthis.Reports,
    "Tags" => Ineedthis.Tags,
    "Filters" => Ineedthis.Filters
  }

  # Perform the queued index. Context function looks like the following:
  #
  #     def perform_reindex(column, condition) do
  #       Image
  #       |> preload(^indexing_preloads())
  #       |> where([i], field(i, ^column) in ^condition)
  #       |> Elasticsearch.reindex(Image)
  #     end
  #
  def perform(module, column, condition) do
    @modules[module].perform_reindex(String.to_existing_atom(column), condition)
  end
end
