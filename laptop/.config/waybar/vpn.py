#!/usr/bin/env python3
"""Stream VPN status to Waybar using libnm events (requires python-gobject, libnm)."""

import html
import json
import signal

import gi

gi.require_version("NM", "1.0")
from gi.repository import GLib, NM


def main():
    signal.signal(signal.SIGPIPE, signal.SIG_DFL)
    client = NM.Client.new(None)
    watched = {}
    last_output = None

    def publish(*_):
        nonlocal last_output
        names = sorted(
            connection.get_id()
            for connection in client.get_active_connections()
            if client.get_nm_running()
            and connection.get_connection_type() in ("vpn", "wireguard")
            and connection.get_state() == NM.ActiveConnectionState.ACTIVATED
        )
        output = json.dumps({
            "text": "" if names else "",
            "tooltip": "VPN connected to:\n" + "\n".join(html.escape(name) for name in names)
            if names else "",
        })
        if output != last_output:
            print(output, flush=True)
            last_output = output

    def watch_connections(*_):
        connections = set(client.get_active_connections())
        for connection in set(watched) - connections:
            connection.disconnect(watched.pop(connection))
        for connection in connections - set(watched):
            watched[connection] = connection.connect("notify::state", publish)
        publish()

    client.connect("notify::active-connections", watch_connections)
    client.connect("notify::nm-running", watch_connections)
    watch_connections()
    GLib.MainLoop().run()


if __name__ == "__main__":
    main()
