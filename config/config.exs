# SPDX-FileCopyrightText: 2026 Mishka Group contributors <https://github.com/mishka-group/mishka_cms_auth_slack/graphs/contributors>
#
# SPDX-License-Identifier: Apache-2.0

import Config

# Only for building and testing this package on its own: a host's own config names these. The
# same stand-ins in every mishka_cms_auth_* package, so one build of the core serves them all.
config :mishka_cms_core,
  repo: MishkaCmsAuth.Test.Repo,
  endpoint: MishkaCmsAuth.Test.Endpoint,
  host_app: :mishka_cms_auth
