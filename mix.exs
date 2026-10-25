# SPDX-FileCopyrightText: 2026 Mishka Group contributors <https://github.com/mishka-group/mishka_cms_auth_slack/graphs/contributors>
#
# SPDX-License-Identifier: Apache-2.0

defmodule MishkaCmsAuthSlack.MixProject do
  use Mix.Project

  @version "0.0.1"
  @source_url "https://github.com/mishka-group/mishka_cms_auth_slack"

  def project do
    [
      app: :mishka_cms_auth_slack,
      name: "Mishka CMS Auth Slack",
      version: @version,
      elixir: "~> 1.20",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      elixirc_paths: elixirc_paths(Mix.env()),
      aliases: aliases(),
      description:
        "Sign in with Slack for Mishka CMS: a plugin each site switches on and gives its own keys.",
      package: package(),
      homepage_url: "https://mishka.tools/cms",
      source_url: @source_url,
      docs: [
        main: "readme",
        source_ref: "v#{@version}",
        extras: ["README.md"],
        source_url: @source_url
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {MishkaCmsAuthSlack.Application, []}
    ]
  end

  # The repo and endpoint names Mishka CMS Core compiles against, for building this package on its
  # own; a host brings its own.
  defp elixirc_paths(:prod), do: ["lib"]
  defp elixirc_paths(_env), do: ["lib", "test/support"]

  defp deps do
    [
      mishka_dep(:mishka_cms_core, "~> 0.0.1"),
      {:ash_authentication, "~> 5.0.0-rc.15"},
      mishka_dep(:mishka_gervaz, "~> 0.0.1"),
      {:ex_doc, "~> 0.40", only: :dev, runtime: false},
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false}
    ]
  end

  # A Mishka package is its sibling checkout `../<name>` when there is one, and its Hex release
  # otherwise. Only a git checkout counts, so the copy Mix fetched into a host's `deps/` never does,
  # and a `hex.*` task (`mix hex.build`, `mix hex.publish`) always takes Hex, as a package must.
  defp mishka_dep(name, requirement) do
    sibling? =
      File.dir?(Path.expand("../#{name}/.git", __DIR__)) and
        not Enum.any?(System.argv(), &String.starts_with?(&1, "hex."))

    case sibling? do
      true -> {name, path: "../#{name}"}
      false -> {name, requirement}
    end
  end

  # The provider is a module: its tests run without starting the CMS.
  defp aliases, do: [test: ["test --no-start"]]

  defp package do
    [
      licenses: ["Apache-2.0"],
      maintainers: ["Shahryar Tavakkoli"],
      files: ~w(lib .formatter.exs mix.exs LICENSE README*),
      links: %{
        "Mishka CMS" => "https://mishka.tools/cms",
        "Official document" => "https://mishka.tools/cms/docs",
        "GitHub" => @source_url,
        "Sponsor" => "https://github.com/sponsors/mishka-group",
        "Contributors" => "#{@source_url}/graphs/contributors"
      }
    ]
  end
end
