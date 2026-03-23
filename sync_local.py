#!/usr/bin/env python3
"""把本地 entries.json 的记录同步到 Supabase（修复版）"""
import json, urllib.request

SUPABASE_URL = "https://dbduutzsoynmhbfazpxu.supabase.co"
SUPABASE_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRiZHV1dHpzb3lubWhiZmF6cHh1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzQyNzU3NDIsImV4cCI6MjA4OTg1MTc0Mn0.lTrhFI7KlhbYQlvyCJ-n-MIPR9uRJ3nW44tE2CNRCW8"

# Map old types to valid DB types
TYPE_MAP = {
    "thought": "thought",
    "inspiration": "inspiration",
    "todo": "todo",
    "quote": "quote",
    "link": "link",
    "idea": "inspiration",
    "reference": "link",
}

with open("/Users/babul/.idea-journal/entries.json") as f:
    entries = json.load(f)

# Check what's already in Supabase to avoid duplicates
req = urllib.request.Request(
    f"{SUPABASE_URL}/rest/v1/entries?select=content",
    headers={
        "apikey": SUPABASE_KEY,
        "Authorization": f"Bearer {SUPABASE_KEY}",
    }
)
existing = json.loads(urllib.request.urlopen(req).read())
existing_contents = {e["content"] for e in existing}

to_sync = [e for e in entries if e.get("content", "") not in existing_contents]
print(f"本地 {len(entries)} 条，云端已有 {len(existing)} 条，需同步 {len(to_sync)} 条")

success = 0
for e in to_sync:
    raw_type = e.get("type", "thought")
    data = {
        "title": e.get("title", "") or e.get("content", "")[:30],
        "content": e.get("content", ""),
        "type": TYPE_MAP.get(raw_type, "thought"),
        "tags": e.get("tags", []),
        "source": e.get("source", "对话"),
        "urls": e.get("urls", []),
        "created_at": e.get("created_at"),
        "updated_at": e.get("updated_at"),
    }
    req = urllib.request.Request(
        f"{SUPABASE_URL}/rest/v1/entries",
        data=json.dumps(data).encode(),
        headers={
            "apikey": SUPABASE_KEY,
            "Authorization": f"Bearer {SUPABASE_KEY}",
            "Content-Type": "application/json",
            "Prefer": "return=minimal"
        },
        method="POST"
    )
    try:
        urllib.request.urlopen(req)
        success += 1
        print(f"  OK  {data['title']}")
    except Exception as ex:
        print(f"  ERR {data['title']}: {ex}")

print(f"\n同步完成：{success}/{len(to_sync)} 条")
