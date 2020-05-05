From: Martin Doucha <mdoucha@suse.cz>
Date: Tue,  5 May 2020 12:24:55 +0200
Subject: [LTP] [PATCH 1/2] Add test for CVE 2016-8655
Message-ID: <20200505102456.13004-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

This test is awfully slow but it checks for local root exploit.

 runtest/cve                                   |   1 +
 runtest/syscalls                              |   1 +
 .../kernel/syscalls/setsockopt/.gitignore     |   1 +
 testcases/kernel/syscalls/setsockopt/Makefile |   2 +
 .../kernel/syscalls/setsockopt/setsockopt06.c | 125 ++++++++++++++++++
 5 files changed, 130 insertions(+)
 create mode 100644 testcases/kernel/syscalls/setsockopt/setsockopt06.c

diff --git a/runtest/cve b/runtest/cve
index c2e9e8c89..786b5ee76 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -12,6 +12,7 @@ cve-2016-4997 setsockopt03
 cve-2016-5195 dirtyc0w
 cve-2016-7042 cve-2016-7042
 cve-2016-7117 cve-2016-7117
+cve-2016-8655 setsockopt06
 cve-2016-9604 keyctl08
 cve-2016-9793 setsockopt04
 cve-2016-10044 cve-2016-10044
diff --git a/runtest/syscalls b/runtest/syscalls
index cbab5730c..bdcd9a5b8 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1326,6 +1326,7 @@ setsockopt02 setsockopt02
 setsockopt03 setsockopt03
 setsockopt04 setsockopt04
 setsockopt05 setsockopt05
+setsockopt06 setsockopt06
 
 settimeofday01 settimeofday01
 settimeofday02 settimeofday02
diff --git a/testcases/kernel/syscalls/setsockopt/.gitignore b/testcases/kernel/syscalls/setsockopt/.gitignore
index f4eabd92b..ad067c3e3 100644
--- a/testcases/kernel/syscalls/setsockopt/.gitignore
+++ b/testcases/kernel/syscalls/setsockopt/.gitignore
@@ -3,3 +3,4 @@
 /setsockopt03
 /setsockopt04
 /setsockopt05
+/setsockopt06
diff --git a/testcases/kernel/syscalls/setsockopt/Makefile b/testcases/kernel/syscalls/setsockopt/Makefile
index 044619fb8..1e80facd4 100644
--- a/testcases/kernel/syscalls/setsockopt/Makefile
+++ b/testcases/kernel/syscalls/setsockopt/Makefile
@@ -2,6 +2,8 @@
 # Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
+setsockopt06:		CFLAGS += -pthread
+setsockopt06:		LDLIBS += -lrt
 
 include $(top_srcdir)/include/mk/testcases.mk
 
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt06.c b/testcases/kernel/syscalls/setsockopt/setsockopt06.c
new file mode 100644
index 000000000..ae2d170a7
--- /dev/null
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt06.c
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 SUSE LLC <mdoucha@suse.cz>
+ */
+
+/*
+ * CVE-2016-8655
+ *
+ * Check for race condition between packet_set_ring() and tp_version. On some
+ * kernels, this may lead to use-after-free. Kernel crash fixed in:
+ * 
+ *  commit 84ac7260236a49c79eede91617700174c2c19b0c
+ *  Author: Philip Pettersson <philip.pettersson@gmail.com>
+ *  Date:   Wed Nov 30 14:55:36 2016 -0800
+ *
+ *  packet: fix race condition in packet_set_ring
+ */
+
+#define _GNU_SOURCE
+#include <unistd.h>
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <linux/if_packet.h>
+#include <net/ethernet.h>
+#include <sched.h>
+
+#include "tst_test.h"
+#include "tst_fuzzy_sync.h"
+#include "tst_taint.h"
+
+static int sock = -1;
+static struct tst_fzsync_pair fzsync_pair;
+
+static void setup(void)
+{
+	int real_uid = getuid();
+	int real_gid = getgid();
+
+	tst_taint_init(TST_TAINT_W | TST_TAINT_D);
+
+	SAFE_UNSHARE(CLONE_NEWUSER);
+	SAFE_UNSHARE(CLONE_NEWNET);
+	SAFE_FILE_PRINTF("/proc/self/setgroups", "deny");
+	SAFE_FILE_PRINTF("/proc/self/uid_map", "0 %d 1", real_uid);
+	SAFE_FILE_PRINTF("/proc/self/gid_map", "0 %d 1", real_gid);
+
+	fzsync_pair.exec_loops = 100000;
+	fzsync_pair.exec_time_p = 0.9;
+	tst_fzsync_pair_init(&fzsync_pair);
+}
+
+static void *thread_run(void *arg)
+{
+	int ret;
+	struct tpacket_req3 req = {
+		.tp_block_size = 4096,
+		.tp_block_nr = 1,
+		.tp_frame_size = 4096,
+		.tp_frame_nr = 1,
+		.tp_retire_blk_tov = 100
+	};
+
+	while (tst_fzsync_run_b(&fzsync_pair)) {
+		tst_fzsync_start_race_b(&fzsync_pair);
+		ret = setsockopt(sock, SOL_PACKET, PACKET_RX_RING, &req,
+			sizeof(req));
+		tst_fzsync_end_race_b(&fzsync_pair);
+
+		if (!ret)
+			tst_fzsync_pair_add_bias(&fzsync_pair, -10);
+	}
+
+	return arg;
+}
+
+static void run(void)
+{
+	int val = TPACKET_V1;
+
+	tst_fzsync_pair_reset(&fzsync_pair, thread_run);
+
+	while (tst_fzsync_run_a(&fzsync_pair)) {
+		sock = SAFE_SOCKET(AF_PACKET, SOCK_RAW, htons(ETH_P_IP));
+		SAFE_SETSOCKOPT_INT(sock, SOL_PACKET, PACKET_VERSION,
+			TPACKET_V3);
+		tst_fzsync_start_race_a(&fzsync_pair);
+		setsockopt(sock, SOL_PACKET, PACKET_VERSION, &val, sizeof(val));
+		tst_fzsync_end_race_a(&fzsync_pair);
+		SAFE_CLOSE(sock);
+	}
+
+	/* setsockopt(PACKET_RX_RING) created a 100ms timer. Wait for it. */
+	usleep(300000);
+
+	if (tst_taint_check()) {
+		tst_res(TFAIL, "Kernel is vulnerable");
+		return;
+	}
+
+	tst_res(TPASS, "Nothing bad happened, probably");
+}
+
+static void cleanup(void)
+{
+	tst_fzsync_pair_cleanup(&fzsync_pair);
+
+	if (sock >= 0)
+		SAFE_CLOSE(sock);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_USER_NS=y",
+		"CONFIG_NET_NS=y",
+		NULL
+	},
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "84ac7260236a"},
+		{"CVE", "2016-8655"},
+		{}
+	}
+};
-- 
2.26.2

