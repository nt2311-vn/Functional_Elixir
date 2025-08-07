defmodule IslandsEngine.Board do
  alias IslandsEngine.Coordinate

  @letters ~W(a b c d e f g h i j)
  @numbers [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

  @doc """
  Using a agent wrapper to init a board
  which is an empty map
  """
  def start_link do
    Agent.start_link(fn -> initialized_board() end)
  end

  @spec keys :: list(atom())
  defp keys() do
    for letter <- @letters, number <- @numbers do
      String.to_atom("#{letter}#{number}")
    end
  end

  @spec initialized_board :: map()
  defp initialized_board() do
    Enum.reduce(keys(), %{}, fn key, board ->
      {:ok, coord} = Coordinate.start_link()
      Map.put_new(board, key, coord)
    end)
  end

  @doc """
  Function to get a pid to the coordinate by board atom
  """
  @spec get_coordinate(map(), atom()) :: pid()
  def get_coordinate(board, key) when is_atom(key) do
    Agent.get(board, fn board -> board[key] end)
  end

  @doc """
  Function to guess a coordiante by its position in board
  """
  @spec guess_coordinate(map, atom) :: :ok
  def guess_coordinate(board, key) do
    get_coordinate(board, key)
    |> Coordinate.guess()
  end

  @doc """
  Function to return whether a coordinate is hit
  by its board position.
  """
  @spec coordinate_hit?(map, atom) :: boolean
  def coordinate_hit?(board, key) do
    get_coordinate(board, key)
    |> Coordinate.hit?()
  end

  @doc """
  Function to set a coordinate to a specific island
  by its board position.
  """
  @spec set_coordinate_in_island(map, atom, atom) :: :ok
  def set_coordinate_in_island(board, key, island) do
    get_coordinate(board, key)
    |> Coordinate.set_in_island(island)
  end

  @doc """
  Function to return which island a coordinate is in
  by ites board position.
  """
  @spec coordinate_island(map, atom) :: atom
  def coordinate_island(board, key) do
    get_coordinate(board, key)
    |> Coordinate.island()
  end
end
