## [Unreleased]

## [0.1.1] - 2025-01-30

### Added

- `Retell::SDK::Unofficial::API::Agent#list_versions(agent_or_id)` — fetches all versions of an agent via `GET /get-agent-versions/:agent_id`. Returns raw array of version hashes (version, is_published, version_description, last_modification_timestamp). Used by labcoat_hero for the engagement agent version selector.

## [0.1.0] - 2024-09-08

- Initial release
