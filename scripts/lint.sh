#!/bin/bash

set -euo pipefail

cd .. && swiftlint --strict --config .swiftlint.yml .