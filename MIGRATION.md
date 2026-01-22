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

#### 2. DeclarationView renamed to StatementView, parameters renamed

**Impact**: High
    
**Before (v1.3.0)**:
```Swift
DeclarationView(xmlFileName: String, selectedTheme: Theme, url: String, useWebView: Bool) 
```

**After (v2.0.0)**:
```Swift
StatementView(xmlFileName: String, theme: Theme, detailURL: String, useWebView: Bool) 
```

**Required Action**:
- Step 1: Rename all `DeclarationView` uses to `StatementView`
- Step 2: Rename all `selectedTheme` parameter uses to `theme`
- Step 3: Rename all `url` parameter uses to `detailURL`

**Reason for Change**: Parameters were not well named, types were not well named

### Compatibility

- **Backward Compatibility**: No
- **v1.3.0 Support**: Use dedicated Git branch **release/1.x**
- **End of Support**: Q2 2026

## Support

If you encounter issues:
- [Open an issue](https://github.com/Orange-OpenSource/accessibility-statement-lib-ios/issues)