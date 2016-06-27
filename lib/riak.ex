defmodule Riak do

  @moduledoc """
  Riak Time series Elixir client
  """
  use :riakc_pb_socket


  @doc """
  Ping the server
  """
  def ping(pid) when is_pid(pid), do: :riakc_pb_socket.ping(pid)

  @doc """
  Put metadata/value in the table
  """

end
