# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :habanero, Habanero.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "9ianRWXphTvTxc6C+iWPoLK9ZRzJwNXaop2LxfCzc+QsHFue/iOOWKQx94vzCpuY",
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: Habanero.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Arc 
config :arc,
  access_key_id: "AKIAIGNRHLVTZVSTRF2A",
  secret_access_key: "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",
  bucket: "nnnnn",
  asset_host: "https://nnnnn.s3.amazonaws.com"

# Ex Aws

config :ex_aws,
  access_key_id: "AKIAIGNRHLVTZVSTRF2A",
  secret_access_key: "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",
  region: "us-east-1"
  #s3: [
  #  scheme: "https://nnnnn.",
  #  host: "s3.us-east-1.amazonaws.com",
  #  region: "us-east-1"
  #]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Configure phoenix generators
config :phoenix, :generators,
  migration: true,
  binary_id: false
