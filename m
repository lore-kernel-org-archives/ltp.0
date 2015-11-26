From: Cedric Hnyda <chnyda@suse.com>
Date: Thu, 26 Nov 2015 11:07:03 +0100
Subject: [LTP]  [PATCH V5] controllers/pids: Add new testcases
Message-ID: <1448532423-767-1-git-send-email-chnyda@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Created new testcases to test the pids controller
which is used to stop any new tasks from being fork()'d
after a certain limit is reached.

Signed-off-by: Cedric Hnyda <chnyda@suse.com>
---
 runtest/controllers                            |  22 +++
 testcases/kernel/controllers/pids/.gitignore   |   2 +
 testcases/kernel/controllers/pids/Makefile     |  28 ++++
 testcases/kernel/controllers/pids/pids.sh      | 186 +++++++++++++++++++++++++
 testcases/kernel/controllers/pids/pids_task1.c |  60 ++++++++
 testcases/kernel/controllers/pids/pids_task2.c |  25 ++++
 6 files changed, 323 insertions(+)
 create mode 100644 testcases/kernel/controllers/pids/.gitignore
 create mode 100644 testcases/kernel/controllers/pids/Makefile
 create mode 100644 testcases/kernel/controllers/pids/pids.sh
 create mode 100644 testcases/kernel/controllers/pids/pids_task1.c
 create mode 100644 testcases/kernel/controllers/pids/pids_task2.c

diff --git a/runtest/controllers b/runtest/controllers
index c62bcce..254a0b0 100644
--- a/runtest/controllers
+++ b/runtest/controllers
@@ -277,3 +277,25 @@ cpuset_memory_spread	cpuset_memory_spread_testset.sh
 cpuset_regression_test cpuset_regression_test.sh
 
 cgroup_xattr	cgroup_xattr
+
+pids_1_1 pids.sh 1 1
+pids_1_2 pids.sh 1 2
+pids_1_10 pids.sh 1 10
+pids_1_50 pids.sh 1 50
+pids_1_100 pids.sh 1 100
+pids_2_1 pids.sh 2 1
+pids_2_2 pids.sh 2 2
+pids_2_10 pids.sh 2 10
+pids_2_50 pids.sh 2 50
+pids_2_100 pids.sh 2 100
+pids_3_1 pids.sh 3 1
+pids_3_2 pids.sh 3 2
+pids_3_10 pids.sh 3 10
+pids_3_50 pids.sh 3 50
+pids_3_100 pids.sh 3 100
+pids_4_1 pids.sh 4 1
+pids_4_2 pids.sh 4 2
+pids_4_10 pids.sh 4 10
+pids_4_50 pids.sh 4 50
+pids_4_100 pids.sh 4 100
+pids_5_1 pids.sh 5 1
diff --git a/testcases/kernel/controllers/pids/.gitignore b/testcases/kernel/controllers/pids/.gitignore
new file mode 100644
index 0000000..a87cce8
--- /dev/null
+++ b/testcases/kernel/controllers/pids/.gitignore
@@ -0,0 +1,2 @@
+/pids_task1
+/pids_task2
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
index 0000000..91ce51b
--- /dev/null
+++ b/testcases/kernel/controllers/pids/pids.sh
@@ -0,0 +1,186 @@
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
+# ./pids.sh caseno max
+#
+
+caseno=$1
+max=$2
+export TCID="pids_$1_$2"
+export TST_TOTAL=1
+mounted=1
+
+. test.sh
+
+usage()
+{
+	echo "usage: ./pids01 caseno max"
+	tst_resm TFAIL "invalid parameters"
+}
+
+cleanup()
+{
+	killall -9 pids_task2 >/dev/null
+
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
+start_pids_tasks2()
+{
+	nb=$1
+	for i in `seq 1 $nb`; do
+		pids_task2 &
+		echo $! > $testpath/tasks
+	done
+
+	if [ $(cat "$testpath/tasks" | wc -l) -ne $nb ]; then
+		tst_resm TBROK "..."
+	fi
+}
+
+case1()
+{
+	start_pids_tasks2 $max
+
+	# should return 0 because there is no limit
+	pids_task1 "$testpath/tasks"
+	ret=$?
+
+	if [ "$ret" -eq "2" ]; then
+		tst_resm TFAIL "fork failed unexpectedly"
+	elif [ "$ret" -eq "0" ]; then
+		tst_resm TPASS "fork didn't fail"
+	else
+		tst_resm TBROK "pids_task1 failed"
+	fi
+}
+
+case2()
+{
+	tmp=$((max - 1))
+	tst_resm TINFO "limit the number of pid to $max"
+	ROD echo $max > $testpath/pids.max
+
+	start_pids_tasks2 $tmp
+
+	# should return 2 because the limit of pids is reached
+	pids_task1 "$testpath/tasks"
+	ret=$?
+
+	if [ "$ret" -eq "2" ]; then
+		tst_resm TPASS "fork failed as expected"
+	elif [ "$ret" -eq "0" ]; then
+		tst_resm TFAIL "fork didn't fail despite the limit"
+	else
+		tst_resm TBROK "pids_task1 failed"
+	fi
+}
+
+case3()
+{
+	tmp=$((max + 1))
+	tst_resm TINFO "limit the number of avalaible pid to $tmp"
+	ROD echo $tmp > $testpath/pids.max
+
+	tmp=$((max - 2))
+	start_pids_tasks2 $tmp
+
+	pids_task1 "$testpath/tasks"
+	ret=$?
+
+	if [ "$ret" -eq "2" ]; then
+		tst_resm TFAIL "fork failed unexpectedly"
+	elif [ "$ret" -eq "0" ]; then
+		tst_resm TPASS "fork worked as expected"
+	else
+		tst_resm TBROK "pids_task1 failed"
+	fi
+}
+
+case4()
+{
+	tst_resm TINFO "limit the number of avalaible pid to 0"
+	ROD echo 0 > $testpath/pids.max
+
+	start_pids_tasks2 $max
+
+	tst_resm TPASS "all process were attached"
+}
+
+case5()
+{
+	tst_resm TINFO "try to limit the number of avalaible pid to -1"
+	echo -1 > $testpath/pids.max
+
+	if [ "$?" -eq "0" ]; then
+		tst_resm TFAIL "managed to set the limit to -1"
+	else
+		tst_resm TPASS "didn't manage to set the limit to -1"
+	fi
+}
+
+setup
+
+if [ "$#" -ne "2" ]; then
+	usage
+else
+	case$caseno
+fi
+
+tst_exit
diff --git a/testcases/kernel/controllers/pids/pids_task1.c b/testcases/kernel/controllers/pids/pids_task1.c
new file mode 100644
index 0000000..7feae1e
--- /dev/null
+++ b/testcases/kernel/controllers/pids/pids_task1.c
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
+#include <sys/types.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <errno.h>
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
+	if (newpid == -1) {
+		perror("fork() failed");
+		return 1;
+	}
+	return 0;
+}
diff --git a/testcases/kernel/controllers/pids/pids_task2.c b/testcases/kernel/controllers/pids/pids_task2.c
new file mode 100644
index 0000000..59f41c7
--- /dev/null
+++ b/testcases/kernel/controllers/pids/pids_task2.c
@@ -0,0 +1,25 @@
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
+#include <unistd.h>
+
+int main(void)
+{
+	pause();
+	return 0;
+}
-- 
2.1.4

