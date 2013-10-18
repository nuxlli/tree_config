defmodule TreeConfig do
  defmacro __using__(mix_module) do
    app = Macro.expand_all(mix_module, __ENV__).project[:app]
    quote do
      def get(key) do
        get_app_env(unquote(app), key)
          |> from_hash(Mix.project[:configs][:overrides][unquote(app)], key)
          |> from_hash(unquote(mix_module).project[:configs], key)
          |> normalize
      end

      def set(key, value) do
        :application.set_env(unquote(app), key, value)
        value
      end

      defp normalize({:ok, {:from_env, env, default}}) do
        System.get_env("#{env}") || default
      end
      defp normalize({:ok, value}), do: value
      defp normalize(_), do: nil

      defp get_app_env(app, key) do
        :application.get_env(unquote(app), key)
      end

      defp from_hash({:ok, value}, _, _), do: {:ok, value}
      defp from_hash(_, hash, key) do
        case Keyword.has_key?((hash || []), key) do
          true  -> {:ok, hash[key]}
          false -> {:not_found}
        end
      end
    end
  end
end
