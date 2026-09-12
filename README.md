# MiniHTML4

MiniHTML library for B4X — a fluent HTML builder for B4J/B4A/B4i.

## Overview

MiniHTML4 lets you construct HTML documents programmatically in B4X using an object-oriented, chaining API. Instead of concatenating strings, you build a tree of `MiniHtml` tag objects, then call `build` to render the final HTML string.

## Features

- **Fluent API** — Method chaining for concise, readable code
- **Automatic tag mode** — Self-closing (`<br>`, `<img>`), uniline (`<span>text</span>`), multiline (`<div>\n  text\n</div>`), meta (`<!DOCTYPE>`, `<meta>`), or no-tag (raw text)
- **Class & style management** — `addClass`, `removeClass`, `addStyle`, `removeStyle` with auto-sync to `class`/`style` attributes
- **Attribute helpers** — `attr`, `attr2` (map), `attr3` (boolean), plus convenience methods: `lang`, `required`, `disabled`, `checked`, `selected`, `hidden`, `readonly`
- **HTML parsing** — Parse existing HTML strings into MiniHtml objects (`Parse`, `ConvertFromBytes`, `ConvertToMiniHtml`)
- **CDN helpers** — `cdn`, `cdn2`, `cdn3` for adding `<script>` and `<link>` tags with integrity/crossorigin support
- **Comments** — `comment` (indented), `comment2` (inline)
- **Text wrapping** — `text`, `text2` (overwrite), `textWrap` (indented)
- **Output options** — `build` (no indent), `build2` (custom indent), `buildImpl` (custom indent + attribute alignment)
- **Flat/minified output** — Set `Flat = True` to suppress line breaks
- **Indentation control** — Customize indent string (default: `"  "`), control indent per-node
- **Format attributes** — `FormatAttributes = True` aligns attributes across lines
- **Child traversal** — `ChildByName`, `ChildById`, `ChildByIndex`, `ChildByClass` with deep search

## Project Structure

```
MiniHTML4/
├── source/
│   ├── Lib/                  # Library source code
│   │   ├── MiniHtml.bas         # Core class — HTML tag builder
│   │   ├── MiniHtmlParser.bas   # HTML parser (credits: Erel)
│   │   ├── MC.bas               # Static cache module - generated from Code Snippet (Cache.txt)
│   │   ├── MH.bas               # Static helper module - generated from Code Snippet (Helper.txt)
│   │   ├── Cache.bas            # Page & component caching utilities - for generating Cache.txt
│   │   ├── Helper.bas           # Higher-level UI helpers & components - for generating Helper.txt
│   │   ├── Model.bas            # Pakai Server Model - for generating Model.txt
│   │   ├── View.bas             # Pakai Server View - for generating View.txt
│   │   ├── Handler.bas          # Pakai Server Handler - for generating Handler.txt
│   │   ├── Index.bas            # Demo handler (B4J servlet)
│   │   ├── MiniHTML.b4j         # B4J project file
│   │   ├── manifest.txt         # Library manifest
│   │   ├── libs.json            # External library dependencies (EndsMeet)
│   │   ├── Snippets/            # Code template snippets (.txt)
│   │   │   ├── Handler.txt         # CRUD handler template
│   │   │   ├── View.txt            # View page template with caching
│   │   │   ├── Model.txt           # Database model template
│   │   │   ├── Helper.txt          # Helper module template (MH.bas)
│   │   │   ├── Boilerplate.txt     # Boilerplate page template
│   │   │   ├── Cache.txt           # Cache module template (MC.bas)
│   │   │   └── CurrentDateTime.txt # Date/time utility snippet
│   │   └── Files/               # Config & asset files
│   └── B4X/                  # B4X multi-platform app projects
│       ├── B4A/                 # Android app project
│       ├── B4i/                 # iOS app project
│       ├── B4J/                 # Desktop app project
│       ├── server/              # Server-side B4J project
│       ├── B4XMainPage.bas      # Shared main page
│       └── Shared Files/        # Cross-platform shared assets
├── release/
│   └── MiniHTML.b4xlib     # Compiled library
├── Helper.md               # Helper.bas API reference
├── Cache.md                # Cache.bas API reference
├── LICENSE                 # MIT License
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
Dim title1 As MiniHtml = MH.Title.up(head1)
title1.text("Hello")
Dim body1 As MiniHtml = MH.Body.up(html1)
Dim div1 As MiniHtml = MH.Div.up(body1)
div1.cls("container").text("Hello World!")
File.WriteString(File.DirApp, "index.html", html1.build)
```

## API Reference

### MH.bas — Tag Factories

| Method | Tag |
|--------|-----|
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
| `Link` | `<link>` |
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
| `H1`, `H2`, `H3`, `H5`, `H6` | Heading tags |

### MiniHtml — Key Methods

**Construction:**
- `Initialize(Name)` — Create a tag with auto-detected mode
- `build` — Render to string (no indent, no CRLF on first line)
- `build2(indent)` — Render with custom indent
- `buildImpl(indent, AlignAttributes)` — Full control

**Adding children:**
- `add(ChildTag)` — Add child, returns child
- `up(ParentTag)` — Add to parent, returns self (alias for `addTo`)
- `addTo(ParentTag)` — Add to parent, returns self
- `text(value)` — Add inner text
- `text2(value)` — Clear children and set inner text
- `textWrap(value)` — Add indented inner text
- `script(value)` — Add `<script>value</script>` child
- `linebreak` — Add a non-indented line break
- `comment(value)` — Add `<!-- value -->` with indent
- `comment2(value, newline)` — Add inline comment

**Attributes:**
- `attr(key, value)` — Set attribute
- `attr2(map)` — Set multiple attributes from map
- `attr3(key)` — Set boolean attribute (no value)

**Classes & Styles:**
- `cls(value)` or `addClass(value)` — Add class(es)
- `removeClass(value)` — Remove class
- `sty(value)` or `addStyle(value)` — Add style(s) (semicolon-separated)
- `removeStyle(key)` — Remove style

**Boolean attributes:**
- `required`, `disabled`, `checked`, `selected`, `hidden`, `readonly`

**CDN helpers:**
- `cdn(format, url)` — Add `<script src="...">` or `<link href="...">`
- `cdn2(format, url, integrity, crossorigin)` — With SRI
- `cdn3(format, url, keyvals)` — With extra attributes

**Traversal:**
- `ChildByName(value)` — Deep search by tag name
- `ChildById(value)` — Deep search by `id` attribute
- `ChildByClass(value)` — Deep search by CSS class name
- `ChildByIndex(index)` — Get child by position
- `child(index)` — Alias for `ChildByIndex` (deprecated)

**Parsing & JSON:**
- `Parse(HtmlText)` — Parse HTML string into MiniHtml
- `FromJson(JsonStr)` — Parse JSON string into MiniHtml tree (shorthand format)
- `FromMap(m As Map)` — Parse pre-parsed Map into MiniHtml (shorthand format)
- `ToMap` — Serialize MiniHtml tree to a Map in shorthand format
- `ToJson` — Serialize MiniHtml tree to a JSON string
- `ConvertFromBytes(Buffer())` — Parse from byte array
- `ConvertToBytes` — Serialize to byte array
- `ConvertToMiniHtml(HtmlNode)` — Convert parser node to MiniHtml

**Configuration:**
- `Flat` — Suppress line breaks (minified output)
- `Indentation` — Enable/disable per-node indent
- `LineFeed` — Enable/disable CRLF
- `IndentString` — Indentation string (default: `"  "`)
- `FormatAttributes` — Align multi-line attributes
- `Mode` — `uniline`, `multiline`, `meta`, `self`, `notext`
- `SpecialTags` — Tags excluded from default indentation

### Helper.bas — UI Components & Helpers

See full API reference in [Helper.md](Helper.md).

| Category | Key Methods |
|----------|-------------|
| **Tag Factories** | `Anchor`, `Button`, `Div`, `Span`, `H1`–`H6`, `Table`, `Form`, `Input`, `SelectTag`, `Img`, `Image`, `Svg`, and 30+ more |
| **Navigation** | `Navbar`, `NavbarExpand`, `NavbarToggler`, `NavbarCollapse`, `NavItem`, `NavLinkItem`, `NavLinkItemImage`, `CategoriesLink`, `GitHubLink` |
| **Form Helpers** | `FormHx`, `FormHxPost`, `FormHxPut`, `FormHxDelete`, `ContainerHxGet` |
| **Bootstrap UI** | `Alert`, `Toast`, `ContainerModal`, `ContainerToast`, `ButtonClose`, `ButtonAdd`, `ButtonSubmit`, `ButtonCancel`, `AnchorIcon` |
| **Inputs** | `InputSearch`, `TextLabel`, `RequiredLabel`, `HiddenInput`, `RequiredTextInput`, `FormGroup`, `InputGroup` |
| **Icons & Images** | `IconAnchor`, `ImageAnchor`, `FavoriteIcon` |
| **Layout** | `ResponsiveHeader`, `CopyrightFooter`, `SponsorLink` |
| **Utilities** | `OptionDisabled`, `ButtonSearch` |

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
| `ConvertToBytes` | `Byte()` | Serialize MiniHtml tree to byte array (renamed from `ConvertToMiniHtml`) |

### MiniHtmlParser — HTML Parser

The parser (credits to Erel) converts HTML strings into a tree of `HtmlNode` objects.

**Types:**
- `HtmlNode(Name, Children, Attributes, Closed, Parent)`
- `HtmlAttribute(Key, Value)`

**Key methods:**
- `Parse(HtmlText)` — Returns root HtmlNode
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

- [B4X Forum](https://www.b4x.com/android/forum/threads/b4x-minihtml3.171326/)
- [GitHub](https://github.com/pyhoon/MiniHTML3)
