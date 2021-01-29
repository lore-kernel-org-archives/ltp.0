From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 29 Jan 2021 13:18:17 +0100
Subject: [LTP] [PATCH 5/5] zram: Move test specific functions out of
 zram_lib.sh
In-Reply-To: <20210129121817.12563-1-pvorel@suse.cz>
References: <20210129121817.12563-1-pvorel@suse.cz>
Message-ID: <20210129121817.12563-6-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Refactoring, as code is confusing enough, when use global variables and
functions which are single test specific + there is zram_fill_fs already
in zram01.sh.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../kernel/device-drivers/zram/zram01.sh      | 34 +++++++
 .../kernel/device-drivers/zram/zram02.sh      | 58 ++++++++++++
 .../kernel/device-drivers/zram/zram_lib.sh    | 92 -------------------
 3 files changed, 92 insertions(+), 92 deletions(-)

diff --git a/testcases/kernel/device-drivers/zram/zram01.sh b/testcases/kernel/device-drivers/zram/zram01.sh
index bb1532c1e..b2c384547 100755
--- a/testcases/kernel/device-drivers/zram/zram01.sh
+++ b/testcases/kernel/device-drivers/zram/zram01.sh
@@ -78,6 +78,40 @@ setup()
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
+		[ $i -eq $dev_num ] && break
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
index d09977ec1..803b8dc29 100755
--- a/testcases/kernel/device-drivers/zram/zram02.sh
+++ b/testcases/kernel/device-drivers/zram/zram02.sh
@@ -23,6 +23,64 @@ zram_max_streams="2"
 zram_sizes="107374182400" # 100GB
 zram_mem_limits="1M"
 
+zram_compress_alg()
+{
+	if tst_kvcmp -lt "3.15"; then
+		tst_res TCONF "device attribute comp_algorithm is"\
+			"introduced since kernel v3.15, the running kernel"\
+			"does not support it"
+		return
+	fi
+
+	local i=0
+
+	tst_res TINFO "test that we can set compression algorithm"
+	local algs="$(sed 's/[][]//g' /sys/block/zram0/comp_algorithm)"
+	tst_res TINFO "supported algs: $algs"
+
+	local dev_max=$(($dev_num - 1))
+
+	for i in $(seq 0 $dev_max); do
+		for alg in $algs; do
+			local sys_path="/sys/block/zram${i}/comp_algorithm"
+			echo "$alg" >  $sys_path || \
+				tst_brk TFAIL "can't set '$alg' to $sys_path"
+			tst_res TINFO "$sys_path = '$alg' ($i/$dev_max)"
+		done
+	done
+
+	tst_res TPASS "test succeeded"
+}
+
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
index b2dce1d7d..39615180e 100755
--- a/testcases/kernel/device-drivers/zram/zram_lib.sh
+++ b/testcases/kernel/device-drivers/zram/zram_lib.sh
@@ -85,35 +85,6 @@ zram_max_streams()
 	tst_res TPASS "test succeeded"
 }
 
-zram_compress_alg()
-{
-	if tst_kvcmp -lt "3.15"; then
-		tst_res TCONF "device attribute comp_algorithm is"\
-			"introduced since kernel v3.15, the running kernel"\
-			"does not support it"
-		return
-	fi
-
-	local i=0
-
-	tst_res TINFO "test that we can set compression algorithm"
-	local algs="$(sed 's/[][]//g' /sys/block/zram0/comp_algorithm)"
-	tst_res TINFO "supported algs: $algs"
-
-	local dev_max=$(($dev_num - 1))
-
-	for i in $(seq 0 $dev_max); do
-		for alg in $algs; do
-			local sys_path="/sys/block/zram${i}/comp_algorithm"
-			echo "$alg" >  $sys_path || \
-				tst_brk TFAIL "can't set '$alg' to $sys_path"
-			tst_res TINFO "$sys_path = '$alg' ($i/$dev_max)"
-		done
-	done
-
-	tst_res TPASS "test succeeded"
-}
-
 zram_set_disksizes()
 {
 	local i=0
@@ -159,66 +130,3 @@ zram_set_memlimit()
 
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
-		[ $i -eq $dev_num ] && break
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
2.30.0

