defmodule Emperor.MixProject do
  use Mix.Project

  def project do
    [
      app: :emperor,
      http: [port: {:system, "PORT"}],
      version: "0.1.0",
      elixir: "~> 1.5",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Emperor, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:poison , "~> 3.1"},
      {:distillery, "~> 1.5", runtime: false}
    ]
  end
end
