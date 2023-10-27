defmodule PingPongSupervisor do
  use Supervisor

  def start_link(init_arg) do
    Supervisor.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  def init(_init_arg) do
    children = [
      %{id: PingPong, start: {PingPong, :start_link, [[], PingPong]}, restart: :transient},
      %{id: PingPong2,  start: {PingPong, :start_link, [[], PingPong2]}, restart: :transient}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end

end
