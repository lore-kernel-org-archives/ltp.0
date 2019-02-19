From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 19 Feb 2019 14:58:14 +0530
Subject: [LTP] [PATCH v3 1/7] lib: Add library functions for sync related
	syscalls
In-Reply-To: <1550568500-10871-1-git-send-email-sumit.garg@linaro.org>
References: <1550568500-10871-1-git-send-email-sumit.garg@linaro.org>
Message-ID: <1550568500-10871-2-git-send-email-sumit.garg@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

These library functions are used to add common test for minimal sectors
written on device for various sync related syscalls.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 include/tst_sync_device.h | 17 ++++++++++
 lib/tst_sync_device.c     | 80 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+)
 create mode 100644 include/tst_sync_device.h
 create mode 100644 lib/tst_sync_device.c

diff --git a/include/tst_sync_device.h b/include/tst_sync_device.h
new file mode 100644
index 0000000..b07c490
--- /dev/null
+++ b/include/tst_sync_device.h
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 Linaro Limited. All rights reserved.
+ * Author: Sumit Garg <sumit.garg@linaro.org>
+ */
+
+#ifndef TST_SYNC_DEVICE_H__
+#define TST_SYNC_DEVICE_H__
+
+#include <stdbool.h>
+
+void tst_sync_device_init(const char *dev);
+int tst_sync_device_write(const char *file, unsigned int size_mb);
+bool tst_sync_device_check(unsigned int size_mb);
+void tst_sync_device_cleanup(void);
+
+#endif
diff --git a/lib/tst_sync_device.c b/lib/tst_sync_device.c
new file mode 100644
index 0000000..5a0a17c
--- /dev/null
+++ b/lib/tst_sync_device.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 Linaro Limited. All rights reserved.
+ * Author: Sumit Garg <sumit.garg@linaro.org>
+ */
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <sys/types.h>
+
+#define TST_NO_DEFAULT_MAIN
+#include "tst_test.h"
+#include "lapi/stat.h"
+#include "tst_sync_device.h"
+
+#define SIZE_MB			(1024*1024)
+#define MODE			0644
+
+static char dev_stat_path[1024];
+static char *buffer;
+static int fd;
+static unsigned long prev_write_sec;
+
+void tst_sync_device_init(const char *dev)
+{
+	struct stat st;
+
+	snprintf(dev_stat_path, sizeof(dev_stat_path), "/sys/block/%s/stat",
+		 strrchr(dev, '/') + 1);
+
+	if (stat(dev_stat_path, &st) != 0)
+		tst_brk(TCONF, "Test device stat file: %s not found",
+			dev_stat_path);
+
+	buffer = SAFE_MALLOC(SIZE_MB);
+
+	memset(buffer, 0, SIZE_MB);
+}
+
+int tst_sync_device_write(const char *file, unsigned int size_mb)
+{
+	unsigned int counter;
+
+	SAFE_FILE_SCANF(dev_stat_path, "%*s %*s %*s %*s %*s %*s %lu",
+			&prev_write_sec);
+
+	fd =  SAFE_OPEN(file, O_RDWR|O_CREAT, MODE);
+
+	/* Filling the test file */
+	for (counter = 0; counter < size_mb; counter++)
+		SAFE_WRITE(1, fd, buffer, SIZE_MB);
+
+	return fd;
+}
+
+bool tst_sync_device_check(unsigned int size_mb)
+{
+	unsigned long write_sec = 0;
+	bool res = false;
+
+	SAFE_FILE_SCANF(dev_stat_path, "%*s %*s %*s %*s %*s %*s %lu",
+			&write_sec);
+
+	if ((write_sec - prev_write_sec) * 512 >=
+	    (size_mb * SIZE_MB))
+		res = true;
+
+	SAFE_CLOSE(fd);
+
+	return res;
+}
+
+void tst_sync_device_cleanup(void)
+{
+	if (buffer)
+		free(buffer);
+
+	if (fd > 0)
+		SAFE_CLOSE(fd);
+}
-- 
2.7.4

