#!/bin/sh
HTML=$(curl -sf --max-time 30 https://layoffs.fyi)
if [ $? -ne 0 ]; then
    echo "[WARN] Failed to fetch layoffs.fyi, skipping render"
    exit 0
fi

COUNTS=$(echo "$HTML" | node -e "
let html = '';
process.stdin.on('data', d => html += d);
process.stdin.on('end', () => {
  const year = new Date().getFullYear();
  const start = html.indexOf(`id="numbers${year}"`);
  const section = html.slice(start, start + 5000);
  const matches = [...section.matchAll(/class=\"[^\"]*big-number[^\"]*\">([^<]+)/g)];
  console.log((matches[0]?.[1] || 'N/A').trim());
  console.log((matches[1]?.[1] || 'N/A').trim());
});
")

EMPLOYEE_COUNT=$(echo "$COUNTS" | sed -n '1p')
COMPANY_COUNT=$(echo "$COUNTS" | sed -n '2p')

pixlet render /app/layoffs.star \
    employee_count="$EMPLOYEE_COUNT" \
    company_count="$COMPANY_COUNT" && \
pixlet push "$TIDBYT_DEVICE_ID" /app/layoffs.webp --api-token "$TIDBYT_API_TOKEN"
