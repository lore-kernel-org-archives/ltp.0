From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 12 Feb 2018 15:08:18 +0100
Subject: [LTP] [COMMITTED] [PATCH] tst_test.sh: Add missing TBROK
Message-ID: <20180212140818.19234-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/lib/tst_test.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 249b05456..d6b638549 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -304,13 +304,13 @@ tst_run()
 
 	if [ "$TST_NEEDS_DEVICE" = 1 ]; then
 		if [ -z ${TST_TMPDIR} ]; then
-			tst_brk "Use TST_NEEDS_TMPDIR must be set for TST_NEEDS_DEVICE"
+			tst_brk TBROK "Use TST_NEEDS_TMPDIR must be set for TST_NEEDS_DEVICE"
 		fi
 
 		TST_DEVICE=$(tst_device acquire)
 
 		if [ -z "$TST_DEVICE" ]; then
-			tst_brk "Failed to acquire device"
+			tst_brk TBROK "Failed to acquire device"
 		fi
 
 		TST_DEVICE_FLAG=1
-- 
2.13.6

