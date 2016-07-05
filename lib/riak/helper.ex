defmodule Riak.Helper do
  @moduledoc """
    Module helper for Riak Elixir Client
  """

  @doc """
    Parse data from riak time series to a map
  """
  def parse({first, second}) when length(first) == 0 and length(second) == 0,
    do: nil
  def parse(tuple) when is_tuple(tuple) do
    {first, [second]} = tuple
    second = second |> Tuple.to_list
    do_parse(%{}, first, second)
  end

  defp do_parse(map, [], []), do: map
  defp do_parse(map, [hd | tl], [head | tail]) when is_map(map) do
    Map.update(map, hd, head, &(&1)) |> do_parse(tl, tail)
  end
end
