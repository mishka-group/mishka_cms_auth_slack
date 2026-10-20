# SPDX-FileCopyrightText: 2026 Mishka Group contributors <https://github.com/mishka-group/mishka_cms_auth_slack/graphs/contributors>
#
# SPDX-License-Identifier: Apache-2.0

defmodule MishkaCmsAuthSlackTest do
  use ExUnit.Case, async: true

  test "is a sign-in provider Assent speaks to" do
    assert MishkaCmsCore.Accounts.SignInProvider in behaviours(MishkaCmsAuthSlack)
    assert MishkaCmsAuthSlack.id() == "slack"
    assert %{assent: Assent.Strategy.Slack} = MishkaCmsAuthSlack.oauth()
    assert MishkaCmsAuthSlack.label() == "Slack"
    assert %{path: "M" <> _, color: "text-" <> _} = MishkaCmsAuthSlack.icon()
  end

  test "asks each site for a client ID and a sealed client secret" do
    assert [
             %{key: "auth.providers.slack.client_id", type: :string, scope: :site},
             %{key: "auth.providers.slack.client_secret", type: :secret, scope: :site}
           ] = MishkaCmsAuthSlack.settings()
  end

  test "hands AshAuthentication nothing it does not keep" do
    assert MishkaCmsAuthSlack.secret(:team_id, "any-site") == :error
  end

  defp behaviours(module),
    do: module.module_info(:attributes) |> Keyword.get_values(:behaviour) |> List.flatten()
end
