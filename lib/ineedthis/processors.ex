defmodule Ineedthis.Processors do
  @moduledoc """
  Utilities for processing uploads.

  Processors have 3 methods available:

  - process/3:
    Takes an analysis, file path, and version list and generates an
    "edit script" that represents how to store this file according to the
    given version list. See Ineedthis.Images.Thumbnailer for more
    information on how this works.

  - post_process/2:
    Takes an analysis and file path and performs optimizations on the
    upload. See Ineedthis.Images.Thumbnailer for more information on how this
    works.

  - intensities/2:
    Takes an analysis and file path and generates an intensities map
    appropriate for use by Ineedthis.DuplicateReports.
  """

  alias Ineedthis.Processors.Gif
  alias Ineedthis.Processors.Jpeg
  alias Ineedthis.Processors.Png
  alias Ineedthis.Processors.Svg
  alias Ineedthis.Processors.Webm

  @doc """
  Returns a processor, with the processor being a module capable
  of processing this content type, or nil.
  """
  @spec processor(String.t()) :: module() | nil
  def processor(content_type)

  def processor("image/gif"), do: Gif
  def processor("image/jpeg"), do: Jpeg
  def processor("image/png"), do: Png
  def processor("image/svg+xml"), do: Svg
  def processor("video/webm"), do: Webm
  def processor(_content_type), do: nil

  @doc """
  Takes an analyzer, file path, and version list and runs the appropriate
  processor's process/3.
  """
  @spec process(map(), String.t(), keyword) :: map()
  def process(analysis, file, versions) do
    processor(analysis.mime_type).process(analysis, file, versions)
  end

  @doc """
  Takes an analyzer and file path and runs the appropriate processor's
  post_process/2.
  """
  @spec post_process(map(), String.t()) :: map()
  def post_process(analysis, file) do
    processor(analysis.mime_type).post_process(analysis, file)
  end

  @doc """
  Takes an analyzer and file path and runs the appropriate processor's
  intensities/2.
  """
  @spec intensities(map(), String.t()) :: map()
  def intensities(analysis, file) do
    processor(analysis.mime_type).intensities(analysis, file)
  end
end
