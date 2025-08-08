defmodule IslandsEngine.IslandSet do
  alias IslandsEngine.{Island, IslandSet}

  defstruct atoll: :none, dot: :none, l_shape: :none, s_shape: :none, squre: :none

  @doc """
  Start link and islandset struct
  """
  def start_link do
    Agent.start_link(fn -> %IslandSet{} end)
  end

  defp initialized_set do
    Enum.reduce(keys(), %IslandSet{}, fn key, set ->
      {:ok, island} = Island.start_link()
      Map.put(set, key, island)
    end)
  end

  defp keys do
    %IslandSet{}
    |> Map.from_struct()
    |> Map.keys()
  end
end
