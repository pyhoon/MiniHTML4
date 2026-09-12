# Cache.bas — Page & Component Caching

Static-code module for caching MiniHtml objects in a `Map` context. Supports round‑tripping through byte arrays so cached MiniHtml trees can be cloned without re-building.

## Methods

| Method | Returns | Description |
|--------|---------|-------------|
| `ExistInCache(ctx, Key)` | `Boolean` | Check if `Key` exists in the cache map |
| `WriteToCache(ctx, Key, Value)` | `-` | Store `Value` in the cache map |
| `ReadFromCache(ctx, Key)` | `Object` | Read from cache; returns `MiniHtml` if stored as MiniHtml or byte array, otherwise raw `Object` |
| `ClearFromCache(ctx, Key)` | `-` | Remove a single key from the cache |
| `ClearAllFromCache(ctx, MatchKey)` | `-` | Remove all keys containing `MatchKey` |
| `ConvertFromBytes(Buffer())` | `MiniHtml` | Parse UTF‑8 byte array into a MiniHtml tree |
| `ConvertToBytes` | `Byte()` | Serialize an empty MiniHtml to UTF‑8 byte array |

## Usage Pattern

```b4x
Dim ctx As Map
ctx.Initialize

' Check and write
If Cache.ExistInCache(ctx, "myKey") = False Then
    Dim el As MiniHtml = MH.Div
    el.text("Hello")
    Cache.WriteToCache(ctx, "myKey", el.ConvertToBytes)
End If

' Read back (auto-detects MiniHtml vs byte[])
Dim el As MiniHtml = Cache.ReadFromCache(ctx, "myKey")
```

## Notes

- `ReadFromCache` transparently handles both raw `MiniHtml` objects and byte arrays (`[B` type), calling `ConvertFromBytes` on the latter.
- `ConvertToBytes` serializes an empty tag — useful when you want to clone a MiniHtml tree by storing and re-reading it as bytes.
