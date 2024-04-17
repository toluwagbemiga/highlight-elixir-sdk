defmodule Highlight do
  @moduledoc """
  This module provides functions to interact with the Highlight SDK.
  """

  @project_id nil
  @otlp_endpoint "https://otel.highlight.io:4318"

  # Initialize the OpenTelemetry SDK
  def init do
    :ok = :opentelemetry_api.init()
    :ok = :opentelemetry.init()
  end

  # Check if the OpenTelemetry SDK is initialized
  def is_initialized, do: :opentelemetry.is_initialized()

  # Capture an exception and report it to Highlight
  def capture_exception(exception) do
    report_to_highlight("error", exception)
  end

  # Capture a log message and report it to Highlight
  def capture_log(severity, message) when is_atom(severity) and is_binary(message) do
    report_to_highlight(severity, message)
  end

  # Report the log message to Highlight via HTTP POST
  defp report_to_highlight(level, payload) do
    url = "https://otel.highlight.io:4318/v1/logs"
    headers = [
      {"Content-Type", "application/json"},
      {"Authorization", "Bearer YOUR_API_KEY"}
    ]
    body = %{
      level: level,
      message: payload
    }

    case HTTPoison.post(url, Poison.encode!(body), headers) do
      {:ok, _} -> IO.puts("Successfully reported #{level} to Highlight API")
      {:error, reason} -> IO.puts("Failed to report #{level} to Highlight API: #{inspect(reason)}")
    end
  end
end
