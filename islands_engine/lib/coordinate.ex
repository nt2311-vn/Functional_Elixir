defmodule IslandsEngine.Coordinate do
  defstruct in_island: :none, guessed?: false

  alias IslandsEngine.Coordinate

  def start_link do
    Agent.start_link(fn -> %Coordinate{} end)
  end

  @doc """
  Function to return current value of key guessed? in Coordinate
  """
  @spec guessed?(Coordinate) :: boolean()
  def guessed?(coordinate) do
    Agent.get(coordinate, fn state -> state.guessed? end)
  end

  @doc """
  Function to return currnet value of key in_island in Coordinate
  """
  @spec island(Coordinate) :: atom()
  def island(coordinate) do
    Agent.get(coordinate, fn state -> state.in_island end)
  end

  @doc """
  Function to check whether Coordiante struct is island
  """
  @spec in_island?(Coordinate) :: boolean()
  def in_island?(coordinate) do
    case island(coordinate) do
      :none -> false
      _ -> true
    end
  end

  @doc """
  Function to check whether the Coordinate is hit
  """
  @spec hit?(Coordinate) :: boolean()
  def hit?(coordinate) do
    guessed?(coordinate) && in_island?(coordinate)
  end

  @doc """
  Function to marked guessed to a Coordinate
  """
  @spec guess(Coordinate) :: :ok
  def(guess(coordinate)) do
    Agent.update(coordinate, fn state -> Map.put(state, :guessed?, true) end)
  end

  @doc """
  Function to set coordinate in island when player
  move around
  """
  @spec set_in_island(Coordinate, atom()) :: :ok
  def set_in_island(coordinate, value) when is_atom(value) do
    Agent.update(coordinate, fn state -> Map.put(state, :in_island, value) end)
  end
end
