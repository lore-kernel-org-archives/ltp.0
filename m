From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Mon, 10 Sep 2018 14:21:21 +0200
Subject: [LTP] [PATCH] [WIP] Add fanout01 CVE-2017-15649
Message-ID: <20180910122121.26752-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---

Note that this requires the new Fuzzy Sync library which has not been merged
at the time of writting. Hence why I have marked it with [WIP].

 runtest/cve                         |   1 +
 runtest/net.features                |   2 +
 testcases/network/packet/.gitignore |   1 +
 testcases/network/packet/Makefile   |  25 ++++++
 testcases/network/packet/fanout01.c | 121 ++++++++++++++++++++++++++++
 5 files changed, 150 insertions(+)
 create mode 100644 testcases/network/packet/.gitignore
 create mode 100644 testcases/network/packet/Makefile
 create mode 100644 testcases/network/packet/fanout01.c

diff --git a/runtest/cve b/runtest/cve
index b38fb3503..1b27477f0 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -25,6 +25,7 @@ cve-2017-12193 add_key04
 cve-2017-15274 add_key02
 cve-2017-15299 request_key03 -b cve-2017-15299
 cve-2017-15537 ptrace07
+cve-2017-15649 fanout01
 cve-2017-15951 request_key03 -b cve-2017-15951
 cve-2017-17807 request_key04
 cve-2017-1000364 stack_clash
diff --git a/runtest/net.features b/runtest/net.features
index eac1b2bf2..154d74900 100644
--- a/runtest/net.features
+++ b/runtest/net.features
@@ -58,3 +58,5 @@ dctcp_ipv6_01 dctcp01.sh -6
 
 geneve01 geneve01.sh
 geneve01_ipv6 geneve01.sh -6
+
+fanout01 fanout01
diff --git a/testcases/network/packet/.gitignore b/testcases/network/packet/.gitignore
new file mode 100644
index 000000000..48f13bf9f
--- /dev/null
+++ b/testcases/network/packet/.gitignore
@@ -0,0 +1 @@
+fanout01
diff --git a/testcases/network/packet/Makefile b/testcases/network/packet/Makefile
new file mode 100644
index 000000000..76f3fd23f
--- /dev/null
+++ b/testcases/network/packet/Makefile
@@ -0,0 +1,25 @@
+# Copyright (c) 2018 Linux Test Project
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program. If not, see <http://www.gnu.org/licenses/>.
+
+top_srcdir		?= ../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+CFLAGS			+= -D_GNU_SOURCE
+
+fanout01:	CFLAGS += -pthread
+fanout01:	LDLIBS += -lrt
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/packet/fanout01.c b/testcases/network/packet/fanout01.c
new file mode 100644
index 000000000..bc5813bdd
--- /dev/null
+++ b/testcases/network/packet/fanout01.c
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018 Richard Palethorpe <rpalethorpe@suse.com>
+ * Original reproducer: https://blogs.securiteam.com/index.php/archives/3484
+ * Other copyrights may apply.
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
+/* CVE-2017-15649
+ *
+ * Fixed by the following commits:
+ * 4971613c "packet: in packet_do_bind, test fanout with bind_lock held"
+ * 008ba2a1 "packet: hold bind lock when rebinding to fanout hook"
+ *
+ * See blogpost in copyright notice for more details.
+ */
+#include <errno.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <sched.h>
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <sys/ioctl.h>
+#include <net/if.h>
+#include <linux/if_packet.h>
+
+#include "tst_test.h"
+#include "tst_fuzzy_sync.h"
+
+static struct tst_fzsync_pair pair;
+static int fd;
+static struct sockaddr_ll addr;
+
+void setup(void)
+{
+	int real_uid = getuid();
+	int real_gid = getgid();
+
+	TEST(unshare(CLONE_NEWUSER));
+	if (TST_RET)
+		tst_brk(TBROK | TTERRNO, "Can't create new user namespace");
+
+	TEST(unshare(CLONE_NEWNET));
+	if (TST_RET)
+		tst_brk(TBROK | TTERRNO, "Can't create new net namespace");
+
+	FILE_PRINTF("/proc/self/setgroups", "deny");
+	FILE_PRINTF("/proc/self/uid_map", "0 %d 1\n", real_uid);
+	FILE_PRINTF("/proc/self/gid_map", "0 %d 1\n", real_gid);
+
+	tst_fzsync_pair_init(&pair);
+}
+
+void cleanup(void)
+{
+	tst_fzsync_pair_cleanup(&pair);
+}
+
+void *binder(void *unused)
+{
+	while (tst_fzsync_run_b(&pair)) {
+		tst_fzsync_start_race_b(&pair);
+		bind(fd, (struct sockaddr *)&addr, sizeof(addr));
+		tst_fzsync_end_race_b(&pair);
+	}
+
+	return unused;
+}
+
+void run(void)
+{
+	int fanout_val = PACKET_FANOUT_ROLLOVER, index;
+	struct ifreq ifr = { 0 };
+
+	tst_fzsync_pair_reset(&pair, binder);
+	while (tst_fzsync_run_a(&pair)) {
+		fd = SAFE_SOCKET(AF_PACKET, SOCK_RAW, PF_PACKET);
+
+		strcpy((char *)&ifr.ifr_name, "lo");
+		SAFE_IOCTL(fd, SIOCGIFINDEX, &ifr);
+		index = ifr.ifr_ifindex;
+
+		SAFE_IOCTL(fd, SIOCGIFFLAGS, &ifr);
+		ifr.ifr_flags &= ~(short)IFF_UP;
+		SAFE_IOCTL(fd, SIOCSIFFLAGS, &ifr);
+
+		addr.sll_family = AF_PACKET;
+		/* need something different to rehook && 0 to skip register_prot_hook */
+		addr.sll_protocol = 0x0;
+		addr.sll_ifindex = index;
+
+		tst_fzsync_start_race_a(&pair);
+		setsockopt(fd, SOL_PACKET, PACKET_FANOUT,
+			   &fanout_val, sizeof(fanout_val));
+		tst_fzsync_end_race_a(&pair);
+
+		/* UAF */
+		close(fd);
+	}
+
+	tst_res(TPASS, "Nothing bad happened, probably...");
+}
+
+static struct tst_test test = {
+	.min_kver = "3.19",
+	.setup = setup,
+	.test_all = run,
+	.cleanup = cleanup,
+	.needs_root = 1,
+};
-- 
2.18.0

