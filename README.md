# Sequence

Simple sequence OTP server

#### Usage
```
iex -S mix
{:ok, pid} = GenServer.start_link(Sequence.Server, 100)
GenServer.call(pid, :next_number)
GenServer.call(pid, {:set_number, 999})
GenServer.cast(pid, {:increment_number, 200})
```
#### Tracing a Server’s Execution
```
{:ok,pid} = GenServer.start_link(Sequence.Server, 100, [debug: [:trace]])
```
```
{:ok,pid} = GenServer.start_link(Sequence.Server, 100, [debug: [:statistics]]
:sys.statistics pid, :get
```
Enable/disable tracing on existing server:
```
:sys.trace pid, true
:sys.trace pid, false
```
Get status:
```
:sys.get_status pid
```