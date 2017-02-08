From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed,  8 Feb 2017 12:02:54 +0100
Subject: [LTP] [PATCH 5/6] tst_test.sh: Make use of tst_device helper
In-Reply-To: <20170208110255.443-1-chrubis@suse.cz>
References: <20170208110255.443-1-chrubis@suse.cz>
Message-ID: <20170208110255.443-5-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/lib/tst_test.sh | 31 +++++--------------------------
 1 file changed, 5 insertions(+), 26 deletions(-)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index b9ac938..087adda 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -41,12 +41,8 @@ tst_do_exit()
 	fi
 
 	if [ "$TST_NEEDS_DEVICE" = 1 -a "$TST_DEVICE_FLAG" = 1 ]; then
-		losetup -a | grep -q "$TST_DEVICE"
-		if [ $? -eq 0 ]; then
-			losetup -d "$TST_DEVICE"
-			if [ $? -ne 0 ]; then
-				tst_res TWARN "'losetup -d $TST_DEVICE' failed"
-			fi
+		if ! tst_device release "$TST_DEVICE"; then
+			tst_res TWARN "Failed to release device '$TST_DEVICE'"
 		fi
 	fi
 
@@ -309,29 +305,12 @@ tst_run()
 			tst_brk "Use TST_NEEDS_TMPDIR must be set for TST_NEEDS_DEVICE"
 		fi
 
-		if [ -n "${LTP_DEV}" ]; then
-			tst_res TINFO "Using test device LTP_DEV='${LTP_DEV}'"
-			if [ ! -b ${LTP_DEV} ]; then
-				tst_brkm TBROK "${LTP_DEV} is not a block device"
-			fi
-
-			ROD_SILENT dd if=/dev/zero of="${LTP_DEV}" bs=1024 count=512
-
-			TST_DEVICE=${LTP_DEV}
-			TST_DEVICE_FLAG=0
-			return
-		fi
-
-		ROD_SILENT dd if=/dev/zero of=test_dev.img bs=1024 count=153600
+		TST_DEVICE=$(tst_device acquire)
 
-		TST_DEVICE=$(losetup -f)
-		if [ $? -ne 0 ]; then
-			tst_brk TBROK "Couldn't find free loop device"
+		if [ -z "$TST_DEVICE" ]; then
+			tst_brk "Failed to acquire device"
 		fi
 
-		tst_res TINFO "Found free device '${TST_DEVICE}'"
-
-		ROD_SILENT losetup ${TST_DEVICE} test_dev.img
 		TST_DEVICE_FLAG=1
 	fi
 
-- 
2.10.2

