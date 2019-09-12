From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 12 Sep 2019 22:46:39 +0200
Subject: [LTP] [PATCH] shell/tst_res: Return exit value
Message-ID: <20190912204639.1080-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

this is a preparation for route shell test v5.
Simple patch, hope there are no bad consequences,
side effects of this change.

return 1 after tst_res TCONF "'$cmd' not found"
in tst_check_cmds() could be now deleted,
but I kept it as it's more readable.

 testcases/lib/tst_test.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index e0b24c6b9..8ac5e35a2 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -93,6 +93,9 @@ _tst_inc_res()
 	esac
 }
 
+# exit code:
+# 0: TINFO, TPASS
+# 1: TBROK, TCONF, TFAIL, TWARN
 tst_res()
 {
 	local res=$1
@@ -106,6 +109,7 @@ tst_res()
 	printf "$TST_ID $TST_COUNT "
 	tst_print_colored $res "$res: "
 	echo "$@"
+	[ "$res" = TINFO -o "$res" = TPASS ]
 }
 
 tst_brk()
@@ -139,6 +143,7 @@ ROD()
 	fi
 }
 
+# exit code: 0 on TPASS, 1: TFAIL
 EXPECT_PASS()
 {
 	tst_rod "$@"
@@ -149,6 +154,7 @@ EXPECT_PASS()
 	fi
 }
 
+# exit code: 0 on TPASS, 1: TFAIL
 EXPECT_FAIL()
 {
 	# redirect stderr since we expect the command to fail
-- 
2.22.1

