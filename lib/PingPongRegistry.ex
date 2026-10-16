defmodule PingPongRegistry do

  def child_spec(opts) do
      %{
        id: __MODULE__,
        start: {__MODULE__, :start_link, [opts]},
        type: :worker,
        restart: :permanent
      }
    end

  def start_link(_state) do
    Registry.start_link(keys: :unique, name: __MODULE__)
  end

  def registrar_ping_pong(key, pid) do
    Registry.register(__MODULE__, key, pid)
  end

  def get_ping_pongs() do
    Registry.select(__MODULE__, [{{:"$1", :"$2", :_}, [], [{{:"$1", :"$2"}}]}])
  end

  def get_ping_pong(id) do
    Registry.lookup(__MODULE__, id)
  end

end

#pids = PingPongRegistry.get_ping_pongs()
#Enum.map(pids, fn({_id, pid}) -> GenServer.call(pid, :get) end)
#Enum.each(pids, fn({_id, pid}) -> GenServer.cast(pid,{:push, :soy_un_estado_loco}) end)
#:rpc.call(:"b@127.0.0.1", PingPongRegistry, :get_ping_pongs, []) #desde el nodo B
