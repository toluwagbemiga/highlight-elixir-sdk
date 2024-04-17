defmodule Highlight.ErrorLogger do
  def handle_event({:error, {_pid, message, stacktrace}}, _state) do
    payload = %{
      level: "error",
      message: message,
      stack_trace: inspect(stacktrace)
    }
    Highlight.report_to_highlight(payload)
    :ok
  end

  def handle_event(_, state), do: {:ok, state}
end
