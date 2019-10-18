From: Clemens Famulla-Conrad <cfamullaconrad@suse.de>
Date: Fri, 18 Oct 2019 14:45:01 +0200
Subject: [LTP] [PATCH v4 4/5] Add newlib shell test for
 tst_multiply_timeout()
In-Reply-To: <20191018124502.25599-1-cfamullaconrad@suse.de>
References: <20191018124502.25599-1-cfamullaconrad@suse.de>
Message-ID: <20191018124502.25599-5-cfamullaconrad@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Simple test for different kinds of calls from tst_multiply_timeout()
---
 lib/newlib_tests/shell/test_timeout_mul.sh | 43 ++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100755 lib/newlib_tests/shell/test_timeout_mul.sh

diff --git a/lib/newlib_tests/shell/test_timeout_mul.sh b/lib/newlib_tests/shell/test_timeout_mul.sh
new file mode 100755
index 000000000..6682e5d66
--- /dev/null
+++ b/lib/newlib_tests/shell/test_timeout_mul.sh
@@ -0,0 +1,43 @@
+#!/bin/sh
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
+	eval "exp_value=\$$2"
+	if [ "$exp_value" -ne "$3" ]; then
+		tst_brk TBROK "LTP_TIMEOUT_MUL=$SAVE_MUL $1 ($exp_value != $3)"
+	else
+		tst_res TPASS "LTP_TIMEOUT_MUL=$SAVE_MUL $1 ($exp_value == $3)"
+	fi
+}
+
+do_test()
+{
+	LTP_TIMEOUT_MUL=2
+	local sec=1
+
+	call_it 'tst_multiply_timeout sec' 'sec' 2
+
+	sec=1
+	LTP_TIMEOUT_MUL="1.5"
+	call_it 'tst_multiply_timeout sec' 'sec' 2
+
+	sec=1
+	LTP_TIMEOUT_MUL=0.5
+	call_it 'tst_multiply_timeout sec' 'sec' 1
+
+	sec=1
+	LTP_TIMEOUT_MUL=2
+	call_it 'tst_multiply_timeout sec' 'sec' 2
+	call_it 'tst_multiply_timeout sec' 'sec' 4
+	call_it 'tst_multiply_timeout sec' 'sec' 8
+}
+
+tst_run
-- 
2.16.4

