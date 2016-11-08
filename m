From: Petr Vorel <pvorel@suse.cz>
Date: Tue,  8 Nov 2016 19:05:16 +0100
Subject: [LTP] [PATCH 1/1] network: fix bashisms + shebang
Message-ID: <20161108180516.10498-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/nfs/nfs_stress/nfs_lib.sh | 1 +
 testcases/network/sockets/ltpSockets.sh     | 4 ++--
 testcases/network/virt/virt_lib.sh          | 3 ++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/testcases/network/nfs/nfs_stress/nfs_lib.sh b/testcases/network/nfs/nfs_stress/nfs_lib.sh
index 78df4d3..0abf39d 100644
--- a/testcases/network/nfs/nfs_stress/nfs_lib.sh
+++ b/testcases/network/nfs/nfs_stress/nfs_lib.sh
@@ -1,3 +1,4 @@
+#!/bin/sh
 # Copyright (c) 2015-2016 Oracle and/or its affiliates. All Rights Reserved.
 # Copyright (c) International Business Machines  Corp., 2001
 #
diff --git a/testcases/network/sockets/ltpSockets.sh b/testcases/network/sockets/ltpSockets.sh
index 48fa8c6..65b2320 100755
--- a/testcases/network/sockets/ltpSockets.sh
+++ b/testcases/network/sockets/ltpSockets.sh
@@ -54,10 +54,10 @@ echo "Starting UDP, TCP and Multicast tests..."
 echo "Starting ltpServer..."
 
 ./ltpServer $hostname1 &
-sleep 5s
+sleep 5
 echo "Starting ltpClient..."
 ./ltpClient $hostname1 $hostname1 $testdata
-sleep 1s
+sleep 1
 killall -9 ltpServer
 killall -9 ltpClient
 
diff --git a/testcases/network/virt/virt_lib.sh b/testcases/network/virt/virt_lib.sh
index ee6488c..df453e5 100644
--- a/testcases/network/virt/virt_lib.sh
+++ b/testcases/network/virt/virt_lib.sh
@@ -103,7 +103,8 @@ trap "tst_brkm TBROK 'test interrupted'" INT
 virt_add()
 {
 	local vname=$1
-	local opt="${@:2}"
+	shift
+	local opt="$*"
 
 	case $virt_type in
 	vlan|vxlan)
-- 
2.10.2

