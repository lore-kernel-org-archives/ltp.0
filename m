From: Leo Yu-Chi Liang <ycliang@andestech.com>
Date: Thu, 17 Sep 2020 16:19:17 +0800
Subject: [LTP] [PATCH]  device-drivers/zram: zram_lib: Fix modinfo's usage
Message-ID: <20200917081917.31510-1-ycliang@andestech.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

zram_lib uses the exit code of modinfo to determine the presence of zram module,
but the exit code does not have direct relation to it.

We could be missing zram module and modinfo still exits "successfully"
because it has done its job of informing the user zram is missing.

Such behavior would give confusing zram test report.
Without this patch, some of the system run LTP without zram module
would have a FAIL instead of CONF as a result.

Signed-off-by: Leo Yu-Chi Liang <ycliang@andestech.com>
---
 testcases/kernel/device-drivers/zram/zram_lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/device-drivers/zram/zram_lib.sh b/testcases/kernel/device-drivers/zram/zram_lib.sh
index 3f4d1d55f..372b93990 100755
--- a/testcases/kernel/device-drivers/zram/zram_lib.sh
+++ b/testcases/kernel/device-drivers/zram/zram_lib.sh
@@ -211,5 +211,5 @@ zram_mount()
 	tst_res TPASS "mount of zram device(s) succeeded"
 }
 
-modinfo zram > /dev/null 2>&1 ||
+modinfo zram 2>&1 | grep filename > /dev/null 2>&1 ||
 	tst_brk TCONF "zram not configured in kernel"
-- 
2.17.0

