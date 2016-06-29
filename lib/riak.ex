defmodule Riak do
  import Riak.Pool

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
  end

  @doc """
  Put data to server
  """
  defpool put(pid, table, list) when is_list(list) and is_pid(pid) do
    :riakc_ts.put(pid, table, list, [])
  end

  @doc """
  Query a table with SQL
  """
  defpool query(pid, query) when is_pid(pid) and is_binary(query) do
    :riakc_ts.query(pid, to_charlist(query))
  end
end
