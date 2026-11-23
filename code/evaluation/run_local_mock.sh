#!/usr/bin/env bash
# Fast local execution of SoftwareX unified 372-unit benchmark with deterministic CPU baseline
set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
python3 "${SCRIPT_DIR}/benchmark_unified.py" --provider mock "$@"
