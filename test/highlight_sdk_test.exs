defmodule HighlightTest do
  use ExUnit.Case

  test "capture_exception/1 reports exception to Highlight" do
    # Simulate an exception
    exception = %RuntimeError{message: "Test error"}
    Highlight.capture_exception(exception)

    # Assert that the exception was reported successfully
    assert_receive {:ok, _} = HTTPoison.post("https://otel.highlight.io:4318/v1/logs", fn _ -> true end)
  end

  test "capture_log/2 reports log to Highlight" do
    # Capture a log message
    Highlight.capture_log(:debug, "Test log message")

    # Assert that the log was reported successfully
    assert_receive {:ok, _} = HTTPoison.post("https://otel.highlight.io:4318/v1/logs", fn _ -> true end)
  end
end
