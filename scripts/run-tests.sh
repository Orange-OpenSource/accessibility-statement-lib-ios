#!/bin/bash
# Software Name: accessibility-statement-lib-ios
# SPDX-FileCopyrightText: Copyright (c) Orange SA
# SPDX-License-Identifier: Apache-2.0
#
# This software is distributed under the Apache 2.0 license,
# the text of which is available at https://opensource.org/license/apache-2-0
# or see the "LICENSE" file for more details.

set -euo pipefail

cd .. 
swift build && swift test