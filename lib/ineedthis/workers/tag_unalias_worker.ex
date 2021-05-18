defmodule Ineedthis.TagUnaliasWorker do
  alias Ineedthis.Tags

  def perform(tag_id) do
    Tags.perform_unalias(tag_id)
  end
end
