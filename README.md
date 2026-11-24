# RAPID CLIENT

A personal Minecraft Java launcher based on the open-source OneClient / OneLauncher project.

RAPID CLIENT keeps the launcher's instance management, Minecraft version selection, mod and resource-pack management, and Microsoft account sign-in. This fork changes the product branding and Windows packaging while retaining the underlying launcher code.

## Windows build

Every push to `main` starts the **RAPID CLIENT Windows Build** workflow.

To download the build:
1. Open the repository's **Actions** tab.
2. Select **RAPID CLIENT Windows Build** and open the newest successful run.
3. Download the `rapid-client-windows` artifact. It contains the Windows installer and standalone executable.

You can also start a build manually with **Actions → RAPID CLIENT Windows Build → Run workflow**.

The current automated package target is Windows x64. The installer is unsigned, so Windows may show its normal publisher warning.

## Upstream and licensing

This repository is a modified fork of [Polyfrost OneClient / OneLauncher](https://github.com/Polyfrost/OneLauncher). The upstream source is licensed under **GPL-3.0-only**; its original copyright and third-party notices are retained in [ATTRIBUTION.md](ATTRIBUTION.md), and the license text is retained in [LICENSE](LICENSE).

RAPID CLIENT's replacement wordmark and icon artwork are original assets for this fork. Microsoft account authentication remains in place; this project does not remove account or game ownership checks.
