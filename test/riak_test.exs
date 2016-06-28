defmodule RiakTest do
  use ExUnit.Case, async: true
  doctest Riak

  setup do
    {:ok, pid} = Riak.Connection.start_link
    {:ok, pid: pid}
  end

  test "get data from GeoCheckin table", %{pid: pid} do
    assert Riak.get(pid, "GeoCheckin", ["Atlantic", "Carolina", 6000]) == {:ok, {["region", "state", "time", "weather", "temperature"], [{"Atlantic", "Carolina", 6000, "hot", 23.5}]}}
  end

  test "query data from GeoCheckin table", %{pid: pid} do
    assert Riak.query(pid, "select weather from GeoCheckin where time > 5999 and time < 6001 and region = 'Atlantic' and state = 'Carolina'") == {:ok, {["weather"], [{"hot"}]}}
  end

  test "put data to GeoCheckin table", %{pid: pid} do
    assert Riak.put(pid, "GeoCheckin", [{"North", "Hanoi", 12000, "really hot", 37.0}]) == :ok
  end

  test "parse data to map", %{pid: pid} do
    {:ok, {keys, values}} = Riak.get(pid, "GeoCheckin", ["Atlantic", "Carolina", 6000])
    for key <- keys, value <- values, do: %{key => value}
  end
end
