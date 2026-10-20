# Mishka CMS Auth Slack

Sign in with Slack for [Mishka CMS](https://mishka.tools/cms). Each site switches it on and
sets its own keys; no other setup is needed.

## Install

```elixir
# mix.exs
{:mishka_cms_auth_slack, "~> 0.0.1"}
```

Run `mix deps.get` and restart. The package registers itself with Mishka CMS through
`mishka_installer`; there is no config to add and no migration.

## Set up

1. Make the app at [api.slack.com/apps](https://api.slack.com/apps) → **Create New App** (under **OAuth & Permissions** add the user scopes `openid`, `email`, `profile`).
2. Redirect URL (OAuth & Permissions; Slack takes `https://` only): `https://<your-site>/api/auth/user/slack/callback`
3. In Mishka CMS: **Settings → Security → Sign-in methods** → switch **Slack** on. Paste the
   **Client ID** and **Client Secret (Basic Information → App Credentials)** into the fields that open under it, then **Save**.

The Slack button now shows on the sign-in and registration pages.

## What it does

- "Sign in with Slack" (OpenID Connect). Slack says whether the email is verified; only a verified one signs in.
- Links to an existing confirmed account with the same email, and claims one nobody confirmed.
- Makes a new account only while the site allows it, and never makes a master.
- Asks for the authenticator code when the account has two-step sign-in.
- Keeps none of Slack's tokens.

## License

Apache-2.0
