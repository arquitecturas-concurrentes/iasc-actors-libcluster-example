defmodule PingPongRegistry do

  def child_spec(opts) do
      %{
        id: __MODULE__,
        start: {__MODULE__, :start_link, [opts]},
        type: :worker,
        restart: :permanent,
        shutdown: 500
      }
    end

  def start_link(_state) do
    Registry.start_link(keys: :duplicate, name: __MODULE__)
  end

  def registrar_ping_pong(key, pid) do
    Registry.register(__MODULE__, key, pid)
  end

  def get_ping_pongs(key) do
    Registry.lookup(__MODULE__, key)
  end

end

#PingPongRegistry.get_ping_pongs(:ping_pong)
#Enum.map(pids, fn({pid, _}) -> GenServer.call(pid, :get) end)
#Enum.each(pids, fn({pid, _}) -> GenServer.cast(pid,{:push, :soy_un_estado_loco}) end)
#:rpc.call(:"a@127.0.0.1", PingPongRegistry, :get_ping_pongs, [:ping_pong]) #desde el nodo b
