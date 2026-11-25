# RAPID Skins — Fabric 1.21.11

This client-side Fabric mod resolves each visible player's Minecraft name against the public RAPID Accounts skin lookup and applies the stored PNG locally.

## Backend setup

Run `rapid-accounts/rapid-skin-lookup.sql` in the RAPID Supabase SQL Editor once. The RPC is read-only and returns only username, skin path, and model.

## Build

Requires Java 21 and Gradle 9.2.1:

```sh
gradle build
```

The jar is written to `build/libs/`.

## Current scope

- Minecraft 1.21.11, Fabric Loader, client-side only.
- Uses public RAPID profile names and public skin files.
- Accepts 64x64 and legacy 64x32 PNG skins.
- Does not authenticate to Microsoft, change server authentication, or modify server behavior.
- Other players see RAPID skins only when they also have this mod installed.
