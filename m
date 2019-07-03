From: Po-Hsu Lin <po-hsu.lin@canonical.com>
Date: Wed,  3 Jul 2019 18:23:02 +0800
Subject: [LTP] [PATCH 2/3] zram/zram_lib.sh: fix variable name and algorithm
 retrieval
In-Reply-To: <20190703102303.32166-1-po-hsu.lin@canonical.com>
References: <20190703102303.32166-1-po-hsu.lin@canonical.com>
Message-ID: <20190703102303.32166-3-po-hsu.lin@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The compression algorithm was stored into a local variable algs,
however the variable name zram_algs was used in the for loop later.

Unify them with zram_algs, and use sed to get rid of the square
brackets that indicates the compression algorithm currently in use.
    $ cat /sys/block/zram0/comp_algorithm
    [lzo] lz4 lz4hc 842 zstd

Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 testcases/kernel/device-drivers/zram/zram_lib.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/device-drivers/zram/zram_lib.sh b/testcases/kernel/device-drivers/zram/zram_lib.sh
index d0e7704a8..d50be699d 100755
--- a/testcases/kernel/device-drivers/zram/zram_lib.sh
+++ b/testcases/kernel/device-drivers/zram/zram_lib.sh
@@ -98,8 +98,8 @@ zram_compress_alg()
 
 	tst_resm TINFO "test that we can set compression algorithm"
 
-	local algs="$(cat /sys/block/zram0/comp_algorithm)"
-	tst_resm TINFO "supported algs: $algs"
+	local zram_algs="$(sed 's/[][]//g' /sys/block/zram0/comp_algorithm)"
+	tst_resm TINFO "supported algs: $zram_algs"
 	local i=0
 	for alg in $zram_algs; do
 		local sys_path="/sys/block/zram${i}/comp_algorithm"
-- 
2.17.1

