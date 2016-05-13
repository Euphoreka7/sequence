# Sequence

Simple sequence OTP server

#### Usage
```
iex -S mix
Sequence.Server.start_link 123
Sequence.Server.next_number # 123
Sequence.Server.next_number # 124
Sequence.Server.increment_number 100 # :ok
Sequence.Server.next_number # 225
Sequence.Server.set_number(12) # 12
Sequence.Server.next_number # 12
Sequence.Server.next_number # 13
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
#### Naming a Process
```
{:ok,pid} = GenServer.start_link(Sequence.Server, 100, name: :seq)
GenServer.call(:seq, :next_number) # 100
GenServer.call(:seq, :next_number) # 101
:sys.get_status :seq
```
