defmodule Ibex.MixProject do
  use Mix.Project

  def project do
    [
      app: :ibex,
      version: "0.1.0",
      elixir: "~> 1.16",
      start_permanent: Mix.env() == :prod,
      deps: deps(),

      # Docs
      name: "Ibex",
      source_url: "https://github.com/malloryerik/ibex",
      homepage_url: "https://github.com/malloryerik/ibex",
      docs: [
        # The main page in the docs
        main: "Ibex"
        # logo: "path/to/logo.png",
        # extras: ["README.md"]
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Ibex.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:ex_doc, "~> 0.31", only: :dev, runtime: false},
      {:msgpax, "~> 2.4"}
    ]
  end
end
