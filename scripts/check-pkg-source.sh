#!/bin/bash
# Extract all packages from progs and check if they're in pacman or AUR
# This version avoids PCRE lookbehinds and is robust to the current script style.

# this is generated.
# when I would have time, i would start to write it from scratch (not to look how the ai solved this)

# duration
# 7:50min with mobile data


pkg_file="$HOME/repo/env/scripts/progs"

# Temp files
pkgs_tmp=$(mktemp)
trap 'rm -f "$pkgs_tmp"' EXIT

# 1) Collect candidate package tokens from lines that contain $pfo/$pcfo or pacman/paru/yay invocations.
#    We cut everything up to the last occurrence of $pfo or $pcfo on the line, then print remaining fields.
awk '
  /\$pfo|\$pcfo|pacman[[:space:]]+-S|paru[[:space:]]|yay[[:space:]]/ {
    line=$0
    # Prefer the last $pfo/$pcfo marker if present (treat $ literally)
    p=index(line, "\$pfo ")
    q=index(line, "\$pcfo ")
    # awk index() returns 0 if not found
    cutpos=0
    if (p>0) cutpos=p+length("\$pfo ")-1
    if (q>0 && q>cutpos) cutpos=q+length("\$pcfo ")-1
    if (cutpos==0) {
      # fallback: after first occurrence of "pacman -S" or "paru"/"yay"
      m=match(line, /(pacman[[:space:]]+-S|paru[[:space:]]+-S|yay[[:space:]]+-S)/)
      if (m>0) cutpos=RSTART+RLENGTH
    }
    if (cutpos>0 && cutpos<=length(line)) {
      rest=substr(line, cutpos+1)
    } else {
      rest=line
    }
    # split rest into fields
    n=split(rest, a, /[[:space:]]+/)
    for (i=1;i<=n;i++) {
      t=a[i]
      # Filter out obvious non-package tokens
      if (t=="" || t ~ /^#/ || t ~ /^;/) continue
      if (t ~ /\$/) continue
      if (t ~ /\(|\)|\{|\}|\[|\]|\||&&|\\\\|=|:|;|<|>/) continue
      if (t ~ /^-/) continue
      if (t ~ /^[0-9]+$/) continue
      # common words/commands
      if (t ~ /^(sudo|pacman|paru|yay|echo|then|fi|for|do|done|cd|make|install|git|clone|default|stable)$/) continue
      # Only keep plausible package names
      if (t !~ /^[A-Za-z0-9][A-Za-z0-9._-]*[A-Za-z0-9]$/) continue
      print t
    }
  }
' "$pkg_file" | sort -u > "$pkgs_tmp"

printf "=== PACKAGE SOURCE CHECK ===\n\n"

pacman_count=0
aur_count=0
unknown_count=0

while IFS= read -r pkg; do
  if [[ -z "$pkg" ]]; then
    continue
  fi
  if pacman -Si "$pkg" &>/dev/null; then
    printf "[PACMAN] %s\n" "$pkg"
    ((pacman_count++))
  elif paru -Si "$pkg" &>/dev/null 2>&1; then
    printf "[AUR]    %s\n" "$pkg"
    ((aur_count++))
  else
    printf "[???]    %s (not found)\n" "$pkg"
    ((unknown_count++))
  fi
done < "$pkgs_tmp"

printf "\n=== SUMMARY ===\n"
printf "Official repos (pacman): %d\n" "$pacman_count"
printf "AUR:                     %d\n" "$aur_count"
printf "Unknown/Not found:       %d\n" "$unknown_count"
