# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

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