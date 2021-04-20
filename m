From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 20 Apr 2021 08:17:59 +0200
Subject: [LTP] [PATCH 1/1] zram01.sh: Skip tmpfs
Message-ID: <20210420061759.22457-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This fixes error: mkfs.tmpfs: command not found

It does not make much sense to adapt test to tmpfs, thus skip it.

Fixes: 012fac904 ("zram: Move test specific functions out of zram_lib.sh")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/device-drivers/zram/zram01.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/device-drivers/zram/zram01.sh b/testcases/kernel/device-drivers/zram/zram01.sh
index 7de8b4b2a..ad9a9a2be 100755
--- a/testcases/kernel/device-drivers/zram/zram01.sh
+++ b/testcases/kernel/device-drivers/zram/zram01.sh
@@ -40,6 +40,7 @@ initialize_vars()
 	dev_num=0
 
 	for fs in $(tst_supported_fs); do
+		[ "$fs" = "tmpfs" ] && continue
 		size="26214400"
 		limit="25M"
 		if [ "$fs" = "btrfs" ]; then
-- 
2.31.1

