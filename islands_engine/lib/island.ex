defmodule IslandsEngine.Island do
  alias IslandsEngine.Coordinate

  @doc """
  Function to start an initial state of a Island
  """
  @spec start_link :: list(Coordinate)
  def start_link() do
    Agent.start_link(fn -> [] end)
  end

  @doc """
  Function to replace a complete new list coordinate to
  old one.
  """
  @spec replace_coordinates(list(Coordinate), list(Coordinate)) :: :ok
  def replace_coordinates(island, new_coordinates) when is_list(new_coordinates) do
    Agent.update(island, fn _state -> new_coordinates end)
  end
end
