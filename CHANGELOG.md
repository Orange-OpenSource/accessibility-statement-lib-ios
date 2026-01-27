
# Accessibility Statement Lib iOS

All notable changes to this project will be documented in this file.
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.1.2](https://github.com/Orange-OpenSource/accessibility-statement-lib-ios/compare/2.0.0...2.1.2) - 2026-01-27

### Changed

- Use OUDS v1.1.0 instead of v1.1.0-rc.1 to avoid compilation troubles with SPM if OUDS v1.1.0 is also embeded

## [2.1.1](https://github.com/Orange-OpenSource/accessibility-statement-lib-ios/compare/2.0.0...2.1.1) - 2026-01-27

### Fixed

- Compilation issues because of Xcode Preview not able to get DEBUG init (Orange-OpenSource/accessibility-statement-lib-ios#62)

## [2.1.0](https://github.com/Orange-OpenSource/accessibility-statement-lib-ios/compare/2.0.0...2.1.0) - 2026-01-27

### Added

- Support of locales ca, es, nl, pl, ro, ru, sk (Orange-OpenSource/accessibility-statement-lib-ios#46)
- Integration of OUDS library (version 1.1.0-rc.1) (Orange-OpenSource/accessibility-statement-lib-ios#38)

### Changed

- GitHub Actions workflow dedicated to snapshots
- Add XCTestPlan for unit tests
- Update README with Swift Package Index badge (Orange-OpenSource/accessibility-statement-lib-ios#47)
- Generation of documentation and upload for GitHub Pages (Orange-OpenSource/accessibility-statement-lib-ios#50)

### Fixed

- When using VoiceOver, the audit date month was abbreviated and not vocalized correctly (Orange-OpenSource/accessibility-statement-lib-ios#54)
- Hard-coded "Details" word instead of localized resource in webview title (Orange-OpenSource/accessibility-statement-lib-ios#53)

## [2.0.0](https://github.com/Orange-OpenSource/accessibility-statement-lib-ios/compare/1.3.0...2.0.0) - 2026-01-22

### Added

- AGENTS.md file
- New API to init the `StatementView` without side effects

### Changed

- Use templates for issues and pull requests (Orange-OpenSource/accessibility-statement-lib-ios#35)
- Use of .gitignore (Orange-OpenSource/accessibility-statement-lib-ios#41)
- Update test suite (Orange-OpenSource/accessibility-statement-lib-ios#40)
- **BREAKING**: Rename of types, parameters and API (Orange-OpenSource/accessibility-statement-lib-ios#39)
- Swift DocC documentation of library (Orange-OpenSource/accessibility-statement-lib-ios#29)
- SBOM generation (Orange-OpenSource/accessibility-statement-lib-ios#37)
- Use of git-cliff for release notes (Orange-OpenSource/accessibility-statement-lib-ios#36)
- Git hooks for commit messages (Orange-OpenSource/accessibility-statement-lib-ios#33)
- GitHub Actions workflow to check of secrets leaks (Orange-OpenSource/accessibility-statement-lib-ios#30)
- GitHub Actions workflow to check of dead code (Orange-OpenSource/accessibility-statement-lib-ios#28)
- GitHub Actions workflow to lint of sources (Orange-OpenSource/accessibility-statement-lib-ios#27)
- Common files for repository hygiene (Orange-OpenSource/accessibility-statement-lib-ios#31)
- Git hooks to format sources (Orange-OpenSource/accessibility-statement-lib-ios#25)
- GitHub Actions workflow to check localizables (Orange-OpenSource/accessibility-statement-lib-ios#24)
