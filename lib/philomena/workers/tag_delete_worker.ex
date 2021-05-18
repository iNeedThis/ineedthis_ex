defmodule Ineedthis.TagDeleteWorker do
  alias Ineedthis.Tags

  def perform(tag_id) do
    Tags.perform_delete(tag_id)
  end
end
