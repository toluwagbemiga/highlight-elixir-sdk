defmodule Highlight.ErrorView do
  use Phoenix.View

  def render("500.json", %{exception: %{message: message, stack: stack}, _conn: conn}) do
    payload = %{
      level: "error",
      message: message,
      stack_trace: stack
    }
    Highlight.report_to_highlight(payload)
    %{error: %{message: "Internal server error"}}
  end
end
