defmodule PingPong do
  use GenServer

  #---------------- Servidor ------------------#

  def start_link(state)do
    GenServer.start_link(__MODULE__, state, name: PingPong)
  end

  def init(state) do
      {:ok, state}
  end

  def handle_call(:ping, _from, state) do
    {:reply, :pong, state}
  end

  def handle_cast({:push, state}, old_state) do
    {:noreply, state}
  end

  def handle_call(:get, _from, state) do
    {:reply, state, state}
  end

  #---------------- Cliente ------------------#

  def ping(pid) do
    GenServer.call(pid, :ping)
  end

end

#GenServer.cast(PingPong,{:push, :soy_un_estado})
#GenServer.call(PingPong, :get)
#GenServer.call({PingPong, :"b@127.0.0.1"}, :get)
