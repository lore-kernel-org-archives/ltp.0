From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 19 Feb 2021 15:47:04 +0100
Subject: [LTP] [PATCH 2/2] netns_netlink: Rewrite into new API
In-Reply-To: <20210219144704.20433-1-pvorel@suse.cz>
References: <20210219144704.20433-1-pvorel@suse.cz>
Message-ID: <20210219144704.20433-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Richard Palethorpe <rpalethorpe@suse.com>

This also require to rewrite netns_helper.h.
New test still uses legacy libclone.h.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

check_iproute() is broken since v5.7.0-77-gb687d1067169 (released in
v5.8.0), but that will be fixed by introducing C code, which will be
used also by helper binary which will be used by shell tests
(netns_helper.sh, mc_cmds.sh). Rewriting netns_helper.h first helps
avoiding having to support legacy API.

Kind regards,
Petr

 .../kernel/containers/netns/netns_helper.h    |  38 ++----
 .../kernel/containers/netns/netns_netlink.c   | 115 +++++++-----------
 2 files changed, 56 insertions(+), 97 deletions(-)

diff --git a/testcases/kernel/containers/netns/netns_helper.h b/testcases/kernel/containers/netns/netns_helper.h
index 8b876454f..5468dd5e3 100644
--- a/testcases/kernel/containers/netns/netns_helper.h
+++ b/testcases/kernel/containers/netns/netns_helper.h
@@ -1,32 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) International Business Machines Corp., 2008
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  *
  * Author: Veerendra C <vechandr@in.ibm.com>
  *
  * Net namespaces were introduced around 2.6.25.  Kernels before that,
  * assume they are not enabled.  Kernels after that, check for -EINVAL
  * when trying to use CLONE_NEWNET and CLONE_NEWNS.
- ***************************************************************************/
+ */
 
 #define _GNU_SOURCE
-#include <sched.h>
 #include "config.h"
-#include "libclone.h"
+#include <sched.h>
 #include "lapi/syscalls.h"
-#include "test.h"
-#include "safe_macros.h"
+#include "tst_safe_macros.h"
+#include "libclone.h"
 
 #ifndef CLONE_NEWNS
 #define CLONE_NEWNS -1
@@ -40,17 +28,15 @@ static void check_iproute(unsigned int spe_ipver)
 
 	ipf = popen("ip -V", "r");
 	if (ipf == NULL)
-		tst_brkm(TCONF, NULL,
-				"Failed while opening pipe for iproute check");
+		tst_brk(TCONF, "Failed while opening pipe for iproute check");
 
 	n = fscanf(ipf, "ip utility, iproute2-ss%u", &ipver);
 	if (n < 1) {
-		tst_brkm(TCONF, NULL,
-			"Failed while obtaining version for iproute check");
+		tst_brk(TCONF, "Failed while obtaining version for iproute check");
 	}
 	if (ipver < spe_ipver) {
-		tst_brkm(TCONF, NULL, "The commands in iproute tools do "
-			"not support required objects");
+		tst_brk(TCONF,
+			"The commands in iproute tools do not support required objects");
 	}
 
 	pclose(ipf);
@@ -67,14 +53,14 @@ static void check_netns(void)
 	int pid, status;
 	/* Checking if the kernel supports unshare with netns capabilities. */
 	if (CLONE_NEWNS == -1)
-		tst_brkm(TCONF | TERRNO, NULL, "CLONE_NEWNS (%d) not supported",
+		tst_brk(TCONF | TERRNO, "CLONE_NEWNS (%d) not supported",
 			 CLONE_NEWNS);
 
 	pid = do_clone_unshare_test(T_UNSHARE, CLONE_NEWNET | CLONE_NEWNS,
 	                            dummy, NULL);
 	if (pid == -1)
-		tst_brkm(TCONF | TERRNO, NULL,
+		tst_brk(TCONF | TERRNO,
 				"unshare syscall smoke test failed");
 
-	SAFE_WAIT(NULL, &status);
+	SAFE_WAIT(&status);
 }
diff --git a/testcases/kernel/containers/netns/netns_netlink.c b/testcases/kernel/containers/netns/netns_netlink.c
index 47e8235d6..7e62611fb 100644
--- a/testcases/kernel/containers/netns/netns_netlink.c
+++ b/testcases/kernel/containers/netns/netns_netlink.c
@@ -1,34 +1,27 @@
-/* Copyright (c) 2014 Red Hat, Inc.
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of version 2 the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- ***********************************************************************
- * File: netns_netlink.c
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2014 Red Hat, Inc.
+ * Copyright (c) 2021 Petr Vorel <pvorel@suse.cz>
+ */
+
+/*\
+ * [DESCRIPTION]
  *
  * Tests a netlink interface inside a new network namespace.
- * Description:
- * 1. Unshares a network namespace (so network related actions
- *    have no effect on a real system)
- * 2. Forks a child which creates a NETLINK_ROUTE netlink socket
- *    and listens to RTMGRP_LINK (network interface create/delete/up/down)
- *    multicast group.
- * 4. Child then waits for parent approval to receive data from socket
- * 3. Parent creates a new TAP interface (dummy0) and immediately
- *    removes it (which should generate some data in child's netlink socket).
- *    Then it allows child to continue.
- * 4. As the child was listening to RTMGRP_LINK multicast group, it should
- *    detect the new interface creation/deletion (by reading data from netlink
- *    socket), if so, the test passes, otherwise it fails.
- */
+ *
+ * - Unshares a network namespace (so network related actions
+ *   have no effect on a real system).
+ * - Forks a child which creates a NETLINK_ROUTE netlink socket
+ *   and listens to RTMGRP_LINK (network interface create/delete/up/down)
+ *   multicast group.
+ * - Child then waits for parent approval to receive data from socket
+ * - Parent creates a new TAP interface (dummy0) and immediately
+ *   removes it (which should generate some data in child's netlink socket).
+ *   Then it allows child to continue.
+ * - As the child was listening to RTMGRP_LINK multicast group, it should
+ *   detect the new interface creation/deletion (by reading data from netlink
+ *   socket), if so, the test passes, otherwise it fails.
+\*/
 
 #define _GNU_SOURCE
 #include <sys/wait.h>
@@ -40,28 +33,18 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <errno.h>
+
+#include "tst_test.h"
+#include "tst_safe_macros.h"
 #include "netns_helper.h"
-#include "test.h"
-#include "safe_macros.h"
 
 #define MAX_TRIES 1000
 #define IP_TUNTAP_MIN_VER 100519
 
-char *TCID	= "netns_netlink";
-int TST_TOTAL	= 1;
-
-static void cleanup(void)
-{
-	tst_rmdir();
-}
-
 static void setup(void)
 {
-	tst_require_root();
 	check_iproute(IP_TUNTAP_MIN_VER);
 	check_netns();
-	tst_tmpdir();
-	TST_CHECKPOINT_INIT(tst_rmdir);
 }
 
 int child_func(void)
@@ -89,7 +72,7 @@ int child_func(void)
 	}
 
 	/* waits for parent to create an interface */
-	TST_SAFE_CHECKPOINT_WAIT(NULL, 0);
+	TST_CHECKPOINT_WAIT(0);
 
 	/* To get rid of "resource temporarily unavailable" errors
 	 * when testing with -i option */
@@ -121,60 +104,50 @@ int child_func(void)
 	return 0;
 }
 
-static void test(void)
+static void test_netns_netlink(void)
 {
 	pid_t pid;
 	int status;
 
 	/* unshares the network namespace */
-	if (unshare(CLONE_NEWNET) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "unshare failed");
+	SAFE_UNSHARE(CLONE_NEWNET);
 
-	pid = tst_fork();
-	if (pid < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup, "fork failed");
-	}
+	pid = SAFE_FORK();
 	if (pid == 0) {
 		_exit(child_func());
 	}
 
 	/* creates TAP network interface dummy0 */
 	if (WEXITSTATUS(system("ip tuntap add dev dummy0 mode tap")))
-		tst_brkm(TBROK, cleanup, "system() failed");
+		tst_brk(TBROK, "system() failed");
 
 	/* removes previously created dummy0 device */
 	if (WEXITSTATUS(system("ip tuntap del mode tap dummy0")))
-		tst_brkm(TBROK, cleanup, "system() failed");
+		tst_brk(TBROK, "system() failed");
 
 	/* allow child to continue */
-	TST_SAFE_CHECKPOINT_WAKE(cleanup, 0);
+	TST_CHECKPOINT_WAKE(0);
 
-
-	SAFE_WAITPID(cleanup, pid, &status, 0);
+	SAFE_WAITPID(pid, &status, 0);
 	if (WIFEXITED(status) && WEXITSTATUS(status) != 0) {
-		tst_resm(TFAIL, "netlink interface fail");
+		tst_res(TFAIL, "netlink interface fail");
 		return;
 	}
 	if (WIFSIGNALED(status)) {
-		tst_resm(TFAIL, "child was killed with signal %s",
+		tst_res(TFAIL, "child was killed with signal %s",
 			 tst_strsig(WTERMSIG(status)));
 		return;
 	}
 
-	tst_resm(TPASS, "netlink interface pass");
+	tst_res(TPASS, "netlink interface pass");
 }
 
-int main(int argc, char *argv[])
-{
-	int lc;
 
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++)
-		test();
-
-	cleanup();
-	tst_exit();
-}
+static struct tst_test test = {
+	.test_all = test_netns_netlink,
+	.setup = setup,
+	.needs_checkpoints = 1,
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+	.forks_child = 1,
+};
-- 
2.30.1

