From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 11 Oct 2019 11:54:40 +0200
Subject: [LTP] [PATCH v5 3/5] shell: Add timeout shell API tests
In-Reply-To: <20191011095442.10541-1-pvorel@suse.cz>
References: <20191011095442.10541-1-pvorel@suse.cz>
Message-ID: <20191011095442.10541-4-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/newlib_tests/shell/test_timeout.sh | 36 ++++++++++++++++++++++++++
 lib/newlib_tests/shell/timeout01.sh    | 13 ++++++++++
 lib/newlib_tests/shell/timeout02.sh    | 13 ++++++++++
 3 files changed, 62 insertions(+)
 create mode 100755 lib/newlib_tests/shell/test_timeout.sh
 create mode 100755 lib/newlib_tests/shell/timeout01.sh
 create mode 100755 lib/newlib_tests/shell/timeout02.sh

diff --git a/lib/newlib_tests/shell/test_timeout.sh b/lib/newlib_tests/shell/test_timeout.sh
new file mode 100755
index 000000000..2cbc66412
--- /dev/null
+++ b/lib/newlib_tests/shell/test_timeout.sh
@@ -0,0 +1,36 @@
+#!/bin/sh
+
+PATH="$(dirname $0)/../../../testcases/lib/:$PATH"
+
+DATA="
+timeout01.sh||0
+timeout02.sh||0
+timeout02.sh|foo|32
+timeout02.sh|2|0
+timeout02.sh|1.1|0
+timeout02.sh|-10|32
+"
+
+echo "Testing timeout in shell API"
+echo
+
+failed=0
+for i in $DATA; do
+	file=$(echo $i | cut -d'|' -f1)
+	timeout=$(echo $i | cut -d'|' -f2)
+	exp_exit=$(echo $i | cut -d'|' -f3)
+
+	echo "=== $test (LTP_TIMEOUT_MUL='$timeout') ==="
+	LTP_TIMEOUT_MUL=$timeout ./$file
+	ret=$?
+	if [ $ret -ne $exp_exit ]; then
+		echo "FAILED (exit code: $ret, expected $exp_exit)"
+		failed=$((failed+1))
+	else
+		echo "PASSED"
+	fi
+	echo
+done
+
+echo "Failed tests: $failed"
+exit $failed
diff --git a/lib/newlib_tests/shell/timeout01.sh b/lib/newlib_tests/shell/timeout01.sh
new file mode 100755
index 000000000..ab7428a2d
--- /dev/null
+++ b/lib/newlib_tests/shell/timeout01.sh
@@ -0,0 +1,13 @@
+#!/bin/sh
+
+TST_TESTFUNC=do_test
+
+TST_TIMEOUT=-1
+. tst_test.sh
+
+do_test()
+{
+	tst_res TPASS "timeout $TST_TIMEOUT set"
+}
+
+tst_run
diff --git a/lib/newlib_tests/shell/timeout02.sh b/lib/newlib_tests/shell/timeout02.sh
new file mode 100755
index 000000000..73af09125
--- /dev/null
+++ b/lib/newlib_tests/shell/timeout02.sh
@@ -0,0 +1,13 @@
+#!/bin/sh
+
+TST_TESTFUNC=do_test
+
+TST_TIMEOUT=2
+. tst_test.sh
+
+do_test()
+{
+	tst_res TPASS "timeout $TST_TIMEOUT set (LTP_TIMEOUT_MUL='$LTP_TIMEOUT_MUL')"
+}
+
+tst_run
-- 
2.23.0

