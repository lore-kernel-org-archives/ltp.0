From: Caspar Zhang <caspar@linux.alibaba.com>
Date: Thu, 30 May 2019 17:09:58 +0800
Subject: [LTP] [PATCH 3/3] tst_test.sh,
	test.sh: report pass if both TPASS and TCONF exist in shell test
In-Reply-To: <f11c83459b71fbf399794fb8363f2b538b0b6346.1559207183.git.caspar@casparzhang.com>
References: <f11c83459b71fbf399794fb8363f2b538b0b6346.1559207183.git.caspar@casparzhang.com>
Message-ID: <1985f9e48c4557c2ec52eded11d08f3b7b514962.1559207183.git.caspar@casparzhang.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We don't want the test reporting TCONF if at least one TPASS existed
during testing. And this is also true in shell tests. So fix it.

Signed-off-by: Caspar Zhang <caspar@linux.alibaba.com>
---
 testcases/lib/test.sh     | 9 +++++++++
 testcases/lib/tst_test.sh | 2 +-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/testcases/lib/test.sh b/testcases/lib/test.sh
index ade8fcdff..7cc3bb2fe 100644
--- a/testcases/lib/test.sh
+++ b/testcases/lib/test.sh
@@ -23,6 +23,7 @@
 
 export LTP_RET_VAL=0
 export TST_COUNT=1
+export TST_PASS_COUNT=0
 export TST_LIB_LOADED=1
 export TST_TMPDIR_RHOST=0
 
@@ -60,6 +61,10 @@ tst_resm()
 	case "$ret" in
 	TPASS|TFAIL|TCONF) TST_COUNT=$((TST_COUNT+1));;
 	esac
+
+	if [ "$ret" = TPASS ]; then
+		TST_PASS_COUNT=$((TST_PASS_COUNT+1))
+	fi
 }
 
 tst_brkm()
@@ -111,6 +116,10 @@ tst_exit()
 		rm -f "$LTP_IPC_PATH"
 	fi
 
+	# Mask out TCONF if no TFAIL/TBROK/TWARN but has TPASS
+	if [ $((LTP_RET_VAL & 7)) -eq 0 -a $TST_PASS_COUNT -gt 0 ]; then
+		LTP_RET_VAL=$((LTP_RET_VAL & ~32))
+	fi
 	# Mask out TINFO
 	exit $((LTP_RET_VAL & ~16))
 }
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 512732315..bf725fdde 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -78,7 +78,7 @@ _tst_do_exit()
 		ret=$((ret|4))
 	fi
 
-	if [ $TST_CONF -gt 0 ]; then
+	if [ $TST_CONF -gt 0 -a $TST_PASS -eq 0 ]; then
 		ret=$((ret|32))
 	fi
 
-- 
2.21.0

