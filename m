From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 20 Aug 2019 17:18:29 +0200
Subject: [LTP] [PATCH v2 3/5] kernel/uevent: Add uevent02
In-Reply-To: <20190820151831.7418-1-chrubis@suse.cz>
References: <20190820151831.7418-1-chrubis@suse.cz>
Message-ID: <20190820151831.7418-4-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Similar to uevent01 but we create and remove a tun network card instead.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/uevent                      |   1 +
 testcases/kernel/uevents/.gitignore |   1 +
 testcases/kernel/uevents/uevent02.c | 141 ++++++++++++++++++++++++++++
 3 files changed, 143 insertions(+)
 create mode 100644 testcases/kernel/uevents/uevent02.c

diff --git a/runtest/uevent b/runtest/uevent
index e9cdf26b8..30b1114a4 100644
--- a/runtest/uevent
+++ b/runtest/uevent
@@ -1 +1,2 @@
 uevent01 uevent01
+uevent02 uevent02
diff --git a/testcases/kernel/uevents/.gitignore b/testcases/kernel/uevents/.gitignore
index 53d0b546a..0afc95534 100644
--- a/testcases/kernel/uevents/.gitignore
+++ b/testcases/kernel/uevents/.gitignore
@@ -1 +1,2 @@
 uevent01
+uevent02
diff --git a/testcases/kernel/uevents/uevent02.c b/testcases/kernel/uevents/uevent02.c
new file mode 100644
index 000000000..2c28d1810
--- /dev/null
+++ b/testcases/kernel/uevents/uevent02.c
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2019 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*
+ * Very simple uevent netlink socket test.
+ *
+ * We fork a child that listens for a kernel events while parents creates and removes
+ * a tun network device which should produce two several add and remove events.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/wait.h>
+#include <linux/if.h>
+#include <linux/if_tun.h>
+
+#include "tst_test.h"
+
+#include "uevent.h"
+
+#define TUN_PATH "/dev/net/tun"
+
+static void generate_tun_uevents(void)
+{
+	int fd = SAFE_OPEN(TUN_PATH, O_RDWR);
+
+	struct ifreq ifr = {
+		.ifr_flags = IFF_TUN,
+		.ifr_name = "ltp-tun0",
+	};
+
+	SAFE_IOCTL(fd, TUNSETIFF, (void*)&ifr);
+
+	SAFE_IOCTL(fd, TUNSETPERSIST, 0);
+
+	SAFE_CLOSE(fd);
+}
+
+static void verify_uevent(void)
+{
+	int pid, fd;
+
+	struct uevent_desc add = {
+		.msg = "add@/devices/virtual/net/ltp-tun0",
+		.value_cnt = 0,
+		.values = (const char*[]) {
+			"ACTION=add",
+			"DEVPATH=/devices/virtual/net/ltp-tun0",
+			"SUBSYSTEM=net",
+			"ITERFACE=ltp-tun0",
+		}
+	};
+
+	struct uevent_desc add_rx = {
+		.msg = "add@/devices/virtual/net/ltp-tun0/queues/rx-0",
+		.value_cnt = 0,
+		.values = (const char*[]) {
+			"ACTION=add",
+			"DEVPATH=/devices/virtual/net/ltp-tun0/queues/rx-0",
+			"SUBSYSTEM=queueus",
+		}
+	};
+
+	struct uevent_desc add_tx = {
+		.msg = "add@/devices/virtual/net/ltp-tun0/queues/tx-0",
+		.value_cnt = 0,
+		.values = (const char*[]) {
+			"ACTION=add",
+			"DEVPATH=/devices/virtual/net/ltp-tun0/queues/tx-0",
+			"SUBSYSTEM=queueus",
+		}
+	};
+
+	struct uevent_desc rem_rx = {
+		.msg = "remove@/devices/virtual/net/ltp-tun0/queues/rx-0",
+		.value_cnt = 0,
+		.values = (const char*[]) {
+			"ACTION=remove",
+			"DEVPATH=/devices/virtual/net/ltp-tun0/queues/rx-0",
+			"SUBSYSTEM=queueus",
+		}
+	};
+
+	struct uevent_desc rem_tx = {
+		.msg = "remove@/devices/virtual/net/ltp-tun0/queues/tx-0",
+		.value_cnt = 0,
+		.values = (const char*[]) {
+			"ACTION=remove",
+			"DEVPATH=/devices/virtual/net/ltp-tun0/queues/tx-0",
+			"SUBSYSTEM=queueus",
+		}
+	};
+
+	struct uevent_desc rem = {
+		.msg = "remove@/devices/virtual/net/ltp-tun0",
+		.value_cnt = 0,
+		.values = (const char*[]) {
+			"ACTION=remove",
+			"DEVPATH=/devices/virtual/net/ltp-tun0",
+			"SUBSYSTEM=net",
+			"ITERFACE=ltp-tun0",
+		}
+	};
+
+	const struct uevent_desc *const uevents[] = {
+		&add,
+		&add_rx,
+		&add_tx,
+		&rem_rx,
+		&rem_tx,
+		&rem,
+		NULL
+	};
+
+	pid = SAFE_FORK();
+	if (!pid) {
+		fd = open_uevent_netlink();
+		TST_CHECKPOINT_WAKE(0);
+		wait_for_uevents(fd, uevents);
+	}
+
+	TST_CHECKPOINT_WAIT(0);
+
+	generate_tun_uevents();
+
+	wait_for_pid(pid);
+}
+
+static struct tst_test test = {
+	.test_all = verify_uevent,
+	.forks_child = 1,
+	.needs_tmpdir = 1,
+	.needs_checkpoints = 1,
+	.needs_root = 1,
+	.needs_drivers = (const char *const []) {
+		"tun",
+		NULL
+	},
+};
-- 
2.21.0

