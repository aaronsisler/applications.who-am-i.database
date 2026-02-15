# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## Legend

- `Added` for new features.
- `Changed` for changes in existing functionality.
- `Deprecated` for soon-to-be removed features.
- `Removed` for now removed features.
- `Fixed` for any bug fixes.
- `Security` in case of vulnerabilities.

## Changelog Refactoring

### Changed

- Removing the versions from the Changelog so we can just worry about features instead of automatically handled versioning

## App User identifiers refactor

### Changed

- Moving from id -> internalId
- Moving from userId -> externalId

## Base Repo

### Added

- Base scripts for database initialization and schema creation.
- Creation of GitHub Actions workflows for CI/CD.
- Initial project documentation and README file.
