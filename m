From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 29 Jan 2021 20:41:39 +0100
Subject: [LTP] [PATCH v2 1/6] zram: Calculate dev_num variable
In-Reply-To: <20210129194144.31299-1-pvorel@suse.cz>
References: <20210129194144.31299-1-pvorel@suse.cz>
Message-ID: <20210129194144.31299-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Instead of requiring to be set.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
changes v1->v2:
Added paranoid check:
+	if [ $dev_num -le 0 ]; then
+		tst_brk TBROK "dev_num must be > 0"
+	fi

Kind regards,
Petr

 testcases/kernel/device-drivers/zram/zram01.sh   |  8 +++-----
 testcases/kernel/device-drivers/zram/zram02.sh   |  8 +++-----
 testcases/kernel/device-drivers/zram/zram_lib.sh | 16 ++++++++++++++--
 3 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/testcases/kernel/device-drivers/zram/zram01.sh b/testcases/kernel/device-drivers/zram/zram01.sh
index 8de2c0cad..a795ff89f 100755
--- a/testcases/kernel/device-drivers/zram/zram01.sh
+++ b/testcases/kernel/device-drivers/zram/zram01.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 # Copyright (c) 2015 Oracle and/or its affiliates. All Rights Reserved.
-# Copyright (c) 2019 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2019-2021 Petr Vorel <pvorel@suse.cz>
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 #
 # Test creates several zram devices with different filesystems on them.
@@ -11,10 +11,8 @@ TST_TESTFUNC="do_test"
 TST_NEEDS_CMDS="awk bc dd"
 . zram_lib.sh
 
-# Test will create the following number of zram devices:
-dev_num=4
-# This is a list of parameters for zram devices.
-# Number of items must be equal to 'dev_num' parameter.
+# List of parameters for zram devices.
+# For each number the test creates own zram device.
 zram_max_streams="2 3 5 8"
 
 FS_SIZE="402653184"
diff --git a/testcases/kernel/device-drivers/zram/zram02.sh b/testcases/kernel/device-drivers/zram/zram02.sh
index f97cf646c..b4d706568 100755
--- a/testcases/kernel/device-drivers/zram/zram02.sh
+++ b/testcases/kernel/device-drivers/zram/zram02.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 # Copyright (c) 2015 Oracle and/or its affiliates. All Rights Reserved.
-# Copyright (c) 2019 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2019-2021 Petr Vorel <pvorel@suse.cz>
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 #
 # Test checks that we can create swap zram device.
@@ -9,10 +9,8 @@ TST_CNT=5
 TST_TESTFUNC="do_test"
 . zram_lib.sh
 
-# Test will create the following number of zram devices:
-dev_num=1
-# This is a list of parameters for zram devices.
-# Number of items must be equal to 'dev_num' parameter.
+# List of parameters for zram devices.
+# For each number the test creates own zram device.
 zram_max_streams="2"
 
 # The zram sysfs node 'disksize' value can be either in bytes,
diff --git a/testcases/kernel/device-drivers/zram/zram_lib.sh b/testcases/kernel/device-drivers/zram/zram_lib.sh
index 6fa6552ca..a7e8b9f5b 100755
--- a/testcases/kernel/device-drivers/zram/zram_lib.sh
+++ b/testcases/kernel/device-drivers/zram/zram_lib.sh
@@ -34,7 +34,19 @@ zram_cleanup()
 
 zram_load()
 {
+	local tmp
+
+	dev_num=0
+	for tmp in $zram_max_streams; do
+		dev_num=$((dev_num+1))
+	done
+
+	if [ $dev_num -le 0 ]; then
+		tst_brk TBROK "dev_num must be > 0"
+	fi
+
 	tst_res TINFO "create '$dev_num' zram device(s)"
+
 	modprobe zram num_devices=$dev_num || \
 		tst_brk TBROK "failed to insert zram module"
 
@@ -42,9 +54,9 @@ zram_load()
 
 	if [ "$dev_num_created" -ne "$dev_num" ]; then
 		tst_brk TFAIL "unexpected num of devices: $dev_num_created"
-	else
-		tst_res TPASS "test succeeded"
 	fi
+
+	tst_res TPASS "all zram devices successfully created"
 }
 
 zram_max_streams()
-- 
2.30.0

