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

  def handle_call(:get, _from, state) do
    {:reply, state, state}
  end

  def handle_cast({:push, state}, _old_state) do
    {:noreply, state}
  end

  #---------------- Cliente ------------------#

  def ping() do
    GenServer.call(PingPong, :ping)
  end

end

#GenServer.cast(PingPong,{:push, :soy_un_estado})
#GenServer.call(PingPong, :get)
#GenServer.call({PingPong, :"a@127.0.0.1"}, :get)
#GenServer.call({PingPong, :"b@127.0.0.1"}, :ping)
