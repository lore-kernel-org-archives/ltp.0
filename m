From: Filip Bozuta <fbozuta1@gmail.com>
Date: Thu, 23 Apr 2020 17:06:26 +0200
Subject: [LTP] [PATCH v2 3/3] testcases/kernel/syscalls/ioctl: Add test for
 RTC ioctls used to turn on/off RTC interrupts
In-Reply-To: <20200423150626.12672-1-fbozuta1@gmail.com>
References: <20200423150626.12672-1-fbozuta1@gmail.com>
Message-ID: <20200423150626.12672-4-fbozuta1@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Filip Bozuta <Filip.Bozuta@rt-rk.com>

This patch tests functionalities of following ioctls:

RTC_AIE_ON, RTC_AIE_OFF - Alarm interrupt enabling on/off

    Enable or disable the alarm interrupt, for RTCs that support
    alarms.  The third ioctl's argument is ignored.

RTC_UIE_ON, RTC_UIE_OFF - Update interrupt enabling on/off

    Enable or disable the interrupt on every clock update, for
    RTCs that support this once-per-second interrupt. The third
    ioctl's argument is ignored.

RTC_PIE_ON, RTC_PIE_OFF - Periodic interrupt enabling on/off

    Enable or disable the periodic interrupt, for RTCs that sup?
    port these periodic interrupts. The third ioctl's argument
    is ignored. Only a privileged process (i.e., one having the
    CAP_SYS_RESOURCE capability) can enable the periodic interrupt
    if the frequency is currently set above the value specified in
    /proc/sys/dev/rtc/max-user-freq.

RTC_WIE_ON, RTC_WIE_OFF - Watchdog interrupt enabling on/off

    Enable or disable the Watchdog interrupt, for RTCs that sup-
    port this Watchdog interrupt. The third ioctl's argument is
    ignored.

Signed-off-by: Filip Bozuta <Filip.Bozuta@rt-rk.com>
---
 runtest/syscalls                              |  1 +
 testcases/kernel/syscalls/ioctl/.gitignore    |  1 +
 testcases/kernel/syscalls/ioctl/ioctl_rtc03.c | 86 +++++++++++++++++++
 3 files changed, 88 insertions(+)
 create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_rtc03.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 0e358337f..d5b9789d3 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -541,6 +541,7 @@ ioctl_sg01 ioctl_sg01
 
 ioctl_rtc01 ioctl_rtc01
 ioctl_rtc02 ioctl_rtc02
+ioctl_rtc03 ioctl_rtc03
 
 inotify_init1_01 inotify_init1_01
 inotify_init1_02 inotify_init1_02
diff --git a/testcases/kernel/syscalls/ioctl/.gitignore b/testcases/kernel/syscalls/ioctl/.gitignore
index b9ed19724..f16c11f58 100644
--- a/testcases/kernel/syscalls/ioctl/.gitignore
+++ b/testcases/kernel/syscalls/ioctl/.gitignore
@@ -16,3 +16,4 @@
 /ioctl_sg01
 /ioctl_rtc01
 /ioctl_rtc02
+/ioctl_rtc03
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_rtc03.c b/testcases/kernel/syscalls/ioctl/ioctl_rtc03.c
new file mode 100644
index 000000000..d5c946629
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl_rtc03.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Filip Bozuta Filip.Bozuta@rt-rk.com
+ */
+
+/*
+ * Test RTC ioctls with requests RTC_AIE_ON, RTC_AIE_OFF,
+ * RTC_PIE_ON, RTC_PIE_OFF, RTC_UIE_ON, RTC_UIE_OFF,
+ * RTC_WIE_ON, RTC_WIE_OFF
+ *
+ * Runs ioctls with the above mentioned requests one by one
+ * and sequentially turns on and off RTC alarm, periodic,
+ * update and watchdog interrupt.
+ */
+
+#include <stdint.h>
+#include <errno.h>
+#include <string.h>
+#include <linux/rtc.h>
+#include "tst_test.h"
+
+static void setup(void)
+{
+	int exists = ("/dev/rtc", O_RDONLY);
+
+	if (exists < 0)
+		tst_brk(TCONF, "RTC device driver file not available");
+}
+
+static char interrupts[][10] = {"alarm", "periodic", "update", "watchdog"};
+static int interrupt_requests[] = {
+	RTC_AIE_ON, RTC_PIE_ON, RTC_UIE_ON, RTC_WIE_ON,
+	RTC_AIE_OFF, RTC_PIE_OFF, RTC_UIE_OFF, RTC_WIE_OFF};
+static char requests_text[][15] = {
+	"RTC_AIE_ON", "RTC_PIE_ON", "RTC_UIE_ON", "RTC_WIE_ON",
+	"RTC_AIE_OFF", "RTC_PIE_OFF", "RTC_UIE_OFF", "RTC_WIE_OFF"};
+
+static void test_request(unsigned int n)
+{
+	int fd;
+
+	int on_request = interrupt_requests[n];
+	int off_request = interrupt_requests[n + 4];
+
+	char on_request_text[15], off_request_text[15];
+
+	strcpy(on_request_text, requests_text[n]);
+	strcpy(off_request_text, requests_text[n + 4]);
+
+	fd = SAFE_OPEN("/dev/rtc", O_RDWR);
+
+	if (fd == -1)
+		tst_brk(TCONF, "RTC device driver file could not be opened");
+
+	if (ioctl(fd, on_request) == -1) {
+		if (errno == ENOTTY) {
+			tst_res(TCONF, "ioctl %s not supported on RTC device",
+				on_request_text);
+		} else {
+			tst_res(TFAIL, "unexpected ioctl error");
+		}
+	} else {
+		tst_res(TPASS, "%s interrupt enabled", interrupts[n]);
+	}
+
+	if (ioctl(fd, off_request) == -1) {
+		if (errno == ENOTTY) {
+			tst_res(TCONF, "ioctl %s not supported on RTC device",
+				off_request_text);
+		} else {
+			tst_res(TFAIL, "unexpected ioctl error");
+		}
+	} else {
+		tst_res(TPASS, "%s interrupt disabled", interrupts[n]);
+	}
+
+	SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(interrupts),
+	.test = test_request,
+	.needs_root = 1,
+	.needs_device = 1,
+	.setup = setup,
+};
-- 
2.17.1

