From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 16 Aug 2019 16:54:07 +0200
Subject: [LTP] [PATCH v1 2/5] kernel/uevent: Add uevent01
In-Reply-To: <20190816145410.8681-1-chrubis@suse.cz>
References: <20190816145410.8681-1-chrubis@suse.cz>
Message-ID: <20190816145410.8681-3-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Simple test that attached and detaches a file to a loop device and
checks that kernel broadcasts correct events to the kernel uevent
broadcast group.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/uevent                      |   1 +
 scenario_groups/default             |   1 +
 testcases/kernel/uevents/.gitignore |   1 +
 testcases/kernel/uevents/Makefile   |   6 +
 testcases/kernel/uevents/uevent.h   | 176 ++++++++++++++++++++++++++++
 testcases/kernel/uevents/uevent01.c |  90 ++++++++++++++
 6 files changed, 275 insertions(+)
 create mode 100644 runtest/uevent
 create mode 100644 testcases/kernel/uevents/.gitignore
 create mode 100644 testcases/kernel/uevents/Makefile
 create mode 100644 testcases/kernel/uevents/uevent.h
 create mode 100644 testcases/kernel/uevents/uevent01.c

diff --git a/runtest/uevent b/runtest/uevent
new file mode 100644
index 000000000..e9cdf26b8
--- /dev/null
+++ b/runtest/uevent
@@ -0,0 +1 @@
+uevent01 uevent01
diff --git a/scenario_groups/default b/scenario_groups/default
index 093f5f706..62ae0759d 100644
--- a/scenario_groups/default
+++ b/scenario_groups/default
@@ -29,3 +29,4 @@ input
 cve
 crypto
 kernel_misc
+uevent
diff --git a/testcases/kernel/uevents/.gitignore b/testcases/kernel/uevents/.gitignore
new file mode 100644
index 000000000..53d0b546a
--- /dev/null
+++ b/testcases/kernel/uevents/.gitignore
@@ -0,0 +1 @@
+uevent01
diff --git a/testcases/kernel/uevents/Makefile b/testcases/kernel/uevents/Makefile
new file mode 100644
index 000000000..cba769739
--- /dev/null
+++ b/testcases/kernel/uevents/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+top_srcdir			?= ../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/uevents/uevent.h b/testcases/kernel/uevents/uevent.h
new file mode 100644
index 000000000..2c32dd534
--- /dev/null
+++ b/testcases/kernel/uevents/uevent.h
@@ -0,0 +1,176 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2019 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+#ifndef UEVENT_H__
+#define UEVENT_H__
+
+#include "tst_netlink.h"
+
+/*
+ * There are two broadcast groups defined for the NETLINK_KOBJECT_UEVENT. The
+ * primary consument of the KERNEL group is udev which handles the hotplug
+ * events and then, once udev does it's magic the events are rebroadcasted to
+ * the UDEV group which is consumed by various daemons in the userspace.
+ */
+enum monitor_netlink_group {
+	MONITOR_GROUP_NONE,
+	MONITOR_GROUP_KERNEL,
+	MONITOR_GROUP_UDEV,
+};
+
+/*
+ * The messages received from the NETLINK_KOBJECT_UEVENT socket are stored as a
+ * sequence of a null-terminated strings. First in the buffer is a summary of a
+ * action i.e. "$ACTION@$DEVPATH" which is then followed by a bunch of
+ * key-value pairs.
+ *
+ * For example attaching a file to loopback device generates event:
+ *
+ * "change@/devices/virtual/block/loop0\0
+ *  ACTION=change\0
+ *  DEVPATH=/devices/virtual/block/loop0\0
+ *  SUBSYSTEM=block\0
+ *  MAJOR=7\0
+ *  MINOR=0\0
+ *  DEVNAME=loop0\0
+ *  DEVTYPE=disk\0
+ *  SEQNUM=2677\0"
+ */
+
+/*
+ * Prints uevent.
+ */
+static inline void print_uevent(const char *event, int len)
+{
+	int consumed = 0;
+
+	tst_res(TINFO, "Got uevent:");
+
+	while (consumed < len) {
+		tst_res(TINFO, "%s", event);
+		int l = strlen(event) + 1;
+		consumed += l;
+		event += l;
+	}
+}
+
+/*
+ * Uevents read from the socket are matched against this description.
+ *
+ * The msg is the overall action description e.g.
+ * "add@/class/input/input4/mouse1" which has to be matched exactly before we
+ * event attempt to check the key-value pairs stored in the values array. The
+ * event is considered to match if all key-value pairs in the values has been
+ * found in the received event.
+ */
+struct uevent_desc {
+	const char *msg;
+	int value_cnt;
+	const char **values;
+};
+
+static inline int uevent_match(const char *event, int len,
+                               const struct uevent_desc *uevent)
+{
+	int consumed = 0;
+	int val_matches = 0;
+
+	if (memcmp(event, uevent->msg, strlen(uevent->msg)))
+		return 0;
+
+	int l = strlen(event) + 1;
+
+	consumed += l;
+	event += l;
+
+	while (consumed < len) {
+		int i;
+		for (i = 0; i < uevent->value_cnt; i++) {
+			if (!strcmp(event, uevent->values[i])) {
+				val_matches++;
+				break;
+			}
+		}
+
+		l = strlen(event) + 1;
+		consumed += l;
+		event += l;
+	}
+
+	return val_matches == uevent->value_cnt;
+}
+
+static inline int open_uevent_netlink(void)
+{
+	int fd;
+	struct sockaddr_nl nl_addr = {
+		.nl_family = AF_NETLINK,
+		.nl_groups = MONITOR_GROUP_KERNEL,
+	};
+
+	fd = SAFE_SOCKET(AF_NETLINK, SOCK_RAW, NETLINK_KOBJECT_UEVENT);
+
+	SAFE_BIND(fd, (struct sockaddr *)&nl_addr, sizeof(nl_addr));
+
+	return fd;
+}
+
+/*
+ * Reads events from uevent netlink socket until all expected events passed in
+ * the uevent array are matched.
+ */
+static inline void wait_for_uevents(int fd, const struct uevent_desc *const uevents[])
+{
+	int i = 0;
+
+	while (1) {
+		int len;
+		char buf[4096];
+
+		len = recv(fd, &buf, sizeof(buf), 0);
+
+		if (len == 0)
+			continue;
+
+		print_uevent(buf, len);
+
+		if (uevent_match(buf, len, uevents[i])) {
+			tst_res(TPASS, "Got expected UEVENT");
+			if (!uevents[++i]) {
+				close(fd);
+				exit(0);
+			}
+		}
+	}
+}
+
+/*
+ * Waits 5 seconds for a child to exit, kills the child after a timeout.
+ */
+static inline void wait_for_pid(int pid)
+{
+	int status, ret;
+	int retries = 5000;
+
+	do {
+		ret = waitpid(pid, &status, WNOHANG);
+		usleep(1000);
+	} while (ret == 0 && retries--);
+
+	if (ret == pid) {
+		if (WIFEXITED(status) && WEXITSTATUS(status) == 0)
+			return;
+
+		tst_res(TFAIL, "Child exitted with %s", tst_strstatus(status));
+	}
+
+	SAFE_KILL(pid, SIGKILL);
+
+	SAFE_WAITPID(pid, NULL, 0);
+
+	tst_res(TFAIL, "Did not get all expected UEVENTS");
+}
+
+#endif /* UEVENT_H__ */
diff --git a/testcases/kernel/uevents/uevent01.c b/testcases/kernel/uevents/uevent01.c
new file mode 100644
index 000000000..41cd01b1f
--- /dev/null
+++ b/testcases/kernel/uevents/uevent01.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2019 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*
+ * Very simple uevent netlink socket test.
+ *
+ * We fork a child that listens for a kernel events while parents attaches and
+ * detaches a loop device which should produce two change events.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/wait.h>
+#include "tst_test.h"
+
+#include "uevent.h"
+
+static void generate_device_events(const char *dev_path)
+{
+	tst_fill_file("loop.img", 0, 1024, 1024);
+
+	tst_res(TINFO, "Attaching device %s", dev_path);
+	tst_attach_device(dev_path, "loop.img");
+	tst_res(TINFO, "Detaching device %s", dev_path);
+	tst_detach_device(dev_path);
+}
+
+static void verify_uevent(void)
+{
+	int pid, fd, dev_num;
+	char dev_path[1024];
+	char ev_msg[1024];
+	char ev_dev_path[1024];
+	char ev_dev_minor[128];
+	char ev_dev_name[128];
+
+	struct uevent_desc desc = {
+		.msg = ev_msg,
+		.value_cnt = 7,
+		.values = (const char*[]) {
+			"ACTION=change",
+			ev_dev_path,
+			"SUBSYSTEM=block",
+			"MAJOR=7",
+			ev_dev_minor,
+			ev_dev_name,
+			"DEVTYPE=disk",
+		}
+	};
+
+	dev_num = tst_find_free_loopdev(dev_path, sizeof(dev_path));
+
+	snprintf(ev_msg, sizeof(ev_msg),
+	         "change@/devices/virtual/block/loop%i", dev_num);
+
+	snprintf(ev_dev_path, sizeof(ev_dev_path),
+	         "DEVPATH=/devices/virtual/block/loop%i", dev_num);
+
+	snprintf(ev_dev_minor, sizeof(ev_dev_minor), "MINOR=%i", dev_num);
+	snprintf(ev_dev_name, sizeof(ev_dev_name), "DEVNAME=loop%i", dev_num);
+
+	const struct uevent_desc *const uevents[] = {
+		&desc,
+		&desc,
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
+	generate_device_events(dev_path);
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
+};
-- 
2.21.0

