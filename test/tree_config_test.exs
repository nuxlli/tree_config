defmodule TreeConfigTest do
  use ExUnit.Case, async: false

  import Mock

  defmodule Config do
    use TreeConfig, TreeConfig.Mixfile
  end

  test "first get from de application env" do
    Config.set(:example_app_env, :value)
    assert :value == Config.get(:example_app_env)
  end

  test "second get from a current override project" do
    value = :current_project_value
    mocks = [ project: fn -> [configs: [overrides: [tree_config: [ current: value ]]]] end]
    with_mock Mix, [:unstick, :passthrough], mocks do
      assert value == Config.get(:current)
    end
  end

  test "third get from a Mixfile" do
    value = :mixfile_value
    mocks = [ project: fn -> [] end]
    with_mock Mix, [:unstick, :passthrough], mocks do
      assert value == Config.get(:example)
    end
  end

  test "and finally get from env" do
    assert :default_from_env == Config.get(:with_env)
    System.put_env("ENV_EXAMPLE", "now_from_env")
    assert "now_from_env" == Config.get(:with_env)
  end

  def pp(value), do: IO.inspect(value)
end
