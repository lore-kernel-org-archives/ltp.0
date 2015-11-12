From: Cedric Hnyda <chnyda@suse.com>
Date: Thu, 12 Nov 2015 15:08:09 +0100
Subject: [LTP]  [PATCH v2] controllers/pids: Add new testcases
Message-ID: <1447337289-15226-1-git-send-email-chnyda@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Created new testcase to test the pids controller
which is used to stop any new tasks from being fork()'d
after a certain limit is reached.

Signed-off-by: Cedric Hnyda <chnyda@suse.com>
---
 runtest/controllers                           |   2 +
 testcases/kernel/controllers/pids/.gitignore  |   1 +
 testcases/kernel/controllers/pids/Makefile    |  28 +++++++
 testcases/kernel/controllers/pids/pids.sh     | 109 ++++++++++++++++++++++++++
 testcases/kernel/controllers/pids/pids_task.c |  60 ++++++++++++++
 5 files changed, 200 insertions(+)
 create mode 100644 testcases/kernel/controllers/pids/.gitignore
 create mode 100644 testcases/kernel/controllers/pids/Makefile
 create mode 100644 testcases/kernel/controllers/pids/pids.sh
 create mode 100644 testcases/kernel/controllers/pids/pids_task.c

diff --git a/runtest/controllers b/runtest/controllers
index c62bcce..cad9d7b 100644
--- a/runtest/controllers
+++ b/runtest/controllers
@@ -277,3 +277,5 @@ cpuset_memory_spread	cpuset_memory_spread_testset.sh
 cpuset_regression_test cpuset_regression_test.sh
 
 cgroup_xattr	cgroup_xattr
+
+pids pids.sh
diff --git a/testcases/kernel/controllers/pids/.gitignore b/testcases/kernel/controllers/pids/.gitignore
new file mode 100644
index 0000000..d7d4e14
--- /dev/null
+++ b/testcases/kernel/controllers/pids/.gitignore
@@ -0,0 +1 @@
+/pids_task
diff --git a/testcases/kernel/controllers/pids/Makefile b/testcases/kernel/controllers/pids/Makefile
new file mode 100644
index 0000000..6500363
--- /dev/null
+++ b/testcases/kernel/controllers/pids/Makefile
@@ -0,0 +1,28 @@
+#
+#    Copyright (C) 2015, SUSE
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
+# Author: Cedric Hnyda <chnyda@suse.com>
+#
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(abs_srcdir)/../Makefile.inc
+
+INSTALL_TARGETS		:= *.sh
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/controllers/pids/pids.sh b/testcases/kernel/controllers/pids/pids.sh
new file mode 100644
index 0000000..de92ad4
--- /dev/null
+++ b/testcases/kernel/controllers/pids/pids.sh
@@ -0,0 +1,109 @@
+#!/bin/sh
+
+################################################################################
+##                                                                            ##
+## Copyright (c) 2015 SUSE                                                    ##
+##                                                                            ##
+## This program is free software;  you can redistribute it and#or modify      ##
+## it under the terms of the GNU General Public License as published by       ##
+## the Free Software Foundation; either version 2 of the License, or          ##
+## (at your option) any later version.                                        ##
+##                                                                            ##
+## This program is distributed in the hope that it will be useful, but        ##
+## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
+## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
+## for more details.                                                          ##
+##                                                                            ##
+## You should have received a copy of the GNU General Public License          ##
+## along with this program;  if not, write to the Free Software               ##
+## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301   ##
+## USA                                                                        ##
+##                                                                            ##
+## Author: Cedric Hnyda <chnyda@suse.com>                                     ##
+##                                                                            ##
+################################################################################
+
+# Usage
+# ./pids.sh
+#
+# Description
+#
+# 1) Find if pids is mounted, if not mounted, pids will be mounted
+# 2) Limit the number of pid avalaible and try to fork with pid_task
+#
+
+export TCID="pids"
+export TST_TOTAL=2
+mounted=1
+
+. test.sh
+
+cleanup()
+{
+	tst_resm TINFO "removing created directories"
+	rmdir $testpath
+	if [ "$mounted" -ne "1" ]; then
+		tst_resm TINFO "Umounting pids"
+		umount $mount_point
+		rmdir $mount_point
+	fi
+}
+
+setup()
+{
+	tst_require_root
+
+	exist=`grep -w pids /proc/cgroups | cut -f1`;
+	if [ "$exist" = "" ]; then
+		tst_brkm TCONF NULL "pids not supported"
+	fi
+
+	mount_point=`grep -w pids /proc/mounts | cut -f 2 | cut -d " " -f2`
+
+	if [ "$mount_point" = "" ]; then
+		mounted=0
+		mount_point=/dev/cgroup
+	fi
+
+	TST_CLEANUP=cleanup
+
+	testpath=$mount_point/ltp_$TCID
+
+	if [ "$mounted" -eq "0" ]; then
+		ROD mkdir -p $mount_point
+		ROD mount -t cgroup -o pids none $mount_point
+	fi
+	ROD mkdir -p $testpath
+}
+
+setup;
+
+tst_resm TINFO "Restrict the number of pid to 1"
+ROD echo 1 > $testpath/pids.max
+
+pids_task "$testpath/tasks"
+ret=$?
+
+if [ "$ret" -eq "2" ]; then
+	tst_resm TPASS "fork failed as expected"
+elif [ "$ret" -eq "0" ]; then
+	tst_resm TFAIL "fork didn't fail despite the limit"
+else
+	tst_resm TBROK "failed to open $testpath/tasks"
+fi
+
+tst_resm TINFO "Increase the number of avalaible pid to 2"
+ROD echo 2 > $testpath/pids.max
+
+pids_task "$testpath/tasks"
+ret=$?
+
+if [ "$ret" -eq "2" ]; then
+	tst_resm TFAIL "fork failed unexpectedly"
+elif [ "$ret" -eq "0" ]; then
+	tst_resm TPASS "fork worked as expected"
+else
+	tst_resm TBROK "failed to open $testpath/tasks"
+fi
+
+tst_exit
diff --git a/testcases/kernel/controllers/pids/pids_task.c b/testcases/kernel/controllers/pids/pids_task.c
new file mode 100644
index 0000000..3543789
--- /dev/null
+++ b/testcases/kernel/controllers/pids/pids_task.c
@@ -0,0 +1,60 @@
+/*
+ * Copyright (c) 2015 Cedric Hnyda <chnyda@suse.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write the Free Software Foundation,
+ * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+/*
+* Description:
+* Write the current process in argv[1]
+* and returns:
+*	-> 2 if fork fails with EAGAIN,
+*	-> 1 if there is another problem
+*	-> 0 if everything worked
+*/
+
+#include <stdio.h>
+#include <sys/time.h>
+#include <sys/types.h>
+#include <unistd.h>
+#include <errno.h>
+#include <stdlib.h>
+
+int main(int argc, char **argv)
+{
+	FILE *f;
+	int newpid;
+
+	if (argc != 2) {
+		fprintf(stderr, "Usage: %s /cgroup/.../tasks\n", argv[0]);
+		return 1;
+	}
+
+	f = fopen(argv[1], "a");
+	if (!f) {
+		perror("fopen failed");
+		return 1;
+	}
+
+	fprintf(f, "%i\n", getpid());
+	fclose(f);
+
+	newpid = fork();
+	if (newpid == -1 && errno == EAGAIN)
+		return 2;
+	if (newpid == -1)
+		return 1;
+	return 0;
+}
-- 
2.1.4

