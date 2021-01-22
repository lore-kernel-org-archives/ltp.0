From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 22 Jan 2021 15:54:57 +0100
Subject: [LTP] [PATCH v5 2/3] zram: Fix module detection on BusyBox
In-Reply-To: <20210122145458.27964-1-pvorel@suse.cz>
References: <20210122145458.27964-1-pvorel@suse.cz>
Message-ID: <20210122145458.27964-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

BusyBox modinfo implementation does not exit with 0 when module not
found. Our own API implementation used for module detection in
tst_check_driver() was fixed in previous commit thus use it.

Reported-by: Leo Yu-Chi Liang <ycliang@andestech.com>
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/device-drivers/zram/zram_lib.sh | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/device-drivers/zram/zram_lib.sh b/testcases/kernel/device-drivers/zram/zram_lib.sh
index 3f4d1d55f..bdbf2453a 100755
--- a/testcases/kernel/device-drivers/zram/zram_lib.sh
+++ b/testcases/kernel/device-drivers/zram/zram_lib.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 # Copyright (c) 2015 Oracle and/or its affiliates. All Rights Reserved.
-# Copyright (c) 2019 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2019-2021 Petr Vorel <pvorel@suse.cz>
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 
 dev_makeswap=-1
@@ -9,6 +9,7 @@ dev_mounted=-1
 TST_NEEDS_TMPDIR=1
 TST_SETUP="zram_load"
 TST_CLEANUP="zram_cleanup"
+TST_NEEDS_DRIVERS="zram"
 . tst_test.sh
 
 zram_cleanup()
@@ -210,6 +211,3 @@ zram_mount()
 
 	tst_res TPASS "mount of zram device(s) succeeded"
 }
-
-modinfo zram > /dev/null 2>&1 ||
-	tst_brk TCONF "zram not configured in kernel"
-- 
2.30.0

