defmodule IneedthisWeb.Profile.Commission.ReportController do
  use IneedthisWeb, :controller

  alias IneedthisWeb.ReportController
  alias IneedthisWeb.ReportView
  alias Ineedthis.Users.User
  alias Ineedthis.Reports.Report
  alias Ineedthis.Reports

  plug IneedthisWeb.FilterBannedUsersPlug
  plug IneedthisWeb.UserAttributionPlug
  plug IneedthisWeb.CaptchaPlug
  plug IneedthisWeb.CheckCaptchaPlug when action in [:create]
  plug IneedthisWeb.CanaryMapPlug, new: :show, create: :show

  plug :load_resource,
    model: User,
    id_name: "profile_id",
    id_field: "slug",
    preload: [
      :verified_links,
      commission: [
        sheet_image: [tags: :aliases],
        user: [awards: :badge],
        items: [example_image: [tags: :aliases]]
      ]
    ],
    persisted: true

  plug :ensure_commission

  def new(conn, _params) do
    user = conn.assigns.user
    commission = conn.assigns.user.commission
    action = Routes.profile_commission_report_path(conn, :create, user)

    changeset =
      %Report{reportable_type: "Commission", reportable_id: commission.id}
      |> Reports.change_report()

    conn
    |> put_view(ReportView)
    |> render("new.html",
      title: "Reporting Commission",
      reportable: commission,
      changeset: changeset,
      action: action
    )
  end

  def create(conn, params) do
    user = conn.assigns.user
    commission = conn.assigns.user.commission
    action = Routes.profile_commission_report_path(conn, :create, user)

    ReportController.create(conn, action, commission, "Commission", params)
  end

  defp ensure_commission(conn, _opts) do
    case is_nil(conn.assigns.user.commission) do
      true -> IneedthisWeb.NotFoundPlug.call(conn)
      false -> conn
    end
  end
end
