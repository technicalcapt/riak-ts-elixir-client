# Riak

**A Riak Time series elixir client**

## Usage
`Make sure your Riak TS is already started`

Start connection with your host and port in riak.conf
  ```
   {:ok, pid} = Riak.Connection.start_link('127.0.0.1', 8087) #Default port
  ```
  
Get data from a table:
  ```
  iex(2)> {:ok, tuple} = Riak.get(pid, "GeoCheckin", ["Atlantic", "Carolina", 6000])
  {:ok,
   {["region", "state", "time", "weather", "temperature"],
     [{"Atlantic", "Carolina", 6000, "hot", 23.5}]}}
  ```
  
Put data:
  ```
  iex(5)> Riak.put(pid, "GeoCheckin", [{"The North", "Hanoi", 15000, "very hot", 37.0}]) # same order when you plan your table
  :ok
  ```
  
Query data with SQL command:
  ```
  iex(8)> Riak.query(pid, "select * from GeoCheckin where time < 15001 and time > 14999 and region = 'The North' and state = 'Hanoi'")
  {:ok,
   {["region", "state", "time", "weather", "temperature"],
     [{"The North", "Hanoi", 15000, "very hot", 37.0}]}}
  ```
  
Parse data after get:
  ```
  iex(2)> {:ok, tuple} = Riak.get(pid, "GeoCheckin", ["Atlantic", "Carolina", 6000])
  {:ok,
   {["region", "state", "time", "weather", "temperature"],
     [{"Atlantic", "Carolina", 6000, "hot", 23.5}]}}

  iex(9)> Riak.Helper.parse(tuple)
  %{"region" => "Atlantic", "state" => "Carolina", "temperature" => 23.5,
    "time" => 6000, "weather" => "hot"}
  ```
