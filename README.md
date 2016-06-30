# Riak

**A Riak Time series elixir client**

## Usage
`Make sure your Riak TS is already started`
Use Pooler to create a pool that manage connection to a Riak node

As long as you config your pool.You can use Riak to get, put and query data without spawning a pid:

  ```
   config :pooler, pools:
[
  [
    name: :riaklocal,
    group: :riak,
    max_count: 10,
    init_count: 5,
    start_mfa: { Riak.Connection, :start_link, []}
  ]
]
  ```

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
  Or
  ```
    Riak.get("GeoCheckin", ["The South", "HCM City", 9000])
    {:ok,
     {["region", "state", "time", "weather", "temperature"],
       [{"The South", "HCM City", 9000, "cool", 27.0}]}}
       iex(2)>
  ```
  
Put data:
  ```
  iex(5)> Riak.put(pid, "GeoCheckin", [{"The North", "Hanoi", 15000, "very hot", 37.0}]) # same order when you plan your table
  :ok
  ```
  Or
  ```
   iex(6)> Riak.put("GeoCheckin", [{"The South", "HCM City", 10000, "hot", 35.0}])
   :ok
  ```
  
Query data with SQL command:
  ```
  iex(8)> Riak.query(pid, "select * from GeoCheckin where time < 15001 and time > 14999 and region = 'The North' and state = 'Hanoi'")
  {:ok,
   {["region", "state", "time", "weather", "temperature"],
     [{"The North", "Hanoi", 15000, "very hot", 37.0}]}}
  ```
  Or
  ```
   iex(9)> Riak.query("select weather, temperature from GeoCheckin where time > 9999 and time < 10001 and region = 'The South' and state = 'HCM City'")
   {:ok,
   {["weather", "temperature"],
   [{"hot", 35.0}]}}
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
