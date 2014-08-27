Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <mmarhefk@redhat.com>) id 1XMfDi-00038f-3a
	for ltp-list@lists.sourceforge.net; Wed, 27 Aug 2014 15:33:10 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XMfDg-0005QZ-EE
	for ltp-list@lists.sourceforge.net; Wed, 27 Aug 2014 15:33:10 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s7RFX1RE017814
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 27 Aug 2014 11:33:01 -0400
Received: from cc-vtoe10.lab.eng.brq.redhat.com
	(cc-vtoe10.lab.eng.brq.redhat.com [10.34.74.245])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id s7RFX0cg016245
	for <ltp-list@lists.sourceforge.net>; Wed, 27 Aug 2014 11:33:01 -0400
From: Matus Marhefka <mmarhefk@redhat.com>
Date: Wed, 27 Aug 2014 17:32:40 +0200
Message-Id: <1409153560-10176-1-git-send-email-mmarhefk@redhat.com>
Subject: [LTP] [PATCH] containers: added netns/netns_interfaces.c
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

* Tests that a separate network namespace can only communicate over
  the devices it sees

Signed-off-by: Matus Marhefka <mmarhefk@redhat.com>
---
 runtest/containers                                 |   1 +
 testcases/kernel/containers/netns/.gitignore       |   1 +
 testcases/kernel/containers/netns/Makefile         |   3 +-
 .../kernel/containers/netns/netns_interfaces.c     | 205 +++++++++++++++++++++
 4 files changed, 209 insertions(+), 1 deletion(-)
 create mode 100644 testcases/kernel/containers/netns/netns_interfaces.c

diff --git a/runtest/containers b/runtest/containers
index 7d01a44..01ed4cc 100644
--- a/runtest/containers
+++ b/runtest/containers
@@ -29,6 +29,7 @@ netns_crtchild_delchild netns_crtchild_delchild
 netns_par_chld_ipv6 netns_par_chld_ipv6
 netns_par_chld_ftp netns_par_chld_ftp.sh
 netns_netlink netns_netlink
+netns_interfaces netns_interfaces
 
 shmnstest_none shmnstest none
 shmnstest_clone shmnstest clone
diff --git a/testcases/kernel/containers/netns/.gitignore b/testcases/kernel/containers/netns/.gitignore
index 65f96be..a134677 100644
--- a/testcases/kernel/containers/netns/.gitignore
+++ b/testcases/kernel/containers/netns/.gitignore
@@ -6,3 +6,4 @@
 /netns_sysfsview
 /netns_two_children_ns
 /netns_netlink
+/netns_interfaces
diff --git a/testcases/kernel/containers/netns/Makefile b/testcases/kernel/containers/netns/Makefile
index eea0d88..cc8827f 100644
--- a/testcases/kernel/containers/netns/Makefile
+++ b/testcases/kernel/containers/netns/Makefile
@@ -31,7 +31,8 @@ LDLIBS			+= -lclone
 MAKE_TARGETS		:= netns_create_container netns_crtchild \
 			   netns_crtchild_delchild netns_par_chld_ftp \
 			   netns_par_chld_ipv6 netns_sysfsview \
-			   netns_two_children_ns netns_netlink
+			   netns_two_children_ns netns_netlink \
+			   netns_interfaces
 
 $(MAKE_TARGETS): %: common.o %.o
 
diff --git a/testcases/kernel/containers/netns/netns_interfaces.c b/testcases/kernel/containers/netns/netns_interfaces.c
new file mode 100644
index 0000000..b4b7834
--- /dev/null
+++ b/testcases/kernel/containers/netns/netns_interfaces.c
@@ -0,0 +1,205 @@
+/* Copyright (c) 2014 Red Hat, Inc.
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of version 2 the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ ***********************************************************************
+ * File: netns_interfaces.c
+ *
+ * Tests that a separate network namespace can only communicate over
+ * the devices it sees. There are three test cases:
+ * 1. communication over paired veth (virtual ethernet) devices
+ *    from two different network namespaces (each namespace has
+ *    one device) should work
+ * 2. communication over the lo (localhost) device in a separate
+ *    network namespace should work
+ * 3. communication over a device which a separate network namespace
+ *    does not see should not work
+ */
+
+#define _GNU_SOURCE
+#include <sys/wait.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <errno.h>
+#include "usctest.h"
+#include "test.h"
+#include "safe_macros.h"
+#include "netns_helper.h"
+
+
+/* by convention a named network namespace is an object
+ * at /var/run/netns/NAME that can be opened. (man 8 ip-netns) */
+#define NETNS     "/var/run/netns"
+char *TCID	= "netns_sendintf";
+int TST_TOTAL	= 3;
+int pipefd[2];
+
+
+static void cleanup(void)
+{
+	close(pipefd[0]);
+	close(pipefd[1]);
+
+	/* removes veth0 device (which also removes paired veth1 device) */
+	if (WEXITSTATUS(system("ip link delete veth0")))
+		perror("system");
+	/* removes the network namespace myns */
+	if (WEXITSTATUS(system("ip netns del myns")))
+		perror("system");
+}
+
+static void setup(void)
+{
+	tst_require_root(NULL);
+	check_netns();
+}
+
+int child_func(void)
+{
+	int status, fd;
+	char c;
+
+	fd = open(NETNS"/myns", O_RDONLY);
+	if (fd == -1) {
+		perror("open");
+		return 1;
+	}
+
+	/* associates child with the namespace referred by fd (myns) */
+	if (setns(fd, 0) == -1) {
+		perror("setns");
+		return 1;
+	}
+
+	/* setup for veth1 device */
+	if (WEXITSTATUS(system("ip address add 192.168.0.2/24 dev veth1"))) {
+		perror("system");
+		return 1;
+	}
+	if (WEXITSTATUS(system("ip link set dev veth1 up"))) {
+		perror("system");
+		return 1;
+	}
+
+	/* waits for parent to confirm that veth0 device setup is done */
+	if (read(pipefd[0], &c, 1) == -1) {
+		perror("read");
+		return 1;
+	}
+
+	/* ping veth0 address through veth1 device */
+	if (WEXITSTATUS(
+	    system("ping -q -c 2 -I veth1 192.168.0.1 &>/dev/null")))
+		return 1;
+
+	return 0;
+}
+
+static void test(void)
+{
+	pid_t pid;
+	int status, ret = 0;
+
+	/* creates a pipe for synchronization between parent and child */
+	SAFE_PIPE(cleanup, pipefd);
+
+	/* unshares a network and a mount namespace */
+	if (unshare(CLONE_NEWNET|CLONE_NEWNS) == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "unshare failed");
+
+
+	/* TEST CASE #1 */
+	/* creates a pair of virtual ethernet devices */
+	if (WEXITSTATUS(system("ip link add veth0 type veth peer name veth1")))
+		tst_brkm(TBROK | TERRNO, cleanup, "system failed");
+	/* creates a new network namespace "myns" (man 8 ip-netns) */
+	if (WEXITSTATUS(system("ip netns add myns")))
+		tst_brkm(TBROK | TERRNO, cleanup, "system failed");
+	/* adds device veth1 to myns namespace */
+	if (WEXITSTATUS(system("ip link set veth1 netns myns")))
+		tst_brkm(TBROK | TERRNO, cleanup, "system failed");
+
+
+	pid = fork();
+	if (pid < 0) {  /* error */
+		tst_brkm(TBROK | TERRNO, cleanup, "fork failed");
+	}
+	if (pid == 0) { /* child */
+		_exit(child_func());
+	}
+
+	/* parent */
+	/* setup for veth0 device */
+	if (WEXITSTATUS(system("ip address add 192.168.0.1/24 dev veth0")))
+		tst_brkm(TBROK | TERRNO, cleanup, "system failed");
+	if (WEXITSTATUS(system("ip link set dev veth0 up")))
+		tst_brkm(TBROK | TERRNO, cleanup, "system failed");
+
+	/* allow child to continue */
+	SAFE_WRITE(cleanup, 0, pipefd[1], "0", 1);
+
+	/* ping veth1 address through veth0 device */
+	ret = system("ping -q -c 2 -I veth0 192.168.0.2 &>/dev/null");
+	if (WEXITSTATUS(ret))
+		tst_resm(TFAIL, "communication over veth devices fail");
+
+	SAFE_WAITPID(cleanup, pid, &status, 0);
+	if (WIFEXITED(status) && WEXITSTATUS(status)) {
+		if (WEXITSTATUS(ret) == 0) {
+			tst_resm(TFAIL, "communication over veth devices fail");
+			ret = status;
+		}
+	}
+
+	if (WEXITSTATUS(ret) == 0)
+		tst_resm(TPASS, "communication over veth devices pass");
+
+
+	/* TEST CASE #2 */
+	/* enable lo device */
+	if (WEXITSTATUS(system("ip link set dev lo up")))
+		tst_brkm(TBROK | TERRNO, cleanup, "system failed");
+	/* ping localhost */
+	if (WEXITSTATUS(system("ping -q -c 2 -I lo 127.0.0.1 &>/dev/null")))
+		tst_resm(TFAIL, "communication over lo device fail");
+	else
+		tst_resm(TPASS, "communication over lo device pass");
+
+
+	/* TEST CASE #3 */
+	/* ping over a device which this separate network namespace
+	 * does not see - this should not work */
+	if (WEXITSTATUS(
+	    system("ping -q -c 2 -I veth1 192.168.0.1 &>/dev/null")))
+		tst_resm(TPASS, "communication over non-existent device pass");
+	else
+		tst_resm(TFAIL, "communication over non-existent device fail");
+}
+
+int main(int argc, char *argv[])
+{
+	const char *msg;
+	int lc;
+
+	msg = parse_opts(argc, argv, NULL, NULL);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		test();
+		cleanup();
+	}
+
+	tst_exit();
+}
-- 
1.8.3.1


------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
