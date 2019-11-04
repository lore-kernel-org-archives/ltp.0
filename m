From: Martin Doucha <mdoucha@suse.cz>
Date: Mon,  4 Nov 2019 13:52:28 +0100
Subject: [LTP] [PATCH 1/1] Fix compression ratio calculation in zram01
In-Reply-To: <20191104125228.17173-1-mdoucha@suse.cz>
References: <20191104125228.17173-1-mdoucha@suse.cz>
Message-ID: <20191104125228.17173-2-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

zram01 uses `free -m` to measure zram memory usage. The results are nonsense
because they are polluted by all running processes on the system.

Use /sys/block/zram<id>/mm_stat to measure memory usage instead. The file is
available since kernel 4.1.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 .../kernel/device-drivers/zram/zram01.sh      | 36 +++++++++----------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/testcases/kernel/device-drivers/zram/zram01.sh b/testcases/kernel/device-drivers/zram/zram01.sh
index 9508211ab..2a8189de2 100755
--- a/testcases/kernel/device-drivers/zram/zram01.sh
+++ b/testcases/kernel/device-drivers/zram/zram01.sh
@@ -58,8 +58,7 @@ TST_CLEANUP="zram_cleanup"
 
 zram_fill_fs()
 {
-	tst_test_cmds awk bc dd free
-	local mem_free0=$(free -m | awk 'NR==2 {print $4}')
+	tst_test_cmds awk bc dd
 
 	for i in $(seq 0 $(($dev_num - 1))); do
 		tst_resm TINFO "fill zram$i..."
@@ -75,29 +74,26 @@ zram_fill_fs()
 			tst_brkm TBROK "cannot fill zram"
 		fi
 		tst_resm TINFO "zram$i can be filled with '$b' KB"
-	done
-
-	local mem_free1=$(free -m | awk 'NR==2 {print $4}')
-	local used_mem=$(($mem_free0 - $mem_free1))
-
-	local total_size=0
-	for sm in $zram_sizes; do
-		local s=$(echo $sm | sed 's/M//')
-		total_size=$(($total_size + $s))
-	done
 
-	[ $used_mem -eq 0 ] && tst_brkm TBROK "no memory used by zram"
+		if [ ! -f "/sys/block/zram$i/mm_stat" ]; then
+			if [ $i -eq 0 ]; then
+				tst_resm TCONF "zram compression ratio test requires zram mm_stat sysfs file"
+			fi
 
-	tst_resm TINFO "zram used ${used_mem}M, zram disk sizes ${total_size}M"
+			continue
+		fi
 
-	local v=$((100 * $total_size / $used_mem))
+		local compr_size=`cat "/sys/block/zram$i/mm_stat" | awk '{print $2}'`
+		local v=$((100 * 1024 * $b / $compr_size))
+		local r=`echo "scale=2; $v / 100 " | bc`
 
-	if [ "$v" -lt 100 ]; then
-		tst_resm TFAIL "compression ratio: 0.$v:1"
-		return
-	fi
+		if [ "$v" -lt 100 ]; then
+			tst_resm TFAIL "compression ratio: $r:1"
+			break
+		fi
 
-	tst_resm TPASS "compression ratio: $(echo "scale=2; $v / 100 " | bc):1"
+		tst_resm TPASS "compression ratio: $r:1"
+	done
 }
 
 zram_load
-- 
2.23.0

