From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 17 Dec 2020 15:44:23 +0100
Subject: [LTP] [PATCH v4 2/3] tst_test.sh: Warn on missing cleanup function
In-Reply-To: <20201217144424.19414-1-pvorel@suse.cz>
References: <20201217144424.19414-1-pvorel@suse.cz>
Message-ID: <20201217144424.19414-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

.i.e. be more informative than:
/opt/ltp/testcases/bin/tst_test.sh: line 33: cleanup: command not found

tst_brk does not make sense here, thus only warning.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_test.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index c205bc91b..dbf1d2a97 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -29,7 +29,11 @@ _tst_do_exit()
 	TST_DO_EXIT=1
 
 	if [ -n "$TST_RUN_STARTED" -a -n "$TST_CLEANUP" -a -z "$TST_NO_CLEANUP" ]; then
-		$TST_CLEANUP
+		if type $TST_CLEANUP >/dev/null 2>/dev/null; then
+			$TST_CLEANUP
+		else
+			tst_res TWARN "TST_CLEANUP=$TST_CLEANUP declared, but function not defined (or cmd not found)"
+		fi
 	fi
 
 	if [ "$TST_NEEDS_DEVICE" = 1 -a "$TST_DEVICE_FLAG" = 1 ]; then
-- 
2.29.2

