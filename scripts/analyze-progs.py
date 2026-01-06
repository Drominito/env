#!/usr/bin/env python3
import re
from collections import Counter
from pathlib import Path

# Read progs file
progs_file = Path.home() / "repo/env/scripts/progs"
content = progs_file.read_text()

# Extract all package names
packages = []

# Match patterns like: $pfo package1 package2
# or: sudo pacman $pfo package1 package2
# or: paru $pfo package1
for line in content.split('\n'):
    # Skip comments and empty lines
    if line.strip().startswith('#') or not line.strip():
        continue
    
    # Find all words that look like package names after install commands
    if '$pfo' in line or '$pcfo' in line or 'pacman -S' in line or 'paru' in line or 'yay' in line:
        # Remove everything before the package manager command
        if '$pfo' in line or '$pcfo' in line:
            parts = re.split(r'\$p[c]?fo\s+', line)
            if len(parts) > 1:
                pkg_line = parts[-1]
        elif 'pacman -S' in line:
            parts = line.split('pacman -S')
            if len(parts) > 1:
                pkg_line = parts[-1]
        elif 'paru' in line or 'yay' in line:
            parts = re.split(r'(?:paru|yay)\s+.*?\s+', line)
            if len(parts) > 1:
                pkg_line = parts[-1]
        else:
            continue
            
        # Extract package names (words with letters, numbers, hyphens, underscores)
        pkgs = re.findall(r'\b[a-zA-Z0-9][a-zA-Z0-9_\-]*[a-zA-Z0-9]\b', pkg_line)
        
        # Filter out common flags and bash constructs
        filtered = [p for p in pkgs if not p.startswith('--') and p not in ['sudo', 'needed', 'for', 'do', 'done', 'in', 'echo', 'if', 'fi', 'then']]
        packages.extend(filtered)

# Count duplicates
counter = Counter(packages)
duplicates = {pkg: count for pkg, count in counter.items() if count > 1}

print("=== DUPLICATES FOUND ===")
print()
for pkg, count in sorted(duplicates.items(), key=lambda x: -x[1]):
    print(f"{count}x  {pkg}")

print()
print(f"=== SUMMARY ===")
print(f"Total package mentions: {len(packages)}")
print(f"Unique packages: {len(counter)}")
print(f"Duplicates: {len(duplicates)}")
print()
print("All unique packages:")
for pkg in sorted(counter.keys()):
    print(f"  {pkg}")
