defmodule IslandsEngine.Board do
  alias IslandsEngine.Coordinate

  @letters ~W(a b c d e f g h i j)
  @numbers [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

  @doc """
  Using a agent wrapper to init a board
  which is an empty map
  """
  def start_link do
    Agent.start_link(fn -> %{} end)
  end

  defp keys do
    for letter <- @letters, number <- @numbers do
      String.to_atom("#{letter}#{number}")
    end
  end
end
