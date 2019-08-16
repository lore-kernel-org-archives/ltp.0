From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 16 Aug 2019 16:54:09 +0200
Subject: [LTP] [PATCH v1 4/5] libs/libltpuinput: Add uinput library.
In-Reply-To: <20190816145410.8681-1-chrubis@suse.cz>
References: <20190816145410.8681-1-chrubis@suse.cz>
Message-ID: <20190816145410.8681-5-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

I to be used in the uevent03 test.

Also I will convert the uinput testcases to new library and make use of
this library as well.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/tst_uinput.h           | 31 ++++++++++++
 libs/libltpuinput/Makefile     | 12 +++++
 libs/libltpuinput/tst_uinput.c | 93 ++++++++++++++++++++++++++++++++++
 3 files changed, 136 insertions(+)
 create mode 100644 include/tst_uinput.h
 create mode 100644 libs/libltpuinput/Makefile
 create mode 100644 libs/libltpuinput/tst_uinput.c

diff --git a/include/tst_uinput.h b/include/tst_uinput.h
new file mode 100644
index 000000000..1d5b5215a
--- /dev/null
+++ b/include/tst_uinput.h
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+#ifndef TST_UINPUT_H__
+#define TST_UINPUT_H__
+
+/**
+ * Tries to open the uinput device.
+ *
+ * Returns file descriptor on success, -1 on failure.
+ */
+int open_uinput(void);
+
+/**
+ * Creates virtual input device.
+ *
+ * @fd File descriptor returned by open_uinput().
+ */
+void create_input_device(int fd);
+
+
+/**
+ * Destroys virtual input device.
+ *
+ * @fd File descriptor returned by open_uinput().
+ */
+void destroy_input_device(int fd);
+
+#endif	/* TST_UINPUT_H__ */
diff --git a/libs/libltpuinput/Makefile b/libs/libltpuinput/Makefile
new file mode 100644
index 000000000..dd2a6c096
--- /dev/null
+++ b/libs/libltpuinput/Makefile
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) Cyril Hrubis <chrubis@suse.cz>
+
+top_srcdir		?= ../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+
+LIB			:= libltpuinput.a
+
+include $(top_srcdir)/include/mk/lib.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/libs/libltpuinput/tst_uinput.c b/libs/libltpuinput/tst_uinput.c
new file mode 100644
index 000000000..41a1f7eb0
--- /dev/null
+++ b/libs/libltpuinput/tst_uinput.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2015 Cedric Hnyda <chnyda@suse.com>
+ * Copyright (c) 2019 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+#include <linux/input.h>
+#include <linux/uinput.h>
+#include <stdio.h>
+
+#define TST_NO_DEFAULT_MAIN
+#include "tst_test.h"
+
+#include "tst_uinput.h"
+
+#define VIRTUAL_DEVICE "virtual-device-ltp"
+
+static const char *uinput_paths[] = {
+	"/dev/input/uinput",
+	"/dev/uinput",
+};
+
+int open_uinput(void)
+{
+	unsigned int i;
+	int fd;
+
+	for (i = 0; i < ARRAY_SIZE(uinput_paths); i++) {
+		fd = open(uinput_paths[i], O_WRONLY | O_NONBLOCK);
+
+		if (fd > 0) {
+			tst_res(TINFO, "Found uinput dev at %s", uinput_paths[i]);
+			return fd;
+		}
+
+		if (fd < 0 && errno != ENOENT) {
+			tst_brk(TBROK | TERRNO, "open(%s)", uinput_paths[i]);
+		}
+	}
+
+	return -1;
+}
+
+static int check_device(void)
+{
+	FILE *file;
+	char line[256];
+
+	file = fopen("/proc/bus/input/devices", "r");
+	if (!file)
+		return 0;
+
+	while (fgets(line, 256, file)) {
+		if (strstr(line, VIRTUAL_DEVICE))
+			return 1;
+	}
+
+	fclose(file);
+
+	return 0;
+}
+
+void destroy_input_device(int fd)
+{
+	SAFE_IOCTL(fd, UI_DEV_DESTROY, NULL);
+	SAFE_CLOSE(fd);
+}
+
+void create_input_device(int fd)
+{
+	int nb;
+	struct uinput_user_dev uidev = {
+		.name = VIRTUAL_DEVICE,
+		.id = {
+			.bustype = BUS_USB,
+			.vendor = 0x1,
+			.product = 0x1,
+			.version = 1,
+		}
+	};
+
+	SAFE_WRITE(1, fd, &uidev, sizeof(uidev));
+	SAFE_IOCTL(fd, UI_DEV_CREATE, NULL);
+
+	for (nb = 100; nb > 0; nb--) {
+		if (check_device())
+			return;
+		usleep(10000);
+	}
+
+	destroy_input_device(fd);
+	tst_brk(TBROK, "Failed to create device");
+}
-- 
2.21.0

