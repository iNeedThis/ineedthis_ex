defmodule IneedthisWeb.Admin.Report.CloseController do
  use IneedthisWeb, :controller

  alias Ineedthis.Reports.Report
  alias Ineedthis.Reports

  plug IneedthisWeb.CanaryMapPlug, create: :edit, delete: :edit
  plug :load_and_authorize_resource, model: Report, id_name: "report_id", persisted: true

  def create(conn, _params) do
    {:ok, _report} = Reports.close_report(conn.assigns.report, conn.assigns.current_user)

    conn
    |> put_flash(:info, "Successfully closed report")
    |> redirect(to: Routes.admin_report_path(conn, :index))
  end
end
