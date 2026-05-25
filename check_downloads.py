"""查看 GitHub Release 下载量"""
import urllib.request, json

TOKEN = "REMOVED_TOKEN"
REPO = "Majie-xixi/MCUQuickStart"

req = urllib.request.Request(
    f"https://api.github.com/repos/{REPO}/releases",
    headers={"Authorization": f"token {TOKEN}"}
)
resp = urllib.request.urlopen(req)
releases = json.loads(resp.read().decode("utf-8"))

total = 0
for r in releases:
    for a in r.get("assets", []):
        print(f"{r['tag_name']}: {a['download_count']} downloads")
        total += a["download_count"]

print(f"\n合计: {total}")
