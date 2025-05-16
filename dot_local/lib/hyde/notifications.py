#!/usr/bin/python3
import subprocess
import json
import sys
import os

FALLBACK_ICON = os.path.expanduser("~/.local/share/icons/Tela-circle-dracula/scalable/apps/notification-bell.svg")

def get_dunst_history():
    result = subprocess.run(['dunstctl', 'history'], stdout=subprocess.PIPE, check=True)
    history = json.loads(result.stdout.decode('utf-8'))
    return history

def get_dnd_status():
    result = subprocess.run(['dunstctl', 'get-pause-level'], stdout=subprocess.PIPE, check=True)
    return result.stdout.decode('utf-8').strip() != '0'

def format_waybar_output(history, dnd_active):
    count = len(history['data'][0])
    alt = "dnd" if dnd_active else "none"

    if count > 0:
        last_category = history['data'][0][0].get('category', {}).get('data', '')
        alt = f"{last_category}-notification" if last_category else "notification"

    tooltip_click = [
        "󰎟 Notifications",
        "󰳽 scroll-down:  history pop",
        "󰳽 click-left: 󱇧 Open panel",
        "󰳽 click-middle: 󰛌 clear history",
        "󰳽 click-right:  Enable & Disable DND"
    ]

    tooltip_notifications = []
    for notif in history['data'][0][:10]:
        body = notif.get('body', {}).get('data', '').strip()
        app_name = notif.get('appname', {}).get('data', '').strip()
        summary = notif.get('summary', {}).get('data', '').strip()

        if app_name.lower() == "vesktop" and summary:
            tooltip_notifications.append(f"{summary}: {body}")
        else:
            tooltip_notifications.append(f" {body}")

    return {
        "text": str(count),
        "alt": alt,
        "tooltip": '\n '.join(tooltip_click) + '\n\n ' + '\n '.join(tooltip_notifications),
        "class": alt
    }

def find_icon_path(app_name):
    icon_theme = "Tela-circle-dracula"
    icon_dirs = [
        os.path.expanduser(f"~/.local/share/icons/{icon_theme}"),
        os.path.expanduser(f"~/.icons/{icon_theme}"),
        f"/usr/share/icons/{icon_theme}",
        "/usr/local/share/icons/hicolor",
        "/usr/share/icons/hicolor"
    ]

    icon_map = {
        "discord": ["discord", "Discord"],
        "vesktop": ["discord", "Vesktop", "Discord"],
        "instagram": ["instagram", "Instagram"],
        "mattermost": ["mattermost", "Mattermost"],
        "messenger": ["messenger", "Messenger"],
        "spotify": ["spotify", "Spotify"],
        "firefox": ["firefox", "Firefox", "org.mozilla.firefox"],
        "chrome": ["google-chrome", "chrome", "Chrome"],
        "chromium": ["chromium", "Chromium"],
        "telegram": ["telegram", "telegram-desktop", "org.telegram.desktop"],
        "signal": ["signal", "signal-desktop"],
        "slack": ["slack", "Slack"],
        "thunderbird": ["thunderbird", "Thunderbird", "org.mozilla.Thunderbird"],
        "terminal": ["terminal", "utilities-terminal"],
        "kitty": ["kitty", "terminal"],
        "alacritty": ["alacritty", "terminal"],
        "blueman": ["blueman", "bluetooth", "bluetooth-active"],
    }

    possible_icon_names = icon_map.get(app_name.lower(), [app_name, "notification", "dialog-information"])

    icon_sizes = ["scalable", "128x128", "64x64", "48x48", "32x32", "24x24", "16x16"]
    icon_categories = ["apps", "devices", "status", "actions", "places", "mimetypes", "emblems", "categories"]
    icon_extensions = [".svg", ".png", ".xpm"]

    for icon_name in possible_icon_names:
        for icon_dir in icon_dirs:
            if not os.path.exists(icon_dir):
                continue

            for size in icon_sizes:
                for category in icon_categories:
                    size_dir = os.path.join(icon_dir, size, category)
                    if os.path.exists(size_dir):
                        for ext in icon_extensions:
                            icon_path = os.path.join(size_dir, f"{icon_name}{ext}")
                            if os.path.exists(icon_path):
                                return icon_path

    return FALLBACK_ICON

def show_rofi_panel(history):
    rofi_entries = []
    icon_cache = {}

    for notif in history['data'][0]:
        body = notif.get('body', {}).get('data', '').strip()
        app_name = notif.get('appname', {}).get('data', '').strip()
        summary = notif.get('summary', {}).get('data', '').strip()

        if app_name not in icon_cache:
            icon_cache[app_name] = find_icon_path(app_name)

        icon = icon_cache[app_name]

        if app_name.lower() == "vesktop" and summary:
            padded_body = f" {summary}: {body}"
        else:
            padded_body = " " + body

        entry = f"{padded_body}\0icon\x1f{icon}"
        rofi_entries.append(entry)

    if not rofi_entries:
        entry = f" No notifications\0icon\x1f{FALLBACK_ICON}"
        rofi_entries = [entry]

    rofi_input = '\n'.join(rofi_entries)

    try:
        subprocess.run(
            [
                "rofi", "-dmenu", "-i",
                "-theme", "notification-panel",
                "-p", "🔔 Notifications",
                "-show-icons",
                "-markup-rows"
            ],
            input=rofi_input.encode('utf-8'),
            check=False
        )
    except Exception as e:
        print(f"Failed to open rofi: {e}", file=sys.stderr)

def main():
    if len(sys.argv) > 1 and sys.argv[1] == "--panel":
        try:
            history = get_dunst_history()
            show_rofi_panel(history)
        except Exception as e:
            print(json.dumps({"text": "!", "alt": "error", "tooltip": str(e)}))
        return

    try:
        history = get_dunst_history()
        dnd_active = get_dnd_status()
        output = format_waybar_output(history, dnd_active)
        sys.stdout.write(json.dumps(output) + '\n')
        sys.stdout.flush()
    except Exception as e:
        sys.stdout.write(json.dumps({"text": "!", "alt": "error", "tooltip": str(e)}) + '\n')
        sys.stdout.flush()

if __name__ == "__main__":
    main()