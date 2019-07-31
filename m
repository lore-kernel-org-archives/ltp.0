From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 31 Jul 2019 08:33:20 +0200
Subject: [LTP] [PATCH] zram01: Fix division by 0
Message-ID: <20190731063320.4898-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Sometimes free reports no memory use by zram, which leads to division by 0:
zram01 8 TINFO: zram used 0M, zram disk sizes 104857600M
/opt/ltp/testcases/bin/zram01.sh: line 87: 100 * 104857600 / 0: division by 0 (error token is "0")

TBROK the test in that case.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/device-drivers/zram/zram01.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/testcases/kernel/device-drivers/zram/zram01.sh b/testcases/kernel/device-drivers/zram/zram01.sh
index 7d3951aa5..79e18cbb7 100755
--- a/testcases/kernel/device-drivers/zram/zram01.sh
+++ b/testcases/kernel/device-drivers/zram/zram01.sh
@@ -82,6 +82,11 @@ zram_fill_fs()
 		total_size=$(($total_size + $s))
 	done
 
+	if [ $used_mem -eq 0 ]; then
+		tst_resm TBROK "no memory used by zram"
+		return
+	fi
+
 	tst_resm TINFO "zram used ${used_mem}M, zram disk sizes ${total_size}M"
 
 	local v=$((100 * $total_size / $used_mem))
-- 
2.22.0

