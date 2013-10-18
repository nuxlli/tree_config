defmodule TreeConfig.Mixfile do
  use Mix.Project

  def project do
    [ app: :tree_config,
      version: "0.0.1",
      elixir: "~> 0.10.3",
      deps: deps(Mix.env),
      configs: [
        example: :mixfile_value,
        with_env: {:from_env, :ENV_EXAMPLE, :default_from_env}
      ]]
  end

  # Configuration for the OTP application
  def application do
    []
  end

  defp deps(:test) do
    [
      {:mock, github: "jjh42/mock"}
    ]
  end

  # Returns the list of dependencies in the format:
  # { :foobar, "~> 0.1", git: "https://github.com/elixir-lang/foobar.git" }
  defp deps(_) do
    []
  end
end
