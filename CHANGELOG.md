# Accessibility Statement Lib iOS

All notable changes to this project will be documented in this file.
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.4.1](https://github.com/Orange-OpenSource/accessibility-statement-lib-ios/compare/1.3.0...1.4.2) - 2026-01-26

### Fixed

- Remove dead code deleated to OUDS breaking compilations

## [1.4.1](https://github.com/Orange-OpenSource/accessibility-statement-lib-ios/compare/1.3.0...1.4.1) - 2026-01-26

### Fixed

- Compilation issues because of Xcode Preview not able to get DEBUG init (Orange-OpenSource/accessibility-statement-lib-ios#62)

## [1.4.0](https://github.com/Orange-OpenSource/accessibility-statement-lib-ios/compare/1.3.0...1.4.0) - 2026-01-26

### Added

- Support of locales ca, es, nl, pl, ro, ru, sk (Orange-OpenSource/accessibility-statement-lib-ios#46)

### Fixed

- When using VoiceOver, the audit date month was abbreviated and not vocalized correctly (Orange-OpenSource/accessibility-statement-lib-ios#54)
- Hard-coded "Details" word instead of localized resource in webview title (Orange-OpenSource/accessibility-statement-lib-ios#53)
