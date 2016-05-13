# Sequence

Simple sequence OTP server

## Usage
```
iex -S mix
{:ok, pid} = GenServer.start_link(Sequence.Server, 100)
GenServer.call(pid, :next_number)
GenServer.call(pid, {:set_number, 999})
GenServer.cast(pid, {:increment_number, 200})
```
