defmodule LibclusterExampleTest do
  use ExUnit.Case
  doctest LibclusterExample

  test "starts the application supervisors and registry" do
    assert Process.whereis(MyApp.Supervisor)
    assert Process.whereis(PingPongDynamicSupervisor)
    assert Process.whereis(PingPongRegistry)
  end
end
