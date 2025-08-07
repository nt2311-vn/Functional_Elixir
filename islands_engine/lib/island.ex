defmodule IslandsEngine.Island do
  alias IslandsEngine.Coordinate

  @doc """
  Function to start an initial state of a Island
  """
  @spec start_link :: list(pid)
  def start_link() do
    Agent.start_link(fn -> [] end)
  end

  @doc """
  Function to replace a complete new list coordinate to
  old one.
  """
  @spec replace_coordinates(list(pid), list(pid)) :: :ok
  def replace_coordinates(island, new_coordinates) when is_list(new_coordinates) do
    Agent.update(island, fn _state -> new_coordinates end)
  end

  def forested?(island) do
    island
    |> Agent.get(fn state -> state end)
    |> Enum.all?(&Coordinate.hit?(&1))
  end

  @doc """
  Function to return represent string of an island
  """
  @spec to_string(list(pid)) :: charlist()
  def to_string(island) do
    "[" <> coordinate_strings(island) <> "]"
  end

  @spec coordinate_strings(list(pid)) :: charlist()
  defp coordinate_strings(island) do
    island
    |> Agent.get(& &1)
    |> Enum.map(&Coordinate.to_string(&1))
    |> Enum.join(", ")
  end
end
