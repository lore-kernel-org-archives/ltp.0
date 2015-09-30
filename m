From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 30 Sep 2015 16:09:20 +0300
Subject: [LTP] [PATCH 02/10] network/nfs: rename nfs dir to nfs_stress
In-Reply-To: <1443618568-29200-1-git-send-email-alexey.kodanev@oracle.com>
References: <1443618568-29200-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1443618568-29200-2-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/.gitignore                  |    2 +-
 testcases/network/nfs/nfs01/Makefile          |   29 ------
 testcases/network/nfs/nfs01/nfs01             |  103 --------------------
 testcases/network/nfs/nfs01/open_files.c      |  126 -------------------------
 testcases/network/nfs/nfs_stress/Makefile     |   29 ++++++
 testcases/network/nfs/nfs_stress/nfs01        |  103 ++++++++++++++++++++
 testcases/network/nfs/nfs_stress/open_files.c |  126 +++++++++++++++++++++++++
 7 files changed, 259 insertions(+), 259 deletions(-)
 delete mode 100644 testcases/network/nfs/nfs01/Makefile
 delete mode 100755 testcases/network/nfs/nfs01/nfs01
 delete mode 100644 testcases/network/nfs/nfs01/open_files.c
 create mode 100644 testcases/network/nfs/nfs_stress/Makefile
 create mode 100755 testcases/network/nfs/nfs_stress/nfs01
 create mode 100644 testcases/network/nfs/nfs_stress/open_files.c

diff --git a/testcases/network/.gitignore b/testcases/network/.gitignore
index aa6d4da..eae306a 100644
--- a/testcases/network/.gitignore
+++ b/testcases/network/.gitignore
@@ -17,7 +17,7 @@
 /multicast/mc_member/mc_member_test
 /multicast/mc_opts/mc_verify_opts
 /multicast/mc_opts/mc_verify_opts_error
-/nfs/nfs01/open_files
+/nfs/nfs_stress/open_files
 /nfs/nfs04/nfs04_create_file
 /nfs/nfs_fsstress/fsstress
 /nfs/nfslock01/nfs_flock
diff --git a/testcases/network/nfs/nfs01/Makefile b/testcases/network/nfs/nfs01/Makefile
deleted file mode 100644
index 64d9819..0000000
--- a/testcases/network/nfs/nfs01/Makefile
+++ /dev/null
@@ -1,29 +0,0 @@
-#
-#    network/nfs/nfs01 testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Garrett Cooper, July 2009
-#
-
-top_srcdir		?= ../../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-INSTALL_TARGETS		:= nfs01
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/nfs/nfs01/nfs01 b/testcases/network/nfs/nfs01/nfs01
deleted file mode 100755
index eab2e74..0000000
--- a/testcases/network/nfs/nfs01/nfs01
+++ /dev/null
@@ -1,103 +0,0 @@
-#!/bin/sh
-# Copyright (c) 2015 Oracle and/or its affiliates. All Rights Reserved.
-# Copyright (c) International Business Machines  Corp., 2001
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of
-# the License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it would be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program. If not, see <http://www.gnu.org/licenses/>.
-#
-#  PURPOSE: Stresses NFS by opening a large number of files on a nfs
-#           mounted filesystem.
-#
-#  SETUP: The home directory of root on the machine exported as "RHOST"
-#         MUST have a ".rhosts" file with the hostname of the machine
-#         where the test is executed.
-#
-#
-# Ported by Robbie Williamson (robbiew@us.ibm.com)
-
-
-TCID="nfs01"
-TST_TOTAL=1
-TST_CLEANUP="cleanup"
-
-. test_net.sh
-
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
-do_test()
-{
-	tst_resm TINFO "starting 'open_files $NFILES'"
-	ROD open_files $NFILES
-
-	cd $LTPROOT
-	ROD umount $TST_TMPDIR
-	tst_resm TPASS "test finished successfully"
-}
-
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
-setup_testcase
-do_test
-
-tst_exit
diff --git a/testcases/network/nfs/nfs01/open_files.c b/testcases/network/nfs/nfs01/open_files.c
deleted file mode 100644
index 9342f11..0000000
--- a/testcases/network/nfs/nfs01/open_files.c
+++ /dev/null
@@ -1,126 +0,0 @@
-#include <stdio.h>
-#include <errno.h>
-#include <stdarg.h>
-#include <stdlib.h>
-#include <string.h>
-#include <fcntl.h>
-#include <sys/param.h>
-#include <sys/wait.h>
-#include <dirent.h>
-#include <sys/stat.h>
-#include <unistd.h>
-
-#define TEMPLATE "ltpXXXXXX"
-
-int write_something(int);
-void delete_files(void);
-void abortx(char *fmt, ...);
-
-int main(int argc, char *argv[])
-{
-	int filedes[25500];
-	int i, n, first, n_files;
-	int cid, fork_number;
-	int status;
-	char filename[PATH_MAX];
-
-	if (argc != 2) {
-		fprintf(stderr, "Usage: %s <number of files>\n", argv[0]);
-		exit(1);
-	}
-
-	n = sscanf(argv[1], "%d", &n_files);
-	if (n != 1) {
-		fprintf(stderr, "Usage: %s <number of files>\n", argv[0]);
-		exit(1);
-	}
-
-	first = 0;
-	fork_number = 0;
-	for (n = 0; n < n_files; n++) {
-		strcpy(filename, TEMPLATE);
-		filedes[n] = mkstemp(filename);
-		if (filedes[n] == -1) {
-			if (errno != EMFILE)
-				abortx
-				    ("open() error: file = \"%s\", errno = %d",
-				     filename, errno);
-			else {
-				if ((cid = fork())) {
-					if (cid == -1)
-						abortx("Error forking child");
-					else {
-						waitpid(cid, &status, 0);
-						for (i = first; i < n; i++)
-							if (!write_something
-							    (filedes[i]))
-								abortx
-								    ("Error writing to files");
-						if (fork_number == 0)
-							delete_files();
-						exit(WEXITSTATUS(status));
-					}
-				} else {
-					fork_number++;
-					for (i = first; i < n; i++)
-						close(filedes[i]);
-					first = n;
-					n--;
-				}
-			}
-		}
-	}
-
-	for (i = first; i < n; i++)
-		if (!write_something(filedes[i]))
-			abortx("Error writing to files");
-	if (fork_number == 0)
-		delete_files();
-	exit(0);
-}
-
-int write_something(int fd)
-{
-	int rc;
-	const char msg[] = "I Love Linux!!!\n";
-	int msg_len = strlen(msg);
-
-	rc = write(fd, msg, msg_len);
-	if (rc != msg_len)
-		return (0);
-	if (close(fd))
-		return (0);
-	return (1);
-}
-
-void delete_files(void)
-{
-	DIR *dirp;
-	struct dirent *entp;
-	struct stat stat_buffer;
-
-	dirp = opendir(".");
-	for (entp = readdir(dirp); entp; entp = readdir(dirp))
-		if (!strncmp(entp->d_name, "apt", 3)) {
-			if (stat(entp->d_name, &stat_buffer))
-				abortx("stat() failed for \"%s\", errno = %d",
-				       entp->d_name, errno);
-			if (stat_buffer.st_size != 23)
-				abortx("wrong file size for \"%s\"",
-				       entp->d_name);
-			if (unlink(entp->d_name))
-				abortx("unlink failed for \"%s\"",
-				       entp->d_name);
-		}
-}
-
-void abortx(char *fmt, ...)
-{
-	va_list args;
-
-	va_start(args, fmt);
-	vfprintf(stderr, fmt, args);
-	va_end(args);
-	fprintf(stderr, "\n");
-	exit(1);
-}
diff --git a/testcases/network/nfs/nfs_stress/Makefile b/testcases/network/nfs/nfs_stress/Makefile
new file mode 100644
index 0000000..64d9819
--- /dev/null
+++ b/testcases/network/nfs/nfs_stress/Makefile
@@ -0,0 +1,29 @@
+#
+#    network/nfs/nfs01 testcases Makefile.
+#
+#    Copyright (C) 2009, Cisco Systems Inc.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+# Garrett Cooper, July 2009
+#
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+
+INSTALL_TARGETS		:= nfs01
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/nfs/nfs_stress/nfs01 b/testcases/network/nfs/nfs_stress/nfs01
new file mode 100755
index 0000000..eab2e74
--- /dev/null
+++ b/testcases/network/nfs/nfs_stress/nfs01
@@ -0,0 +1,103 @@
+#!/bin/sh
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
+#
+#  PURPOSE: Stresses NFS by opening a large number of files on a nfs
+#           mounted filesystem.
+#
+#  SETUP: The home directory of root on the machine exported as "RHOST"
+#         MUST have a ".rhosts" file with the hostname of the machine
+#         where the test is executed.
+#
+#
+# Ported by Robbie Williamson (robbiew@us.ibm.com)
+
+
+TCID="nfs01"
+TST_TOTAL=1
+TST_CLEANUP="cleanup"
+
+. test_net.sh
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
+do_test()
+{
+	tst_resm TINFO "starting 'open_files $NFILES'"
+	ROD open_files $NFILES
+
+	cd $LTPROOT
+	ROD umount $TST_TMPDIR
+	tst_resm TPASS "test finished successfully"
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
+
+# Check if current filesystem is NFS
+if [ "$(stat -f . | grep "Type: nfs")" ]; then
+	tst_resm TCONF "Cannot run nfs-stress test on mounted NFS"
+fi
+
+setup_testcase
+do_test
+
+tst_exit
diff --git a/testcases/network/nfs/nfs_stress/open_files.c b/testcases/network/nfs/nfs_stress/open_files.c
new file mode 100644
index 0000000..9342f11
--- /dev/null
+++ b/testcases/network/nfs/nfs_stress/open_files.c
@@ -0,0 +1,126 @@
+#include <stdio.h>
+#include <errno.h>
+#include <stdarg.h>
+#include <stdlib.h>
+#include <string.h>
+#include <fcntl.h>
+#include <sys/param.h>
+#include <sys/wait.h>
+#include <dirent.h>
+#include <sys/stat.h>
+#include <unistd.h>
+
+#define TEMPLATE "ltpXXXXXX"
+
+int write_something(int);
+void delete_files(void);
+void abortx(char *fmt, ...);
+
+int main(int argc, char *argv[])
+{
+	int filedes[25500];
+	int i, n, first, n_files;
+	int cid, fork_number;
+	int status;
+	char filename[PATH_MAX];
+
+	if (argc != 2) {
+		fprintf(stderr, "Usage: %s <number of files>\n", argv[0]);
+		exit(1);
+	}
+
+	n = sscanf(argv[1], "%d", &n_files);
+	if (n != 1) {
+		fprintf(stderr, "Usage: %s <number of files>\n", argv[0]);
+		exit(1);
+	}
+
+	first = 0;
+	fork_number = 0;
+	for (n = 0; n < n_files; n++) {
+		strcpy(filename, TEMPLATE);
+		filedes[n] = mkstemp(filename);
+		if (filedes[n] == -1) {
+			if (errno != EMFILE)
+				abortx
+				    ("open() error: file = \"%s\", errno = %d",
+				     filename, errno);
+			else {
+				if ((cid = fork())) {
+					if (cid == -1)
+						abortx("Error forking child");
+					else {
+						waitpid(cid, &status, 0);
+						for (i = first; i < n; i++)
+							if (!write_something
+							    (filedes[i]))
+								abortx
+								    ("Error writing to files");
+						if (fork_number == 0)
+							delete_files();
+						exit(WEXITSTATUS(status));
+					}
+				} else {
+					fork_number++;
+					for (i = first; i < n; i++)
+						close(filedes[i]);
+					first = n;
+					n--;
+				}
+			}
+		}
+	}
+
+	for (i = first; i < n; i++)
+		if (!write_something(filedes[i]))
+			abortx("Error writing to files");
+	if (fork_number == 0)
+		delete_files();
+	exit(0);
+}
+
+int write_something(int fd)
+{
+	int rc;
+	const char msg[] = "I Love Linux!!!\n";
+	int msg_len = strlen(msg);
+
+	rc = write(fd, msg, msg_len);
+	if (rc != msg_len)
+		return (0);
+	if (close(fd))
+		return (0);
+	return (1);
+}
+
+void delete_files(void)
+{
+	DIR *dirp;
+	struct dirent *entp;
+	struct stat stat_buffer;
+
+	dirp = opendir(".");
+	for (entp = readdir(dirp); entp; entp = readdir(dirp))
+		if (!strncmp(entp->d_name, "apt", 3)) {
+			if (stat(entp->d_name, &stat_buffer))
+				abortx("stat() failed for \"%s\", errno = %d",
+				       entp->d_name, errno);
+			if (stat_buffer.st_size != 23)
+				abortx("wrong file size for \"%s\"",
+				       entp->d_name);
+			if (unlink(entp->d_name))
+				abortx("unlink failed for \"%s\"",
+				       entp->d_name);
+		}
+}
+
+void abortx(char *fmt, ...)
+{
+	va_list args;
+
+	va_start(args, fmt);
+	vfprintf(stderr, fmt, args);
+	va_end(args);
+	fprintf(stderr, "\n");
+	exit(1);
+}
-- 
1.7.1

