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
#### Hot Swap
increase `@vsn` to +1, change function:
```
def code_change("0", old_state = { current_number, stash_pid }, _extra) do
  new_state = %State{current_number: current_number,
                     stash_pid: stash_pid,
                     delta: 1
                     }
  Logger.info "Changing code from 0 to 1"
  Logger.info inspect(old_state)
  Logger.info inspect(new_state)
  { :ok, new_state }
end

:sys.suspend Sequence.Server
c("updated_file.ex")
:sys.change_code Sequence.Server, Sequence.Server, "0", []
:sys.resume Sequence.Server
```
