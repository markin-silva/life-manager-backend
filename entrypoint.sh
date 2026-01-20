#!/bin/sh
set -e

echo "Starting entrypoint..."

# Garante que o ambiente esteja definido
export RAILS_ENV=${RAILS_ENV:-development}

if [ "$RAILS_ENV" = "production" ]; then
  echo "Running database migrations in production..."
  rails db:setup
  bin/rails db:migrate
else
  echo "Skipping migrations (RAILS_ENV=$RAILS_ENV)"
fi

exec "$@"