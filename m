From: Amir Goldstein <amir73il@gmail.com>
Date: Wed,  9 Sep 2020 20:57:04 +0300
Subject: [LTP] [PATCH 07/10] syscalls/inotify: New test for watches on both
 parent and child
In-Reply-To: <20200909175707.10670-1-amir73il@gmail.com>
References: <20200909175707.10670-1-amir73il@gmail.com>
Message-ID: <20200909175707.10670-8-amir73il@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Check that an inotify event is reported to both watching parent and
watching child when the child metadata changes.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/inotify/.gitignore  |   1 +
 testcases/kernel/syscalls/inotify/inotify10.c | 149 ++++++++++++++++++
 3 files changed, 151 insertions(+)
 create mode 100644 testcases/kernel/syscalls/inotify/inotify10.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 376a2bc6b..b556fb85d 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -564,6 +564,7 @@ inotify06 inotify06
 inotify07 inotify07
 inotify08 inotify08
 inotify09 inotify09
+inotify10 inotify10
 
 fanotify01 fanotify01
 fanotify02 fanotify02
diff --git a/testcases/kernel/syscalls/inotify/.gitignore b/testcases/kernel/syscalls/inotify/.gitignore
index 32ccab5de..da9bfc767 100644
--- a/testcases/kernel/syscalls/inotify/.gitignore
+++ b/testcases/kernel/syscalls/inotify/.gitignore
@@ -7,3 +7,4 @@
 /inotify07
 /inotify08
 /inotify09
+/inotify10
diff --git a/testcases/kernel/syscalls/inotify/inotify10.c b/testcases/kernel/syscalls/inotify/inotify10.c
new file mode 100644
index 000000000..1c43915a8
--- /dev/null
+++ b/testcases/kernel/syscalls/inotify/inotify10.c
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2020 CTERA Networks. All Rights Reserved.
+ *
+ * Started by Amir Goldstein <amir73il@gmail.com>
+ *
+ * DESCRIPTION
+ *     Check that event is reported to both watching parent and watching child
+ */
+
+#include "config.h"
+
+#if defined(HAVE_SYS_INOTIFY_H)
+# include <sys/inotify.h>
+#endif
+#include <errno.h>
+#include <string.h>
+#include "tst_test.h"
+#include "inotify.h"
+
+#if defined(HAVE_SYS_INOTIFY_H)
+
+#define EVENT_MAX 10
+/* Size of the event structure, not including the name */
+#define EVENT_SIZE  (sizeof(struct inotify_event))
+#define EVENT_BUF_LEN        (EVENT_MAX * (EVENT_SIZE + 16))
+
+
+#define BUF_SIZE 256
+
+struct event_t {
+	char name[BUF_SIZE];
+	unsigned int mask;
+	int wd;
+};
+
+#define	TEST_DIR	"test_dir"
+#define	TEST_FILE	"test_file"
+
+struct event_t event_set[EVENT_MAX];
+
+char event_buf[EVENT_BUF_LEN];
+
+int fd_notify;
+
+static void verify_inotify(void)
+{
+	int i = 0, test_num = 0, len;
+	int wd_parent, wd_dir, wd_file;
+	int test_cnt = 0;
+
+	fd_notify = SAFE_MYINOTIFY_INIT();
+
+	/* Set watch on both parent dir and children */
+	wd_parent = SAFE_MYINOTIFY_ADD_WATCH(fd_notify, ".", IN_ATTRIB);
+	wd_dir = SAFE_MYINOTIFY_ADD_WATCH(fd_notify, TEST_DIR, IN_ATTRIB);
+	wd_file = SAFE_MYINOTIFY_ADD_WATCH(fd_notify, TEST_FILE, IN_ATTRIB);
+
+	/*
+	 * Generate events on file and subdir that should be reported to parent
+	 * dir with name and to children without name.
+	 */
+	SAFE_CHMOD(TEST_DIR, 0755);
+	SAFE_CHMOD(TEST_FILE, 0644);
+
+	event_set[test_cnt].wd = wd_parent;
+	event_set[test_cnt].mask = IN_ATTRIB | IN_ISDIR;
+	strcpy(event_set[test_cnt].name, TEST_DIR);
+	test_cnt++;
+	event_set[test_cnt].wd = wd_dir;
+	event_set[test_cnt].mask = IN_ATTRIB | IN_ISDIR;
+	strcpy(event_set[test_cnt].name, "");
+	test_cnt++;
+	event_set[test_cnt].wd = wd_parent;
+	event_set[test_cnt].mask = IN_ATTRIB;
+	strcpy(event_set[test_cnt].name, TEST_FILE);
+	test_cnt++;
+	event_set[test_cnt].wd = wd_file;
+	event_set[test_cnt].mask = IN_ATTRIB;
+	strcpy(event_set[test_cnt].name, "");
+	test_cnt++;
+
+	len = read(fd_notify, event_buf, EVENT_BUF_LEN);
+	if (len == -1)
+		tst_brk(TBROK | TERRNO, "read failed");
+
+	while (i < len) {
+		struct event_t *expected = &event_set[test_num];
+		struct inotify_event *event;
+		event = (struct inotify_event *)&event_buf[i];
+		if (test_num >= test_cnt) {
+			tst_res(TFAIL,
+				"got unnecessary event: "
+				"wd=%d mask=%04x len=%u "
+				"name=\"%.*s\"", event->wd, event->mask,
+				event->len, event->len, event->name);
+
+		} else if (expected->wd == event->wd &&
+			   expected->mask == event->mask &&
+			   !strncmp(expected->name, event->name, event->len)) {
+			tst_res(TPASS,
+				"got event: wd=%d mask=%04x "
+				"cookie=%u len=%u name=\"%.*s\"",
+				event->wd, event->mask, event->cookie,
+				event->len, event->len, event->name);
+
+		} else {
+			tst_res(TFAIL, "got event: wd=%d (expected %d) "
+				"mask=%04x (expected %x) len=%u "
+				"name=\"%.*s\" (expected \"%s\")",
+				event->wd, expected->wd,
+				event->mask, expected->mask,
+				event->len, event->len,
+				event->name, expected->name);
+		}
+		test_num++;
+		i += EVENT_SIZE + event->len;
+	}
+
+	for (; test_num < test_cnt; test_num++) {
+		tst_res(TFAIL, "didn't get event: mask=%04x ",
+			event_set[test_num].mask);
+	}
+
+	SAFE_CLOSE(fd_notify);
+}
+
+static void setup(void)
+{
+	SAFE_MKDIR(TEST_DIR, 00700);
+	SAFE_FILE_PRINTF(TEST_FILE, "1");
+}
+
+static void cleanup(void)
+{
+	if (fd_notify > 0)
+		SAFE_CLOSE(fd_notify);
+}
+
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = verify_inotify,
+};
+
+#else
+	TST_TEST_TCONF("system doesn't have required inotify support");
+#endif /* defined(HAVE_SYS_INOTIFY_H) */
-- 
2.17.1

