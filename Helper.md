# Helper.bas — Higher-Level UI Helpers

Static-code module providing tag factories, Bootstrap 5 UI components, form helpers, HTMX helpers, and custom components for the MiniHTML library.

## Tag Factories

| Method | Tag | Notes |
|--------|-----|-------|
| `CreateTag(Name)` | `any` | Generic tag factory |
| `Html` | `<html>` | With `lang="en"` |
| `Head` | `<head>` | |
| `Body` | `<body>` | |
| `Title` | `<title>` | |
| `Div` | `<div>` | |
| `Span` | `<span>` | |
| `P` | `<p>` | |
| `Anchor` | `<a>` | |
| `Button` | `<button>` | |
| `Strong` | `<strong>` | |
| `Br` | `<br>` | |
| `Nav` | `<nav>` | |
| `Form` | `<form>` | |
| `H1`, `H2`, `H3`, `H5`, `H6` | `<h1>`–`<h6>` | |
| `Script` | `<script>` | |
| `Style` | `<style>` | |
| `Meta` | `<meta>` | |
| `Link` | `<link>` | |
| `Icon` | `<i>` | |
| `Img` | `<img>` | |
| `Image` | `<img>` | Alias for `Img` |
| `Svg` | `<svg>` | |
| `Path` | `<path>` | |
| `Input` | `<input>` | |
| `Label` | `<label>` | |
| `Caption` | `<caption>` | |
| `Footer` | `<footer>` | |
| `Table` | `<table>` | |
| `Thead` | `<thead>` | |
| `Tbody` | `<tbody>` | |
| `Tr` | `<tr>` | |
| `Td` | `<td>` | |
| `Th` | `<th>` | |
| `Ul` | `<ul>` | |
| `Li` | `<li>` | |
| `SelectTag` | `<select>` | |
| `Option` | `<option>` | |
| `Textarea` | `<textarea>` | |

## Custom Components

| Method | Returns | Description |
|--------|---------|-------------|
| `CreateAlertInfo(Message, Status)` | `AlertInfo` | Create alert data object |
| `CreateToastInfo(Entity, Action, Message, Status)` | `ToastInfo` | Create toast data object |
| `Alert(info)` | `String` | Renders `<div class="alert alert-{status}">{message}</div>` |
| `Toast(id, table, info)` | `String` | HTMX out-of‑band swap container + MiniJs event dispatch |
| `NavLinkItem(text, href, icon_cls, icon_title)` | `MiniHtml` | `<li class="nav-item">` with anchor + icon |
| `AnchorIcon(cls, hx_get, title_text, icon_class)` | `MiniHtml` | Anchor with hx-get for modal trigger + icon |
| `ButtonClose` | `MiniHtml` | `<button type="button" class="btn-close" data-bs-dismiss="modal">` |
| `ButtonAdd(text, cls, hx_get, hx_target, hx_trigger, data_bs_target, data_bs_toggle)` | `MiniHtml` | Button with icon + HTMX modal attributes |
| `ButtonSubmit(text, cls)` | `MiniHtml` | `<button type="submit">` |
| `ButtonCancel(text, cls)` | `MiniHtml` | `<button type="button" data-bs-dismiss="modal">` |
| `ButtonSearch(text, cls, hx_post, hx_target)` | `MiniHtml` | Search button with HTMX attrs |
| `InputSearch(cls, id, name)` | `MiniHtml` | `<input type="text">` search field |
| `TextLabel(text, cls, forId)` | `MiniHtml` | `<label for="...">` |
| `FormGroup` | `MiniHtml` | `<div class="form-group">` |
| `InputGroup` | `MiniHtml` | `<div class="input-group mb-3">` |
| `HiddenInput(id, name, value)` | `MiniHtml` | `<input type="hidden">` |
| `RequiredLabel(text, forId)` | `MiniHtml` | Label with red asterisk |
| `RequiredTextInput(id, name, value)` | `MiniHtml` | Required text input |
| `RequiredDropdown(id, name)` | `MiniHtml` | Required `<select class="form-select">` |
| `ContainerModal` | `MiniHtml` | Bootstrap 5 modal container (fade, centered) |
| `ContainerModalWithButton(TitleText, ParagraphText, ButtonText)` | `MiniHtml` | Modal with header, body, footer + dismiss button |
| `ContainerToast` | `MiniHtml` | Fixed-position toast container (bottom‑right) |
| `NavLinkItemImage(href, img_src, img_title)` | `MiniHtml` | `<li class="nav-item">` with anchor + image |
| `IconAnchor(cls, href, icon_class, icon_title)` | `MiniHtml` | Anchor with icon |
| `ImageAnchor(href, img_src, img_class, img_title)` | `MiniHtml` | Anchor with image |
| `FavoriteIcon(icon_type, href)` | `MiniHtml` | `<link rel="icon" type="..." href="...">` |
| `OptionDisabled(text)` | `MiniHtml` | `<option value="" disabled>{text}</option>` |

## Conversion Helpers

| Method | Returns | Description |
|--------|---------|-------------|
| `ConvertFromBytes(Buffer())` | `MiniHtml` | Parse UTF‑8 byte array into MiniHtml tree |
| `ConvertToBytes(Root)` | `Byte()` | Serialize MiniHtml tree to UTF‑8 byte array |

## Bootstrap Layout Helpers

| Method | Returns | Description |
|--------|---------|-------------|
| `Container` | `MiniHtml` | `<div class="container">` |
| `ContainerFluid` | `MiniHtml` | `<div class="container-fluid">` |
| `Row` | `MiniHtml` | `<div class="row">` |
| `Col(cols)` | `MiniHtml` | `<div class="col-{cols}">` |

## Form Input Helpers

All form helpers apply `form-control` class and guard empty-string parameters.

| Method | Returns | Description |
|--------|---------|-------------|
| `InputText(id, name, value, placeholder)` | `MiniHtml` | `<input type="text">` |
| `InputEmail(id, name, value, placeholder)` | `MiniHtml` | `<input type="email">` |
| `InputPassword(id, name, placeholder)` | `MiniHtml` | `<input type="password">` |
| `InputNumber(id, name, value, MinValue, MaxValue, StepValue)` | `MiniHtml` | `<input type="number">` |
| `InputDate(id, name, value)` | `MiniHtml` | `<input type="date">` |
| `InputFile(id, name, accept, multiple)` | `MiniHtml` | `<input type="file">` |
| `TextareaInput(id, name, value, rows, placeholder)` | `MiniHtml` | `<textarea class="form-control">` |
| `CheckboxInput(id, name, value, text, checked)` | `MiniHtml` | `form-check` div with label |
| `RadioInput(name, id, value, text, checked)` | `MiniHtml` | `form-check` div with label |
| `SelectInput(id, name, options, selectedValue, prompt, required)` | `MiniHtml` | `<select class="form-select">` with `<option>` children |

`SelectInput` expects `options` as a `List` of `Map` items with keys `"value"` and `"text"`.

## Bootstrap UI Components

| Method | Returns | Description |
|--------|---------|-------------|
| `Card` | `MiniHtml` | `<div class="card">` |
| `CardHeader` | `MiniHtml` | `<div class="card-header">` |
| `CardBody` | `MiniHtml` | `<div class="card-body">` |
| `CardFooter` | `MiniHtml` | `<div class="card-footer">` |
| `CardTitle` | `MiniHtml` | `<h5 class="card-title">` |
| `CardText` | `MiniHtml` | `<p class="card-text">` |
| `Badge(text, cls)` | `MiniHtml` | `<span class="badge {cls}">{text}</span>` |
| `ListGroup` | `MiniHtml` | `<ul class="list-group">` |
| `ListGroupItem(text, cls)` | `MiniHtml` | `<li class="list-group-item {cls}">{text}</li>` |
| `ListGroupButton(text, cls, active)` | `MiniHtml` | `<button class="list-group-item list-group-item-action {cls}[ active]">` |
| `ProgressBar(now, MinValue, MaxValue, cls, showLabel)` | `MiniHtml` | Progress bar with ARIA attrs |
| `Spinner(cls, text)` | `MiniHtml` | `<div class="spinner-border {cls}">` + sr‑only text |
| `SpinnerGrow(cls, text)` | `MiniHtml` | `<div class="spinner-grow {cls}">` + sr‑only text |
| `AlertDismissible(message, status)` | `MiniHtml` | Dismissible Bootstrap alert with close button |

## HTMX Helpers

| Method | Returns | Description |
|--------|---------|-------------|
| `HxGet(href, target, swap, trigger)` | `MiniHtml` | Anchor with `hx-get`, `hx-target`, `hx-swap`, `hx-trigger` |
| `HxPost(href, target, swap)` | `MiniHtml` | Button with `hx-post`, `hx-target`, `hx-swap` |
| `ContainerHxGet(id, href, trigger, text)` | `MiniHtml` | `<div>` with `hx-get`, `hx-trigger`, and inner text |
| `FormHx(verb, href, target)` | `MiniHtml` | `<form>` with `hx-{verb}`, `hx-target`, `hx-swap="innerHTML"` |
| `FormHxPost(href, target)` | `MiniHtml` | Shorthand for `FormHx("post", href, target)` |
| `FormHxPut(href, target)` | `MiniHtml` | Shorthand for `FormHx("put", href, target)` |
| `FormHxDelete(href, target)` | `MiniHtml` | Shorthand for `FormHx("delete", href, target)` |

## Navigation Helpers

| Method | Returns | Description |
|--------|---------|-------------|
| `Navbar(cls)` | `MiniHtml` | `<nav class="navbar {cls}">` with `container-fluid` child |
| `NavbarExpand(cls, expand, brand)` | `MiniHtml` | `<nav class="navbar navbar-expand-{expand} {cls}">` with brand |
| `NavbarToggler` | `MiniHtml` | Collapse toggler button (`navbar-toggler`) |
| `NavbarCollapse` | `MiniHtml` | Collapsible nav container (`collapse navbar-collapse`) |
| `NavItem(text, href, active)` | `MiniHtml` | `<li class="nav-item"><a class="nav-link[ active]" href="...">` |

## Utility Helpers

| Method | Returns | Description |
|--------|---------|-------------|
| `CssLink(href)` | `MiniHtml` | `<link rel="stylesheet" href="...">` |
| `JsScript(src)` | `MiniHtml` | `<script src="...">` |
| `ImgResponsive(src, alt, cls)` | `MiniHtml` | `<img class="img-fluid {cls}" src="..." alt="...">` |
| `PageHeading(text, tag)` | `MiniHtml` | Generic heading tag with inner text |
| `ButtonIcon(text, iconCls, btnCls)` | `MiniHtml` | Button with icon + text |
| `AnchorButton(text, href, cls)` | `MiniHtml` | Anchor styled as button (`class="btn {cls}"`) |
| `ResponsiveHeader` | `MiniHtml` | `<head>` with charset + viewport meta tags |
| `CopyrightFooter` | `MiniHtml` | Footer with copyright text + heart icon |
| `SponsorLink` | `MiniHtml` | PayPal sponsor link with image |
| `GitHubLink` | `MiniHtml` | GitHub link with SVG icon + text |

## Types

```
Type AlertInfo (Message As String, Status As String)
Type ToastInfo (Entity As String, Action As String, Message As String, Status As String)
```
