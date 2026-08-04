#!/usr/bin/env python3
"""
the-bubbles build — seals the standalone playable: reads
game-template.html, embeds the fuller set (bubbles-set.json) and the
seven approved pops (sounds/*.wav, base64 data URIs), and writes
index.html — one file, open and play. Heal by regeneration.
"""

import base64
import json
import os

HERE = os.path.dirname(os.path.abspath(__file__))

with open(os.path.join(HERE, "bubbles-set.json"), encoding="utf-8") as f:
    bubbles = json.load(f)

pops = []
names = ["pop-bubble.wav"] + [f"pop-bubble-{i}.wav" for i in range(2, 8)]
for name in names:
    with open(os.path.join(HERE, "sounds", name), "rb") as f:
        pops.append("data:audio/wav;base64," + base64.b64encode(f.read()).decode())

with open(os.path.join(HERE, "game-template.html"), encoding="utf-8") as f:
    html = f.read()

html = html.replace("/*__BUBBLES_JSON__*/", json.dumps(bubbles, ensure_ascii=False))
html = html.replace("/*__POPS_JSON__*/", json.dumps(pops))

out = os.path.join(HERE, "index.html")
with open(out, "w", encoding="utf-8") as f:
    f.write(html)

kb = os.path.getsize(out) / 1024
print(f"index.html sealed: {kb:.0f} KB · {len(bubbles['bubbles'])} bubbles · "
      f"{len(bubbles['collections'])} collections · {len(pops)} pops embedded")

# the-logbook's encoding: one line at end of run, walk-up placement, silent on failure
try:
    import datetime
    d = HERE
    target = None
    while True:
        for c in (os.path.join(d, "docs", "RUN-LOG.md"), os.path.join(d, "RUN-LOG.md")):
            if os.path.exists(c):
                target = c
                break
        if target or os.path.exists(os.path.join(d, ".git")):
            target = target or os.path.join(d, "RUN-LOG.md")
            break
        parent = os.path.dirname(d)
        if parent == d:
            break
        d = parent
    if target:
        stamp = datetime.datetime.now().strftime("%Y-%m-%d %H:%M")
        with open(target, "a", encoding="utf-8") as f:
            f.write(f"{stamp} · the-bubbles · game sealed · {len(bubbles['bubbles'])} bubbles · "
                    f"{len(bubbles['collections'])} collections · {len(pops)} pops · {kb:.0f} KB\n")
except Exception:
    pass
