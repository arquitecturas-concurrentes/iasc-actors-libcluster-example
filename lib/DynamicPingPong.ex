defmodule DynamicPingPong do
  use GenServer

  #---------------- Servidor ------------------#

  def start_link(state)do
    id = System.unique_integer([:positive, :monotonic])
    GenServer.start_link(__MODULE__, %{id: id, data: state})
  end

  def init(state) do
      {:ok, _} = PingPongRegistry.registrar_ping_pong(state.id, self())
      {:ok, state}
  end

  def handle_call(:ping, _from, state) do
    {:reply, :pong, state}
  end

  def handle_call(:get, _from, state) do
    {:reply, state, state}
  end

  def handle_cast({:push, data}, state) do
    {:noreply, %{state | data: data}}
  end

  #---------------- Cliente ------------------#

  def ping(pid) do
    GenServer.call(pid, :ping)
  end

end

#GenServer.cast(pid,{:push, :soy_un_estado})
#GenServer.call(pid, :get)
#GenServer.call({pid, :"b@127.0.0.1"}, :get)
