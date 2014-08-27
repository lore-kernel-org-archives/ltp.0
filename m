Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <mmarhefk@redhat.com>) id 1XMbQ0-0007eJ-AJ
	for ltp-list@lists.sourceforge.net; Wed, 27 Aug 2014 11:29:36 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XMbPy-0004l7-S9
	for ltp-list@lists.sourceforge.net; Wed, 27 Aug 2014 11:29:36 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s7RBTRhU022165
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 27 Aug 2014 07:29:27 -0400
Received: from cc-vtoe10.lab.eng.brq.redhat.com
	(cc-vtoe10.lab.eng.brq.redhat.com [10.34.74.245])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id s7RBTQeX017061
	for <ltp-list@lists.sourceforge.net>; Wed, 27 Aug 2014 07:29:27 -0400
From: Matus Marhefka <mmarhefk@redhat.com>
Date: Wed, 27 Aug 2014 13:29:15 +0200
Message-Id: <1409138955-3810-1-git-send-email-mmarhefk@redhat.com>
In-Reply-To: <1409057073-2988-1-git-send-email-mmarhefk@redhat.com>
References: <1409057073-2988-1-git-send-email-mmarhefk@redhat.com>
Subject: [LTP] [PATCH v2] containers: added netns/netns_netlink.c
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

* Tests a netlink interface inside a new network namespace

Signed-off-by: Matus Marhefka <mmarhefk@redhat.com>
---
 runtest/containers                                |   1 +
 testcases/kernel/containers/netns/.gitignore      |   1 +
 testcases/kernel/containers/netns/Makefile        |   2 +-
 testcases/kernel/containers/netns/netns_netlink.c | 175 ++++++++++++++++++++++
 4 files changed, 178 insertions(+), 1 deletion(-)
 create mode 100644 testcases/kernel/containers/netns/netns_netlink.c

diff --git a/runtest/containers b/runtest/containers
index 8e8e067..7d01a44 100644
--- a/runtest/containers
+++ b/runtest/containers
@@ -28,6 +28,7 @@ netns_two_children_ns netns_two_children_ns
 netns_crtchild_delchild netns_crtchild_delchild
 netns_par_chld_ipv6 netns_par_chld_ipv6
 netns_par_chld_ftp netns_par_chld_ftp.sh
+netns_netlink netns_netlink
 
 shmnstest_none shmnstest none
 shmnstest_clone shmnstest clone
diff --git a/testcases/kernel/containers/netns/.gitignore b/testcases/kernel/containers/netns/.gitignore
index e096adc..65f96be 100644
--- a/testcases/kernel/containers/netns/.gitignore
+++ b/testcases/kernel/containers/netns/.gitignore
@@ -5,3 +5,4 @@
 /netns_par_chld_ipv6
 /netns_sysfsview
 /netns_two_children_ns
+/netns_netlink
diff --git a/testcases/kernel/containers/netns/Makefile b/testcases/kernel/containers/netns/Makefile
index cdda23b..eea0d88 100644
--- a/testcases/kernel/containers/netns/Makefile
+++ b/testcases/kernel/containers/netns/Makefile
@@ -31,7 +31,7 @@ LDLIBS			+= -lclone
 MAKE_TARGETS		:= netns_create_container netns_crtchild \
 			   netns_crtchild_delchild netns_par_chld_ftp \
 			   netns_par_chld_ipv6 netns_sysfsview \
-			   netns_two_children_ns
+			   netns_two_children_ns netns_netlink
 
 $(MAKE_TARGETS): %: common.o %.o
 
diff --git a/testcases/kernel/containers/netns/netns_netlink.c b/testcases/kernel/containers/netns/netns_netlink.c
new file mode 100644
index 0000000..fbeda4d
--- /dev/null
+++ b/testcases/kernel/containers/netns/netns_netlink.c
@@ -0,0 +1,175 @@
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
+ * File: netns_netlink.c
+ *
+ * Tests a netlink interface inside a new network namespace.
+ * Description:
+ * 1. Unshares a network namespace (so network related actions
+ *    have no effect on a real system)
+ * 2. Forks a child which creates a NETLINK_ROUTE netlink socket
+ *    and listens to RTMGRP_LINK (network interface create/delete/up/down)
+ *    multicast group.
+ * 4. Child then waits for parent approval to receive data from socket
+ * 3. Parent creates a new TAP interface (dummy0) and immediately
+ *    removes it (which should generate some data in child's netlink socket).
+ *    Then it allows child to continue.
+ * 4. As the child was listening to RTMGRP_LINK multicast group, it should
+ *    detect the new interface creation (by reading data from netlink socket),
+ *    if so, the test passes, otherwise it fails.
+ */
+
+#define _GNU_SOURCE
+#include <sys/wait.h>
+#include <asm/types.h>
+#include <sys/socket.h>
+#include <linux/netlink.h>
+#include <linux/rtnetlink.h>
+#include <unistd.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <errno.h>
+#include "usctest.h"
+#include "test.h"
+#include "safe_macros.h"
+#include "netns_helper.h"
+
+
+char *TCID	= "netns_netlink";
+int TST_TOTAL	= 1;
+int pipefd[2];
+
+
+static void cleanup(void)
+{
+	close(pipefd[0]);
+	close(pipefd[1]);
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
+	int fd, len;
+	struct sockaddr_nl sa;
+	char c, buffer[4096];
+	struct nlmsghdr *nlh;
+
+	/* child will listen to a network interface create/delete/up/down
+	 * events */
+	memset(&sa, 0, sizeof(sa));
+	sa.nl_family = AF_NETLINK;
+	sa.nl_groups = RTMGRP_LINK;
+	
+	fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
+	if (fd == -1) {
+		perror("socket");
+		return 1;
+	}
+	if (bind(fd, (struct sockaddr *) &sa, sizeof(sa)) == -1) {
+		perror("bind");
+		return 1;
+	}
+
+	/* waits for parent to create an interface */
+	read(pipefd[0], &c, 1);
+
+	nlh = (struct nlmsghdr *) buffer;
+	/* non-blocking recv call */
+	while ((len = recv(fd, nlh, sizeof(buffer), MSG_DONTWAIT)) > 0) {
+		/* stop receiving only on interface create event */
+		if (nlh->nlmsg_type == RTM_NEWLINK)
+			break;
+	}
+
+	if (len == -1) {
+		perror("recv");
+		return 1;
+	}
+
+	return 0;
+}
+
+static void test(void)
+{
+	pid_t pid;
+	int status;
+
+	/* creates a pipe for synchronization between parent and child */
+	SAFE_PIPE(cleanup, pipefd);
+
+	/* unshares the network namespace */
+	if (unshare(CLONE_NEWNET) == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "unshare failed");
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
+	/* creates TAP network interface dummy0 */
+	if (WEXITSTATUS(system("ip tuntap add dev dummy0 mode tap")) == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "system failed");
+
+	/* removes previously created dummy0 device */
+	if (WEXITSTATUS(system("ip tuntap del mode tap dummy0")) == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "system failed");
+
+	/* allow child to continue */
+	SAFE_WRITE(cleanup, 0, pipefd[1], "0", 1);
+
+
+	SAFE_WAITPID(cleanup, pid, &status, 0);
+	if (WIFEXITED(status) && WEXITSTATUS(status) != 0) {
+		tst_resm(TFAIL, "netlink interface fail");
+		return;
+	}
+	if (WIFSIGNALED(status)) {
+		tst_resm(TFAIL, "child was killed with signal %s",
+			 tst_strsig(WTERMSIG(status)));
+		return;
+	}
+
+	tst_resm(TPASS, "netlink interface pass");
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
+		/* To get rid of "resource temporarily unavalable" errors
+		 * when testing with -i option */
+		sleep(1);
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
