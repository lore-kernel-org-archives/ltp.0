From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 15 Aug 2019 07:58:36 +0200
Subject: [LTP] [PATCH v3] zram01: Improve error detection
Message-ID: <20190815055836.13634-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* TBROK when detected size is 0 (+ print dd stderr, if any)
* TBROK if actually used memory is 0, this fixes division by 0:

Sometimes free reports no memory use by zram, which leads to division by 0:
zram01 8 TINFO: zram used 0M, zram disk sizes 104857600M
/opt/ltp/testcases/bin/zram01.sh: line 87: 100 * 104857600 / 0: division by 0 (error token is "0")

Suggested-by: Alexey Kodanev <alexey.kodanev@oracle.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi Alexey,

feel free to send your fix if this is not what you meant.

Kind regards,
Petr

Changes v2->v3:
* print last dd error (if any) only when $b -eq 0

Changes v2->v3:
* add TBROK when $b -eq 0
* print last dd error, if any
---

 testcases/kernel/device-drivers/zram/zram01.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/device-drivers/zram/zram01.sh b/testcases/kernel/device-drivers/zram/zram01.sh
index b3ed5170d..c0d46ed75 100755
--- a/testcases/kernel/device-drivers/zram/zram01.sh
+++ b/testcases/kernel/device-drivers/zram/zram01.sh
@@ -67,9 +67,13 @@ zram_fill_fs()
 		while true; do
 			dd conv=notrunc if=/dev/zero of=zram${i}/file \
 				oflag=append count=1 bs=1024 status=none \
-				> /dev/null 2>&1 || break
+				2>err.txt || break
 			b=$(($b + 1))
 		done
+		if [ $b -eq 0 ]; then
+			[ -s err.txt ] && tst_resm TWARN "dd error: $(cat err.txt)"
+			tst_brkm TBROK "cannot fill zram"
+		fi
 		tst_resm TINFO "zram$i can be filled with '$b' KB"
 	done
 
@@ -82,6 +86,8 @@ zram_fill_fs()
 		total_size=$(($total_size + $s))
 	done
 
+	[ $used_mem -eq 0 ] && tst_brkm TBROK "no memory used by zram"
+
 	tst_resm TINFO "zram used ${used_mem}M, zram disk sizes ${total_size}M"
 
 	local v=$((100 * $total_size / $used_mem))
-- 
2.22.0

