# TreeConfig

Simple configure module to elixir projects.

# Simple example

```elixir
defmodule Simple.Mixfile do
  def project
    [ app: :simple,
      configs: [
        plan: "plan value",
        from_env: {:from_env, :ENV_VALUE, :default}
      ]]
    ]
  end
end

defmodule Simple.Config do
  use TreeConfig, Simple.Mixfile
end
```

```elixir
iex> Simple.Config.get(:plan)
"plan value"
iex> # save override in :application
iex> Simple.Config.set(:plan, 10)
10
iex> Simple.Config.get(:from_env)
:default
iex> System.put_env("ENV_VALUE", "env_value")
iex> System.Config.get(:from_env)
"env_value"
```

# Depedencies overrides examples

```elixir
defmodule OverTheSimple.Mixfile do
  def project
    [ app: :over_the_simple,
      deps: [{:simple}],
      configs: [
        overrides: [
          simple: [plan: "other plan value"]
        ]
      ]]
end
```

## License

"Azuki" and the Azuki logo are copyright (c) 2013 Azuki Serviços de Internet LTDA..

TreeConfig source code is released under Apache 2 License.

Check LEGAL and LICENSE files for more information.
