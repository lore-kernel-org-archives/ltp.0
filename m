From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Wed, 14 Mar 2018 15:54:27 +0100
Subject: [LTP] [PATCH 2/2] Add CVE-2017-18075,
	pcrypt mishandles freeing instances
In-Reply-To: <20180314145427.2738-1-rpalethorpe@suse.com>
References: <20180314145427.2738-1-rpalethorpe@suse.com>
Message-ID: <20180314145427.2738-2-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---

I can not find the original reproducer posted upstream. I assume it was
created by syzkaller.

This patch will not display error messages correctly without the previous
TRERRNO patch I posted.

 runtest/cve                    |   1 +
 testcases/cve/.gitignore       |   1 +
 testcases/cve/cve-2017-18075.c | 201 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 203 insertions(+)
 create mode 100644 testcases/cve/cve-2017-18075.c

diff --git a/runtest/cve b/runtest/cve
index 8b7cbe539..17ef5186d 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -32,3 +32,4 @@ cve-2017-5754 meltdown
 cve-2017-17052 cve-2017-17052
 cve-2017-16939 cve-2017-16939
 cve-2017-17053 cve-2017-17053
+cve-2017-18075 cve-2017-18075
diff --git a/testcases/cve/.gitignore b/testcases/cve/.gitignore
index b05c0ded6..e4dbb58c1 100644
--- a/testcases/cve/.gitignore
+++ b/testcases/cve/.gitignore
@@ -14,3 +14,4 @@ stack_clash
 cve-2017-17052
 cve-2017-16939
 cve-2017-17053
+cve-2017-18075
diff --git a/testcases/cve/cve-2017-18075.c b/testcases/cve/cve-2017-18075.c
new file mode 100644
index 000000000..3723b0655
--- /dev/null
+++ b/testcases/cve/cve-2017-18075.c
@@ -0,0 +1,201 @@
+/*
+ * Copyright (c) 2018 SUSE
+ * Author: Nicolai Stange <nstange@suse.de>
+ * LTP conversion: Richard Palethorpe <rpalethorpe@suse.com>
+ *
+ * Based on the reproducer posted upstream so other copyrights may
+ * apply.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * Test for CVE-2017-5754 - pcrypt mishandles freeing instances
+ *
+ * See commit d76c68109f37 crypto: pcrypt - fix freeing pcrypt instances.
+ *
+ * If the bug is present this will most likely crash your kernel.
+ */
+
+#include <sys/socket.h>
+#include <linux/netlink.h>
+#include <errno.h>
+#include <time.h>
+
+#include "tst_test.h"
+#include "tst_safe_net.h"
+#include "tst_taint.h"
+
+#define ATTEMPTS 10000
+
+enum {
+	CRYPTO_MSG_BASE = 0x10,
+	CRYPTO_MSG_NEWALG = 0x10,
+	CRYPTO_MSG_DELALG,
+	CRYPTO_MSG_UPDATEALG,
+	CRYPTO_MSG_GETALG,
+	CRYPTO_MSG_DELRNG,
+	__CRYPTO_MSG_MAX
+};
+
+#define CRYPTO_MAX_ALG_NAME		64
+#define CRYPTO_MAX_NAME CRYPTO_MAX_ALG_NAME
+
+#define CRYPTO_ALG_TYPE_MASK		0x0000000f
+#define CRYPTO_ALG_TYPE_AEAD		0x00000003
+
+#ifndef NETLINK_CRYPTO
+#define NETLINK_CRYPTO 21
+#endif
+
+struct crypto_user_alg {
+	char cru_name[CRYPTO_MAX_ALG_NAME];
+	char cru_driver_name[CRYPTO_MAX_ALG_NAME];
+	char cru_module_name[CRYPTO_MAX_ALG_NAME];
+	uint32_t cru_type;
+	uint32_t cru_mask;
+	uint32_t cru_refcnt;
+	uint32_t cru_flags;
+};
+
+static void send_nl_msg(int fd, struct nlmsghdr *nh, void *payload)
+{
+	static unsigned int sequence_number;
+	struct sockaddr_nl sa = { .nl_family = AF_NETLINK };
+	struct iovec iov[2] = {
+		{nh, sizeof(*nh)},
+		{payload, nh->nlmsg_len - sizeof(*nh)}
+	};
+	struct msghdr msg = {
+		.msg_name = &sa,
+		.msg_namelen = sizeof(sa),
+		.msg_iov = iov,
+		.msg_iovlen = 2
+	};
+
+	nh->nlmsg_pid = 0;
+	nh->nlmsg_seq = ++sequence_number;
+	/* Request an ack from kernel by setting NLM_F_ACK */
+	nh->nlmsg_flags |= NLM_F_ACK;
+
+	SAFE_SENDMSG(nh->nlmsg_len, fd, &msg, 0);
+}
+
+static int read_reply(int fd)
+{
+	int len;
+	char buf[4096];
+	struct iovec iov = { buf, sizeof(buf) };
+	struct sockaddr_nl sa;
+	struct msghdr msg = {
+		.msg_name = &sa,
+		.msg_namelen = sizeof(sa),
+		.msg_iov = &iov,
+		.msg_iovlen = 1
+	};
+	struct nlmsghdr *nh;
+
+	len = SAFE_RECVMSG(0, fd, &msg, 0);
+
+	for (nh = (struct nlmsghdr *) buf;
+	     NLMSG_OK(nh, len);
+	     nh = NLMSG_NEXT(nh, len)) {
+		/* The end of multipart message. */
+		if (nh->nlmsg_type == NLMSG_DONE)
+			return 0;
+
+		if (nh->nlmsg_type == NLMSG_ERROR)
+			return ((struct nlmsgerr *)NLMSG_DATA(nh))->error;
+	}
+
+	return 0;
+}
+
+static int add_alg(int fd, struct crypto_user_alg *a)
+{
+	int r;
+	struct nlmsghdr nh = {
+		.nlmsg_len = sizeof(struct nlmsghdr) + sizeof(*a),
+		.nlmsg_type = CRYPTO_MSG_NEWALG,
+		.nlmsg_flags = NLM_F_REQUEST,
+	};
+
+	send_nl_msg(fd, &nh, a);
+
+	r = read_reply(fd);
+	if (r == -EEXIST)
+		return 0;
+	return r;
+}
+
+static int del_alg(int fd, struct crypto_user_alg *a)
+{
+	int i;
+	struct timespec delay = { .tv_nsec = 1000000 };
+	struct nlmsghdr nh = {
+		.nlmsg_len = sizeof(struct nlmsghdr) + sizeof(*a),
+		.nlmsg_type = CRYPTO_MSG_DELALG,
+		.nlmsg_flags = NLM_F_REQUEST,
+	};
+
+	for (i = 0; i < 1000; i++) {
+		send_nl_msg(fd, &nh, a);
+
+		TEST(read_reply(fd));
+		if (TEST_RETURN != -EBUSY)
+			break;
+
+		if (nanosleep(&delay, NULL) && errno != EINTR)
+			tst_brk(TBROK | TERRNO, "nanosleep");
+	}
+
+	return TEST_RETURN;
+}
+
+void setup(void)
+{
+	tst_taint_init(TST_TAINT_W | TST_TAINT_D);
+}
+
+void run(void)
+{
+	int fd, i;
+	struct crypto_user_alg a = {
+		.cru_driver_name = "pcrypt(authenc(hmac(sha256-generic),cbc(aes-generic)))",
+		.cru_type = CRYPTO_ALG_TYPE_AEAD,
+		.cru_mask = CRYPTO_ALG_TYPE_MASK,
+	};
+
+	fd = SAFE_SOCKET(AF_NETLINK, SOCK_DGRAM, NETLINK_CRYPTO);
+
+	for (i = 0; i < ATTEMPTS; ++i) {
+		TEST(add_alg(fd, &a));
+		if (TEST_RETURN)
+			tst_brk(TBROK | TRERRNO, "add_alg");
+
+		TEST(del_alg(fd, &a));
+		if (TEST_RETURN)
+			tst_brk(TBROK | TRERRNO, "del_alg");
+	}
+
+	if (tst_taint_check())
+		tst_res(TFAIL, "Kernel has been tainted, check kernel log");
+	else
+		tst_res(TPASS, "You are probably safe");
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.needs_root = 1,
+	.min_kver = "4.2.0",
+};
-- 
2.16.2

