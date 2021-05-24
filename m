From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Mon, 24 May 2021 15:47:43 +0100
Subject: [LTP] [RFC PATCH 2/4] Add script to run Coccinelle checks
In-Reply-To: <20210524144745.10887-1-rpalethorpe@suse.com>
References: <20210524144745.10887-1-rpalethorpe@suse.com>
Message-ID: <20210524144745.10887-3-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

---
 scripts/coccinelle/libltp_checks.sh | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100755 scripts/coccinelle/libltp_checks.sh

diff --git a/scripts/coccinelle/libltp_checks.sh b/scripts/coccinelle/libltp_checks.sh
new file mode 100755
index 000000000..6fdaa7ae8
--- /dev/null
+++ b/scripts/coccinelle/libltp_checks.sh
@@ -0,0 +1,29 @@
+#!/bin/sh -eu
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2021 SUSE LLC  <rpalethorpe@suse.com>
+
+# Run the Coccinelle checks for the library. Running the fixes
+# requires passing -D fix instead of -D report.
+
+if [[ ! -d lib || ! -d scripts/coccinelle ]]; then
+    echo "$0: Can't find lib or scripts directories. Run me from top src dir"
+    exit 1
+fi
+
+echo Python args ${COCCI_PYTHON:=--python python3} >&2
+
+libltp_spatch() {
+    spatch $COCCI_PYTHON --dir lib \
+	   --ignore lib/parse_opts.c \
+	   --ignore lib/newlib_tests \
+	   --ignore lib/tests \
+	   --very-quiet \
+	   --use-gitgrep \
+	   -D report \
+	   --include-headers \
+	   $*
+}
+
+libltp_spatch --sp-file scripts/coccinelle/libltp-test-macro.cocci
+libltp_spatch --sp-file scripts/coccinelle/libltp-test-macro-vars.cocci \
+	      --ignore lib/tst_test.c
-- 
2.31.1

