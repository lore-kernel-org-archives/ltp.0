From: Po-Hsu Lin <po-hsu.lin@canonical.com>
Date: Wed, 10 Jul 2019 15:23:04 +0800
Subject: [LTP] [PATCHv2 2/3] zram/zram_lib.sh: iterate through all available
 compression algorithms for all zram block devices
In-Reply-To: <20190710072305.25806-1-po-hsu.lin@canonical.com>
References: <20190710072305.25806-1-po-hsu.lin@canonical.com>
Message-ID: <20190710072305.25806-3-po-hsu.lin@canonical.com>
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

Fix this by using the number of devices defined in zram01.sh. And
iterate all the available compression algorithms on each block device.
This ensures all the algorithm can be assigned on all of the zram block
devices and thus improves the test coverage.

Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 testcases/kernel/device-drivers/zram/zram_lib.sh | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/device-drivers/zram/zram_lib.sh b/testcases/kernel/device-drivers/zram/zram_lib.sh
index 599e5f0f3..7773f4338 100755
--- a/testcases/kernel/device-drivers/zram/zram_lib.sh
+++ b/testcases/kernel/device-drivers/zram/zram_lib.sh
@@ -101,12 +101,15 @@ zram_compress_alg()
 	local algs="$(sed 's/[][]//g' /sys/block/zram0/comp_algorithm)"
 	tst_resm TINFO "supported algs: $algs"
 	local i=0
-	for alg in $algs; do
-		local sys_path="/sys/block/zram${i}/comp_algorithm"
-		echo "$alg" >  $sys_path || \
-			tst_brkm TFAIL "can't set '$alg' to $sys_path"
-		i=$(($i + 1))
-		tst_resm TINFO "$sys_path = '$alg' ($i/$dev_num)"
+	local dev_max=$(($dev_num - 1))
+
+	for i in $(seq 0 $dev_max); do
+		for alg in $algs; do
+			local sys_path="/sys/block/zram${i}/comp_algorithm"
+			echo "$alg" >  $sys_path || \
+				tst_brkm TFAIL "can't set '$alg' to $sys_path"
+			tst_resm TINFO "$sys_path = '$alg' ($i/$dev_max)"
+		done
 	done
 
 	tst_resm TPASS "test succeeded"
-- 
2.17.1

