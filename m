From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 30 Mar 2021 09:27:27 +0200
Subject: [LTP] [PATCH v2 1/1] pec: Convert to the new API
Message-ID: <20210330072727.16565-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Joerg Vehlow <joerg.vehlow@aox-tech.de>

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi Joerg,

few fixes for this commit:
* event_generator uses SAFE_EXECVP() instead of SAFE_EXECV()
* use ROD for event_generator (it checks startup failure for us)
* remove bashism (SIGINT => INT), use #!/bin/sh
* remove useless exit 0
* add local
* few minor reword

It also expects tst_safe_macros: Add SAFE_EXECVP() patch [1].

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/project/ltp/patch/20210329174135.23890-1-pvorel@suse.cz/

 runtest/connectors                            |   2 +-
 testcases/kernel/connectors/Makefile          |   2 -
 testcases/kernel/connectors/connector_test.sh |   9 --
 testcases/kernel/connectors/pec/Makefile      |   2 +-
 testcases/kernel/connectors/pec/README        |  48 --------
 testcases/kernel/connectors/pec/cn_pec.sh     |  66 +++++++++++
 .../kernel/connectors/pec/event_generator.c   |  71 ++++++------
 .../kernel/connectors/pec/pec_listener.c      |  52 ++++-----
 testcases/kernel/connectors/pec/run_pec_test  | 107 ------------------
 9 files changed, 121 insertions(+), 238 deletions(-)
 delete mode 100644 testcases/kernel/connectors/connector_test.sh
 delete mode 100644 testcases/kernel/connectors/pec/README
 create mode 100755 testcases/kernel/connectors/pec/cn_pec.sh
 delete mode 100755 testcases/kernel/connectors/pec/run_pec_test

diff --git a/runtest/connectors b/runtest/connectors
index 6153a98e6..2c7aed474 100644
--- a/runtest/connectors
+++ b/runtest/connectors
@@ -1,2 +1,2 @@
 #DESCRIPTION:Netlink Connector tests
-Connectors connector_test.sh
+cn_pec_sh cn_pec.sh
diff --git a/testcases/kernel/connectors/Makefile b/testcases/kernel/connectors/Makefile
index 04d8a4b91..5f668f419 100644
--- a/testcases/kernel/connectors/Makefile
+++ b/testcases/kernel/connectors/Makefile
@@ -24,6 +24,4 @@ top_srcdir		?= ../../..
 
 include $(top_srcdir)/include/mk/env_pre.mk
 
-INSTALL_TARGETS		:= connector_test.sh
-
 include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/kernel/connectors/connector_test.sh b/testcases/kernel/connectors/connector_test.sh
deleted file mode 100644
index f92e10b85..000000000
--- a/testcases/kernel/connectors/connector_test.sh
+++ /dev/null
@@ -1,9 +0,0 @@
-#!/bin/sh
-
-if [ ! -f /proc/net/connector ];then
-	echo "Connectors 0 CONF : system doesn't support execution of the test"
-	exit 32
-fi
-
-$LTPROOT/testcases/bin/run_pec_test
-
diff --git a/testcases/kernel/connectors/pec/Makefile b/testcases/kernel/connectors/pec/Makefile
index fa0aa6828..d9a7f104e 100644
--- a/testcases/kernel/connectors/pec/Makefile
+++ b/testcases/kernel/connectors/pec/Makefile
@@ -24,6 +24,6 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-INSTALL_TARGETS		:= run_pec_test
+INSTALL_TARGETS		:= cn_pec.sh
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/connectors/pec/README b/testcases/kernel/connectors/pec/README
deleted file mode 100644
index bf1636475..000000000
--- a/testcases/kernel/connectors/pec/README
+++ /dev/null
@@ -1,48 +0,0 @@
-
-TEST SUITE:
-
-The directory pec contains the tests related to the process event connector.
-
-Process event connector is a netlink connector that reports process events
-to userspace. It sends events such as fork, exec, id change and exit.
-
-There are total 5 testcases.
-
-Note: the test can be run by root only.
-
-TESTS AIM:
-
-The aim of the tests is to test the functionality of process event connector.
-
-FILES DESCRIPTION:
-
-check_connector_enabled.c
-------------------
-This program is used to check if the kernel supports netlink connector.
-
-event_generator.c
-------------------
-This program is used to generate a specified process event (fork, exec, uid,
-gid or exit).
-
-run_pec_test
-------------------
-This script runs all the 5 testcases.
-
-pec_listener.c
-------------------
-This program is used to listen to process events received through the kernel
-connector and print them.
-
-Makefile
-------------------
-The usual makefile for this directory
-
-$LTPROOT/output/pec/*.log
-------------------
-The outputs of event_generator and pec_listeners.
-
-README:
-------------------
-The one you have gone through.
-
diff --git a/testcases/kernel/connectors/pec/cn_pec.sh b/testcases/kernel/connectors/pec/cn_pec.sh
new file mode 100755
index 000000000..4ab84b4fa
--- /dev/null
+++ b/testcases/kernel/connectors/pec/cn_pec.sh
@@ -0,0 +1,66 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2008 FUJITSU LIMITED
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Copyright (c) 2021 Petr Vorel <pvorel@suse.cz>
+#
+# Author: Li Zefan <lizf@cn.fujitsu.com>
+#
+# Process event connector is a netlink connector that reports process events
+# to userspace. It sends events such as fork, exec, id change and exit.
+
+TST_SETUP=setup
+TST_TESTFUNC=test
+TST_NEEDS_ROOT=1
+TST_NEEDS_TMPDIR=1
+TST_TEST_DATA="fork exec exit uid gid"
+
+NUM_EVENTS=1
+
+. tst_test.sh
+
+setup()
+{
+	if ! grep -q cn_proc /proc/net/connector; then
+		tst_brk TCONF "Process Event Connector is not supported or kernel < 2.6.26"
+	fi
+
+	tst_res TINFO "Test process events connector"
+}
+
+test()
+{
+	local event=$2
+	local expected_events lis_rc pid
+
+	pec_listener >lis_$event.log 2>lis_$event.err &
+	pid=$!
+	# wait for pec_listener to start listening
+	tst_sleep 100ms
+
+	# generator must be in PATH
+	ROD event_generator -n $NUM_EVENTS -e $event \>gen_$event.log 2\>gen_$event.err
+
+	# sleep until pec_listener has seen and handled all of the generated events
+	tst_sleep 100ms
+	kill -s INT $pid 2> /dev/null
+	wait $pid
+	lis_rc=$?
+
+	if [ ! -s gen_$event.log ]; then
+		tst_brk TBROK "failed to generate process events"
+	fi
+
+	if [ $lis_rc -ne 0 ]; then
+		tst_brk TBROK "failed to execute the listener: $(cat lis_$event.err)"
+	fi
+
+	expected_events="$(cat gen_$event.log)"
+	if grep -q "$expected_events" lis_$event.log; then
+		tst_res TPASS "$event detected by listener"
+	else
+		tst_res TFAIL "$event not detected by listener"
+	fi
+}
+
+tst_run
diff --git a/testcases/kernel/connectors/pec/event_generator.c b/testcases/kernel/connectors/pec/event_generator.c
index cfa6b0dcc..0a90b91c4 100644
--- a/testcases/kernel/connectors/pec/event_generator.c
+++ b/testcases/kernel/connectors/pec/event_generator.c
@@ -1,24 +1,12 @@
-/******************************************************************************/
-/*                                                                            */
-/* Copyright (c) 2008 FUJITSU LIMITED                                         */
-/*                                                                            */
-/* This program is free software;  you can redistribute it and/or modify      */
-/* it under the terms of the GNU General Public License as published by       */
-/* the Free Software Foundation; either version 2 of the License, or          */
-/* (at your option) any later version.                                        */
-/*                                                                            */
-/* This program is distributed in the hope that it will be useful,            */
-/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
-/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
-/* the GNU General Public License for more details.                           */
-/*                                                                            */
-/* You should have received a copy of the GNU General Public License          */
-/* along with this program;  if not, write to the Free Software               */
-/* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    */
-/*                                                                            */
-/* Author: Li Zefan <lizf@cn.fujitsu.com>                                     */
-/*                                                                            */
-/******************************************************************************/
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2008 FUJITSU LIMITED
+ * Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+ *
+ * Author: Li Zefan <lizf@cn.fujitsu.com>
+ *
+ * Generate a specified process event (fork, exec, uid, gid or exit).
+ */
 
 #include <unistd.h>
 #include <string.h>
@@ -28,7 +16,13 @@
 #include <sys/types.h>
 #include <sys/wait.h>
 
-#include "test.h"
+#define TST_NO_DEFAULT_MAIN
+#include "tst_test.h"
+
+extern struct tst_test *tst_test;
+static struct tst_test test = {
+	.forks_child = 1
+};
 
 #define DEFAULT_EVENT_NUM       1
 
@@ -41,11 +35,12 @@ const char *ltp_user = "nobody";
 char **exec_argv;
 
 void (*gen_event) (void);
+static void usage(int status) LTP_ATTRIBUTE_NORETURN;
 
 /*
  * Show the usage
  *
- * @status: the exit status
+ * @param status the exit status
  */
 static void usage(int status)
 {
@@ -61,8 +56,8 @@ static void usage(int status)
  * Generate exec event.
  *
  * We can't just exec nr_event times, because the current process image
- * will be replaced with the new process image, so we use enviroment
- * viriable as event counters, as it will be inherited after exec.
+ * will be replaced with the new process image, so we use environment
+ * variable as event counters, as it will be inherited after exec.
  */
 static void gen_exec(void)
 {
@@ -89,7 +84,8 @@ static void gen_exec(void)
 	printf("exec pid: %d\n", getpid());
 	fflush(stdout);
 
-	execv(exec_argv[0], exec_argv);
+	/* Note: This expects the full path to self in exec_argv[0]! */
+	SAFE_EXECVP(exec_argv[0], exec_argv);
 }
 
 /*
@@ -100,13 +96,10 @@ static inline void gen_fork(void)
 	pid_t pid;
 	int status;
 
-	pid = fork();
+	pid = SAFE_FORK();
 	if (pid == 0) {
 		printf("fork parent: %d, child: %d\n", getppid(), getpid());
 		exit(0);
-	} else if (pid < 0) {
-		fprintf(stderr, "fork() failed\n");
-		exit(1);
 	} else {		/* Parent should wait for the child */
 		wait(&status);
 	}
@@ -118,14 +111,14 @@ static inline void gen_fork(void)
 static inline void gen_exit(void)
 {
 	pid_t pid;
+	int status;
 
-	pid = fork();
+	pid = SAFE_FORK();
 	if (pid == 0) {
 		printf("exit pid: %d exit_code: %d\n", getpid(), 0);
 		exit(0);
-	} else if (pid < 0) {
-		fprintf(stderr, "fork() failed\n");
-		exit(1);
+	} else {
+		wait(&status);
 	}
 }
 
@@ -134,7 +127,7 @@ static inline void gen_exit(void)
  */
 static inline void gen_uid(void)
 {
-	setuid(ltp_uid);
+	SAFE_SETUID(ltp_uid);
 	printf("uid pid: %d euid: %d\n", getpid(), ltp_uid);
 }
 
@@ -143,15 +136,15 @@ static inline void gen_uid(void)
  */
 static inline void gen_gid(void)
 {
-	setgid(ltp_gid);
+	SAFE_SETGID(ltp_gid);
 	printf("gid pid: %d egid: %d\n", getpid(), ltp_gid);
 }
 
 /*
  * Read option from user input.
  *
- * @argc: number of arguments
- * @argv: argument list
+ * @param argc number of arguments
+ * @param argv argument list
  */
 static void process_options(int argc, char **argv)
 {
@@ -205,6 +198,8 @@ int main(int argc, char **argv)
 	unsigned long i;
 	struct passwd *ent;
 
+	tst_test = &test;
+
 	process_options(argc, argv);
 
 	ent = getpwnam(ltp_user);
diff --git a/testcases/kernel/connectors/pec/pec_listener.c b/testcases/kernel/connectors/pec/pec_listener.c
index cd653c7b1..7844dc905 100644
--- a/testcases/kernel/connectors/pec/pec_listener.c
+++ b/testcases/kernel/connectors/pec/pec_listener.c
@@ -1,24 +1,12 @@
-/******************************************************************************/
-/*                                                                            */
-/* Copyright (c) 2008 FUJITSU LIMITED                                         */
-/*                                                                            */
-/* This program is free software;  you can redistribute it and/or modify      */
-/* it under the terms of the GNU General Public License as published by       */
-/* the Free Software Foundation; either version 2 of the License, or          */
-/* (at your option) any later version.                                        */
-/*                                                                            */
-/* This program is distributed in the hope that it will be useful,            */
-/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
-/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
-/* the GNU General Public License for more details.                           */
-/*                                                                            */
-/* You should have received a copy of the GNU General Public License          */
-/* along with this program;  if not, write to the Free Software               */
-/* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    */
-/*                                                                            */
-/* Author: Li Zefan <lizf@cn.fujitsu.com>                                     */
-/*                                                                            */
-/******************************************************************************/
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2008 FUJITSU LIMITED
+ *
+ * Author: Li Zefan <lizf@cn.fujitsu.com>
+ *
+ * Listen to process events received through the kernel connector
+ * and print them.
+ */
 
 #include <sys/socket.h>
 #include <sys/poll.h>
@@ -70,7 +58,7 @@ struct nlmsghdr *nlhdr;
 /*
  * Handler for signal int. Set exit flag.
  *
- * @signo: the signal number, not used
+ * @param signo the signal number, not used
  */
 static void sigint_handler(int __attribute__ ((unused)) signo)
 {
@@ -80,9 +68,9 @@ static void sigint_handler(int __attribute__ ((unused)) signo)
 /*
  * Send netlink package.
  *
- * @sd: socket descripor
- * @to: the destination sockaddr
- * @cnmsg: the pec control message
+ * @param sd    socket descriptor
+ * @param to    the destination sockaddr
+ * @param cnmsg the pec control message
  */
 static int netlink_send(int sd, struct sockaddr_nl *to, struct cn_msg *cnmsg)
 {
@@ -117,8 +105,8 @@ static int netlink_send(int sd, struct sockaddr_nl *to, struct cn_msg *cnmsg)
 /*
  * Receive package from netlink.
  *
- * @sd: socket descripor
- * @from: source sockaddr
+ * @param sd   socket descriptor
+ * @param from source sockaddr
  */
 static int netlink_recv(int sd, struct sockaddr_nl *from)
 {
@@ -146,9 +134,9 @@ static int netlink_recv(int sd, struct sockaddr_nl *from)
 /*
  * Send control message to PEC.
  *
- * @sd: socket descriptor
- * @to: the destination sockaddr
- * @op: control flag
+ * @param sd socket descriptor
+ * @param to the destination sockaddr
+ * @param op control flag
  */
 static int control_pec(int sd, struct sockaddr_nl *to, enum proc_cn_mcast_op op)
 {
@@ -177,7 +165,7 @@ static int control_pec(int sd, struct sockaddr_nl *to, enum proc_cn_mcast_op op)
 /*
  * Process PEC event.
  *
- * @nlhdr: the netlinke pacakge
+ * @param nlhdr the netlink package
  */
 static void process_event(struct nlmsghdr *nlhdr)
 {
@@ -323,7 +311,7 @@ int main(void)
 	while (fsync(STDOUT_FILENO) == -1) {
 		if (errno != EIO)
 			break;
-		/* retry once every 10 secodns */
+		/* retry once every 10 seconds */
 		sleep(10);
 	}
 
diff --git a/testcases/kernel/connectors/pec/run_pec_test b/testcases/kernel/connectors/pec/run_pec_test
deleted file mode 100755
index 272948575..000000000
--- a/testcases/kernel/connectors/pec/run_pec_test
+++ /dev/null
@@ -1,107 +0,0 @@
-#!/bin/bash
-
-################################################################################
-##                                                                            ##
-## Copyright (c) 2008 FUJITSU LIMITED                                         ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-## Author: Li Zefan <lizf@cn.fujitsu.com>                                     ##
-##                                                                            ##
-################################################################################
-
-NUM_EVENTS=1
-EVENT_TEST_CASES=( "fork" "exec" "exit" "uid" "gid" )
-
-cd $LTPROOT/testcases/bin
-
-export TCID="pec01"
-export TST_TOTAL=5
-export TST_COUNT=1
-
-exit_status=0
-
-if [ $(id -u) != 0 ]; then
-	tst_brkm TCONF ignored "Test must be run as root"
-	exit 0;
-fi
-
-grep cn_proc /proc/net/connector > /dev/null
-if [ $? -ne 0 ]; then
-	tst_brkm TCONF ignored "Process Event Connector is not supported or kernel is below 2.6.26"
-	exit 0;
-fi
-
-# Run a test case
-#
-# $1: the test number
-# $2: type of event
-run_case()
-{
-	export TST_COUNT=$1
-
-	log="$LTPROOT/output/log"
-	mkdir -p $log 2> /dev/null
-
-	pec_listener > "$log/listener_$1.log" 2>&1 &
-	pid=$!
-	# Wait for pec_listener to start listening
-	sleep $((1*NUM_EVENTS))
-
-	event_generator -e $2 > "$log/generator_$1.log"
-	ret1=$?
-
-	# Sleep until pec_listener has seen and handled all of
-	# the generated events
-	sleep $((1*NUM_EVENTS))
-	kill -s SIGINT $pid 2> /dev/null
-	wait $pid
-	ret2=$?
-
-	if [ $ret1 -ne 0 -o ! -s "$log/generator_$1.log" ]; then
-		tst_resm TFAIL "failed to generate process events"
-		exit_status=1
-		return 1
-	fi
-
-	if [ $ret2 -eq 2 ]; then
-		tst_brkm TCONF NULL "connector may not be supported"
-		exit 0
-	fi
-
-	if [ $ret2 -ne 0 ]; then
-		tst_resm TFAIL "failed to listen process events"
-		exit_status=1
-		return 1
-	fi
-
-	event="`cat $log/generator_$1.log`"
-	cat "$log/listener_$1.log" | grep "$event" > /dev/null
-	if [ $? -eq 0 ]; then
-		tst_resm TPASS "get event - $event"
-	else
-		tst_resm TFAIL "expected event - $event"
-		exit_status=1
-	fi
-}
-
-i=1;
-for CASE in "${EVENT_TEST_CASES[@]}" ; do
-	run_case $i $CASE
-	((i++))
-done
-
-exit $exit_status
-
-- 
2.30.2

