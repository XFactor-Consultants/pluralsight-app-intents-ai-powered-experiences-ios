# TaskFlow — Canonical Base Build (Pre-Auth)

This is the app Clip 1's walkthrough records: a working task manager with
teammates, due dates, priorities, and two sensitive tasks whose lock icons
don't do anything yet. No sign-in, no gates. The Authentication course adds
those, module by module.

## Creating the Xcode project (one time, ~5 minutes)

1. Open Xcode (16 or later) → **File → New → Project…**
2. Choose **iOS → App** → Next.
3. Product Name: **TaskFlow**. Interface: **SwiftUI**. Language: **Swift**.
   Leave "Include Tests" unchecked for now. → Next → save it wherever you
   keep your repos.
4. In the file navigator (left sidebar), delete **ContentView.swift**
   (right-click → Delete → Move to Trash). Also delete the generated
   **TaskFlowApp.swift** — we're replacing it.
5. Drag all seven `.swift` files from this folder's `TaskFlow/` directory
   into the Xcode file navigator, dropping them on the yellow **TaskFlow**
   group (the folder icon, not the blue project icon at the very top).
   In the dialog: check **Copy items if needed** and make sure the
   **TaskFlow** target is checked. → Finish.
6. Click the blue **TaskFlow** project icon at the top of the navigator →
   select the **TaskFlow** target → **General** tab → set
   **Minimum Deployments** to **iOS 18.0**. (The tab bar uses the iOS 18
   `Tab` syntax.)
7. At the top of the window, pick a simulator (e.g. **iPhone 16 Pro**) and
   press **⌘R** (or the ▶ button).

The app should launch straight into the task list.

## Verifying the Clip 1 recording shots

- **vid1@0:00** — App opens directly to the task list. Teammate initials,
  due dates (one overdue task shows a red date), priority icons all visible.
- **vid1@0:20** — "Update emergency contact info" shows a lock icon. Tap it —
  nothing gates it. That's the point.
- **vid2@0:00** — The sensitive task's detail view opens with no challenge.
- **vid2@0:15** — Long-press any task row for the **Share Task** action
  (there's also a Share button in the detail view's toolbar). No
  authorization check runs.

## Notes for the course scripts

- **The task model is named `TaskItem`, not `Task`.** Swift Concurrency has
  a built-in `Task` type; naming ours `Task` causes confusing collisions the
  moment anyone writes `Task { }` — which the Concurrency course does
  constantly. Worth a one-line aside if it ever shows on screen.
- `RootView` currently shows the tab bar unconditionally. Module 1, Clip 2
  replaces its body with the `switch authStore.state` version from the
  script — that diff is the demo.
- `SettingsView` has a placeholder "Not signed in" account section for the
  same reason: Clip 2's vid4 expects Settings to show a signed-in user
  afterward.
- Sample due dates are relative to "now," so the list always has one overdue
  task no matter when you record.
- Sign in with Apple / passkey capabilities are NOT configured in this base
  project — the canonical build doesn't need them, and adding the capability
  on-camera is part of Module 1's setup demo. You'll need a paid Apple
  Developer Program team selected under Signing & Capabilities when you get
  there.

## Suggested repo structure

Per the series plan (starter/completed branches per module):

- `main` — this canonical build
- `auth-m1-starter` = main, `auth-m1-completed` — after Clips 2–3
- `auth-m2-starter` = m1-completed, and so on

Commit this base first so every course branches from the same commit.
