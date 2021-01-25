From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 25 Jan 2021 19:06:30 +0100
Subject: [LTP] [PATCH v2 1/1] lib: Add test for tst_check_driver()
Message-ID: <20210125180630.15163-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Test for 8f7013ba6.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi Cyril,

thanks for previous review. I modified the test more thus sending v2.

Changes v1-v2:
* Check two version of module (using '_' and '-' also on built-in
  modules) => more coverage.
* Fix test when $MODULES_DIR exists, but does not contain modules
(in v1 it TBROK: Test didn't report any results), now at least check non-existing module:

Kind regards,
Petr

tst_check_driver 1 TINFO: timeout per run is 0h 5m 0s
tst_check_driver 1 TINFO: using modules directory '/tmp/xx'
tst_check_driver 1 TINFO: check loadable module detection
tst_check_driver 1 TCONF: no modules found
tst_check_driver 2 TINFO: check non-existing module detection
tst_check_driver 2 TPASS: tst_check_drivers not-existing-kernel-module failed as expected
tst_check_driver 3 TINFO: check built-in module detection
tst_check_driver 3 TCONF: missing '/tmp/xx/modules.builtin'

Kind regards,
Petr

 lib/newlib_tests/shell/tst_check_driver.sh | 63 ++++++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100755 lib/newlib_tests/shell/tst_check_driver.sh

diff --git a/lib/newlib_tests/shell/tst_check_driver.sh b/lib/newlib_tests/shell/tst_check_driver.sh
new file mode 100755
index 000000000..b1418ef8e
--- /dev/null
+++ b/lib/newlib_tests/shell/tst_check_driver.sh
@@ -0,0 +1,63 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2021 Petr Vorel <pvorel@suse.cz>
+
+TST_TESTFUNC=test
+TST_SETUP=setup
+TST_CNT=3
+TST_NEEDS_CMDS="tst_check_drivers find grep head sed"
+. tst_test.sh
+
+MODULES_DIR="${MODULES_DIR:-/lib/modules/$(uname -r)}"
+
+setup()
+{
+	tst_res TINFO "using modules directory '$MODULES_DIR'"
+
+	[ -d "$MODULES_DIR" ] || \
+		tst_brk TCONF "modules directory '$MODULES_DIR' missing"
+}
+
+test_drivers()
+{
+	local paths="$@"
+	local drv
+
+	if [ -z "$paths" ]; then
+		tst_res TCONF "no modules found"
+		return
+	fi
+
+	for drv in $paths; do
+		drv="$(echo $drv | sed 's/.*\/\([^/]\+\)\.ko.*/\1/')"
+		EXPECT_PASS tst_check_drivers $drv
+		drv="$(echo $drv | sed 's/_/-/g')"
+		EXPECT_PASS tst_check_drivers $drv
+	done
+}
+
+test1()
+{
+	tst_res TINFO "check loadable module detection"
+	test_drivers $(find $MODULES_DIR | grep -E '_[^/]+\.ko' | head -3)
+}
+
+test2()
+{
+	tst_res TINFO "check non-existing module detection"
+	EXPECT_FAIL tst_check_drivers not-existing-kernel-module
+}
+
+test3()
+{
+	local f="$MODULES_DIR/modules.builtin"
+
+	tst_res TINFO "check built-in module detection"
+
+	[ -f "$f" ] || \
+		tst_brk TCONF "missing '$f'"
+
+	test_drivers $(grep -E '_[^/]+\.ko' $f | head -3)
+}
+
+tst_run
-- 
2.30.0

