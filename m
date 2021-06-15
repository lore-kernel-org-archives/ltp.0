From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Tue, 15 Jun 2021 08:40:43 +0100
Subject: [LTP] [PATCH v4 1/3] Add Coccinelle helper scripts for reference
Message-ID: <20210615074045.23974-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Check-in a couple of semantic patches used for removing the TEST macro
from the library. Also include a shell script to run them with a
working set of arguments.

These are only intended to help someone develop their own refactoring
or check scripts. Not for running automatically.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---

V4:
* Break rtnetlink/netdevice into separate patch and save errno

V3:
* Make proper shell script to run spatch
* Fix some issues people would likely encounter with semantic patches

V2:
* Simplify the Cocci scripts
* Simplify the patchset and combine it with the separate CGroups patch
* Testing & sign-off

 .../coccinelle/libltp-test-macro-vars.cocci   |  19 ++++
 scripts/coccinelle/libltp-test-macro.cocci    | 107 ++++++++++++++++++
 scripts/coccinelle/run-spatch.sh              | 106 +++++++++++++++++
 3 files changed, 232 insertions(+)
 create mode 100644 scripts/coccinelle/libltp-test-macro-vars.cocci
 create mode 100644 scripts/coccinelle/libltp-test-macro.cocci
 create mode 100755 scripts/coccinelle/run-spatch.sh

diff --git a/scripts/coccinelle/libltp-test-macro-vars.cocci b/scripts/coccinelle/libltp-test-macro-vars.cocci
new file mode 100644
index 000000000..ed5459a48
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
+expression E;
+@@
+
+(
+* TST_ERR
+|
+* TST_RET
+|
+* TTERRNO | E
+)
diff --git a/scripts/coccinelle/libltp-test-macro.cocci b/scripts/coccinelle/libltp-test-macro.cocci
new file mode 100644
index 000000000..7563d23aa
--- /dev/null
+++ b/scripts/coccinelle/libltp-test-macro.cocci
@@ -0,0 +1,107 @@
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
+@ depends on !fix exists @
+@@
+
+* TEST(...);
+
+// Below are rules which will create a patch to replace TEST usage
+// It assumes we can use the ret var without conflicts
+
+// Fix all references to the variables TEST modifies when they occur in a
+// function where TEST was used.
+@ depends on fix exists @
+@@
+
+ TEST(...)
+
+ ...
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
+// Replace any remaining occurrences of TEST
+@ depends on fix @
+expression tested_expr;
+@@
+
+- 	TEST(tested_expr);
++	ret = tested_expr;
+
diff --git a/scripts/coccinelle/run-spatch.sh b/scripts/coccinelle/run-spatch.sh
new file mode 100755
index 000000000..e8e6f47d8
--- /dev/null
+++ b/scripts/coccinelle/run-spatch.sh
@@ -0,0 +1,106 @@
+#!/bin/sh -eu
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2021 SUSE LLC  <rpalethorpe@suse.com>
+
+# Helper for running spatch Coccinelle scripts on the LTP source tree
+
+if [ ! -d lib ] || [ ! -d scripts/coccinelle ]; then
+    echo "$0: Can't find lib or scripts directories. Run me from top src dir"
+    exit 1
+fi
+
+do_fix=no
+
+# Run a script on the lib dir
+libltp_spatch() {
+    echo libltp_spatch $*
+
+    if [ $do_fix = yes ]; then
+	spatch --dir lib \
+	       --ignore lib/parse_opts.c \
+	       --ignore lib/newlib_tests \
+	       --ignore lib/tests \
+	       --use-gitgrep \
+	       --in-place \
+	       -D fix \
+	       --include-headers \
+	       $*
+    else
+	spatch --dir lib \
+	       --ignore lib/parse_opts.c \
+	       --ignore lib/newlib_tests \
+	       --ignore lib/tests \
+	       --use-gitgrep \
+	       --include-headers \
+	       $*
+    fi
+}
+
+tests_spatch() {
+        echo tests_spatch $*
+
+        if [ $do_fix = yes ]; then
+	    spatch --dir testcases \
+		   --use-gitgrep \
+		   --in-place \
+		   -D fix \
+		   --include-headers \
+		   $*
+	else
+	    spatch --dir testcases \
+		   --use-gitgrep \
+		   --include-headers \
+		   $*
+	fi
+}
+
+usage()
+{
+    cat <<EOF
+Usage:
+$0 [ -f ] <patch basename> [ <patch basename> [...] ]
+$0 -h
+
+Options:
+-f	Apply the semantic patch in-place to fix the code
+-h	You are reading it
+
+If run without -f then the semantic patch will only print locations
+where it matches or show a diff.
+
+EOF
+}
+
+while getopts "fh" opt; do
+    case $opt in
+	f) do_fix=yes;;
+	h|?) usage; exit $([ $opt = h ]);;
+    esac
+done
+
+shift $(($OPTIND - 1))
+
+if [ $# -eq 0 ]; then
+    echo -e "Missing semantic patch name \n"
+    usage; exit 1
+fi
+
+if [ $do_fix = yes ] && [ -n "$(git ls-files -m -d)" ]; then
+    echo "At least stage your current changes!"
+    exit 1
+fi
+
+for spatch_file in $*; do
+    case $spatch_file in
+	libltp-test-macro)
+	    libltp_spatch --sp-file scripts/coccinelle/libltp-test-macro.cocci;;
+	libltp-test-macro-vars)
+	    libltp_spatch --sp-file scripts/coccinelle/libltp-test-macro-vars.cocci \
+			  --ignore lib/tst_test.c;;
+	*)
+	    tests_spatch --sp-file scripts/coccinelle/$spatch_file.cocci;;
+    esac
+done
+
+
+
-- 
2.31.1

