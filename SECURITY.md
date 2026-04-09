# Security

## Architecture

This app runs as an Electron desktop application with strict security boundaries between the main process and renderer.

### Context Isolation

- `contextIsolation: true` — renderer cannot access Node.js APIs directly
- `nodeIntegration: false` — no `require()` in renderer code
- All communication goes through a whitelisted IPC bridge (`preload.js`)

### Content Security Policy

The renderer enforces a strict CSP via meta tag:

```
default-src 'none';
script-src 'self';
style-src 'self' 'unsafe-inline';
font-src 'self';
img-src 'self' data:;
connect-src 'none';
```

- No external scripts or stylesheets can load
- No network requests from the renderer (`connect-src 'none'`) — all API calls go through IPC to the main process
- `unsafe-inline` for styles is required for widget framework functionality (inline style attributes for progress bars, animations)

### Credential Storage

- Session keys are encrypted using Electron's `safeStorage` API, which delegates to the OS keychain (Windows Credential Manager, macOS Keychain, Linux libsecret)
- If the OS keychain is unavailable, falls back to plain electron-store (local file)
- Credentials are never logged — only truncated prefixes appear in debug output
- On logout: cookies, localStorage, sessionStorage, and cache are all cleared

### External URL Handling

- `shell.openExternal()` is protected by a domain allowlist in both `preload.js` and `main.js`
- Allowed domains: `claude.ai`, `github.com`, `paypal.me`
- URLs must use `https:` protocol
- Any URL not matching the allowlist is silently blocked

### DOM Safety

- UI is built with `document.createElement()` and `appendChild()` — not `innerHTML`
- No `eval()` or `new Function()` anywhere in the codebase
- API response data (usage numbers, timestamps) is rendered as text content, not HTML

## API Communication

- All requests go to `https://claude.ai` API endpoints
- Fetched via a hidden `BrowserWindow` to work around Cloudflare browser verification
- User-Agent is set to a Chrome string (documented — required to avoid Cloudflare blocks)
- 30-second timeout on all requests
- Cloudflare block detection with user-facing error messages

## Data Stored Locally

| Data | Storage | Encryption |
|---|---|---|
| Session key | electron-store | OS keychain (safeStorage) |
| Organization ID | electron-store | OS keychain (safeStorage) |
| Settings (theme, thresholds, etc.) | electron-store | None (not sensitive) |
| Usage history (up to 10,000 samples) | electron-store | None (not sensitive) |
| Window position | electron-store | None (not sensitive) |

No data is sent to any third-party server. The app only communicates with `claude.ai` and `api.github.com` (for update checks, currently disabled in this fork).

## Session Key Disclaimer

This app requires a **Claude.ai session key** to authenticate API requests. This is necessary because Claude.ai does not offer a public API or OAuth flow for usage monitoring — the session cookie is the only available authentication method.

**What you should know:**

- Your session key grants access to your Claude.ai account — treat it like a password
- This app encrypts the key via your OS keychain and sends it **only** to `claude.ai`
- The app never transmits your key to any third-party server
- You provide your session key **at your own risk** — the author is not responsible for any misuse or unauthorized access resulting from session key exposure
- If you suspect your key has been compromised, log out of Claude.ai in your browser to invalidate it immediately
- You can review the full source code to verify exactly how the key is used

> This is the same authentication approach used by the [original project](https://github.com/SlavomirDurej/claude-usage-widget) and other community-built Claude tools.

---

## Reporting Issues

If you find a security issue, please open an issue on [GitHub](https://github.com/kucharko/oled-claude-usage-monitor/issues) or contact the repository owner directly.
