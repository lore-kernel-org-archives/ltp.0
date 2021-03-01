From: Petr Vorel <pvorel@suse.cz>
Date: Mon,  1 Mar 2021 23:02:19 +0100
Subject: [LTP] [PATCH 4/7] zram: Move test specific functions out of
 zram_lib.sh
In-Reply-To: <20210301220222.22705-1-pvorel@suse.cz>
References: <20210301220222.22705-1-pvorel@suse.cz>
Message-ID: <20210301220222.22705-5-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Refactoring, as code is confusing enough, when use global variables and
functions which are single test specific + there is zram_fill_fs already
in zram01.sh.

Reviewed-by: Li Wang <liwang@redhat.com>
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v2->v3:
* keep zram_compress_alg() here due it's use in zram01.sh (Cyril)

 .../kernel/device-drivers/zram/zram01.sh      | 33 ++++++++++
 .../kernel/device-drivers/zram/zram02.sh      | 29 +++++++++
 .../kernel/device-drivers/zram/zram_lib.sh    | 62 -------------------
 3 files changed, 62 insertions(+), 62 deletions(-)

diff --git a/testcases/kernel/device-drivers/zram/zram01.sh b/testcases/kernel/device-drivers/zram/zram01.sh
index 54f7d0ebd..6dce89325 100755
--- a/testcases/kernel/device-drivers/zram/zram01.sh
+++ b/testcases/kernel/device-drivers/zram/zram01.sh
@@ -66,6 +66,39 @@ setup()
 	zram_load
 }
 
+zram_makefs()
+{
+	local i=0
+	local fs
+
+	for fs in $zram_filesystems; do
+		tst_res TINFO "make $fs filesystem on /dev/zram$i"
+		mkfs.$fs /dev/zram$i > err.log 2>&1
+		if [ $? -ne 0 ]; then
+			cat err.log
+			tst_brk TFAIL "failed to make $fs on /dev/zram$i"
+		fi
+
+		i=$(($i + 1))
+	done
+
+	tst_res TPASS "zram_makefs succeeded"
+}
+
+zram_mount()
+{
+	local i=0
+
+	for i in $(seq 0 $(($dev_num - 1))); do
+		tst_res TINFO "mount /dev/zram$i"
+		mkdir zram$i
+		ROD mount /dev/zram$i zram$i
+		dev_mounted=$i
+	done
+
+	tst_res TPASS "mount of zram device(s) succeeded"
+}
+
 zram_fill_fs()
 {
 	for i in $(seq 0 $(($dev_num - 1))); do
diff --git a/testcases/kernel/device-drivers/zram/zram02.sh b/testcases/kernel/device-drivers/zram/zram02.sh
index d09977ec1..f0421ce7f 100755
--- a/testcases/kernel/device-drivers/zram/zram02.sh
+++ b/testcases/kernel/device-drivers/zram/zram02.sh
@@ -23,6 +23,35 @@ zram_max_streams="2"
 zram_sizes="107374182400" # 100GB
 zram_mem_limits="1M"
 
+zram_makeswap()
+{
+	tst_res TINFO "make swap with zram device(s)"
+	tst_require_cmds mkswap swapon swapoff
+	local i=0
+
+	for i in $(seq 0 $(($dev_num - 1))); do
+		ROD mkswap /dev/zram$i
+		ROD swapon /dev/zram$i
+		tst_res TINFO "done with /dev/zram$i"
+		dev_makeswap=$i
+	done
+
+	tst_res TPASS "making zram swap succeeded"
+}
+
+zram_swapoff()
+{
+	tst_require_cmds swapoff
+	local i
+
+	for i in $(seq 0 $dev_makeswap); do
+		ROD swapoff /dev/zram$i
+	done
+	dev_makeswap=-1
+
+	tst_res TPASS "swapoff completed"
+}
+
 do_test()
 {
 	case $1 in
diff --git a/testcases/kernel/device-drivers/zram/zram_lib.sh b/testcases/kernel/device-drivers/zram/zram_lib.sh
index c0a9f4618..65e431e86 100755
--- a/testcases/kernel/device-drivers/zram/zram_lib.sh
+++ b/testcases/kernel/device-drivers/zram/zram_lib.sh
@@ -161,65 +161,3 @@ zram_set_memlimit()
 
 	tst_res TPASS "test succeeded"
 }
-
-zram_makeswap()
-{
-	tst_res TINFO "make swap with zram device(s)"
-	tst_require_cmds mkswap swapon swapoff
-	local i=0
-
-	for i in $(seq 0 $(($dev_num - 1))); do
-		ROD mkswap /dev/zram$i
-		ROD swapon /dev/zram$i
-		tst_res TINFO "done with /dev/zram$i"
-		dev_makeswap=$i
-	done
-
-	tst_res TPASS "making zram swap succeeded"
-}
-
-zram_swapoff()
-{
-	tst_require_cmds swapoff
-	local i
-
-	for i in $(seq 0 $dev_makeswap); do
-		ROD swapoff /dev/zram$i
-	done
-	dev_makeswap=-1
-
-	tst_res TPASS "swapoff completed"
-}
-
-zram_makefs()
-{
-	local i=0
-	local fs
-
-	for fs in $zram_filesystems; do
-		tst_res TINFO "make $fs filesystem on /dev/zram$i"
-		mkfs.$fs /dev/zram$i > err.log 2>&1
-		if [ $? -ne 0 ]; then
-			cat err.log
-			tst_brk TFAIL "failed to make $fs on /dev/zram$i"
-		fi
-
-		i=$(($i + 1))
-	done
-
-	tst_res TPASS "zram_makefs succeeded"
-}
-
-zram_mount()
-{
-	local i=0
-
-	for i in $(seq 0 $(($dev_num - 1))); do
-		tst_res TINFO "mount /dev/zram$i"
-		mkdir zram$i
-		ROD mount /dev/zram$i zram$i
-		dev_mounted=$i
-	done
-
-	tst_res TPASS "mount of zram device(s) succeeded"
-}
-- 
2.30.1

