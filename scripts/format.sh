#!/bin/bash
# Software Name: accessibility-statement-lib-ios
# SPDX-FileCopyrightText: Copyright (c) Orange SA
# SPDX-License-Identifier: Apache-2.0
#
# This software is distributed under the Apache 2.0 license,
# the text of which is available at https://opensource.org/license/apache-2-0
# or see the "LICENSE" file for more details.

set -euo pipefail

# Template for sources
template=$'\n// Software Name: accessibility-statement-lib-ios\n// SPDX-FileCopyrightText: Copyright (c) Orange SA\n// SPDX-License-Identifier: Apache-2.0\n//\n// This software is distributed under the Apache 2.0 license,\n// the text of which is available at https://opensource.org/license/apache-2-0\n// or see the "LICENSE" file for more details.\n'

# Exécution de swiftformat avec le header
cd .. && swiftformat . --header "$template"
