From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Mon,  7 Jun 2021 15:14:20 +0100
Subject: [LTP] [PATCH v2 1/2] Add Coccinelle helper scripts for reference
Message-ID: <20210607141421.15072-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Check-in a couple of scripts used for removing the TEST macro from the
library. Also a shell script to show how to run them. These are only
intended to help someone develop their own refactoring scripts. Not
for running automatically.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---

V2:
* Simplify the Cocci scripts
* Simplify the patchset and combine it with the separate CGroups patch
* Testing & sign-off

Feel free to drop the Coccinelle scripts. However I do think they
should be included for people's information. I simplified them to
remove the Python code and make them easier to understand.

 .../coccinelle/libltp-test-macro-vars.cocci   |  19 ++++
 scripts/coccinelle/libltp-test-macro.cocci    | 104 ++++++++++++++++++
 scripts/coccinelle/run-spatch.sh              |  39 +++++++
 3 files changed, 162 insertions(+)
 create mode 100644 scripts/coccinelle/libltp-test-macro-vars.cocci
 create mode 100644 scripts/coccinelle/libltp-test-macro.cocci
 create mode 100755 scripts/coccinelle/run-spatch.sh

diff --git a/scripts/coccinelle/libltp-test-macro-vars.cocci b/scripts/coccinelle/libltp-test-macro-vars.cocci
new file mode 100644
index 000000000..c12bf3891
--- /dev/null
+++ b/scripts/coccinelle/libltp-test-macro-vars.cocci
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright (c) 2021 SUSE LLC  <rpalethorpe@suse.com>
+
+// The TEST macro should not be used in the library because it sets
+// TST_RET and TST_ERR which are global variables. The test author
+// only expects these to be changed if *they* call TEST directly.
+
+// Find all positions where TEST's variables are used
+@ find_use exists @
+identifier tst_var =~ "TST_(ERR|RET)";
+position p;
+expression E;
+@@
+
+(
+* tst_var@p
+|
+* TTERRNO@p | E
+)
diff --git a/scripts/coccinelle/libltp-test-macro.cocci b/scripts/coccinelle/libltp-test-macro.cocci
new file mode 100644
index 000000000..8855aaeb7
--- /dev/null
+++ b/scripts/coccinelle/libltp-test-macro.cocci
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright (c) 2021 SUSE LLC  <rpalethorpe@suse.com>
+
+// The TEST macro should not be used in the library because it sets
+// TST_RET and TST_ERR which are global variables. The test author
+// only expects these to be changed if *they* call TEST directly.
+
+// Set with -D fix
+virtual fix
+
+// Find all positions where TEST is _used_.
+@ find_use exists @
+position p;
+@@
+
+* TEST@p(...);
+
+// Below are rules which will create a patch to replace TEST usage
+// It assumes we can use the ret var without conflicts
+
+// Fix all references to the variables TEST modifies when they occur in a
+// function where TEST was used.
+@ depends on fix && find_use @
+@@
+
+(
+- TST_RET
++ ret
+|
+- TST_ERR
++ errno
+|
+- TTERRNO
++ TERRNO
+)
+
+// Replace TEST in all functions where it occurs only at the start. It
+// is slightly complicated by adding a newline if a statement appears
+// on the line after TEST(). It is not clear to me what the rules are
+// for matching whitespace as it has no semantic meaning, but this
+// appears to work.
+@ depends on fix @
+identifier fn;
+expression tested_expr;
+statement st;
+@@
+
+  fn (...)
+  {
+- 	TEST(tested_expr);
++	const long ret = tested_expr;
+(
++
+	st
+|
+
+)
+	... when != TEST(...)
+  }
+
+// Replace TEST in all functions where it occurs at the start
+// Functions where it *only* occurs at the start were handled above
+@ depends on fix @
+identifier fn;
+expression tested_expr;
+statement st;
+@@
+
+  fn (...)
+  {
+- 	TEST(tested_expr);
++	long ret = tested_expr;
+(
++
+	st
+|
+
+)
+	...
+  }
+
+// Add ret var at the start of a function where TEST occurs and there
+// is not already a ret declaration
+@ depends on fix exists @
+identifier fn;
+@@
+
+  fn (...)
+  {
++	long ret;
+	... when != long ret;
+
+	TEST(...)
+	...
+  }
+
+// Replace any remaining occurances of TEST
+@ depends on fix @
+expression tested_expr;
+@@
+
+- 	TEST(tested_expr);
++	ret = tested_expr;
+
diff --git a/scripts/coccinelle/run-spatch.sh b/scripts/coccinelle/run-spatch.sh
new file mode 100755
index 000000000..7bb781bc1
--- /dev/null
+++ b/scripts/coccinelle/run-spatch.sh
@@ -0,0 +1,39 @@
+#!/bin/sh -eu
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2021 SUSE LLC  <rpalethorpe@suse.com>
+
+# Helper for running spatch Coccinelle scripts on the LTP source tree
+
+if [[ ! -d lib || ! -d scripts/coccinelle ]]; then
+    echo "$0: Can't find lib or scripts directories. Run me from top src dir"
+    exit 1
+fi
+
+# Run a script on the lib dir
+libltp_spatch_report() {
+    spatch --dir lib \
+	   --ignore lib/parse_opts.c \
+	   --ignore lib/newlib_tests \
+	   --ignore lib/tests \
+	   --use-gitgrep \
+	   -D report \
+	   --include-headers \
+	   $*
+}
+
+libltp_spatch_fix() {
+    spatch --dir lib \
+	   --ignore lib/parse_opts.c \
+	   --ignore lib/newlib_tests \
+	   --ignore lib/tests \
+	   --use-gitgrep \
+	   --in-place \
+	   -D fix \
+	   --include-headers \
+	   $*
+}
+
+echo You should uncomment one of the scripts below!
+#libltp_spatch_report --sp-file scripts/coccinelle/libltp-test-macro.cocci
+#libltp_spatch_report --sp-file scripts/coccinelle/libltp-test-macro-vars.cocci \
+#		     --ignore lib/tst_test.c
-- 
2.31.1

