# Migration Guide

- [v2.0.0 → v2.1.0](#v200--v210)
- [v1.3.0 → v2.0.0](#v130--v200)
- [Support](#support)

## v2.0.0 → v2.1.0

### Overview

Deprecation of local `Theme` API for benefit of [OUDS library](https://github.com/Orange-OpenSource/ouds-ios).

> [!NOTE]
> This older API is not yet removed, if you come from v1.3.0 you should migrate to v2.1.0

### Before You Begin

#### Prerequisites

- Use version 2.0.0
- Integrated OUDS library (e.g. dependency, module, `OUDSThemeableView`), version 1.0.0

### Changes

#### 1. `StatementView` has new init and deprecated older ones

**Impact**: Low

**Required Action**:
- Use new init with `OUDSTheme` parameter instead of local `Theme` parameter

**Before (v2.0.0)**:

```swift
StatementView(xmlFileName: fileName, theme: someTheme, localUrl: detailsPageURL)
```

**After (v2.1.0)**:
```swift
@Environment(\.theme) var theme
StatementView(xmlFile: fileName, localUrl: detailsPageURLdetailsPageURL, theme: theme) 
```

## v1.3.0 → v2.0.0

### Overview

Several types have been renamed to bring more consistency.
Some parameters have been renamed to be clearer.
Some types are not public anymore, they where not supposed to be public.

### Before You Begin

#### Prerequisites

- Use version 1.3.0

### Breaking Changes

#### 1. InformationView, GroupView not public anymore

**Impact**: High

**Required Action**:
- Do not use `InformationView`, `GroupView` anymore

#### 2. DeclarationView renamed to StatementView, parameters renamed, initializer deprecated for newer ones

**Impact**: High
    
**Before (v1.3.0)**:
```swift
DeclarationView(xmlFileName: String, selectedTheme: Theme, url: String, useWebView: Bool) 
```

**After (v2.0.0)**:

If the URL of detailed statement points to a local file embeded in the app:
```swift
StatementView(xmlFileName: String, theme: Theme, localUrl: String) 
```

But if the URL of detailed statement points to a file outside the app, e.g. a web page:
```swift
StatementView(xmlFileName: String, theme: Theme, remoteUrl: String, useWebView: Bool) 
```

**Required Action**:
- Step 1: Rename all `DeclarationView` uses to `StatementView`
- Step 2: Rename all `selectedTheme` parameter uses to `theme`
- Step 3: Rename all `url` parameter uses to `detailURL` if you use deprecated init, or `localUrl` or `remoteUrl` if you use new initializers
- Step 4: Rename all `xmlFileName` parameter uses to `xmlFile` if you use new initializers

**Reason for Change**: Parameters were not well named, types were not well named, previous initializer had side effects (e.g. no web view for local file resulted in no page)

### Compatibility

- **Backward Compatibility**: No
- **v1.3.0 Support**: Use dedicated Git branch **release/1.x**
- **End of Support**: End of 2026

## Support

If you encounter issues:
- [Open an issue](https://github.com/Orange-OpenSource/accessibility-statement-lib-ios/issues)
