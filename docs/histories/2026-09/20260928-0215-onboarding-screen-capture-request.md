## [2026-09-28 02:15] | Task: Make onboarding register for Screen Recording

### 🤖 Execution Context
* **Agent ID**: `Claude Code`
* **Base Model**: `claude-opus-5-5`
* **Runtime**: `Claude Code CLI, macOS 27`

### 📥 User Query
> The Screen & System Audio Recording page did not list our build, so it could not be granted.

### 🛠 Changes Overview
**Scope:** `packages/OpenComputerUseKit`, `apps/OpenComputerUse`

**Key Actions:**
- **Request, not just open Settings**: the onboarding's Screen Recording step now calls `CGRequestScreenCaptureAccess()` (new `PermissionSupport.requestScreenRecordingPrompt`) before opening the pane, as the Accessibility step already called `AXIsProcessTrustedWithOptions` with a prompt.

### 🧠 Design Intent (Why)
macOS lists an app under Screen Recording only after it has asked for access. Opening the pane without asking left a freshly built or re-signed app missing from the list, so the user had to add it by hand with +.

### 📁 Files Modified
- `packages/OpenComputerUseKit/Sources/OpenComputerUseKit/Permissions.swift`
- `apps/OpenComputerUse/Sources/OpenComputerUse/PermissionOnboardingApp.swift`
