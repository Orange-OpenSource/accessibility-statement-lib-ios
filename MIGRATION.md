# Migration Guide

- [v1.3.0 → v2.0.0](#v100--v110)
- [Support](#support)

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
- **End of Support**: 2nd half of 2026

## Support

If you encounter issues:
- [Open an issue](https://github.com/Orange-OpenSource/accessibility-statement-lib-ios/issues)
