From: Po-Hsu Lin <po-hsu.lin@canonical.com>
Date: Wed, 10 Jul 2019 15:23:05 +0800
Subject: [LTP] [PATCH 3/3] zram/zram_lib.sh: set the compression algorithms
 back to default after test
In-Reply-To: <20190710072305.25806-1-po-hsu.lin@canonical.com>
References: <20190710072305.25806-1-po-hsu.lin@canonical.com>
Message-ID: <20190710072305.25806-4-po-hsu.lin@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Set the compression algorithm back to the default one in the end of the
zram_compress_alg() test.

Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 testcases/kernel/device-drivers/zram/zram_lib.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/testcases/kernel/device-drivers/zram/zram_lib.sh b/testcases/kernel/device-drivers/zram/zram_lib.sh
index 7773f4338..e2b6eb8ec 100755
--- a/testcases/kernel/device-drivers/zram/zram_lib.sh
+++ b/testcases/kernel/device-drivers/zram/zram_lib.sh
@@ -99,6 +99,7 @@ zram_compress_alg()
 	tst_resm TINFO "test that we can set compression algorithm"
 
 	local algs="$(sed 's/[][]//g' /sys/block/zram0/comp_algorithm)"
+	local alg_default="$(grep -oP '(?<=\[).*(?=\])' /sys/block/zram0/comp_algorithm)"
 	tst_resm TINFO "supported algs: $algs"
 	local i=0
 	local dev_max=$(($dev_num - 1))
@@ -110,6 +111,12 @@ zram_compress_alg()
 				tst_brkm TFAIL "can't set '$alg' to $sys_path"
 			tst_resm TINFO "$sys_path = '$alg' ($i/$dev_max)"
 		done
+		# Restore the compression algorithm to the default one
+		if [ -n "$alg_default" ]; then
+			echo "$alg_default" >  $sys_path || \
+				tst_brkm TFAIL "can't restore '$alg_default' to $sys_path"
+			tst_resm TINFO "Set $sys_path back to $alg_default"
+		fi
 	done
 
 	tst_resm TPASS "test succeeded"
-- 
2.17.1

