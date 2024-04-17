defmodule MyApp.Application do
  use Application

  def start(_type, _args) do
    # Initialize the OpenTelemetry SDK
    OpenTelemetry.start()

    # Add your other application startup logic here

    # Start the application
    Supervisor.start_link(
      [
        # Add your supervision tree here
      ],
      strategy: :one_for_one
    )
  end
end
