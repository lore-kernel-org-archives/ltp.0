From: Petr Vorel <pvorel@suse.cz>
Date: Mon,  1 Mar 2021 23:02:18 +0100
Subject: [LTP] [PATCH 3/7] zram: Add zram_compress_alg() to zram02.sh
In-Reply-To: <20210301220222.22705-1-pvorel@suse.cz>
References: <20210301220222.22705-1-pvorel@suse.cz>
Message-ID: <20210301220222.22705-4-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Quit at setup in case there is no fs support (change in previous commit)
can lead to skipping zram_compress_alg(). Add it to zram02.sh where is no
such limitation and still keep it in zram01.sh since the tests
do depend on each other, the zram_fill_fs actually checks compression
ration, which only makes sense if compression is enabled.

Reviewed-by: Li Wang <liwang@redhat.com>
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v2->v3:
* keep zram_compress_alg() also in zram01.sh (Cyril)

 testcases/kernel/device-drivers/zram/zram02.sh | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

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
2.30.1

