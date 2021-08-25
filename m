From: Martin Doucha <mdoucha@suse.cz>
Date: Wed, 25 Aug 2021 12:43:00 +0200
Subject: [LTP] [PATCH 3/3] Add test for CVE 2021-3609
In-Reply-To: <20210825104300.15255-1-mdoucha@suse.cz>
References: <20210825104300.15255-1-mdoucha@suse.cz>
Message-ID: <20210825104300.15255-3-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Fixes #863

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 runtest/can                           |   1 +
 runtest/cve                           |   1 +
 testcases/network/can/cve/.gitignore  |   1 +
 testcases/network/can/cve/Makefile    |  10 ++
 testcases/network/can/cve/can_bcm01.c | 161 ++++++++++++++++++++++++++
 5 files changed, 174 insertions(+)
 create mode 100644 testcases/network/can/cve/.gitignore
 create mode 100644 testcases/network/can/cve/Makefile
 create mode 100644 testcases/network/can/cve/can_bcm01.c

diff --git a/runtest/can b/runtest/can
index b637183c6..23cbf9acd 100644
--- a/runtest/can
+++ b/runtest/can
@@ -1,2 +1,3 @@
 can_filter can_filter
 can_rcv_own_msgs can_rcv_own_msgs
+can_bcm01 can_bcm01
diff --git a/runtest/cve b/runtest/cve
index c27f58d8d..449f5ad7e 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -66,6 +66,7 @@ cve-2020-14416 pty03
 cve-2020-25705 icmp_rate_limit01
 cve-2020-29373 io_uring02
 cve-2021-3444 bpf_prog05
+cve-2021-6309 can_bcm01
 cve-2021-22555 setsockopt08 -i 100
 cve-2021-26708 vsock01
 # Tests below may cause kernel memory leak
diff --git a/testcases/network/can/cve/.gitignore b/testcases/network/can/cve/.gitignore
new file mode 100644
index 000000000..3d138b0b4
--- /dev/null
+++ b/testcases/network/can/cve/.gitignore
@@ -0,0 +1 @@
+/can_bcm01
diff --git a/testcases/network/can/cve/Makefile b/testcases/network/can/cve/Makefile
new file mode 100644
index 000000000..86f84e9f2
--- /dev/null
+++ b/testcases/network/can/cve/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+can_bcm01: CFLAGS += -pthread
+can_bcm01: LDLIBS += -lrt
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/can/cve/can_bcm01.c b/testcases/network/can/cve/can_bcm01.c
new file mode 100644
index 000000000..b1816e6c2
--- /dev/null
+++ b/testcases/network/can/cve/can_bcm01.c
@@ -0,0 +1,161 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2020 SUSE LLC <mdoucha@suse.cz>
+ *
+ * CVE-2021-3609
+ *
+ * Test for race condition vulnerability in CAN BCM. Fixed in:
+ *
+ *  commit d5f9023fa61ee8b94f37a93f08e94b136cf1e463
+ *  Author: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
+ *  Date:   Sat Jun 19 13:18:13 2021 -0300
+ *
+ *  can: bcm: delay release of struct bcm_op after synchronize_rcu()
+ */
+
+#include "config.h"
+#include "tst_test.h"
+
+#ifdef HAVE_LINUX_CAN_H
+
+#include <linux/can.h>
+#include <linux/can/bcm.h>
+
+#include "tst_netdevice.h"
+#include "tst_fuzzy_sync.h"
+
+#define LTP_DEVICE "ltp_vcan0"
+
+struct test_payload {
+	struct bcm_msg_head head;
+	struct can_frame frame;
+};
+
+static int sock1 = -1, sock2 = -1;
+static struct tst_fzsync_pair fzsync_pair;
+
+static void setup(void)
+{
+	struct sockaddr_can addr = { .can_family = AF_CAN };
+
+	/*
+	 * Older kernels require explicit modprobe of vcan. Newer kernels
+	 * will load the modules automatically and support CAN in network
+	 * namespace which would eliminate the need for running the test
+	 * with root privileges.
+	 */
+	tst_cmd((const char*[]){"modprobe", "vcan", NULL}, NULL, NULL, 0);
+
+	NETDEV_ADD_DEVICE(LTP_DEVICE, "vcan");
+	NETDEV_SET_STATE(LTP_DEVICE, 1);
+	addr.can_ifindex = NETDEV_INDEX_BY_NAME(LTP_DEVICE);
+	addr.can_addr.tp.rx_id = 1;
+	sock1 = SAFE_SOCKET(AF_CAN, SOCK_DGRAM, CAN_BCM);
+	SAFE_CONNECT(sock1, (struct sockaddr *)&addr, sizeof(addr));
+
+	fzsync_pair.exec_loops = 100000;
+	tst_fzsync_pair_init(&fzsync_pair);
+}
+
+static void *thread_run(void *arg)
+{
+	struct test_payload data = {
+		{
+			.opcode = TX_SEND,
+			.flags = RX_NO_AUTOTIMER,
+			.count = -1,
+			.nframes = 1
+		},
+		{0}
+	};
+	struct iovec iov = {
+		.iov_base = &data,
+		.iov_len = sizeof(data)
+	};
+	struct msghdr msg = {
+		.msg_iov = &iov,
+		.msg_iovlen = 1
+	};
+
+	while (tst_fzsync_run_b(&fzsync_pair)) {
+		tst_fzsync_start_race_b(&fzsync_pair);
+		SAFE_SENDMSG(iov.iov_len, sock1, &msg, 0);
+		tst_fzsync_end_race_b(&fzsync_pair);
+	}
+
+	return arg;
+}
+
+static void run(void)
+{
+	struct sockaddr_can addr = { .can_family = AF_CAN };
+	struct bcm_msg_head data = {
+		.opcode = RX_SETUP,
+		.flags = RX_FILTER_ID | SETTIMER | STARTTIMER,
+		.ival1.tv_sec = 1,
+		.ival2.tv_sec = 1
+	};
+	struct iovec iov = {
+		.iov_base = &data,
+		.iov_len = sizeof(data)
+	};
+	struct msghdr msg = {
+		.msg_iov = &iov,
+		.msg_iovlen = 1,
+	};
+
+	tst_fzsync_pair_reset(&fzsync_pair, thread_run);
+
+	while (tst_fzsync_run_a(&fzsync_pair)) {
+		sock2 = SAFE_SOCKET(AF_CAN, SOCK_DGRAM, CAN_BCM);
+		SAFE_CONNECT(sock2, (struct sockaddr *)&addr, sizeof(addr));
+		SAFE_SENDMSG(iov.iov_len, sock2, &msg, 0);
+		tst_fzsync_start_race_a(&fzsync_pair);
+		SAFE_CLOSE(sock2);
+		tst_fzsync_end_race_a(&fzsync_pair);
+	}
+
+	tst_res(TPASS, "Nothing bad happened, probably");
+}
+
+static void cleanup(void)
+{
+	tst_fzsync_pair_cleanup(&fzsync_pair);
+
+	if (sock1 >= 0)
+		SAFE_CLOSE(sock1);
+
+	if (sock2 >= 0)
+		SAFE_CLOSE(sock2);
+
+	NETDEV_REMOVE_DEVICE(LTP_DEVICE);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.taint_check = TST_TAINT_W | TST_TAINT_D,
+	.needs_root = 1,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_USER_NS=y",
+		"CONFIG_NET_NS=y",
+		NULL
+	},
+	.needs_drivers = (const char *const[]) {
+		"vcan",
+		"can-bcm",
+		NULL
+	},
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "d5f9023fa61e"},
+		{"CVE", "2021-3609"},
+		{}
+	}
+};
+
+#else
+
+TST_TEST_TCONF("The test was built without <linux/can.h>");
+
+#endif /* HAVE_LINUX_CAN_H */
-- 
2.32.0

