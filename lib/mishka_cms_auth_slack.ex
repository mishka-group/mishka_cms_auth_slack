# SPDX-FileCopyrightText: 2026 Mishka Group contributors <https://github.com/mishka-group/mishka_cms_auth_slack/graphs/contributors>
#
# SPDX-License-Identifier: Apache-2.0

defmodule MishkaCmsAuthSlack do
  @moduledoc """
  A `mishka_installer` plugin on `"auth:providers"` (`MishkaCmsCore.Accounts.SignInProvider`),
  started by `MishkaCmsAuthSlack.Application`: installed, it adds Slack to every site's Security tab →
  Sign-in methods, where each site switches it on and sets its keys.

  Signing in with a Slack account ("Sign in with Slack", OpenID Connect): `Assent.Strategy.Slack`
  through the core's one provider strategy, with an app made at api.slack.com/apps. Under OAuth &
  Permissions its redirect URL is the site's
  `MishkaCmsCore.Accounts.SignInProvider.callback_url/1`, and the user scopes are `openid`,
  `email` and `profile`. Slack says whether the email is verified, and only a verified one signs
  in.
  """

  use MishkaCmsCore.Accounts.SignInProvider,
    id: "slack",
    label: gettext_noop("Slack"),
    priority: 30

  @client_id "auth.providers.slack.client_id"
  @client_secret "auth.providers.slack.client_secret"

  @impl true
  def oauth, do: %{assent: Assent.Strategy.Slack}

  @impl true
  def icon,
    do: %{
      color: "text-[#4a154b]",
      path:
        "M5.042 15.165a2.528 2.528 0 0 1-2.52 2.523A2.528 2.528 0 0 1 0 15.165a2.527 2.527 0 0 1 2.522-2.52h2.52v2.52zM6.313 15.165a2.527 2.527 0 0 1 2.521-2.52 2.527 2.527 0 0 1 2.521 2.52v6.313A2.528 2.528 0 0 1 8.834 24a2.528 2.528 0 0 1-2.521-2.522v-6.313zM8.834 5.042a2.528 2.528 0 0 1-2.521-2.52A2.528 2.528 0 0 1 8.834 0a2.528 2.528 0 0 1 2.521 2.522v2.52H8.834zM8.834 6.313a2.528 2.528 0 0 1 2.521 2.521 2.528 2.528 0 0 1-2.521 2.521H2.522A2.528 2.528 0 0 1 0 8.834a2.528 2.528 0 0 1 2.522-2.521h6.312zM18.956 8.834a2.528 2.528 0 0 1 2.522-2.521A2.528 2.528 0 0 1 24 8.834a2.528 2.528 0 0 1-2.522 2.521h-2.522V8.834zM17.688 8.834a2.528 2.528 0 0 1-2.523 2.521 2.527 2.527 0 0 1-2.52-2.521V2.522A2.527 2.527 0 0 1 15.165 0a2.528 2.528 0 0 1 2.523 2.522v6.312zM15.165 18.956a2.528 2.528 0 0 1 2.523 2.522A2.528 2.528 0 0 1 15.165 24a2.527 2.527 0 0 1-2.52-2.522v-2.522h2.52zM15.165 17.688a2.527 2.527 0 0 1-2.52-2.523 2.526 2.526 0 0 1 2.52-2.52h6.313A2.527 2.527 0 0 1 24 15.165a2.528 2.528 0 0 1-2.522 2.523h-6.313z"
    }

  @impl true
  def settings do
    [
      key(@client_id, gettext_noop("Slack client ID"),
        description:
          gettext_noop(
            "From Basic Information of the Slack app made for this site, at api.slack.com/apps. Its redirect address is this site's address followed by /api/auth/user/provider/callback."
          )
      ),
      key(@client_secret, :secret, gettext_noop("Slack client secret"),
        description: gettext_noop("From the same page. Stored sealed and never shown again.")
      )
    ]
  end

  @impl true
  def ready?(site_id), do: own(@client_id, site_id) != nil and secret?(@client_secret, site_id)

  @impl true
  def secret(:client_id, site_id), do: present(own(@client_id, site_id))

  def secret(:client_secret, site_id),
    do: present(MishkaCmsCore.Settings.secret(@client_secret, site_id))

  def secret(_name, _site_id), do: :error

  defp present(value) when is_binary(value) and value != "", do: {:ok, value}
  defp present(_none), do: :error
end
