From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 17 Dec 2019 20:19:17 +0300
Subject: [LTP] [PATCH v2 1/2] network/iptables: reduce ping timeouts
Message-ID: <20191217171918.10237-1-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
v2: no changes

 testcases/network/iptables/iptables_tests.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/testcases/network/iptables/iptables_tests.sh b/testcases/network/iptables/iptables_tests.sh
index 11412d6fb..d8b23283f 100755
--- a/testcases/network/iptables/iptables_tests.sh
+++ b/testcases/network/iptables/iptables_tests.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) 2018 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) 2018-2019 Oracle and/or its affiliates. All Rights Reserved.
 # Copyright (c) International Business Machines  Corp., 2001
 #
 #  Author:	Jan 20 2004 Hubert Lin <linux02NOSPAAAM@tw.ibm.com>
@@ -123,7 +123,7 @@ test2()
 	fi
 
 	tst_res TINFO "Pinging 127.0.0.1"
-	ping -c 2 127.0.0.1 > tst_iptables.out 2>&1
+	ping -c 2 127.0.0.1 -W 1 -i 0 > tst_iptables.out 2>&1
 	if [ $? -ne 0 ]; then
 		grep "100% packet loss" tst_iptables.out > tst_iptables.err 2>&1
 		if [ $? -ne 0 ]; then
@@ -148,7 +148,7 @@ test2()
 		return
 	fi
 	tst_res TINFO "Pinging 127.0.0.1 again"
-	ping -c 2 127.0.0.1 > tst_iptables.out 2>&1
+	ping -c 2 127.0.0.1 -W 1 -i 0 > tst_iptables.out 2>&1
 	if [ $? -ne 0 ]; then
 		tst_res TFAIL "iptables blocking loopback. This is expected" \
 			       "behaviour on certain distributions where" \
@@ -174,7 +174,7 @@ test3()
 	fi
 
 	tst_res TINFO "Pinging 127.0.0.1"
-	ping -c 2 127.0.0.1 > tst_iptables.out 2>&1
+	ping -c 2 127.0.0.1 -W 1 -i 0 > tst_iptables.out 2>&1
 	if [ $? -ne 0 ]; then
 		grep "100% packet loss" tst_iptables.out > tst_iptables.err 2>&1
 		if [ $? -ne 0 ]; then
@@ -198,7 +198,7 @@ test3()
 		return
 	fi
 	tst_res TINFO "Pinging 127.0.0.1 again"
-	ping -c 2 127.0.0.1 > tst_iptables.out 2>&1
+	ping -c 2 127.0.0.1 -W 1 -i 0 > tst_iptables.out 2>&1
 	if [ $? -ne 0 ]; then
 		tst_res TFAIL "iptables blocking ping requests. This is" \
 			      "expected behaviour on certain distributions" \
@@ -332,7 +332,7 @@ test6()
 	fi
 
 	tst_res TINFO "ping 127.0.0.1"
-	ping -c 10 127.0.0.1 > tst_iptables.out 2>&1
+	ping -c 10 127.0.0.1 -W 1 -i 0 > tst_iptables.out 2>&1
 	if [ $? -eq 0 ]; then
 		sleep 2
 		logcnt=$(dmesg | grep -c "$logprefix")
-- 
2.20.1

