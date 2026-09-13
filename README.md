# MiniHTML4

MiniHTML library for B4X — a fluent HTML builder for B4J/B4A/B4i.

## Overview

MiniHTML4 lets you construct HTML documents programmatically in B4X using an object-oriented, chaining API. Instead of concatenating strings, you build a tree of `MiniHtml` tag objects, then call `build` to render the final HTML string.

## Features

- **Fluent API** — Method chaining for concise, readable code
- **Automatic tag mode** — Meta (`<meta>`, `<link>`, `<img>`, `<br>`, `<input>`, `<path>`), uniline (`<span>text</span>`), multiline (`<html>`, `<head>`, `<body>`, `<form>`, `<table>`, `<svg>`), self-closing (`<tag/>`), or no-tag (raw text)
- **Class & style management** — `addClass`/`cls`, `removeClass`, `addStyle`/`sty`, `removeStyle` with auto-sync to `class`/`style` attributes, plus conditional `clsIf`/`addClassIf`/`clsIIf`/`addClassIIf`
- **Attribute helpers** — `attr`, `attrs` (map), `bool` (boolean), conditional `attrIf`/`attrIfValue`/`attrsIfValues`/`attrsIfConditions`/`boolIf`, plus convenience methods: `lang`, `rel`, `href`, `src`, `integrity`, `crossorigin`, `required`, `disabled`, `checked`, `selected`, `selectedIf`, `hidden`, `readonly`, `defer`
- **HTML parsing** — Parse existing HTML strings into MiniHtml objects (`parse`, `convertFromBytes`, `convertToMiniHtml`)
- **JSON round-trip** — `fromJson`/`fromMap` (shorthand format) and `toMap`/`toJson`
- **CDN helper** — `cdn(format, url)` for adding `<script>` and `<link>` tags (deprecated in favor of `MH.Script`/`MH.Link` with `src`/`href`)
- **Comments** — `comment(value, position)` with `--` sanitizing
- **Text** — `text(value, wrap)`, conditional `textIf`/`textIfValue`, `replace(value)`, `linebreak`, `script(value)`
- **Output options** — `build(indent)` (default `-1` = no indent); `setFlat` syncs `LineFeed`/`Indentation`; `setDocType`/`getDocType` auto-prepends `<!DOCTYPE>`; `wrapAttributes`/`FormatAttributes` aligns attributes across lines
- **Indentation control** — Customize indent string (default: `"  "`), control indent per-node
- **Child traversal** — `add`/`addChild`/`addTo`/`up`/`down`, `childByName`, `childById`, `childByIndex` (`child` alias), `childByClass` with deep search

## Project Structure

```
MiniHTML4/
├── source/
│   ├── MiniHtml.bas            # Core class — HTML tag builder
│   ├── MiniHtmlParser.bas      # HTML parser (credits: Erel)
│   ├── Helper.bas              # Higher-level UI helpers & components (for generating Helper.txt → MH.bas)
│   ├── MH.bas                  # Generated helper module (do not edit; edit Helper.bas instead)
│   ├── Cache.bas               # Page & component caching utilities (for generating Cache.txt → MC.bas)
│   ├── MC.bas                  # Generated cache module (do not edit; edit Cache.bas instead)
│   ├── Boilerplate.bas         # For generating Boilerplate.txt
│   ├── Model.bas               # For generating Model.txt
│   ├── View.bas                # For generating View.txt
│   ├── Handler.bas             # For generating Handler.txt
│   ├── Index.bas               # Index server handler
│   ├── MainView.bas            # Main View class template
│   ├── MiniHTML.b4j            # B4J project file
│   ├── manifest.txt            # Library manifest (Version 4.00)
│   ├── libs.json               # External library dependencies
│   ├── Snippets/               # Code template snippets (.txt)
│   │   ├── Boilerplate.txt        # Boilerplate page template
│   │   ├── Cache.txt              # Cache module template
│   │   ├── Helper.txt             # Helper module template
│   │   ├── Model.txt              # Database model template
│   │   ├── View.txt               # View page template with caching
│   │   └── Handler.txt            # CRUD handler template
│   └── Files/                  # Config & asset files
├── release/
│   └── MiniHTML.b4xlib        # Compiled library
├── Helper.md                  # Helper.bas API reference
├── Cache.md                   # Cache.bas API reference
├── CHANGELOG.md               # Version history
├── LICENSE                    # MIT License
└── README.md
```

## Installation

1. Copy `release/MiniHTML.b4xlib` to your B4X additional libraries folder
2. Add the library reference in your B4J/B4A/B4i project

## Quick Start

```b4x
' Build a simple HTML page
Dim html1 As MiniHtml = MH.Html
Dim head1 As MiniHtml = MH.Head.up(html1)
MH.Title.up(head1).text("Hello")
Dim body1 As MiniHtml = MH.Body.up(html1)
Dim div1 As MiniHtml = MH.Div.up(body1)
div1.cls("container")
div1.text("Hello World!")
File.WriteString(File.DirApp, "index.html", html1.build)
```

## API Reference

### MH.bas — Tag Factories

| Method | Tag |
|--------|-----|
| `Create(Name, multiline)` | Any tag (generic factory) |
| `Html` | `<html lang="en">` |
| `Head` | `<head>` |
| `Body` | `<body>` |
| `Title` | `<title>` |
| `Div` | `<div>` |
| `Span` | `<span>` |
| `P` | `<p>` |
| `Anchor` | `<a>` |
| `Button` | `<button>` |
| `Input` | `<input>` |
| `Label` | `<label>` |
| `Form` | `<form>` |
| `Table` | `<table>` |
| `Tr` | `<tr>` |
| `Td` | `<td>` |
| `Th` | `<th>` |
| `Thead` | `<thead>` |
| `Tbody` | `<tbody>` |
| `Ul` | `<ul>` |
| `Li` | `<li>` |
| `SelectTag` | `<select>` |
| `Option` | `<option>` |
| `Textarea` | `<textarea>` |
| `Img` | `<img>` |
| `Image` | Alias for `Img` |
| `Meta` | `<meta>` |
| `Link(rel, typeof)` | `<link>` |
| `Script` | `<script>` |
| `Style` | `<style>` |
| `Strong` | `<strong>` |
| `Br` | `<br>` |
| `Nav` | `<nav>` |
| `Icon` | `<i>` |
| `Svg` | `<svg>` |
| `Path` | `<path>` |
| `Footer` | `<footer>` |
| `Caption` | `<caption>` |
| `H1`, `H2`, `H3`, `H5`, `H6` | Heading tags (no `H4` in source) |

### MiniHtml — Key Methods

**Construction:**
- `Initialize(Name As String = ModeNoTag, Mode As String = "default", Flat As Boolean = False, Indents As Int = 0, IndentString As String = "  ")` — Create a MiniHtml object with optional parameters
- `build(indent As Int = -1)` — Render to string (`-1` = no indent)
- `setDocType(value)` / `getDocType` — DOCTYPE auto-prepended before `<html>` (default `"html"`)
- `wrapAttributes` — Align multi-line attributes (same as `FormatAttributes = True`)

**Adding children:**
- `add(ChildTag)` — Add child, returns parent
- `addChild(ChildTag)` — Add child, returns child
- `up(ParentTag)` / `addTo(ParentTag)` — Add self to parent, returns self
- `down(ChildTag)` — Add child, returns child (alias for `addChild`)
- `text(value, wrap)` — Add inner text
- `replace(value)` — Clear children and set inner content
- `textIf(condition, value)` / `textIfValue(value)` — Conditional text
- `script(value)` — Add `<script>value</script>` child
- `linebreak` — Add a non-indented line break
- `comment(value, position)` — Insert `<!-- value -->` above/below current tag (`--` sanitized; requires parent)

**Attributes:**
- `attr(key, value)` — Set attribute
- `attrs(keyvals)` — Set multiple attributes from map
- `bool(key)` — Set boolean attribute (no value)
- `attrIf(condition, key, value)` / `attrIfValue(key, value)` — Conditional attributes
- `attrsIfConditions(keyconditions, keyvals)` / `attrsIfValues(keyvals)` — Conditional attr maps
- `boolIf(condition, key)` — Conditional boolean attribute
- `lang(value)`, `rel(value)`, `href(value)`, `src(value)`, `integrity(hash)`, `crossorigin(credentials)` — Convenience attributes

**Classes & Styles:**
- `cls(value)` or `addClass(value)` — Add class(es)
- `removeClass(value)` — Remove class
- `sty(value)` or `addStyle(value)` — Add style(s) (semicolon-separated)
- `removeStyle(key)` — Remove style
- `clsIf(condition, value)` / `addClassIf(condition, value)` — Conditional class
- `clsIIf(condition, valTrue, valFalse)` / `addClassIIf(condition, valTrue, valFalse)` — Ternary class
- `multilineIf(condition)` — Set multiline mode if true
- `uniline` / `multiline` — Fluent mode setters
- `classesAsString` / `stylesAsString` — Serialize class list / style map

**Boolean attributes:**
- `required`, `disabled`, `checked`, `selected`, `hidden`, `readonly`, `defer`
- `selectedIf(condition)` — Conditional selected

**CDN helper (deprecated — prefer `MH.Script`/`MH.Link`):**
- `cdn(format, url)` — Add `<script src="...">` (`script`/`js`) or `<link href="...">` (`style`/`css`)

**Traversal:**
- `childByName(value)` — Deep search by tag name
- `childById(value)` — Deep search by `id` attribute
- `childByClass(value)` — Deep search by CSS class name
- `childByIndex(index)` — Get child by position
- `child(index)` — Alias for `childByIndex`

**Parsing & JSON:**
- `parse(HtmlText)` — Parse HTML string into MiniHtml
- `fromJson(JsonStr)` — Parse JSON string into MiniHtml tree (shorthand format)
- `fromMap(m As Map)` — Parse pre-parsed Map into MiniHtml (shorthand format)
- `toMap` — Serialize MiniHtml tree to a Map in shorthand format
- `toJson` — Serialize MiniHtml tree to a JSON string
- `convertFromBytes(Buffer())` — Parse from byte array
- `convertToBytes` — Serialize to byte array
- `convertToMiniHtml(HtmlNode)` — Convert parser node to MiniHtml

**Configuration (via getters/setters):**
- `setFlat` / `getFlat` — Suppress line breaks (auto-syncs `LineFeed`/`Indentation`)
- `setIndentation` / `getIndentation` — Enable/disable per-node indent
- `setLineFeed` / `getLineFeed` — Enable/disable CRLF
- `setIndentString` / `getIndentString` — Indentation string (default: `"  "`)
- `setIndents` / `getIndents` — Indent amount
- `setFormatAttributes` / `getFormatAttributes` — Align multi-line attributes
- `setMode` / `getMode` — `uniline`, `multiline`, `meta`, `self`, `""` (no-tag)
- `getName`, `getChildren`/`setChildren`, `getParent`/`setParent`, `getAttributes`/`setAttributes`

### Helper.bas — UI Components & Helpers

See full API reference in [Helper.md](Helper.md).

| Category | Key Methods |
|----------|-------------|
| **Tag Factories** | `Create`, `Anchor`, `Button`, `Div`, `Span`, `H1`–`H3`, `H5`–`H6` (no `H4`), `Table`, `Form`, `Input`, `SelectTag`, `Img`, `Image` (alias), `Svg`, `Link(rel, typeof)`, and 30+ more |
| **Navigation** | `Navbar`, `NavbarExpand(cls, expand, brand_icon_cls, brand_text)`, `NavbarToggler`, `NavbarCollapse`, `NavItem`, `NavLinkItem`, `NavLinkItemImage` |
| **Form Helpers** | `FormHx`, `FormHxPost`, `FormHxPut`, `FormHxDelete`, `ContainerHxGet`, `HxGet`, `HxPost` |
| **Bootstrap UI** | `Alert`, `Toast`, `ContainerModal`, `ContainerModalWithButton`, `ContainerToast`, `ModalHeader`, `ModalBody`, `ModalMessage`, `ModalFooter`, `ButtonClose`, `ButtonAdd`, `ButtonSubmit`, `ButtonCancel`, `AnchorIcon` |
| **Inputs** | `InputSearch`, `TextLabel`, `RequiredLabel`, `HiddenInput`, `RequiredTextInput`, `RequiredDropdown`, `FormGroup`, `InputGroup`, `SelectInput`, `OptionDisabled`, `OptionSelected`, `CheckboxInput`, `RadioInput` |
| **Icons & Images** | `AnchorIcon`, `AnchorImage`, `FavoriteIcon` |
| **Layout** | `Container`, `ContainerFluid`, `Row`, `Col`, `ResponsiveHeader`, `CopyrightFooter`, `SponsorLink`, `GitHubLink`, `Card`, `Badge`, `AlertDismissible` |
| **Utilities** | `CreateMiniJs`, `CreateCustomEventScript`, `ConvertFromBytes`, `ConvertToBytes`, `CssLink`, `JsScript`, `ButtonSearch`, `PageHeading`, `ButtonIcon`, `AnchorButton` |

### Cache.bas — Caching Utilities

See full API reference in [Cache.md](Cache.md).

| Method | Returns | Description |
|--------|---------|-------------|
| `ExistInCache(ctx, Key)` | `Boolean` | Check if key exists in cache map |
| `WriteToCache(ctx, Key, Value)` | `-` | Store value in cache map |
| `ReadFromCache(ctx, Key)` | `Object` | Read from cache; auto-detects MiniHtml vs byte arrays |
| `ClearFromCache(ctx, Key)` | `-` | Remove a single key from cache |
| `ClearAllFromCache(ctx, MatchKey)` | `-` | Remove all keys containing `MatchKey` |
| `ConvertFromBytes(Buffer())` | `MiniHtml` | Parse byte array into MiniHtml tree |
| `ConvertToBytes(tag)` | `Byte()` | Serialize MiniHtml tree to byte array |

### MiniHtmlParser — HTML Parser

The parser (credits to Erel) converts HTML strings into a tree of `HtmlNode` objects.

**Types:**
- `HtmlNode(Name, Children, Attributes, Closed, Parent)`
- `HtmlAttribute(Key, Value)`

**Key methods:**
- `Parse(HtmlText)` — Returns root HtmlNode
- `IsRoot(n)` — Test if node is the document root
- `setShowParserLogs(value)` — Enable/disable parser debug logs
- `FindNode(Root, TagName, Attribute)` — Recursive node search
- `FindDirectNodes(Root, TagName, Attribute)` — Direct children search
- `IsNodeMatches(Node, TagName, Attribute)` — Match test
- `GetTextFromNode(Node, ChildIndex)` — Extract text
- `GetAttributeValue(Node, Key, Default)` — Get attribute value
- `UnescapeEntities(XmlInput)` — Unescape HTML entities
- `PrintNode(node)` — Debug output
- `CreateHtmlAttribute(Key, Value)` — Create attribute

## JSON to MiniHtml

Build HTML from JSON using the shorthand format.

### Format

```json
{"tagname": {"property": "value", ...}}
```

The outer key is the tag name, and its value is a map of properties. A string value is treated as inner text.

### Properties

| Key | Type | Description |
|-----|------|-------------|
| `class` | string | CSS class(es) |
| `style` | string | CSS style(s) |
| `text` | string | Inner text |
| `id` | string | `id` attribute |
| `attrs` | map | Additional attributes |
| `children` | array | Nested elements (same format) |
| `mode` | string | `uniline`, `multiline`, `meta`, `self` |
| `flat` | bool | Suppress line breaks |
| `indentation` | bool | Enable indentation |
| `formatattributes` | bool | Align multi-line attributes |
| `defer` | bool | Boolean attribute |
| `required` | bool | Boolean attribute |
| `disabled` | bool | Boolean attribute |
| `checked` | bool | Boolean attribute |
| `selected` | bool | Boolean attribute |
| `hidden` | bool | Boolean attribute |
| `readonly` | bool | Boolean attribute |
| *(any other)* | * | Treated as attribute |

### Examples

```b4x
Dim m As MiniHtml
m.Initialize("")
Dim root As MiniHtml = m.FromJson($"
{
  "div": {
    "class": "container",
    "style": "margin: auto",
    "attrs": {"data-id": "123"},
    "children": [
      {"h1": {"text": "Title"}},
      {"p": {"class": "lead", "text": "Paragraph text"}},
      {"button": {
        "class": "btn btn-primary",
        "disabled": true,
        "text": "Submit"
      }}
    ]
  }
}
"$)
Return root.build
```

Array root for multiple fragments:
```json
[{"div": {"class": "alert", "text": "Message"}}, {"script": {"text": "console.log('ok')"}}]
```

String shorthand for text-only tags:
```json
{"span": "hello world"}
```

Pre-parsed Map:
```b4x
Dim map1 As Map = CreateMap("div": CreateMap("class": "foo", "text": "bar"))
Dim root As MiniHtml = m.FromMap(map1)
```

### Round-trip (ToMap / ToJson)

Serialize a MiniHtml tree back to Map or JSON:

```b4x
Dim m As MiniHtml
m.Initialize("")
Dim root As MiniHtml = m.FromJson(${"div": {"class": "container", "text": "Hello"}}$)

' To Map
Dim map1 As Map = root.ToMap

' To JSON string
Dim json As String = root.ToJson
```

Text-only shorthand is preserved:
```b4x
Dim el As MiniHtml
el.Initialize("span")
el.text("Hello")
Log(el.ToJson) ' {"span":"Hello"}
```

Mixed content (text + tags) uses a `children` array with strings for text:
```b4x
' Produces: {"children": ["Hello ", {"strong": {"text": "world"}}, "!"]}
```

Boolean attributes round-trip as `true`:
```b4x
Dim el As MiniHtml
el.Initialize("button")
el.required
el.text("Submit")
Log(el.ToJson) ' {"button": {"text": "Submit", "required": true}}
```

## Dependencies

- [B4XCollections](https://www.b4x.com/android/forum/threads/b4x-b4xcollections.101115/)
- [JSON](https://www.b4x.com/android/forum/threads/convert-collections-to-json-and-vice-versa.132678/)

## License

MIT License. See [LICENSE](LICENSE).

## Changelog

### v4.00 (Latest)

**Library version bump (`manifest.txt` → 4.00):**
- `Helper.bas` / `MH.bas` — `Create` now takes `(Name, multiline)`; `Link` now takes `(rel, typeof)`; `NavbarExpand` takes `(cls, expand, brand_icon_cls, brand_text)`; `ProgressBar` first param renamed to `NowPercent`
- `Helper.bas` / `MH.bas` — Canonical names are `AnchorIcon` / `AnchorImage` (docs previously listed swapped `IconAnchor` / `ImageAnchor`); new/documented `CreateMiniJs`, `CreateCustomEventScript`, `OptionSelected`, `ModalHeader`, `ModalBody`, `ModalMessage`, `ModalFooter`
- `Cache.bas` / `MC.bas` — `ConvertToBytes(tag)` takes the tag to serialize (docs previously showed no param / "empty tag")
- `MiniHtml.bas` — Single `build(indent)` renderer (docs previously listed removed `build2`/`buildImpl`); `text2`/`textWrap`/`comment2`/`attr2`/`attr3`/`cdn2`/`cdn3`/`SpecialTags` removed from docs (not in source — use `replace`, `comment(value, position)`, `attrs`, `bool`, `cdn`, `wrapAttributes`)
- `MiniHtmlParser.bas` — Documented `IsRoot` and `setShowParserLogs`
- Project structure section rewritten to match the actual flat `source/` layout

### v3.31

**Bug Fix:**
- Uniline tags no longer get extra line break before closing tag (regression in v3.30). Fixed `buildImpl` condition from `If mFlat = False` to `If mFlat = False And mMode = mMultiline`.

### v3.30

**Rendering Overhaul (MiniHtml.bas):**
- DOCTYPE: `"doctype"` case removed from `Initialize`; new `setDocType(value)`/`getDocType`; auto-prepended in `buildImpl`
- Self-closing: `img`, `br`, `path` use `mMeta`; `mSelf` renders `/>`; tags ending with `/` auto-detect
- Indentation: removed `SpecialTags`; `setFlat` auto-syncs `LineFeed` and `Indentation`
- `<div>` added to uniline defaults
- `attrIf`/`boolIf`/`textIf` now use `If` blocks (no more `IIf`)
- `comment2` sanitizes `--`; `cdn` uses `add2` instead of deprecated `.up(Me)`

**Parser (MiniHtmlParser.bas):**
- Text nodes renamed from `"text"` to `""`; DOCTYPE capture; script `src` skips raw parsing
- Boolean attr regex simplified

**Index.bas:**
- Removed old `doc.Initialize("doctype")` pattern; uses `IndexPage.build` directly
- Nav lookup changed to `ChildByClass("navbar-nav")`

**Template Simplification (View.bas):**
- New `CreateOrReadFromCache` unified caching
- Modals rewritten with `FormHxPost/Put/Delete`, `ModalHeader/Body/Message/Footer`, `RequiredLabel/TextInput/Dropdown`, `HiddenInput`
- `ContainerContent` uses `ButtonAdd`, `ButtonSearch`, `ContainerHxGet`, `Row`/`Col`
- Table simplified; removed `ContainerModal`/`ContainerToast`/`GitHubLink` (use MH directly)

**MainView.bas:**
- Uses `NavbarExpand` new signature; `cdn()` replaced with direct `Script/Link` attrs

### v3.20

**New MiniHtml.bas Methods:**
- `attrs(keyvals)` — Set multiple attributes from map (replaces deprecated `attr2`)
- `bool(key)` — Generic boolean attribute (replaces deprecated `attr3`)
- `attrIf(condition, key, value)` / `attrIfValue(key, value)` — Conditional attributes
- `attrsIfConditions(keyconditions, keyvals)` / `attrsIfValues(keyvals)` — Conditional attr maps
- `boolIf(condition, key)` — Conditional boolean attribute
- `textIf(condition, value)` / `textIfValue(value)` — Conditional text
- `addClassIf(condition, value)` / `clsIf(condition, value)` — Conditional class
- `clsIIf(condition, valTrue, valFalse)` — Ternary class conditional
- `uniline` / `multiline` — Fluent mode setters

**New Helper.bas / MH.bas:**
- `CreateMiniJs`, `ConvertFromBytes`, `ConvertToBytes`, `HiddenInput`, `RequiredLabel`, `RequiredTextInput`, `RequiredDropdown`, `OptionSelected`, `ModalHeader`, `ModalBody`, `ModalMessage`, `ModalFooter`, `CreateCustomEventScript`
- All components refactored to fluent chaining with `.Parent`
- `NavbarExpand` signature changed (now takes `brand_icon_cls` and `brand_text`)

### v3.11

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

## Links

- [B4X Forum](https://www.b4x.com/android/forum/threads/b4x-minihtml4.172058/)
- [GitHub](https://github.com/pyhoon/MiniHTML4)
