# Migration Guide — MiniHTML v3 → v4

Scope: **MiniHTML3 (v3.03–v3.31) → MiniHTML4 (v4.00)**.
Read with [README.md](README.md) (current API) and [CHANGELOG.md](CHANGELOG.md) (per-version history).

## 0. Preparation

1. **Back up everything** — your project sources *and* a copy of the rendered HTML output (see Phase 6: golden-file diff).
2. **Swap the library** — remove the v3 `.b4xlib`, copy `release/MiniHTML.b4xlib` (v4.00) into your B4X additional libraries folder, and re-select the library reference in each project (B4J/B4A/B4i).
3. **Check dependencies** — v4 requires:
   - `B4XCollections` (all platforms)
   - `JSON` / `iJSON` / `Json` (for `fromJson`/`toJson`)
   - `MiniJs` (only if you use `MH.Toast` / `CreateCustomEventScript` — Toast now dispatches an `entity:changed` event through MiniJs)
   - `EndsMeet` (only for the bundled server templates: `Index.bas`, `View.bas`, `MainView.bas`)
4. Expect to touch **every file that builds HTML** — the renames in Phase 1 are mechanical, the behavior changes in Phases 2–4 need review.

## 1. Mechanical renames (code will not compile until fixed)

Global search-replace, then compile. All are exact `MiniHtml` member names:

| v3 (removed) | v4 (replacement) | Notes |
|---|---|---|
| `attr2(map)` | `attrs(map)` | Multi-attribute map |
| `attr3(key)` | `bool(key)` | Boolean attribute |
| `text2(value)` | `replace(value)` | Clear children, set content |
| `textWrap(value)` | `text(value)` | `text` already indents by default (`wrap=True`) |
| `build2(indent)` | `build(indent)` | Single renderer, `build(indent As Int = -1)` |
| `buildImpl(indent, align)` | `wrapAttributes.build(indent)` or set `FormatAttributes=True` | Attribute alignment is now a flag, not a parameter |
| `comment2(...)` | `comment(value, position)` | Inline-comment helper is gone; `comment` inserts a sibling via the parent and sanitizes `--` |
| `ConvertToMiniHtml` (Cache) | `ConvertToBytes(tag)` | Cache module; takes the tag to serialize |
| `AddAttr`, `AddAttr2`, `AddAttr3`, `AddText` (Helper, private) | inline `attr`/`attrs`/`bool`/`text` chains | Were private helpers; inlined during refactor |

```b4x
' v3
el.attr2(CreateMap("id": "x", "name": "y"))
el.attr3("disabled")
el.text2("Hello")
Dim s As String = el.build2(1)
Dim s2 As String = el.buildImpl(1, True)

' v4
el.attrs(CreateMap("id": "x", "name": "y"))
el.bool("disabled")
el.replace("Hello")
Dim s As String = el.build(1)
Dim s2 As String = el.wrapAttributes.build(1)
```

## 2. Signature changes (compiles, but check each call)

### 2.1 `NavbarExpand` — breaks at runtime if not updated

```b4x
' v3
MH.NavbarExpand(cls, expand, brand)

' v4 — brand split into icon class + text
MH.NavbarExpand(cls, expand, brand_icon_cls, brand_text)
' e.g.
MH.NavbarExpand("navbar-light sticky-top bg-info py-1", "lg", "bi bi-infinity h3", "$APP_TRADEMARK$")
```

### 2.2 `MH.Link` now defaults `rel="stylesheet"`

```b4x
' v4 signature
MH.Link(rel As String = "stylesheet", typeof As String = "")
```

Old `MH.Link` calls still compile, but now emit `<link rel="stylesheet" ...>`. For non-stylesheet links pass explicit args:

```b4x
' favicon (as in Boilerplate.bas)
MH.Link("icon", "image/png").up(head1).href("/assets/img/favicon.png")
```

### 2.3 `ConvertToBytes` requires the tag

```b4x
' v3 (Cache / MiniHtml)
Cache.ConvertToBytes        ' no-arg form is gone

' v4 — Cache module
Cache.WriteToCache(ctx, "myKey", Cache.ConvertToBytes(el))
' ...or the MiniHtml instance method (no arg)
Cache.WriteToCache(ctx, "myKey", el.ConvertToBytes)
```

### 2.4 Safe renames (no call changes needed, names only)

- `ProgressBar(now, ...)` → `ProgressBar(NowPercent, ...)` — positional calls unaffected.
- Canonical helper names are `MH.AnchorIcon(cls, href, icon_class, icon_title)` and `MH.AnchorImage(href, img_src, img_class, img_title)`. If your v3 code uses `IconAnchor`/`ImageAnchor`, rename.
- `comment(value)` still compiles — new optional `position` (`"above"` default / `"below"`).
- `MH.Create(Name)` still compiles — new optional `multiline` flag forces multiline mode on uniline-capable tags.

### 2.5 No `H4` factory

`MH` provides `H1, H2, H3, H5, H6` — there is **no `H4`**. Use `MH.Create("h4")` or `MH.PageHeading(text, "h4")`.

## 3. Rendering changes (output HTML will differ — review diffs)

- **DOCTYPE is automatic.** Delete the old wrapper:
  ```b4x
  ' v3
  Dim doc As MiniHtml
  doc.Initialize("doctype")
  doc.Append(page.build)   ' pseudo-pattern
  Return doc.ToString

  ' v4 — build() prepends <!DOCTYPE html> itself
  Return page.build
  ```
  Customize with `page.setDocType("html")` / `getDocType`. The `"doctype"` name case in `Initialize` is gone.
- **`<div>` is now uniline by default** (was multiline). Expect fewer line breaks inside divs. Force the old shape per-node with `.multiline` if a golden file requires it.
- **Self-closing tags:** `img`, `br`, `path` (plus `meta`, `link`, `input`) render in `meta` mode; `mSelf` mode now renders `/>`. A tag name ending in `/` (e.g. `Initialize("hr/")`) is auto-detected as self-closing.
- **`setFlat(True)` now also disables `LineFeed` and `Indentation`.** If you set the flags individually, keep setting them — `setFlat` just syncs all three.
- **`SpecialTags` is removed.** Delete any references; indentation is controlled purely by the per-node `Indentation` flag. If a parent has `Indentation = False`, its children force indent level 1.
- **Deprecated pattern `head.cdn(...)`:** `cdn(format, url)` still exists but prefer explicit tags (required for SRI hashes anyway):
  ```b4x
  ' v4 pattern (as in MainView.bas)
  MH.Script.up(body1).attr("src", "https://cdn.jsdelivr.net/npm/htmx.org@2.0.8/dist/htmx.min.js") _
      .integrity("sha384-...").crossorigin("anonymous").wrapAttributes
  MH.Link.up(head1).href("https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css") _
      .integrity("sha384-...").crossorigin("anonymous").wrapAttributes
  ```

## 4. Parser consumers (`MiniHtmlParser` / `parse`)

- **Text nodes renamed:** `HtmlNode.Name = "text"` → `Name = ""` (empty string). Update every comparison, including `convertToMiniHtml` overrides:
  ```b4x
  ' v3
  If node.Name = "text" Then ...
  ' v4
  If node.Name = "" Then ...
  ```
- **DOCTYPE captured:** `HtmlNode` has a new `DocType` field; `<!DOCTYPE>` closes the parent and stores the type instead of becoming a node.
- **Scripts with `src`** skip raw-text parsing; whitespace-only text nodes now store `""`.
- New helpers: `IsRoot(n)`, `setShowParserLogs(value)`.

## 5. Server templates (`Index` / `View` / `MainView`)

If you copied these from v3 snippets, re-copy from v4 (`source/Snippets/`) or apply:

- **Index:** return `IndexPage.build` directly (no doctype wrapper); nav lookup is `page.ChildByClass("navbar-nav")`, not `ChildById("navbarCollapse").child(0)`.
- **View:** new unified `CreateOrReadFromCache` (stores segments via `ConvertToBytes`, no per-view cache wrappers); modals rebuilt with `FormHxPost/Put/Delete` + `ModalHeader/Body/Message/Footer` + `RequiredLabel/TextInput/Dropdown` + `HiddenInput`; content uses `ButtonAdd`, `ButtonSearch`, `ContainerHxGet`, `Row`/`Col`; tables use `ChildByName("tbody")` + `AnchorIcon` actions. `ContainerModal`/`ContainerToast`/`GitHubLink`/`CategoriesLink`/`HelpLink` are used via `MH` directly.
- **MainView:** `NavbarExpand` 4-arg call; `cdn()` replaced by direct `Script`/`Link` attrs (see 3); footer via `page.ChildByName("body")`; `SponsorLink`/`NavLinkItemImage` removed from default layout.
- **Cache keys:** v4 cache stores **bytes** (`ConvertToBytes`), readable by v4 `ReadFromCache` either way — but v3-cached entries are safest discarded: clear the cache map on deploy (`ClearAllFromCache`).

## 6. Optional — adopt the new APIs

Not required to migrate, but worth using as you touch code:

- Conditionals: `attrIf`, `attrIfValue`, `attrsIfValues`, `attrsIfConditions`, `boolIf`, `textIf`/`textIfValue`, `clsIf`/`addClassIf`, `clsIIf`/`addClassIIf`, `multilineIf`, `selectedIf`
- Navigation: `add` returns the **parent**; `addChild`/`down` return the **child**; `up`/`addTo` return self — pick the direction that keeps your chains flat
- Introspection: `classesAsString`, `stylesAsString`, `getAttributes`/`setAttributes`, `getChildren`/`setChildren`, `getParent`/`setParent`
- JSON round-trip: `fromJson`/`fromMap` ↔ `toMap`/`toJson` shorthand format (`{"tag": {"class": ..., "text": ..., "attrs": {...}, "children": [...]}}`, plus `defer`); text-only shorthand `{"span": "hello"}`
- `ChildByClass` is now a substring match on the class list (more hits than v3's exact match — verify selectors)

## 7. Verification checklist

- [ ] Project compiles against `MiniHTML.b4xlib` v4.00 with no `attr2`/`attr3`/`text2`/`textWrap`/`build2`/`buildImpl`/`comment2` references left (`SpecialTags`, `.Id =`, bare `ConvertToBytes` included)
- [ ] `NavbarExpand`, `MH.Link` (non-stylesheet uses), `ConvertToBytes(tag)` calls reviewed
- [ ] **Golden-file diff:** render every page with v3 and v4 and diff the HTML — expect only: DOCTYPE line, `<div>` line breaks, self-closing slashes, attribute alignment. Anything else is a bug in your migration
- [ ] Parser-dependent code tested with representative pages (especially mixed text/tag content and `<script src>`)
- [ ] Cache cleared on first v4 deploy; `ReadFromCache` call sites smoke-tested
- [ ] HTMX endpoints re-tested (modal open/submit, table search, toast `entity:changed` event fires — requires MiniJs)

## 8. Rollback

Regressing is safe: v4 changes are source-level only (no data migration — the cache map is the sole state, and it rebuilds itself). Keep the v3 `.b4xlib` and the v3 golden HTML; to roll back, restore the library reference and redeploy with a cleared cache.
