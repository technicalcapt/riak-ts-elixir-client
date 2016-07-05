defmodule Riak do
  import Riak.Pool
  alias Riak.Helper

  @moduledoc """
  Riak Time series Elixir client
  """

  @doc """
  Ping the server
  """
  defpool ping(pid) when is_pid(pid), do: :riakc_pb_socket.ping(pid)

  @doc """
  Get data from server
  """
  defpool get(pid, table, keys) when is_list(keys) and is_pid(pid) do
    :riakc_ts.get(pid, table, keys, [])
    |> response
  end

  @doc """
  Put data to server
  """
  defpool put(pid, table, list) when is_list(list) and is_pid(pid) do
    :riakc_ts.put(pid, table, list, [])
    |> response
  end

  @doc """
  Query a table with SQL
  """
  defpool query(pid, query) when is_pid(pid) and is_binary(query) do
    :riakc_ts.query(pid, to_charlist(query))
    |> response
  end

  @doc """
  Delete a row in table by primary key
  """
  defpool delete(pid, table, keys) when is_pid(pid) and is_list(keys) do
    :riakc_ts.delete(pid, table, keys, [])
    |> response
  end

  @doc """
  Listing keys in table
  """
  defpool list_keys(pid, table) when is_pid(pid) do
    :riakc_ts.stream_list_keys(pid, table, [])
  end

  defp response(:ok), do: :ok
  defp response({:ok, tuple}) when is_tuple(tuple), do: tuple |> Helper.parse
  defp response({:error, {_, reason}}), do: {:error, reason}
end
