defmodule IslandsEngine.Island do
  alias IslandsEngine.Coordinate

  @doc """
  Function to start an initial state of a Island
  """
  @spec start_link :: list(Coordinate)
  def start_link() do
    Agent.start_link(fn -> [] end)
  end
end
