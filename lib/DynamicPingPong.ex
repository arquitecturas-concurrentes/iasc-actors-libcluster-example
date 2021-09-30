defmodule DynamicPingPong do
  use GenServer

  #---------------- Servidor ------------------#

  def start_link(state)do
    GenServer.start_link(__MODULE__, state)
  end

  def init(state) do
      PingPongRegistry.registrar_ping_pong(:ping_pong, self())
      {:ok, state}
  end

  def handle_call(:ping, _from, state) do
    {:reply, :pong, state}
  end

  def handle_call(:get, _from, state) do
    {:reply, state, state}
  end

  def handle_cast({:push, state}, _old_state) do
    {:noreply, state}
  end

  #---------------- Cliente ------------------#

  def ping(pid) do
    GenServer.call(pid, :ping)
  end

end

#GenServer.cast(pid,{:push, :soy_un_estado})
#GenServer.call(pid, :get)
#GenServer.call({pid, :"b@127.0.0.1"}, :get)
