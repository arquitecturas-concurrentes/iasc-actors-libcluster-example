defmodule LibclusterExampleTest do
  use ExUnit.Case
  doctest LibclusterExample

  test "greets the world" do
    assert LibclusterExample.hello() == :world
  end
end
