#!/data/data/com.termux/files/usr/bin/bash

while IFS= read -r url; do
  [ -z "$url" ] && continue

  name=$(basename "${url%%\?*}")

  if find assets -type f -iname "$name" | grep -q .; then
    echo "SKIP (already exists): $name"
    continue
  fi

  echo "DOWNLOAD: $name"

  curl -fLsS --retry 2 \
    -A "Mozilla/5.0" \
    -e "https://www.ciaoenergy.com/" \
    -o "missing-assets/$name" "$url" \
    || {
      echo "FAILED: $name"
      rm -f "missing-assets/$name"
    }

done < missing-urls.txt
