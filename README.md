# OLED Claude Usage Monitor Widget

A desktop widget for real-time **Claude.ai** usage monitoring, built with Electron.  
Designed for OLED displays with burn-in prevention, transparent glass mode, and full accent color customization.

> Based on [Claude Usage Widget](https://github.com/SlavomirDurej/claude-usage-widget) by Slavomir Durej. See [CREDITS.md](CREDITS.md) for attribution.

![OLED Theme — full view](assets/screenshots/oled-theme-full.png)

---

## Download

**[Latest Release (v2.0.0)](https://github.com/kucharko/OLED_Claude_Usage_Widget/releases/latest)** — Windows Setup .exe + portable .exe

Or build from source (see [Installation](#installation) below).

---

## Features

### Display Modes
| Mode | Description |
|---|---|
| **Dark** | Default theme with gradient backgrounds |
| **Light** | Bright theme for daytime use |
| **OLED** | Pure black (#000000) backgrounds, dimmed UI, zero glow |
| **Glass** | Fully transparent — only bars and data float on screen |
| **Compact** | Minimal two-bar view (290px wide) |

### OLED Protection
- **Pure black backgrounds** — real black pixels = pixels off on OLED
- **Pixel shift** — subtle content drift animation prevents static burn-in
- **Dimmed accents** — reduced brightness and no glow effects

### Customization
- **Dual accent colors** — separate color for Session and Weekly (7 options each)
- **Window opacity** — 20% to 100%
- **Glass hover opacity** — how visible labels become on mouse hover
- **Column toggles** — show/hide Elapsed, Resets In, Resets At
- **Row toggles** — show/hide Current Session or Weekly Limit
- **Claude logo** — small icon next to session label

### Monitoring
- Session and weekly usage with progress bars + circular timers
- Extra usage tracking (overage spending, prepaid credits)
- 7-day usage history graph
- Desktop notifications at configurable thresholds
- Auto-refresh (15s to 5min)

---

## Screenshots

### Glass Mode — session only
![Glass Mode — session only](assets/screenshots/glass-session-only.png)

### Glass Mode — dual bars with pixel shift
![Glass Mode — dual bars](assets/screenshots/glass-dual-bars.png)

### Dark Theme
![Dark Theme](assets/screenshots/dark-theme-compact.png)

### Settings Panel
![Settings](assets/screenshots/settings-panel.png)

---

## Installation

### Quick Start (Windows)

1. Install [Node.js](https://nodejs.org/) (LTS)
2. Clone and run:
   ```bash
   git clone https://github.com/kucharko/OLED_Claude_Usage_Widget.git
   cd OLED_Claude_Usage_Widget
   install.bat
   ```
3. Choose: **1** = run now, **2** = build .exe installer, **3** = both

### Manual

```bash
npm install
npm start
```

### Build .exe

```bash
npm run build
```

> **Note:** Building requires admin privileges on Windows (for symlink creation during packaging). Run your terminal as Administrator, or enable Developer Mode in Windows Settings.

Output in `dist/`:
- `OLED-Claude-Usage-Monitor-2.0.0-Setup.exe` — installer
- `OLED-Claude-Usage-Monitor-2.0.0-portable.exe` — no install needed

---

## Setup

1. Launch the app
2. Click **Log in** to authenticate via Claude.ai, or **Manual** to paste your session key
3. Open Settings (gear icon) to customize everything

### Getting a Session Key

1. Open [claude.ai](https://claude.ai) in your browser
2. Press `F12` → **Application** tab → **Cookies** → `https://claude.ai`
3. Copy the value of `sessionKey`

---

## Tech Stack

| Component | Version |
|---|---|
| Electron | 41.2.0 (Chromium 136) |
| Chart.js | 4.5.1 |
| electron-store | 8.2.0 (OS keychain encrypted) |
| Frontend | Vanilla JS — no framework |

---

## Security

See [SECURITY.md](SECURITY.md) for full details.

- Context isolation + strict CSP (`connect-src 'none'`)
- Credentials encrypted via OS keychain
- No external network from renderer — all API calls through IPC
- 0 npm vulnerabilities (`npm audit`)

---

## Credits

Based on **[Claude Usage Widget](https://github.com/SlavomirDurej/claude-usage-widget)** by **Slavomir Durej**.

See [CREDITS.md](CREDITS.md) for full attribution and changes.

---

## License

MIT (as declared in the original project's package.json). See [CREDITS.md](CREDITS.md) for details.
