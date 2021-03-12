From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 12 Mar 2021 18:32:00 +0100
Subject: [LTP] [PATCH 2/3] test: Adding timeout03.sh for testing
 _tst_kill_test()
In-Reply-To: <20210312173201.27708-1-pvorel@suse.cz>
References: <20210312173201.27708-1-pvorel@suse.cz>
Message-ID: <20210312173201.27708-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
new commit in this attempt

 lib/newlib_tests/shell/timeout03.sh | 47 +++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100755 lib/newlib_tests/shell/timeout03.sh

diff --git a/lib/newlib_tests/shell/timeout03.sh b/lib/newlib_tests/shell/timeout03.sh
new file mode 100755
index 000000000..89a4928b2
--- /dev/null
+++ b/lib/newlib_tests/shell/timeout03.sh
@@ -0,0 +1,47 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2021 Petr Vorel <pvorel@suse.cz>
+
+# testing shell timeout handling in _tst_kill_test()
+# expected output:
+# timeout03 1 TINFO: timeout per run is 0h 0m 1s
+# timeout03 1 TINFO: testing killing test after TST_TIMEOUT
+# timeout03 1 TBROK: Test timeouted, sending SIGTERM! If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1
+# timeout03 1 TBROK: test interrupted or timed out
+# timeout03 1 TPASS: test run cleanup after timeout
+# timeout03 1 TINFO: Test is still running, waiting 10s
+# timeout03 1 TINFO: Test is still running, waiting 9s
+# timeout03 1 TINFO: Test is still running, waiting 8s
+# timeout03 1 TINFO: Test is still running, waiting 7s
+# timeout03 1 TINFO: Test is still running, waiting 6s
+# timeout03 1 TINFO: Test is still running, waiting 5s
+# timeout03 1 TINFO: Test is still running, waiting 4s
+# timeout03 1 TINFO: Test is still running, waiting 3s
+# timeout03 1 TINFO: Test is still running, waiting 2s
+# timeout03 1 TINFO: Test is still running, waiting 1s
+# timeout03 1 TBROK: Test still running, sending SIGKILL
+# Killed
+
+TST_TESTFUNC=do_test
+TST_CLEANUP=cleanup
+
+TST_TIMEOUT=1
+. tst_test.sh
+
+do_test()
+{
+	tst_res TINFO "testing killing test after TST_TIMEOUT"
+
+	tst_sleep 2
+	tst_res TFAIL "test: running after TST_TIMEOUT"
+}
+
+cleanup()
+{
+	tst_res TPASS "test run cleanup after timeout"
+
+	tst_sleep 15 # must be higher than wait time in _tst_kill_test
+	tst_res TFAIL "cleanup: running after TST_TIMEOUT"
+}
+
+tst_run
-- 
2.30.1

