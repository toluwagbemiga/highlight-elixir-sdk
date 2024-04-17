config :logger, backends: [HighlightLogger]

config :logger, HighlightLogger,
  level: :info

config :logger, :error_logger_backend, Highlight.ErrorLogger
