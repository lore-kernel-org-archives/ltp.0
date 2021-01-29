From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 29 Jan 2021 13:18:13 +0100
Subject: [LTP] [PATCH 1/5] zram: Require root
In-Reply-To: <20210129121817.12563-1-pvorel@suse.cz>
References: <20210129121817.12563-1-pvorel@suse.cz>
Message-ID: <20210129121817.12563-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Calling modprobe, rmmod and working with zram device requires root.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/device-drivers/zram/zram_lib.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/device-drivers/zram/zram_lib.sh b/testcases/kernel/device-drivers/zram/zram_lib.sh
index bdbf2453a..6fa6552ca 100755
--- a/testcases/kernel/device-drivers/zram/zram_lib.sh
+++ b/testcases/kernel/device-drivers/zram/zram_lib.sh
@@ -7,6 +7,7 @@ dev_makeswap=-1
 dev_mounted=-1
 
 TST_NEEDS_TMPDIR=1
+TST_NEEDS_ROOT=1
 TST_SETUP="zram_load"
 TST_CLEANUP="zram_cleanup"
 TST_NEEDS_DRIVERS="zram"
-- 
2.30.0

