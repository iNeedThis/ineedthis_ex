defmodule IneedthisWeb.DuplicateReport.RejectController do
  use IneedthisWeb, :controller

  alias Ineedthis.DuplicateReports.DuplicateReport
  alias Ineedthis.DuplicateReports

  plug IneedthisWeb.CanaryMapPlug, create: :edit, delete: :edit

  plug :load_and_authorize_resource,
    model: DuplicateReport,
    id_name: "duplicate_report_id",
    persisted: true,
    preload: [:image, :duplicate_of_image]

  def create(conn, _params) do
    {:ok, _report} =
      DuplicateReports.reject_duplicate_report(
        conn.assigns.duplicate_report,
        conn.assigns.current_user
      )

    conn
    |> put_flash(:info, "Successfully rejected report.")
    |> redirect(to: Routes.duplicate_report_path(conn, :index))
  end
end
