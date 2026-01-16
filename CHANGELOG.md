# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed
- Separate test database configuration from development via `DATABASE_URL_TEST`.
- `goo test` now uses `rails db:prepare` to create and migrate the test database.

## [1.6.0]

### Added
- Categories with system and custom support, plus category endpoints and policies.
- Transactions updated for categories, currency, amount_cents, and paid status.
- MoneyRails configuration for currency handling in transactions.
- Category seeds for system defaults and a `goo db seed` command.

## [1.5.0]

### Added
- Transactions module with model, policy, controller, routes, and test coverage.

## [1.4.0]

### Added
- Request specs covering Devise Token Auth sign up/sign in/sign out flows.

## [1.3.0]

### Added
- RSpec test suite with organized specs (models, requests, policies, services).
- FactoryBot setup and shared helpers for JSON parsing and authentication.

## [1.2.0]

### Added
- Global API response renderer with standardized success/error payloads.
- I18n-based error handling for 403/404/422/500 responses.

### Changed
- Health endpoint now uses the standardized success response format.

## [1.1.0]

### Added
- Pundit authorization handling in `Api::ApiController` with standardized 403 JSON errors.

### Changed
- Persist Bundler gems in Docker Compose via a named volume.

## [1.0.0]

### Added
- `goo` CLI script to streamline Docker + Rails commands from the project root.