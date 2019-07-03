From: Po-Hsu Lin <po-hsu.lin@canonical.com>
Date: Wed,  3 Jul 2019 18:23:03 +0800
Subject: [LTP] [PATCH 3/3] zram/zram_lib.sh: iterate through all available
 compression algorithms for all zram block devices
In-Reply-To: <20190703102303.32166-1-po-hsu.lin@canonical.com>
References: <20190703102303.32166-1-po-hsu.lin@canonical.com>
Message-ID: <20190703102303.32166-4-po-hsu.lin@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The test was designed to switch up to 4 zram compression algorithms,
one of them on a zram block device at a time through 4 devices as
defined in zram01.sh.

As the number of zram block devices are hard-coded in zram01.sh, the
test will fail if your system supports more than 4 compression
algorithms because it will try to access a non-existing block device:
    zram01.sh: cannot create /sys/block/zram4/comp_algorithm: Directory nonexistent
    zram01 2 TFAIL: can't set 'zstd' to /sys/block/zram4/comp_algorithm

Fix this by checking how many available zram block devices we can use
first. And iterate all the available compression algorithms on each one
of block devices. This ensures all the algorithm can be assigned on all
of the zram block devices and thus improves the test coverage.

Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 .../kernel/device-drivers/zram/zram_lib.sh     | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/device-drivers/zram/zram_lib.sh b/testcases/kernel/device-drivers/zram/zram_lib.sh
index d50be699d..96400b2d9 100755
--- a/testcases/kernel/device-drivers/zram/zram_lib.sh
+++ b/testcases/kernel/device-drivers/zram/zram_lib.sh
@@ -101,12 +101,18 @@ zram_compress_alg()
 	local zram_algs="$(sed 's/[][]//g' /sys/block/zram0/comp_algorithm)"
 	tst_resm TINFO "supported algs: $zram_algs"
 	local i=0
-	for alg in $zram_algs; do
-		local sys_path="/sys/block/zram${i}/comp_algorithm"
-		echo "$alg" >  $sys_path || \
-			tst_brkm TFAIL "can't set '$alg' to $sys_path"
-		i=$(($i + 1))
-		tst_resm TINFO "$sys_path = '$alg' ($i/$dev_num)"
+	local dev_max=0
+	while [ -d /sys/block/zram$(($dev_max + 1)) ]; do
+		dev_max=$(($dev_max + 1))
+	done
+
+	for i in $(seq 0 $dev_max); do
+		for alg in $zram_algs; do
+			local sys_path="/sys/block/zram${i}/comp_algorithm"
+			echo "$alg" >  $sys_path || \
+				tst_brkm TFAIL "can't set '$alg' to $sys_path"
+			tst_resm TINFO "$sys_path = '$alg' ($i/$dev_max)"
+		done
 	done
 
 	tst_resm TPASS "test succeeded"
-- 
2.17.1

