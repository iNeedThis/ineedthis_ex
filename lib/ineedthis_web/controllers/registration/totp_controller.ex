defmodule IneedthisWeb.Registration.TotpController do
  use IneedthisWeb, :controller

  alias IneedthisWeb.UserAuth
  alias Ineedthis.Users.User
  alias Ineedthis.Users
  alias Ineedthis.Repo

  def edit(conn, _params) do
    user = conn.assigns.current_user

    case user.encrypted_otp_secret do
      nil ->
        user
        |> User.create_totp_secret_changeset()
        |> Repo.update()

        # Redirect to have the conn pick up the changes
        redirect(conn, to: Routes.registration_totp_path(conn, :edit))

      _ ->
        changeset = Users.change_user(user)
        secret = User.totp_secret(user)
        qrcode = User.totp_qrcode(user)

        render(conn, "edit.html",
          title: "Two Factor Authentication",
          changeset: changeset,
          totp_secret: secret,
          totp_qrcode: qrcode
        )
    end
  end

  def update(conn, params) do
    backup_codes = User.random_backup_codes()
    user = conn.assigns.current_user

    user
    |> User.totp_changeset(params, backup_codes)
    |> Repo.update()
    |> case do
      {:error, changeset} ->
        secret = User.totp_secret(user)
        qrcode = User.totp_qrcode(user)
        render(conn, "edit.html", changeset: changeset, totp_secret: secret, totp_qrcode: qrcode)

      {:ok, user} ->
        conn
        |> put_flash(:totp_backup_codes, backup_codes)
        |> put_session(:user_return_to, Routes.registration_totp_path(conn, :edit))
        |> UserAuth.totp_auth_user(user, %{})
    end
  end
end
