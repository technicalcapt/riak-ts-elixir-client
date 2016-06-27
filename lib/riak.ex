defmodule Riak do

  @moduledoc """
  Riak Time series Elixir client
  """

  @doc """
  Ping the server
  """
  def ping(pid) when is_pid(pid), do: :riakc_pb_socket.ping(pid)

  @doc """
  Get data from server
  """
  def get(pid, table, list \\ [], opts \\ []) when is_binary(table) and is_pid(pid) do
    :riakc_ts.get(pid, table, list, opts)
  end

  @doc """
  Put data to server
  """
  def put(pid, table, list \\ []) when is_binary(table) and is_pid(pid) do
    :riakc_ts.put(pid, table, list)
  end
end
