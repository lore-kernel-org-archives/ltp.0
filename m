From: Po-Hsu Lin <po-hsu.lin@canonical.com>
Date: Mon,  1 Jul 2019 19:37:05 +0800
Subject: [LTP] [PATCH] zram/zram_lib.sh: fix local variable assignment
Message-ID: <20190701113705.2758-1-po-hsu.lin@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The compression algorithm was stored into a local variable "algs",
however the variable name "zram_algs" was used in the for loop later.

Unify them with "zram_algs", and use sed to get rid of the square
brackets that indicates the compression algorithm currently in use.
    $ cat /sys/block/zram0/comp_algorithm
    [lzo] lz4 lz4hc 842 zstd

Also, the /bin/sh was symbolically link to dash in Ubuntu.
This is making the one-liner local variable assignment not working [1]:
    /opt/ltp/testcases/bin/zram01.sh: 102: local: 842: bad variable name

Break it into two lines to solve this issue.

[1] https://wiki.ubuntu.com/DashAsBinSh#local

Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 testcases/kernel/device-drivers/zram/zram_lib.sh | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/device-drivers/zram/zram_lib.sh b/testcases/kernel/device-drivers/zram/zram_lib.sh
index 45116af3e..a19d03a01 100755
--- a/testcases/kernel/device-drivers/zram/zram_lib.sh
+++ b/testcases/kernel/device-drivers/zram/zram_lib.sh
@@ -98,11 +98,13 @@ zram_compress_alg()
 
 	tst_resm TINFO "test that we can set compression algorithm"
 
-	local algs=$(cat /sys/block/zram0/comp_algorithm)
-	tst_resm TINFO "supported algs: $algs"
+	local zram_algs
+	zram_algs=$(sed 's/[][]//g' /sys/block/zram0/comp_algorithm)
+	tst_resm TINFO "supported algs: $zram_algs"
 	local i=0
 	for alg in $zram_algs; do
-		local sys_path="/sys/block/zram${i}/comp_algorithm"
+		local sys_path
+		sys_path="/sys/block/zram${i}/comp_algorithm"
 		echo "$alg" >  $sys_path || \
 			tst_brkm TFAIL "can't set '$alg' to $sys_path"
 		i=$(($i + 1))
-- 
2.17.1

