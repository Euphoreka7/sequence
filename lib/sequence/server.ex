defmodule Sequence.Server do
  use GenServer
  @vsn "1"

  defmodule State, do: defstruct current_number: 0, stash_pid: nil, delta: 1

  #####
  # External API

  def start_link(stash_pid) do
    GenServer.start_link(__MODULE__, stash_pid, name: __MODULE__)
  end

  def next_number do
    GenServer.call __MODULE__, :next_number
  end

  def increment_number(delta) do
    GenServer.cast __MODULE__, {:increment_number, delta}
  end

  def set_number(number) do
    GenServer.cast __MODULE__, {:set_number, number}
  end

  #####
  # Genserver implementation

  def init(stash_pid) do
    current_number = Sequence.Stash.get_value stash_pid
    { :ok, %State{current_number: current_number, stash_pid: stash_pid} }
  end

  def handle_call(:next_number, _from, state) do
    {
     :reply,
      state.current_number,
      %{ state | current_number: state.current_number + state.delta  }
    }
  end

  def handle_cast({:set_number, new_number}, state) do
    {
     :noreply,
     %{ state | current_number: new_number, delta: 1 }
    }
  end

  def handle_cast({:increment_number, delta}, state) do
    {
     :noreply,
     %{ state | current_number: state.current_number + delta, delta: delta }
    }
  end

  def terminate(_reason, state) do
    Sequence.Stash.save_value state.stash_pid, state.current_number
  end

  def format_status(_reason, [_pdict, state]) do
    [data: [{'State', "My current state is '#{inspect state}', and I'm happy"}]]
  end
end
