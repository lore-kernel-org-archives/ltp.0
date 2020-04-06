From: Martin Doucha <mdoucha@suse.cz>
Date: Mon,  6 Apr 2020 17:37:59 +0200
Subject: [LTP] [PATCH v2] Add test for CVE 2018-18559
Message-ID: <20200406153759.2832-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Fixes #411

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v1: added needs_kconfigs to metadata

This is a rather slow test. The bind() thread can take on average 15ms due to
kernel locks on the socket or netdevice and the kernel crash is only triggered
on process exit. So the test takes about 2 to 3 minutes even with really low
number of race loops. But it reliably crashes SLE-12SP3 GM kernel.

 runtest/cve                               |   1 +
 runtest/syscalls                          |   1 +
 testcases/kernel/syscalls/bind/.gitignore |   1 +
 testcases/kernel/syscalls/bind/Makefile   |   1 +
 testcases/kernel/syscalls/bind/bind06.c   | 133 ++++++++++++++++++++++
 5 files changed, 137 insertions(+)
 create mode 100644 testcases/kernel/syscalls/bind/bind06.c

diff --git a/runtest/cve b/runtest/cve
index dbd065fd1..da42c4ede 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -43,4 +43,5 @@ cve-2018-5803 sctp_big_chunk
 cve-2018-1000001 realpath01
 cve-2018-1000199 ptrace08
 cve-2018-1000204 ioctl_sg01
+cve-2018-18559 bind06
 cve-2018-19854 crypto_user01
diff --git a/runtest/syscalls b/runtest/syscalls
index 777f0ac6a..44254d7da 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -34,6 +34,7 @@ bind02 bind02
 bind03 bind03
 bind04 bind04
 bind05 bind05
+bind06 bind06
 
 bpf_map01 bpf_map01
 bpf_prog01 bpf_prog01
diff --git a/testcases/kernel/syscalls/bind/.gitignore b/testcases/kernel/syscalls/bind/.gitignore
index e18ceea56..c85774441 100644
--- a/testcases/kernel/syscalls/bind/.gitignore
+++ b/testcases/kernel/syscalls/bind/.gitignore
@@ -3,3 +3,4 @@
 /bind03
 /bind04
 /bind05
+/bind06
diff --git a/testcases/kernel/syscalls/bind/Makefile b/testcases/kernel/syscalls/bind/Makefile
index fffa146ad..3de725143 100644
--- a/testcases/kernel/syscalls/bind/Makefile
+++ b/testcases/kernel/syscalls/bind/Makefile
@@ -6,5 +6,6 @@ top_srcdir		?= ../../../..
 include $(top_srcdir)/include/mk/testcases.mk
 
 bind04 bind05:	CFLAGS		+= -pthread
+bind06:		LDFLAGS		+= -pthread -lrt
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/bind/bind06.c b/testcases/kernel/syscalls/bind/bind06.c
new file mode 100644
index 000000000..47351ddbd
--- /dev/null
+++ b/testcases/kernel/syscalls/bind/bind06.c
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2020 SUSE LLC <mdoucha@suse.cz>
+ *
+ * CVE-2018-18559
+ *
+ * Test for race condition vulnerability in bind() on AF_PACKET socket.
+ * Fixed in:
+ *
+ *  commit 15fe076edea787807a7cdc168df832544b58eba6
+ *  Author: Eric Dumazet <edumazet@google.com>
+ *  Date:   Tue Nov 28 08:03:30 2017 -0800
+ *
+ *  net/packet: fix a race in packet_bind() and packet_notifier()
+ */
+
+#define _GNU_SOURCE
+#include <sys/socket.h>
+#include <sys/ioctl.h>
+#include <linux/if_packet.h>
+#include <net/ethernet.h>
+#include <net/if.h>
+#include <sched.h>
+#include "tst_test.h"
+#include "tst_fuzzy_sync.h"
+#include "tst_taint.h"
+
+static volatile int fd = -1;
+static struct sockaddr_ll addr1, addr2;
+static struct tst_fzsync_pair fzsync_pair;
+
+static void setup(void)
+{
+	int real_uid = getuid();
+	int real_gid = getgid();
+	struct ifreq ifr;
+
+	tst_taint_init(TST_TAINT_W | TST_TAINT_D);
+
+	SAFE_UNSHARE(CLONE_NEWUSER);
+	SAFE_UNSHARE(CLONE_NEWNET);
+	SAFE_FILE_PRINTF("/proc/self/setgroups", "deny");
+	SAFE_FILE_PRINTF("/proc/self/uid_map", "0 %d 1\n", real_uid);
+	SAFE_FILE_PRINTF("/proc/self/gid_map", "0 %d 1\n", real_gid);
+
+	fd = SAFE_SOCKET(AF_PACKET, SOCK_DGRAM, PF_PACKET);
+	strcpy(ifr.ifr_name, "lo");
+	SAFE_IOCTL(fd, SIOCGIFINDEX, &ifr);
+	SAFE_CLOSE(fd);
+
+	addr1.sll_family = AF_PACKET;
+	addr1.sll_ifindex = ifr.ifr_ifindex;
+	addr2.sll_family = AF_PACKET;
+}
+
+static void do_bind(void) {
+	bind(fd, (struct sockaddr *)&addr1, sizeof(addr1));
+	bind(fd, (struct sockaddr *)&addr2, sizeof(addr2));
+}
+
+static void *thread_run(void *arg)
+{
+	while (tst_fzsync_run_b(&fzsync_pair)) {
+		tst_fzsync_start_race_b(&fzsync_pair);
+		do_bind();
+		tst_fzsync_end_race_b(&fzsync_pair);
+	}
+
+	return arg;
+}
+
+static void child_run(void)
+{
+	struct ifreq ifr;
+
+	fzsync_pair.exec_loops = 10000;
+	tst_fzsync_pair_init(&fzsync_pair);
+	tst_fzsync_pair_reset(&fzsync_pair, thread_run);
+	strcpy(ifr.ifr_name, "lo");
+
+	while (tst_fzsync_run_a(&fzsync_pair)) {
+		fd = SAFE_SOCKET(AF_PACKET, SOCK_DGRAM, PF_PACKET);
+		ifr.ifr_flags = 0;
+		ioctl(fd, SIOCSIFFLAGS, &ifr);
+		ifr.ifr_flags = IFF_UP;
+		tst_fzsync_start_race_a(&fzsync_pair);
+		ioctl(fd, SIOCSIFFLAGS, &ifr);
+		tst_fzsync_end_race_a(&fzsync_pair);
+		SAFE_CLOSE(fd);
+
+	}
+
+	tst_fzsync_pair_cleanup(&fzsync_pair);
+}
+
+static void run(void)
+{
+	pid_t child;
+
+	/* The kernel crash is triggered on process exit. */
+	child = SAFE_FORK();
+
+	if (!child) {
+		child_run();
+		exit(0);
+	}
+
+	SAFE_WAITPID(child, NULL, 0);
+
+	if (tst_taint_check()) {
+		tst_res(TFAIL, "Kernel is vulnerable");
+		return;
+	}
+
+	tst_res(TPASS, "Nothing bad happened, probably");
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.timeout = 600,
+	.forks_child = 1,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_USER_NS=y",
+		"CONFIG_NET_NS=y",
+		NULL
+	},
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "15fe076edea7"},
+		{"CVE", "2018-18559"},
+		{}
+	}
+};
-- 
2.26.0

