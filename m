From: Leo Liang <ycliang@andestech.com>
Date: Thu, 14 Jan 2021 15:46:03 +0800
Subject: [LTP] [PATCH 1/1] device-drivers/zram: Fix false-judgement on
 zram's presence
Message-ID: <20210114074603.GB32318@andestech.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Date: Thu, 14 Jan 2021 15:27:34 +0800
From: Leo Yu-Chi Liang <ycliang@andestech.com>
Subject: [LTP][PATCH 1/1] device-drivers/zram: Fix false-judgement on zram's presence

zram_lib.sh uses the return value of modinfo to check if zram module exists,
but the behavior of modinfo implemented by busybox is different.

The busybox-implemented modinfo would also return true (code: 0)
even if zram module is not present,
so grep the info that only shows when the module exists.

Signed-off-by: Leo Yu-Chi Liang <ycliang@andestech.com>
---
 testcases/kernel/device-drivers/zram/zram_lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/device-drivers/zram/zram_lib.sh b/testcases/kernel/device-drivers/zram/zram_lib.sh
index 3f4d1d55f..04d4a4da6 100755
--- a/testcases/kernel/device-drivers/zram/zram_lib.sh
+++ b/testcases/kernel/device-drivers/zram/zram_lib.sh
@@ -211,5 +211,5 @@ zram_mount()
 	tst_res TPASS "mount of zram device(s) succeeded"
 }
 
-modinfo zram > /dev/null 2>&1 ||
+modinfo zram | grep "filename" > /dev/null 2>&1 ||
 	tst_brk TCONF "zram not configured in kernel"
-- 
2.17.0
