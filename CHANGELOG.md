# Changelog

## v3.30 (Latest)

### MiniHtml.bas — Rendering Overhaul

**DOCTYPE handling (refined):**
- `"doctype"` tag case removed from `Initialize` — DOCTYPE now handled entirely via `setDocType(value)` / `getDocType` and auto-prepended before `<html>` in `buildImpl`
- Old pattern `doc.Initialize("doctype"): doc.Append(page.build): Return doc.ToString` replaced by `page.build` (which auto-generates `<!DOCTYPE html>`)

**Self-closing tags:**
- `img`, `br`, `path` now use `mMeta` mode instead of `mSelf`
- `mSelf` mode now renders `/>` instead of `>`
- Tags ending with `/` are auto-detected as self-closing (e.g. `Initialize("hr/")`)

**Indentation changes:**
- Removed `SpecialTags` public field — indentation now purely controlled by `Indentation` flag
- If parent has `Indentation = False`, child forces indent to level 1
- `setFlat` now auto-syncs: `setFlat(True)` sets `LineFeed = False` and `Indentation = False`

**Tag mode changes:**
- `<div>` added to uniline defaults (was multiline)

**Fixes:**
- `attrIf`, `boolIf`, `textIf` now use proper `If` blocks instead of `IIf` (fixes Object return type issue)
- `comment2` sanitizes `--` in value to prevent broken HTML comments
- `cdn` no longer uses deprecated `.up(Me)` — uses `add2(Create(...))` returning the child
- `ConvertToMiniHtml` now uses `Name = ""` (empty) for text node detection

### MiniHtmlParser.bas — Parser Refinements

- **Text nodes renamed** from `"text"` to `""` (empty string) — critical change aligning with MiniHtml
- **DOCTYPE capture** — `HtmlNode.DocType` field added; `<!DOCTYPE>` closes parent and stores type
- **Script src handling** — scripts with `src` attribute skip raw text parsing
- **Boolean attr regex simplified** — single-group regex replaces two-group alternation
- **Whitespace text nodes** now store empty value (`""`) instead of `" "`
- Credit attribution added

### Index.bas — Simplified

- Removed old `doc.Initialize("doctype")` / `doc.Append(...)` / `doc.ToString` pattern — now uses `IndexPage.build` directly
- Nav item lookup changed from `ChildById("navbarCollapse").child(0)` to `ChildByClass("navbar-nav")`
- Removed large block of commented-out code

### View.bas / View.txt — Major Template Simplification

- **New `CreateOrReadFromCache`** — unified caching that stores segments as byte arrays
- Removed private `ExistInCache`/`ReadFromCache`/`WriteToCache` wrappers
- **ModalAdd/Edit/Delete** — completely rewritten using new Helper methods (`FormHxPost/Put/Delete`, `ModalHeader`, `ModalBody`, `ModalMessage`, `ModalFooter`, `RequiredLabel`, `RequiredTextInput`, `RequiredDropdown`, `HiddenInput`)
- **ContainerContent** — now uses `ButtonAdd`, `ButtonSearch`, `ContainerHxGet`, `Row`/`Col` helpers
- **Table** — simplified: removed price column, uses `ChildByName("tbody")`, uses `AnchorIcon` for action buttons
- Removed `ContainerModal`, `ContainerToast`, `GitHubLink`, `CategoriesLink`, `HelpLink` (now use `MH` equivalents directly)

### MainView.bas — Updated

- Uses `NavbarExpand` with new signature (brand icon + text)
- Replaced `cdn()` calls with direct `MH.Script.up(body1).attr("src", ...)` / `MH.Link.up(head1).attr(...)`
- Uses `page1.ChildByName("body")` for copyright footer placement
- Removed `SponsorLink` and `NavLinkItemImage`

### Helper.bas / MH.bas

- `ConvertToBytes` parameter renamed from `Root` to `tag`

---

## v3.20

### MiniHtml.bas — New Conditional Methods

- `attrs(keyvals)` — Set multiple attributes from map (replaces deprecated `attr2`)
- `bool(key)` — Generic boolean attribute (replaces deprecated `attr3`)
- `attrIf(condition, key, value)` — Conditional attribute
- `attrIfValue(key, value)` — Attribute if value not empty
- `attrsIfConditions(keyconditions, keyvals)` — Conditional attr map
- `attrsIfValues(keyvals)` — Set each attr only if value not empty
- `boolIf(condition, key)` — Conditional boolean attribute
- `textIf(condition, value)` / `textIfValue(value)` — Conditional text
- `addClassIf(condition, value)` / `clsIf(condition, value)` — Conditional class
- `clsIIf(condition, valTrue, valFalse)` — Ternary class conditional

**Fluent mode setters:**
- `uniline` — Set mode to uniline
- `multiline` — Set mode to multiline

**Improvements:**
- `path` tag added as self-closing (auto mode)
- `ChildByClass` now does substring match on class list instead of exact match
- Internal refactoring: `attrs` replaces `attr2`, `bool` replaces `attr3` throughout

### Helper.bas / MH.bas — Major Refactoring

- **Removed private helpers** `AddAttr`, `AddAttr2`, `AddAttr3`, `AddText` — all replaced by new fluent conditional methods
- **All components refactored** to single-line fluent chaining using `.Parent` for upward navigation
- **New:** `CreateMiniJs` — Create MiniJs instance for custom event scripts
- **New:** `ConvertFromBytes` / `ConvertToBytes` — Byte conversion helpers
- **New:** `HiddenInput(id, name, value)` — Hidden form input
- **New:** `RequiredLabel(text, forId)` — Label with required asterisk
- **New:** `RequiredTextInput(id, name, value)` — Required text input
- **New:** `RequiredDropdown(id, name)` — Required select dropdown
- **New:** `OptionSelected(text, value, selected)` — Option with conditional selected state
- **New:** `ModalHeader(text)` — Bootstrap modal header with title and close button
- **New:** `ModalBody` — Bootstrap modal body container
- **New:** `ModalMessage` — Message container for modal
- **New:** `ModalFooter(submit_text, cancel_text, submit_cls, cancel_cls)` — Modal footer with submit/cancel
- **New:** `CreateCustomEventScript(info)` — Generate MiniJs custom event dispatch script
- **Changed:** `NavbarExpand` signature — now takes `brand_icon_cls` and `brand_text` instead of `brand`
- **Changed:** `ProgressBar` parameter `now` renamed to `NowPercent`
- **Changed:** `Toast` now uses `CreateCustomEventScript` for event dispatch

### Bug Fixes

- `AddStyle` fixed in MiniHtml.bas
- Code Snippets fixed (Helper.txt, Model.txt, View.txt)

---

## v3.11

**New:**
- Bug fixed for AddStyle in MiniHtml.bas
- Bug Fixed in Code Snippets (Helper.txt, Model.txt, View.txt)

### v3.10

**New:**
- Added Main View class template
- Added `ChildByClass` sub — deep search by CSS class name
- Added `DeepSearchByClass` sub (private)
- Added `Image` sub (alias for `Img`)
- Restored `child` sub (alias for `ChildByIndex`)
- Added `NavbarExpand`, `NavbarToggler`, `NavbarCollapse`
- Added `NavLinkItemImage`, `IconAnchor`, `ImageAnchor`
- Added `FavoriteIcon`, `OptionDisabled`
- Added `ResponsiveHeader`, `CopyrightFooter`, `SponsorLink`, `GitHubLink`
- Added `ContainerHxGet`
- Added `FormHx`, `FormHxPost`, `FormHxPut`, `FormHxDelete`
- Added `AddAttr`, `AddAttr2`, `AddAttr3`, `AddText` (private)

**Code Snippets:**
- Added `Boilerplate.txt`

**Updates:**
- Updated Cache module — `ConvertToMiniHtml` renamed to `ConvertToBytes`
- Updated Helper module
- Updated Navbar methods
- Code refactoring across multiple modules

---

## v3.06

### New Modules

- **Cache.bas** — Page and component caching utilities (`ExistInCache`, `WriteToCache`, `ReadFromCache`, `ClearFromCache`, `ClearAllFromCache`, `ConvertFromBytes`, `ConvertToBytes`)
- **MC.bas** — Static cache module generated from `Cache.txt` snippet
- **MH.bas** — Static helper module generated from `Helper.txt` snippet
- **Helper.bas** — High-level UI component library with 60+ helpers

### Helper.bas — New Helpers

**Bootstrap Layout:**
`Container`, `ContainerFluid`, `Row`, `Col`

**Form Inputs:**
`InputText`, `InputEmail`, `InputPassword`, `InputNumber`, `InputDate`, `InputFile`, `TextareaInput`, `CheckboxInput`, `RadioInput`, `SelectInput`, `HiddenInput`, `RequiredLabel`, `RequiredTextInput`, `RequiredDropdown`

**Bootstrap UI Components:**
`Card`, `CardHeader`, `CardBody`, `CardFooter`, `CardTitle`, `CardText`, `Badge`, `ListGroup`, `ListGroupItem`, `ListGroupButton`, `ProgressBar`, `Spinner`, `SpinnerGrow`, `AlertDismissible`

**HTMX Helpers:**
`HxGet`, `HxPost`, `ContainerHxGet`, `FormHxPost`, `FormHxPut`, `FormHxDelete`, `FormHx`

**Navigation:**
`Navbar`, `NavbarExpand`, `NavbarToggler`, `NavbarCollapse`, `NavItem`, `NavLinkItem`, `NavLinkItemImage`

**Modal Components:**
`ModalHeader`, `ModalBody`, `ModalMessage`, `ModalFooter`, `ContainerModalWithButton`

**Utility:**
`CssLink`, `JsScript`, `ImgResponsive`, `PageHeading`, `ButtonIcon`, `AnchorButton`, `IconAnchor`, `ImageAnchor`, `FavoriteIcon`, `OptionDisabled`, `OptionSelected`, `ResponsiveHeader`, `CopyrightFooter`, `SponsorLink`, `GitHubLink`, `CreateMiniJs`, `CreateCustomEventScript`, `Image` (alias of `Img`)

### MiniHtml.bas — New Methods

**Conditional helpers (fluent):**
- `attrIf(condition, key, value)` — conditional attribute
- `attrIfValue(key, value)` — attribute if value not empty
- `attrsIfValues(keyvals)` — set each attr only if value not empty
- `attrsIfConditions(keyconditions, keyvals)` — conditional attr map
- `attr3If(condition, key)` / `boolIf(condition, key)` — conditional boolean attribute
- `textIf(condition, value)` / `textIfValue(value)` — conditional text
- `addClassIf(condition, value)` / `clsIf(condition, value)` — conditional class
- `clsIIf(condition, valTrue, valFalse)` — ternary class

**Fluent downward navigation:**
- `down(child)` — add child, return parent (fluent builder pattern)

**Traversal:**
- `ChildByClass(value)` — deep search by CSS class
- `child(index)` — alias of `ChildByIndex`

**Mode setters:**
- `uniline` — set mode to uniline
- `multiline` — set mode to multiline

**Boolean attributes:**
- `defer` — `defer` attribute for scripts
- `bool(key)` — generic boolean attribute
- `selectedIf(condition)` — conditional selected

### MiniHtmlParser.bas

- **HTMX/Alpine.js support** — Attribute regex updated to parse `@` (Alpine.js, e.g. `@click`) and `:` (Vue/HTMX, e.g. `:src`, `hx-target`) prefixed attribute names (#210, #219)

### Project Structure

- **B4X multi-platform layout** — Source reorganized into `Lib/` and `B4X/` directories supporting B4A (Android), B4i (iOS), B4J (Desktop), and server projects
- **Boilerplate.bas** — Reusable page template with responsive header and CDN links
- **MainView.bas** — Composable page layout with content, sub-content, modal, and toast slots

### Dependencies

- **JSON** — Added as a required dependency (`manifest.txt` updated)

---

## v3.03

- Initial release as MiniHTML3
- Core `MiniHtml` tag builder with fluent API
- `MiniHtmlParser` for parsing HTML strings
- Basic demo handler (`Index.bas`)
- `MH.bas` with 30+ tag factories
- Code snippet templates: Handler, View, Model, Helper
