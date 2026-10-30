# new_computer_launcher

Sets up a new Apple Silicon Mac: apps, command-line tools, shell config and Hammerspoon hotkeys.

## Usage

```bash
git clone https://github.com/andrebrener/new_computer_launcher.git
cd new_computer_launcher
bash installer.sh
```

- `git` on a fresh Mac prompts to install the Xcode Command Line Tools first.
- Safe to re-run: Homebrew skips what is installed, and shell lines are only added once.
- The script stops at the first failure. Fix it and run it again.

## What it does

`installer.sh` is the list; edit it to add or remove anything.

- **Homebrew:** installs it if missing and adds it to `~/.zprofile`.
- **Apps:** Homebrew casks.
- **CLI tools:** Homebrew formulae.
- **Node:** the LTS release through nvm, plus global `pnpm`, `vercel` and `netlify-cli`.
- **Shell:** adds nvm, pyenv and `postgresql@14` to `~/.zshrc`.
- **Hammerspoon:** symlinks `~/.hammerspoon/init.lua` to `hammerspoon/init.lua` in this repo.

## After installing

- Open Hammerspoon and grant it Accessibility access.
- Keep the repo where it is: moving it breaks the Hammerspoon symlink.
- Open a new terminal to pick up the shell changes.

## Hotkeys

Windows:

| Keys | Action |
|---|---|
| `shift` + `←` | Left half |
| `shift` + `→` | Right half |
| `shift` + `↑` | Full screen |

Apps, with `ctrl` + `cmd`:

| Key | App |
|---|---|
| `a` | Arc (not installed by the script) |
| `c` | Claude |
| `g` | Grok Bot |
| `l` | Linear |
| `m` | Spotify |
| `n` | Notion |
| `s` | Slack |
| `t` | Telegram |
| `w` | WhatsApp |
| `x` | Visual Studio Code |
