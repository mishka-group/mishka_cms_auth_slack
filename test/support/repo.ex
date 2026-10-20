# SPDX-FileCopyrightText: 2026 Mishka Group contributors <https://github.com/mishka-group/mishka_cms_auth_slack/graphs/contributors>
#
# SPDX-License-Identifier: Apache-2.0

defmodule MishkaCmsAuth.Test.Repo do
  @moduledoc false
  use AshPostgres.Repo, otp_app: :mishka_cms_auth

  def installed_extensions, do: ["ash-functions", "citext"]
  def min_pg_version, do: %Version{major: 16, minor: 0, patch: 0}
end
