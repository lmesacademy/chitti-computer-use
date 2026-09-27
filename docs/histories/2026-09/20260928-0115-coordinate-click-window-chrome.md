## [2026-09-28 01:15] | Task: Stop x/y clicks from pressing the window's close button

### 🤖 Execution Context
* **Agent ID**: `Claude Code`
* **Base Model**: `claude-opus-5-5`
* **Runtime**: `Claude Code CLI, macOS 27`

### 📥 User Query
> Coordinate clicks on a GPU-rendered desktop app (GPUI) destroyed its window and then failed with `cgWindowNotFound`; fix it in our own copy.

### 🛠 Changes Overview
**Scope:** `packages/OpenComputerUseKit`

**Key Actions:**
- **Constrain the x/y descendant fallback**: when no AX node sits under the point, the best element containing it is the window (or its content container). The AX click sequence then pressed "the smallest pressable descendant" of that element, with no check that it was under the click, and for a window that is its close button. An x/y click now only accepts descendants whose frame contains the point.
- **Never press title-bar controls as a stand-in**: close / minimize / zoom / full-screen subroles are excluded from descendant candidates for every click.
- **Recover the running bundle, not the bundle id**: window recovery used `open -b <id>`, which Launch Services resolves to its preferred copy. With an installed app and a dev build sharing an id, that launched the other copy. It now reopens `NSRunningApplication.bundleURL` and only falls back to `-b` when the path is unknown.

### 🧠 Design Intent (Why)
A click the caller aimed at a point must land at that point or fall through to the non-AX mouse path, never on an unrelated control elsewhere in the window. Pressing the close button is destructive and was invisible to the caller: the next call just reported `cgWindowNotFound`.

### 📁 Files Modified
- `packages/OpenComputerUseKit/Sources/OpenComputerUseKit/ClickTargeting.swift`
- `packages/OpenComputerUseKit/Sources/OpenComputerUseKit/ComputerUseService.swift`
- `packages/OpenComputerUseKit/Sources/OpenComputerUseKit/AccessibilitySnapshot.swift`
- `packages/OpenComputerUseKit/Tests/OpenComputerUseKitTests/OpenComputerUseKitTests.swift`
