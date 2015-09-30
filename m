From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 30 Sep 2015 16:09:21 +0300
Subject: [LTP] [PATCH 03/10] network/nfs_stress: move common code from nfs01
	to library
In-Reply-To: <1443618568-29200-1-git-send-email-alexey.kodanev@oracle.com>
References: <1443618568-29200-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1443618568-29200-3-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/nfs/nfs_stress/Makefile   |    3 +-
 testcases/network/nfs/nfs_stress/nfs01      |   62 +-----------------------
 testcases/network/nfs/nfs_stress/nfs_lib.sh |   70 +++++++++++++++++++++++++++
 3 files changed, 73 insertions(+), 62 deletions(-)
 create mode 100644 testcases/network/nfs/nfs_stress/nfs_lib.sh

diff --git a/testcases/network/nfs/nfs_stress/Makefile b/testcases/network/nfs/nfs_stress/Makefile
index 64d9819..58e24d0 100644
--- a/testcases/network/nfs/nfs_stress/Makefile
+++ b/testcases/network/nfs/nfs_stress/Makefile
@@ -24,6 +24,7 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/env_pre.mk
 
-INSTALL_TARGETS		:= nfs01
+INSTALL_TARGETS		:= nfs_lib.sh \
+			   nfs01
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/nfs/nfs_stress/nfs01 b/testcases/network/nfs/nfs_stress/nfs01
index eab2e74..986855e 100755
--- a/testcases/network/nfs/nfs_stress/nfs01
+++ b/testcases/network/nfs/nfs_stress/nfs01
@@ -18,60 +18,15 @@
 #  PURPOSE: Stresses NFS by opening a large number of files on a nfs
 #           mounted filesystem.
 #
-#  SETUP: The home directory of root on the machine exported as "RHOST"
-#         MUST have a ".rhosts" file with the hostname of the machine
-#         where the test is executed.
-#
-#
 # Ported by Robbie Williamson (robbiew@us.ibm.com)
 
-
 TCID="nfs01"
 TST_TOTAL=1
 TST_CLEANUP="cleanup"
 
+. nfs_lib.sh
 . test_net.sh
 
-setup_testcase()
-{
-	VERSION=${VERSION:=3}
-	NFILES=${NFILES:=1000}
-	SOCKET_TYPE="${SOCKET_TYPE:=udp}${TST_IPV6}"
-	NFS_TYPE=${NFS_TYPE:=nfs}
-
-	tst_check_cmds mount exportfs
-
-	tst_tmpdir
-
-	tst_resm TINFO "NFS_TYPE: $NFS_TYPE, NFS VERSION: $VERSION"
-	tst_resm TINFO "NFILES: $NFILES, SOCKET_TYPE: $SOCKET_TYPE"
-
-	if [ "$NFS_TYPE" != "nfs4" ]; then
-		OPTS=${OPTS:="-o proto=$SOCKET_TYPE,vers=$VERSION "}
-	fi
-
-	tst_rhost_run -s -c "mkdir -p $TST_TMPDIR"
-
-	if [ $TST_IPV6 ]; then
-		REMOTE_DIR="[$(tst_ipaddr rhost)]:$TST_TMPDIR"
-	else
-		REMOTE_DIR="$(tst_ipaddr rhost):$TST_TMPDIR"
-	fi
-
-	if [ "$NFS_TYPE" = "nfs4" ]; then
-		tst_rhost_run -s -c "mkdir -p /export$TST_TMPDIR"
-		tst_rhost_run -s -c "mount --bind $TST_TMPDIR /export$TST_TMPDIR"
-		tst_rhost_run -s -c "exportfs -o no_root_squash,rw,nohide,\
-			insecure,no_subtree_check *:$TST_TMPDIR"
-	else
-		tst_rhost_run -s -c "exportfs -i -o no_root_squash,rw \
-			*:$TST_TMPDIR"
-	fi
-
-	tst_resm TINFO "Mounting NFS '$REMOTE_DIR' with options '$OPTS'"
-	ROD mount -t $NFS_TYPE $OPTS $REMOTE_DIR $TST_TMPDIR
-}
-
 do_test()
 {
 	tst_resm TINFO "starting 'open_files $NFILES'"
@@ -82,21 +37,6 @@ do_test()
 	tst_resm TPASS "test finished successfully"
 }
 
-cleanup()
-{
-	tst_resm TINFO "Cleaning up testcase"
-	cd $LTPROOT
-	grep -q "$TST_TMPDIR" /proc/mounts && umount $TST_TMPDIR
-
-	tst_rhost_run -c "exportfs -u *:$TST_TMPDIR"
-	tst_rhost_run -c "rm -rf $TST_TMPDIR"
-}
-
-# Check if current filesystem is NFS
-if [ "$(stat -f . | grep "Type: nfs")" ]; then
-	tst_resm TCONF "Cannot run nfs-stress test on mounted NFS"
-fi
-
 setup_testcase
 do_test
 
diff --git a/testcases/network/nfs/nfs_stress/nfs_lib.sh b/testcases/network/nfs/nfs_stress/nfs_lib.sh
new file mode 100644
index 0000000..7867b17
--- /dev/null
+++ b/testcases/network/nfs/nfs_stress/nfs_lib.sh
@@ -0,0 +1,70 @@
+# Copyright (c) 2015 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) International Business Machines  Corp., 2001
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program. If not, see <http://www.gnu.org/licenses/>.
+
+setup_testcase()
+{
+	VERSION=${VERSION:=3}
+	NFILES=${NFILES:=1000}
+	SOCKET_TYPE="${SOCKET_TYPE:=udp}${TST_IPV6}"
+	NFS_TYPE=${NFS_TYPE:=nfs}
+
+	tst_check_cmds mount exportfs
+
+	tst_tmpdir
+
+	# Check if current filesystem is NFS
+	if [ "$(stat -f . | grep "Type: nfs")" ]; then
+		tst_brkm TCONF "Cannot run nfs-stress test on mounted NFS"
+	fi
+
+	tst_resm TINFO "NFS_TYPE: $NFS_TYPE, NFS VERSION: $VERSION"
+	tst_resm TINFO "NFILES: $NFILES, SOCKET_TYPE: $SOCKET_TYPE"
+
+	if [ "$NFS_TYPE" != "nfs4" ]; then
+		OPTS=${OPTS:="-o proto=$SOCKET_TYPE,vers=$VERSION "}
+	fi
+
+	tst_rhost_run -s -c "mkdir -p $TST_TMPDIR"
+
+	if [ $TST_IPV6 ]; then
+		REMOTE_DIR="[$(tst_ipaddr rhost)]:$TST_TMPDIR"
+	else
+		REMOTE_DIR="$(tst_ipaddr rhost):$TST_TMPDIR"
+	fi
+
+	if [ "$NFS_TYPE" = "nfs4" ]; then
+		tst_rhost_run -s -c "mkdir -p /export$TST_TMPDIR"
+		tst_rhost_run -s -c "mount --bind $TST_TMPDIR /export$TST_TMPDIR"
+		tst_rhost_run -s -c "exportfs -o no_root_squash,rw,nohide,\
+			insecure,no_subtree_check *:$TST_TMPDIR"
+	else
+		tst_rhost_run -s -c "exportfs -i -o no_root_squash,rw \
+			*:$TST_TMPDIR"
+	fi
+
+	tst_resm TINFO "Mounting NFS '$REMOTE_DIR' with options '$OPTS'"
+	ROD mount -t $NFS_TYPE $OPTS $REMOTE_DIR $TST_TMPDIR
+}
+
+cleanup()
+{
+	tst_resm TINFO "Cleaning up testcase"
+	cd $LTPROOT
+	grep -q "$TST_TMPDIR" /proc/mounts && umount $TST_TMPDIR
+
+	tst_rhost_run -c "exportfs -u *:$TST_TMPDIR"
+	tst_rhost_run -c "rm -rf $TST_TMPDIR"
+}
-- 
1.7.1

