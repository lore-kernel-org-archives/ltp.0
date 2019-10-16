From: Clemens Famulla-Conrad <cfamullaconrad@suse.de>
Date: Wed, 16 Oct 2019 18:15:19 +0200
Subject: [LTP] [PATCH v3 4/4] Add newlib shell test for
 tst_multiply_timeout()
In-Reply-To: <20191016161519.11256-1-cfamullaconrad@suse.de>
References: <1571225126.8494.1.camel@suse.de>
 <20191016161519.11256-1-cfamullaconrad@suse.de>
Message-ID: <20191016161519.11256-4-cfamullaconrad@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Simple test for different kinds of calls from tst_multiply_timeout()
---
 lib/newlib_tests/shell/test_timeout_mul.sh | 54 ++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100755 lib/newlib_tests/shell/test_timeout_mul.sh

diff --git a/lib/newlib_tests/shell/test_timeout_mul.sh b/lib/newlib_tests/shell/test_timeout_mul.sh
new file mode 100755
index 000000000..8397df25c
--- /dev/null
+++ b/lib/newlib_tests/shell/test_timeout_mul.sh
@@ -0,0 +1,54 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2019 Clemens Famulla-Conrad <cfamullaconrad@suse.de>
+
+TST_TESTFUNC=do_test
+. tst_test.sh
+
+
+call_it()
+{
+	local SAVE_MUL=${LTP_TIMEOUT_MUL}
+	$1
+	if [ "${!2}" -ne "$3" ]; then
+		tst_brk TBROK "LTP_TIMEOUT_MUL=$SAVE_MUL $1 (${!2} != $3)"
+	else
+		tst_res TPASS "LTP_TIMEOUT_MUL=$SAVE_MUL $1 (${!2} == $3)"
+	fi
+}
+
+do_test()
+{
+	LTP_TIMEOUT_MUL=2
+	local sec=1
+
+        call_it 'tst_multiply_timeout sec' 'sec' 2
+        call_it 'tst_multiply_timeout foo 1000' 'foo' 2000
+
+	sec=1
+        call_it 'tst_multiply_timeout sec 500' 'sec' 1000
+
+	sec=1
+	LTP_TIMEOUT_MUL="1.5"
+        call_it 'tst_multiply_timeout sec' 'sec' 2
+
+	sec=1
+	LTP_TIMEOUT_MUL=0.5
+        call_it 'tst_multiply_timeout sec' 'sec' 1
+
+	sec=1
+	LTP_TIMEOUT_MUL=1.5
+        call_it 'tst_multiply_timeout sec 5' 'sec' 10
+
+	sec=1
+	LTP_TIMEOUT_MUL=0.5
+        call_it 'tst_multiply_timeout sec 5' 'sec' 5
+
+	sec=1
+	LTP_TIMEOUT_MUL=2
+        call_it 'tst_multiply_timeout sec' 'sec' 2
+        call_it 'tst_multiply_timeout sec' 'sec' 4
+        call_it 'tst_multiply_timeout sec' 'sec' 8
+}
+
+tst_run;
-- 
2.16.4

