defmodule Excontainers.RedisContainer do
  alias Excontainers.{Container, Containers, CommandWaitStrategy}

  @redis_port 6379
  @wait_strategy CommandWaitStrategy.new(["redis-cli", "PING"])

  def new(image \\ "redis:6.0-alpine", opts \\ []) do
    Containers.new(
      image,
      exposed_ports: [@redis_port],
      environment: %{},
      wait_strategy: @wait_strategy
    )
  end

  def port(pid), do: Container.mapped_port(pid, @redis_port)

  def connection_url(pid), do: "redis://localhost:#{port(pid)}/"
end
