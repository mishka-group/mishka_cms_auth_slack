# Changelog for MishkaCmsAuthSlack 0.0.2

- Needs mishka_cms_core 0.0.4 and mishka_gervaz 0.0.3, where it needed 0.0.2 of each. The core's 0.0.3 release moved the visual editor into the new mishka_cms_builder package. The Slack sign-in itself does not change
- The release runs on Erlang 29.1.2 and Elixir 1.20.5. The temporary OTP 29.0.5 pin is removed, because the download libraries fetch precompiled NIFs again on newer OTP versions
- Every dependency is at its latest release, including igniter_js 0.5.2, image 0.73.0, localize 1.5.0 and assent 0.3.2
- Security: phoenix_html 4.4.0 fixes a security advisory. jose 1.11.13 fixes 8 advisories, and ash 3.37.2 and ash_postgres 2.15.2 fix the multitenancy ones
- `mix ci` runs the dependency audits, Credo, Sobelow, Dialyzer and the duplicate-code check, and Dependabot updates the dependencies every week

# Changelog for MishkaCmsAuthSlack 0.0.1

- Initial version: [mishka.tools/cms](https://mishka.tools/cms)
