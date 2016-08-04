From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu,  4 Aug 2016 13:33:19 +0300
Subject: [LTP] [PATCH 2/2] network/nfs06: rewrite the test and change
	test-cases
In-Reply-To: <1470306799-10970-1-git-send-email-alexey.kodanev@oracle.com>
References: <1470306799-10970-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1470306799-10970-2-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Changes:
* instead of NFSv2 & NFSv3 test runs NFSv3, 4, 4.1 & 4.2.
* remove test duration, fsstress processes are running with '1 loop'
  parameter. After a process completes, test will check its status.
* sar statistic was removed for now. Test didn't handle it and just
  saved it to a file.
* add '-c' option, which prevents fsstress to cleanup its files as
  there can be multiple processes running and using the same files.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 runtest/net.nfs                        |    4 +
 testcases/network/nfs/nfs_stress/nfs06 |  168 +++++++++++---------------------
 2 files changed, 61 insertions(+), 111 deletions(-)

diff --git a/runtest/net.nfs b/runtest/net.nfs
index 9898f1b..0bbe7c3 100644
--- a/runtest/net.nfs
+++ b/runtest/net.nfs
@@ -47,6 +47,10 @@ nfs4_ipv6_05 nfs05 -6 -v 4 -t tcp
 nfs41_ipv6_05 nfs05 -6 -v 4.1 -t tcp
 nfs42_ipv6_05 nfs05 -6 -v 4.2 -t tcp
 
+nfs06 nfs06 -v "3 3 3 4 4 4" -t "udp udp tcp tcp tcp tcp"
+nfs06 nfs06 -v "3 4 4.1 4.2 4.2 4.2" -t "udp tcp tcp tcp tcp tcp"
+nfs06 nfs06 -6 -v "4 4.1 4.1 4.2 4.2 4.2" -t "tcp tcp tcp tcp tcp tcp"
+
 nfslock3_01 nfslock01 -v 3 -t udp
 nfslock4_01 nfslock01 -v 4 -t tcp
 nfslock41_01 nfslock01 -v 4.1 -t tcp
diff --git a/testcases/network/nfs/nfs_stress/nfs06 b/testcases/network/nfs/nfs_stress/nfs06
index 1bb2c2d..ff46509 100755
--- a/testcases/network/nfs/nfs_stress/nfs06
+++ b/testcases/network/nfs/nfs_stress/nfs06
@@ -1,117 +1,63 @@
 #!/bin/sh
+# Copyright (c) 2016 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) International Business Machines  Corp., 2003
 #
-#   Copyright (c) International Business Machines  Corp., 2003
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
 #
-#   This program is free software;  you can redistribute it and/or modify
-#   it under the terms of the GNU General Public License as published by
-#   the Free Software Foundation; either version 2 of the License, or
-#   (at your option) any later version.
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
 #
-#   This program is distributed in the hope that it will be useful,
-#   but WITHOUT ANY WARRANTY;  without even the implie; warranty of
-#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#   the GNU General Public License for more details.
-#
-#   You should have received a copy of the GNU General Public License
-#   along with this program;  if not, write to the Free Software
-#   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-#
-#
-#  FILE   : nfs_fsstress.sh
+# You should have received a copy of the GNU General Public License
+# along with this program. If not, see <http://www.gnu.org/licenses/>.
 #
 #  PURPOSE: Runs fsstress over an NFS mount point for a specified amount
-#          of time.  The test will also start 'sar' to monitor the system
-#	   utilization data.  The purpose of this test is to stress the
-#	   NFS kernel code and possibly the underlying filesystem where
-#	   the export resides.  A PASS is if the test completes.
-#
-#  PREREQUISITE: There must exist an NFS exported filesystem available to
-#		test on.
-#
-#
-#  HISTORY:
-#    11/21/03 Robbie Williamson (robbiew@us.ibm.com)
-#      -Written
-#
-#***********************************************************************
-
-#Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-
-$trace_logic
-
-echo -n "Please enter the server location of the NFS exported filesystem: "
-read RHOST
-echo -n "Please enter the name of the NFS exported filesystem: "
-read FILESYSTEM
-echo -n "Please enter the test duration in hours: "
-read DURATION
-
-HOSTNAME=$(hostname | awk {'print $1'})
-
-#Convert to seconds
-DURATION=$(( $DURATION * 60 * 60 ))
-
-echo "Setting up local mount points"
-mkdir -p /tmp/udp/2/${HOSTNAME}1
-mkdir -p /tmp/tcp/2/${HOSTNAME}2
-mkdir -p /tmp/udp/3/${HOSTNAME}3
-mkdir -p /tmp/tcp/3/${HOSTNAME}4
-
-echo "Mounting NFS filesystem"
-mount -o "intr,soft,proto=udp,vers=2" $RHOST:$FILESYSTEM /tmp/udp/2/${HOSTNAME}1 >/dev/null 2>&1
-if [ $? -ne 0 ];then
-  echo "Error: mount using UDP & version 2 failed"
-  exit 1
-fi
-mount -o "intr,soft,proto=tcp,vers=2" $RHOST:$FILESYSTEM /tmp/tcp/2/${HOSTNAME}2 >/dev/null 2>&1
-if [ $? -ne 0 ];then
-  echo "Error: mount using TCP & version 2 failed"
-  exit 1
-fi
-mount -o "intr,soft,proto=udp,vers=3" $RHOST:$FILESYSTEM /tmp/udp/3/${HOSTNAME}3 >/dev/null 2>&1
-if [ $? -ne 0 ];then
-  echo "Error: mount using UDP & version 3 failed"
-  exit 1
-fi
-mount -o "intr,soft,proto=tcp,vers=3" $RHOST:$FILESYSTEM /tmp/tcp/3/${HOSTNAME}4 >/dev/null 2>&1
-if [ $? -ne 0 ];then
-  echo "Error: mount using TCP & version 3 failed"
-  exit 1
-fi
-
-echo "Test set for $DURATION seconds. Starting test processes now."
-./fsstress -l 0 -d /tmp/udp/2/${HOSTNAME}1 -n 1000 -p 50 -r > /tmp/nfs_fsstress.udp.2.log 2>&1 &
-./fsstress -l 0 -d /tmp/udp/3/${HOSTNAME}2 -n 1000 -p 50 -r > /tmp/nfs_fsstress.udp.3.log 2>&1 &
-./fsstress -l 0 -d /tmp/tcp/2/${HOSTNAME}3 -n 1000 -p 50 -r > /tmp/nfs_fsstress.tcp.2.log 2>&1 &
-./fsstress -l 0 -d /tmp/tcp/3/${HOSTNAME}4 -n 1000 -p 50 -r > /tmp/nfs_fsstress.tcp.3.log 2>&1 &
-
-echo "Starting sar"
-sar -o /tmp/nfs_fsstress.sardata 30 0 &
-
-echo "Testing in progress"
-sleep $DURATION
-echo "Testing done. Killing processes."
-killall -9 sadc
-killall -9 fsstress
-ps -ef | grep -v grep | grep fsstress > /dev/null 2>&1
-TESTING=$?
-while [ $TESTING -eq 0 ]
-do
-  killall -9 fsstress
-  echo -n "."
-  sleep 5
-  ps -ef | grep -v grep | grep -v nfs_fsstress | grep fsstress > /dev/null 2>&1
-  TESTING=$?
-done
-echo " "
-echo "All processes killed."
-echo "Unmounting NFS filesystem"
-umount /tmp/udp/2/${HOSTNAME}1
-umount /tmp/tcp/2/${HOSTNAME}2
-umount /tmp/udp/3/${HOSTNAME}3
-umount /tmp/tcp/3/${HOSTNAME}4
-echo " Testing Complete: PASS"
-
-
+#           of time.  The test will also start 'sar' to monitor the system
+#           utilization data.  The purpose of this test is to stress the
+#           NFS kernel code and possibly the underlying filesystem where
+#           the export resides.  A PASS is if the test completes.
+
+TCID=nfs06
+TST_TOTAL=1
+TST_CLEANUP="nfs_cleanup"
+
+. nfs_lib.sh
+. test_net.sh
+
+do_test()
+{
+	tst_resm TINFO "Starting fsstress processes on NFS mounts"
+
+	local n=0
+	local pids
+	for i in $VERSION; do
+		fsstress -l 1 -d $TST_TMPDIR/$i/$n -n 1000 -p 50 -r -c > /dev/null &
+		pids="$pids $!"
+		n=$(( n + 1 ))
+	done
+
+	tst_resm TINFO "waiting for pids:$pids"
+	for p in $pids; do
+		wait $p
+		if [ $? -ne 0 ]; then
+			kill -9 $pids
+			tst_brkm TFAIL "fsstress process failed"
+		else
+			tst_resm TINFO "fsstress '$p' completed"
+		fi
+	done
+
+	tst_resm TPASS "all fsstress processes completed on '$n' NFS mounts"
+}
+
+tst_check_cmds sar
+
+nfs_setup
+
+do_test
+
+tst_exit
-- 
1.7.1

