From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 29 Jan 2021 13:18:16 +0100
Subject: [LTP] [PATCH 4/5] zram: Move zram_compress_alg() to zram02.sh
In-Reply-To: <20210129121817.12563-1-pvorel@suse.cz>
References: <20210129121817.12563-1-pvorel@suse.cz>
Message-ID: <20210129121817.12563-5-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Quit at setup in case there is no fs support (change in previous commit)
can lead to skipping zram_compress_alg(). Move to zram02.sh where is no
such limitation.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/device-drivers/zram/zram01.sh | 13 ++++++-------
 testcases/kernel/device-drivers/zram/zram02.sh | 11 ++++++-----
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/testcases/kernel/device-drivers/zram/zram01.sh b/testcases/kernel/device-drivers/zram/zram01.sh
index ef4ff4d75..bb1532c1e 100755
--- a/testcases/kernel/device-drivers/zram/zram01.sh
+++ b/testcases/kernel/device-drivers/zram/zram01.sh
@@ -6,7 +6,7 @@
 # Test creates several zram devices with different filesystems on them.
 # It fills each device with zeros and checks that compression works.
 
-TST_CNT=7
+TST_CNT=6
 TST_TESTFUNC="do_test"
 TST_NEEDS_CMDS="awk bc dd"
 . zram_lib.sh
@@ -120,12 +120,11 @@ do_test()
 {
 	case $1 in
 	 1) zram_max_streams;;
-	 2) zram_compress_alg;;
-	 3) zram_set_disksizes;;
-	 4) zram_set_memlimit;;
-	 5) zram_makefs;;
-	 6) zram_mount;;
-	 7) zram_fill_fs;;
+	 2) zram_set_disksizes;;
+	 3) zram_set_memlimit;;
+	 4) zram_makefs;;
+	 5) zram_mount;;
+	 6) zram_fill_fs;;
 	esac
 }
 
diff --git a/testcases/kernel/device-drivers/zram/zram02.sh b/testcases/kernel/device-drivers/zram/zram02.sh
index b4d706568..d09977ec1 100755
--- a/testcases/kernel/device-drivers/zram/zram02.sh
+++ b/testcases/kernel/device-drivers/zram/zram02.sh
@@ -5,7 +5,7 @@
 #
 # Test checks that we can create swap zram device.
 
-TST_CNT=5
+TST_CNT=6
 TST_TESTFUNC="do_test"
 . zram_lib.sh
 
@@ -27,10 +27,11 @@ do_test()
 {
 	case $1 in
 	 1) zram_max_streams;;
-	 2) zram_set_disksizes;;
-	 3) zram_set_memlimit;;
-	 4) zram_makeswap;;
-	 5) zram_swapoff;;
+	 2) zram_compress_alg;;
+	 3) zram_set_disksizes;;
+	 4) zram_set_memlimit;;
+	 5) zram_makeswap;;
+	 6) zram_swapoff;;
 	esac
 }
 
-- 
2.30.0

