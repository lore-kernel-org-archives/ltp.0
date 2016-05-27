From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 27 May 2016 14:54:18 +0300
Subject: [LTP] [PATCH] network/virt: adjust virt_threshold by using
	environment variable
Message-ID: <1464350058-15558-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add the ability to configure performance threshold of virtual
devices by using environment variable. Also rename:

  virt_threshold -> VIRT_PERF_THRESHOLD,

and print it in the test result message.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/virt/virt_lib.sh |   16 +++++++++-------
 testcases/network/virt/vxlan03.sh  |    5 +++--
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/testcases/network/virt/virt_lib.sh b/testcases/network/virt/virt_lib.sh
index d582284..2246d0d 100644
--- a/testcases/network/virt/virt_lib.sh
+++ b/testcases/network/virt/virt_lib.sh
@@ -1,5 +1,5 @@
 #!/bin/sh
-# Copyright (c) 2014-2015 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) 2014-2016 Oracle and/or its affiliates. All Rights Reserved.
 #
 # This program is free software; you can redistribute it and/or
 # modify it under the terms of the GNU General Public License as
@@ -42,7 +42,9 @@ clients_num=2
 client_requests=500000
 max_requests=3
 net_load="TFO"
-virt_threshold=80
+
+# Max performance loss (%) for virtual devices during network load
+VIRT_PERF_THRESHOLD=${VIRT_PERF_THRESHOLD:-80}
 vxlan_dstport=0
 
 while getopts :hsx:i:r:c:R:p:n:l:t:d:6 opt; do
@@ -76,7 +78,7 @@ while getopts :hsx:i:r:c:R:p:n:l:t:d:6 opt; do
 		ip_virt_remote="192.168.${OPTARG}.2"
 	;;
 	l) net_load=$OPTARG ;;
-	t) virt_threshold=$OPTARG ;;
+	t) VIRT_PERF_THRESHOLD=$OPTARG ;;
 	d) vxlan_dst_addr=$OPTARG ;;
 	6) # skip, test_net library already processed it
 	;;
@@ -290,11 +292,11 @@ virt_compare_netperf()
 		tst_resm TINFO "IPv6 $virt_type slower by $per6 %"
 	esac
 
-	if [ "$per" -ge "$virt_threshold" -o \
-	     "$per6" -ge "$virt_threshold" ]; then
-		tst_resm TFAIL "Test failed"
+	if [ "$per" -ge "$VIRT_PERF_THRESHOLD" -o \
+	     "$per6" -ge "$VIRT_PERF_THRESHOLD" ]; then
+		tst_resm TFAIL "Test failed, threshold: $VIRT_PERF_THRESHOLD %"
 	else
-		tst_resm TPASS "Test passed"
+		tst_resm TPASS "Test passed, threshold: $VIRT_PERF_THRESHOLD %"
 	fi
 }
 
diff --git a/testcases/network/virt/vxlan03.sh b/testcases/network/virt/vxlan03.sh
index 65a71aa..e86d119 100755
--- a/testcases/network/virt/vxlan03.sh
+++ b/testcases/network/virt/vxlan03.sh
@@ -1,5 +1,5 @@
 #!/bin/sh
-# Copyright (c) 2014-2015 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) 2014-2016 Oracle and/or its affiliates. All Rights Reserved.
 #
 # This program is free software; you can redistribute it and/or
 # modify it under the terms of the GNU General Public License as
@@ -39,7 +39,8 @@ vxlan_dst_addr="uni"
 # by 10-30%. If hosts are too close to each other, e.g. connected to the same
 # switch, VxLAN can be much slower when comparing to the performance without
 # any encapsulation.
-virt_threshold=160
+VIRT_PERF_THRESHOLD=${VIRT_PERF_THRESHOLD:-160}
+[ "$VIRT_PERF_THRESHOLD" -lt 160 ] && VIRT_PERF_THRESHOLD=160
 
 cleanup()
 {
-- 
1.7.1

