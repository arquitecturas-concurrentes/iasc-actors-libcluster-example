defmodule DynamicPingPongTest do
  use ExUnit.Case

  test "workers register with increasing IDs and preserve their state" do
    {:ok, first} = PingPongDynamicSupervisor.start_child(:first)
    on_exit(fn -> DynamicSupervisor.terminate_child(PingPongDynamicSupervisor, first) end)
    {:ok, second} = PingPongDynamicSupervisor.start_child(:second)
    on_exit(fn -> DynamicSupervisor.terminate_child(PingPongDynamicSupervisor, second) end)

    entries = Registry.select(PingPongRegistry, [{{:"$1", :"$2", :_}, [], [{{:"$1", :"$2"}}]}])
    ids = Map.new(entries, fn {id, pid} -> {pid, id} end)

    assert ids[first] > 0
    assert ids[second] > ids[first]
    assert PingPongRegistry.get_ping_pong(ids[first]) == [{first, first}]
    assert PingPongRegistry.get_ping_pong(ids[second]) == [{second, second}]
    assert Enum.sort(PingPongRegistry.get_ping_pongs()) == Enum.sort([{ids[first], first}, {ids[second], second}])
    assert GenServer.call(first, :get) == %{id: ids[first], data: :first}
    assert GenServer.call(second, :get) == %{id: ids[second], data: :second}
    GenServer.cast(first, {:push, :updated})
    assert GenServer.call(first, :get) == %{id: ids[first], data: :updated}
    assert DynamicPingPong.ping(first) == :pong
  end
end
