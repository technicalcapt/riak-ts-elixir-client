defmodule Riak.Query do
  @moduledoc """
    Query module to create query string
  """

  defmacro from(args) do
    quote do
      unquote(args)
    end
  end
end
