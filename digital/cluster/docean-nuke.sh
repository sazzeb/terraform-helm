#!/usr/bin/env bash
set -euo pipefail

echo "🚀 Starting full DigitalOcean cleanup…"

# Kubernetes clusters
echo "- Deleting Kubernetes clusters"
while read -r id; do
  [[ -z $id ]] && break
  echo "  • $id"
  doctl kubernetes cluster delete "$id" --force
done < <(doctl kubernetes cluster list --format ID --no-header)

# Droplets
echo "- Deleting Droplets"
while read -r id; do
  [[ -z $id ]] && break
  echo "  • $id"
  doctl compute droplet delete "$id" --force
done < <(doctl compute droplet list --format ID --no-header)

# Volumes
echo "- Deleting Volumes"
while read -r id; do
  [[ -z $id ]] && break
  echo "  • $id"
  doctl compute volume delete "$id" --force
done < <(doctl compute volume list --format ID --no-header)

echo "✅ All resources deleted."
