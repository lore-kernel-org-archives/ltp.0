From: Martin Doucha <mdoucha@suse.cz>
Date: Tue,  5 May 2020 17:23:15 +0200
Subject: [LTP] [PATCH v2 3/3] Add test for CVE 2017-1000111
In-Reply-To: <20200505152315.29216-1-mdoucha@suse.cz>
References: <20200505152315.29216-1-mdoucha@suse.cz>
Message-ID: <20200505152315.29216-3-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Fixes #497

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v1:
- Use LAPI headers
- Quit early if TPACKET_V3 is not supported

The tiny race iteration limit is intentional. The bug is mostly harmless and
the setsockopt(PACKET_RX_RING) syscall is really slow. Vulnerable kernels will
fail the test in 15 iterations or less. The test will run for about 30 seconds
on patched systems.

 runtest/cve                                   |   1 +
 runtest/syscalls                              |   1 +
 .../kernel/syscalls/setsockopt/.gitignore     |   1 +
 testcases/kernel/syscalls/setsockopt/Makefile |   4 +-
 .../kernel/syscalls/setsockopt/setsockopt07.c | 145 ++++++++++++++++++
 5 files changed, 150 insertions(+), 2 deletions(-)
 create mode 100644 testcases/kernel/syscalls/setsockopt/setsockopt07.c

diff --git a/runtest/cve b/runtest/cve
index 786b5ee76..339d57f23 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -40,6 +40,7 @@ cve-2017-16939 cve-2017-16939
 cve-2017-16995 bpf_prog03
 cve-2017-17053 cve-2017-17053
 cve-2017-18075 pcrypt_aead01
+cve-2017-1000111 setsockopt07
 cve-2017-1000112 setsockopt05
 cve-2017-1000380 snd_timer01
 cve-2018-5803 sctp_big_chunk
diff --git a/runtest/syscalls b/runtest/syscalls
index bdcd9a5b8..3d953fd22 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1327,6 +1327,7 @@ setsockopt03 setsockopt03
 setsockopt04 setsockopt04
 setsockopt05 setsockopt05
 setsockopt06 setsockopt06
+setsockopt07 setsockopt07
 
 settimeofday01 settimeofday01
 settimeofday02 settimeofday02
diff --git a/testcases/kernel/syscalls/setsockopt/.gitignore b/testcases/kernel/syscalls/setsockopt/.gitignore
index ad067c3e3..1ca5b836b 100644
--- a/testcases/kernel/syscalls/setsockopt/.gitignore
+++ b/testcases/kernel/syscalls/setsockopt/.gitignore
@@ -4,3 +4,4 @@
 /setsockopt04
 /setsockopt05
 /setsockopt06
+/setsockopt07
diff --git a/testcases/kernel/syscalls/setsockopt/Makefile b/testcases/kernel/syscalls/setsockopt/Makefile
index 1e80facd4..678ada75a 100644
--- a/testcases/kernel/syscalls/setsockopt/Makefile
+++ b/testcases/kernel/syscalls/setsockopt/Makefile
@@ -2,8 +2,8 @@
 # Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
-setsockopt06:		CFLAGS += -pthread
-setsockopt06:		LDLIBS += -lrt
+setsockopt06 setsockopt07:	CFLAGS += -pthread
+setsockopt06 setsockopt07:	LDLIBS += -lrt
 
 include $(top_srcdir)/include/mk/testcases.mk
 
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt07.c b/testcases/kernel/syscalls/setsockopt/setsockopt07.c
new file mode 100644
index 000000000..e3a0bf645
--- /dev/null
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt07.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 SUSE LLC <mdoucha@suse.cz>
+ */
+
+/*
+ * CVE-2017-1000111
+ *
+ * Check for race condition between packet_set_ring() and tp_reserve.
+ * The race allows you to set tp_reserve bigger than ring buffer size.
+ * While this will cause truncation of all incoming packets to 0 bytes,
+ * sanity checks in tpacket_rcv() prevent any exploitable buffer overflows.
+ * Race fixed in:
+ * 
+ *  commit c27927e372f0785f3303e8fad94b85945e2c97b7 (HEAD)
+ *  Author: Willem de Bruijn <willemb@google.com>
+ *  Date:   Thu Aug 10 12:41:58 2017 -0400
+ *
+ *  packet: fix tp_reserve race in packet_set_ring
+ */
+
+#define _GNU_SOURCE
+#include <unistd.h>
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <sched.h>
+
+#include "tst_test.h"
+#include "tst_fuzzy_sync.h"
+#include "lapi/if_packet.h"
+#include "lapi/if_ether.h"
+
+static int sock = -1;
+static struct tst_fzsync_pair fzsync_pair;
+
+static void setup(void)
+{
+	int real_uid = getuid();
+	int real_gid = getgid();
+
+	SAFE_UNSHARE(CLONE_NEWUSER);
+	SAFE_UNSHARE(CLONE_NEWNET);
+	SAFE_FILE_PRINTF("/proc/self/setgroups", "deny");
+	SAFE_FILE_PRINTF("/proc/self/uid_map", "0 %d 1", real_uid);
+	SAFE_FILE_PRINTF("/proc/self/gid_map", "0 %d 1", real_gid);
+
+	/*
+	 * Reproducing the bug on unpatched system takes <15 loops. The test
+	 * is slow and the bug is mostly harmless so don't waste too much
+	 * time.
+	 */
+	fzsync_pair.exec_loops = 500;
+	tst_fzsync_pair_init(&fzsync_pair);
+}
+
+static void *thread_run(void *arg)
+{
+	unsigned int val = 1 << 30;
+
+	while (tst_fzsync_run_b(&fzsync_pair)) {
+		tst_fzsync_start_race_b(&fzsync_pair);
+		setsockopt(sock, SOL_PACKET, PACKET_RESERVE, &val, sizeof(val));
+		tst_fzsync_end_race_b(&fzsync_pair);
+	}
+
+	return arg;
+}
+
+static void run(void)
+{
+	unsigned int val, version = TPACKET_V3;
+	socklen_t vsize = sizeof(val);
+	struct tpacket_req3 req = {
+		.tp_block_size = 4096,
+		.tp_block_nr = 1,
+		.tp_frame_size = 4096,
+		.tp_frame_nr = 1,
+		.tp_retire_blk_tov = 100
+	};
+
+	tst_fzsync_pair_reset(&fzsync_pair, thread_run);
+
+	while (tst_fzsync_run_a(&fzsync_pair)) {
+		sock = SAFE_SOCKET(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
+		TEST(setsockopt(sock, SOL_PACKET, PACKET_VERSION, &version,
+			sizeof(version)));
+
+		if (TST_RET == -1 && TST_ERR == EINVAL)
+			tst_brk(TCONF | TTERRNO, "TPACKET_V3 not supported");
+
+		if (TST_RET) {
+			tst_brk(TBROK | TTERRNO,
+				"setsockopt(PACKET_VERSION, TPACKET_V3");
+		}
+
+		tst_fzsync_start_race_a(&fzsync_pair);
+		TEST(setsockopt(sock, SOL_PACKET, PACKET_RX_RING, &req,
+			sizeof(req)));
+		tst_fzsync_end_race_a(&fzsync_pair);
+
+		SAFE_GETSOCKOPT(sock, SOL_PACKET, PACKET_RESERVE, &val, &vsize);
+		SAFE_CLOSE(sock);
+
+		if (TST_RET == -1 && TST_ERR == EINVAL) {
+			tst_fzsync_pair_add_bias(&fzsync_pair, 1);
+			continue;
+		}
+
+		if (TST_RET) {
+			tst_brk(TBROK | TTERRNO,
+				"Invalid setsockopt() return value");
+		}
+
+		if (val > req.tp_block_size){
+			tst_res(TFAIL, "PACKET_RESERVE checks bypassed");
+			return;
+		}
+	}
+
+	tst_res(TPASS, "Cannot reproduce bug");
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
+		{"linux-git", "c27927e372f0"},
+		{"CVE", "2017-1000111"},
+		{}
+	}
+};
-- 
2.26.2

