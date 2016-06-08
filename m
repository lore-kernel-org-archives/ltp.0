From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Wed,  8 Jun 2016 12:59:04 +0300
Subject: [LTP] [PATCH] Shell wrappers for the checkpoint interface
Message-ID: <1465379944-21713-1-git-send-email-stanislav.kholmanskikh@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This patch provides necessary wrappers to use the checkpoint
API in shell tests.

Big thanks to Cyril and Jan for their comments to the RFC versions.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
Changes since RFC:
 * Single tst_checkpoint binary instead of tst_checkpoint_{wait,wake}
 * Changed the order of arguments passed to the binary
 * The 'wake' command of the binary requires NR_WAKE paramater.
 * Implement wrappers to all TST_CHECKPOINT_ functions
 * Use TCID in LTP_IPC_PATH
 * Add docs. Noted that the shell functions are compatible to C
   counterparts (initialized with tst_reinit).

 doc/test-writing-guidelines.txt |   23 ++++++++-
 testcases/lib/.gitignore        |    1 +
 testcases/lib/Makefile          |    6 +-
 testcases/lib/test.sh           |   38 +++++++++++++++
 testcases/lib/tst_checkpoint.c  |  101 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 165 insertions(+), 4 deletions(-)
 create mode 100644 testcases/lib/tst_checkpoint.c

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index cdff39c..b58a526 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -583,7 +583,7 @@ As LTP tests are written for Linux, most of the tests involve fork()-ing and
 parent-child process synchronization. LTP includes a checkpoint library that
 provides wait/wake futex based functions.
 
-In order to use checkpoints the '.need_chekcpoints' flag in the 'struct
+In order to use checkpoints the '.needs_checkpoints' flag in the 'struct
 tst_test' must be set to '1', this causes the test library to initialize
 checkpoints before the 'test()' function is called.
 
@@ -1400,6 +1400,27 @@ else
 fi
 -------------------------------------------------------------------------------
 
+2.3.6 Access to the checkpoint interface
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The shell library provides an implementation of the checkpoint interface
+compatible with the C version. All TST_CHECKPOINT_* functions are available.
+
+In order to initialize checkpoints '$TST_NEEDS_CHECKPOINTS' must be set to '1'
+before the inclusion of 'test.sh':
+
+[source,sh]
+-------------------------------------------------------------------------------
+#!/bin/sh
+
+TST_NEEDS_CHECKPOINTS=1
+. test.sh
+-------------------------------------------------------------------------------
+
+Since both the implementations are compatible, it's also possible to start
+a child binary process from a shell test and synchronize with it. This process
+must have checkpoints initialized by calling tst_reinit()'.
+
 3. Common problems
 ------------------
 
diff --git a/testcases/lib/.gitignore b/testcases/lib/.gitignore
index 8886b34..3227552 100644
--- a/testcases/lib/.gitignore
+++ b/testcases/lib/.gitignore
@@ -1 +1,2 @@
 tst_sleep
+tst_checkpoint
diff --git a/testcases/lib/Makefile b/testcases/lib/Makefile
index 0bfb149..c625c6e 100644
--- a/testcases/lib/Makefile
+++ b/testcases/lib/Makefile
@@ -22,10 +22,10 @@
 
 top_srcdir		?= ../..
 
-include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_srcdir)/include/mk/testcases.mk
 
-INSTALL_TARGETS		:= *.sh tst_sleep
+INSTALL_TARGETS		:= *.sh
 
-MAKE_TARGETS		:= tst_sleep
+MAKE_TARGETS		:= tst_sleep tst_checkpoint
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/lib/test.sh b/testcases/lib/test.sh
index e118a56..9f1e3be 100644
--- a/testcases/lib/test.sh
+++ b/testcases/lib/test.sh
@@ -100,6 +100,10 @@ tst_exit()
 		$TST_CLEANUP
 	fi
 
+	if [ -n "$LTP_IPC_PATH" -a -f "$LTP_IPC_PATH" ]; then
+		rm -f "$LTP_IPC_PATH"
+	fi
+
 	# Mask out TINFO
 	exit $((LTP_RET_VAL & ~16))
 }
@@ -383,6 +387,27 @@ tst_su()
 	su "$usr" -c "PATH=\$PATH:$LTPROOT/testcases/bin/ $@"
 }
 
+TST_CHECKPOINT_WAIT()
+{
+	ROD tst_checkpoint wait 10000 "$1"
+}
+
+TST_CHECKPOINT_WAKE()
+{
+	ROD tst_checkpoint wake 10000 "$1" 1
+}
+
+TST_CHECKPOINT_WAKE2()
+{
+	ROD tst_checkpoint wake 10000 "$1" "$2"
+}
+
+TST_CHECKPOINT_WAKE_AND_WAIT()
+{
+	TST_CHECKPOINT_WAKE
+	TST_CHECKPOINT_WAIT
+}
+
 # Check that test name is set
 if [ -z "$TCID" ]; then
 	tst_brkm TBROK "TCID is not defined"
@@ -402,3 +427,16 @@ if [ -z "$LTPROOT" ]; then
 else
 	export LTP_DATAROOT="$LTPROOT/testcases/data/$TCID"
 fi
+
+if [ "$TST_NEEDS_CHECKPOINTS" = "1" ]; then
+	LTP_IPC_PATH="/dev/shm/ltp_${TCID}_$$"
+
+	LTP_IPC_SIZE=$(getconf PAGESIZE)
+	if [ $? -ne 0 ]; then
+		tst_brkm TBROK "getconf PAGESIZE failed"
+	fi
+
+	ROD_SILENT dd if=/dev/zero of="$LTP_IPC_PATH" bs="$LTP_IPC_SIZE" count=1
+	ROD_SILENT chmod 600 "$LTP_IPC_PATH"
+	export LTP_IPC_PATH
+fi
diff --git a/testcases/lib/tst_checkpoint.c b/testcases/lib/tst_checkpoint.c
new file mode 100644
index 0000000..712657e
--- /dev/null
+++ b/testcases/lib/tst_checkpoint.c
@@ -0,0 +1,101 @@
+/*
+ * Copyright (c) 2016 Linux Test Project
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
+#include <errno.h>
+#include <limits.h>
+#include <stdio.h>
+#include <stdlib.h>
+#define TST_NO_DEFAULT_MAIN
+#include "tst_test.h"
+
+static void print_help(void)
+{
+	printf("Usage: tst_checkpoint wait TIMEOUT ID\n");
+	printf("   or: tst_checkpoint wake TIMEOUT ID NR_WAKE\n");
+	printf("       TIMEOUT - timeout in ms\n");
+	printf("       ID - checkpoint id\n");
+	printf("       NR_WAKE - number of processes to wake up\n");
+}
+
+static int get_val(const char *name, const char *arg, unsigned int *val)
+{
+	unsigned long temp;
+	char *e;
+
+	errno = 0;
+	temp = strtoul(arg, &e, 10);
+	if (errno || (e == arg) || (temp > UINT_MAX)) {
+		fprintf(stderr, "ERROR: Invalid %s '%s'\n",
+			name, arg);
+		return -1;
+	}
+
+	*val = temp;
+
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	unsigned int id, timeout, nr_wake;
+	int ret;
+	int type;
+
+	if (argc < 3)
+		goto help;
+
+	if (!strcmp(argv[1], "wait")) {
+		type = 0;
+
+		if (argc != 4)
+			goto help;
+	} else if (!strcmp(argv[1], "wake")) {
+		type = 1;
+
+		if (argc != 5)
+			goto help;
+
+		if (get_val("NR_WAKE", argv[4], &nr_wake))
+			goto help;
+	} else {
+		fprintf(stderr, "ERROR: Invalid COMMAND '%s'\n",
+			argv[1]);
+		goto help;
+	}
+
+	if (get_val("TIMEOUT", argv[2], &timeout)
+	    || get_val("ID", argv[3], &id)) {
+		goto help;
+	}
+
+	tst_reinit();
+
+	if (!type)
+		ret = tst_checkpoint_wait(id, timeout);
+	else
+		ret = tst_checkpoint_wake(id, nr_wake, timeout);
+
+	if (ret)
+		return 1;
+	else
+		return 0;
+
+help:
+	print_help();
+	return 1;
+}
-- 
1.7.1

