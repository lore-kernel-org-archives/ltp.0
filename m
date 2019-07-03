From: Po-Hsu Lin <po-hsu.lin@canonical.com>
Date: Wed,  3 Jul 2019 18:23:01 +0800
Subject: [LTP] [PATCH 1/3] zram/zram_lib.sh: fix local variable assignment
 for DASH
In-Reply-To: <20190703102303.32166-1-po-hsu.lin@canonical.com>
References: <20190703102303.32166-1-po-hsu.lin@canonical.com>
Message-ID: <20190703102303.32166-2-po-hsu.lin@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The /bin/sh was symbolically link to dash in Ubuntu.
This is making the one-liner local variable assignment not working [1]:
    /opt/ltp/testcases/bin/zram01.sh: 102: local: 842: bad variable name

This is because there are more then one string in the return value:
    $ cat /sys/block/zram0/comp_algorithm
    [lzo] lz4 lz4hc 842 zstd

Use a pair of quotes to enclose to solve this issue.

[1] https://wiki.ubuntu.com/DashAsBinSh#local

Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 testcases/kernel/device-drivers/zram/zram_lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/device-drivers/zram/zram_lib.sh b/testcases/kernel/device-drivers/zram/zram_lib.sh
index 45116af3e..d0e7704a8 100755
--- a/testcases/kernel/device-drivers/zram/zram_lib.sh
+++ b/testcases/kernel/device-drivers/zram/zram_lib.sh
@@ -98,7 +98,7 @@ zram_compress_alg()
 
 	tst_resm TINFO "test that we can set compression algorithm"
 
-	local algs=$(cat /sys/block/zram0/comp_algorithm)
+	local algs="$(cat /sys/block/zram0/comp_algorithm)"
 	tst_resm TINFO "supported algs: $algs"
 	local i=0
 	for alg in $zram_algs; do
-- 
2.17.1

