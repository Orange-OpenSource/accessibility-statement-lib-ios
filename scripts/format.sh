#!/bin/bash

set -euo pipefail

# Template for sources
template=$'\nSoftware Name: accessibility-statement-lib-ios\nSPDX-FileCopyrightText: Copyright (c) Orange SA\nSPDX-License-Identifier: Apache-2.0\n\nThis software is distributed under the Apache 2.0 license,\nthe text of which is available at https://opensource.org/license/apache-2-0\nor see the "LICENSE" file for more details.\n'

# Exécution de swiftformat avec le header
cd .. && swiftformat . --header "$template"
