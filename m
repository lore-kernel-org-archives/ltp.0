From: gengcixi@gmail.com <gengcixi@gmail.com>
Date: Mon, 11 Jan 2021 16:37:10 +0800
Subject: [LTP] [PATCH V2 3/3] device-drivers/rtc: add verify rtc set time
 case
In-Reply-To: <20210111083711.1715851-1-gengcixi@gmail.com>
References: <20210111083711.1715851-1-gengcixi@gmail.com>
Message-ID: <20210111083711.1715851-4-gengcixi@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Cixi Geng <cixi.geng1@unisoc.com>

Test for the Real Time Clock driver.
 * Veirify that,
 * 1) set a RTC time
 * 2) read the RTC time after set RTC time at once
 * 3) compare the set time and the read is identical

Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
---
 runtest/kernel_misc                           |   1 +
 .../kernel/device-drivers/rtc/.gitignore      |   1 +
 testcases/kernel/device-drivers/rtc/rtc02.c   | 111 ++++++++++++++++++
 3 files changed, 113 insertions(+)
 create mode 100644 testcases/kernel/device-drivers/rtc/rtc02.c

diff --git a/runtest/kernel_misc b/runtest/kernel_misc
index 7937c7bbf..abb75ebaf 100644
--- a/runtest/kernel_misc
+++ b/runtest/kernel_misc
@@ -1,6 +1,7 @@
 kmsg01 kmsg01
 fw_load fw_load
 rtc01 rtc01
+rtc02 rtc02
 block_dev block_dev
 tpci tpci
 tbio tbio
diff --git a/testcases/kernel/device-drivers/rtc/.gitignore b/testcases/kernel/device-drivers/rtc/.gitignore
index 8412fe679..0c0161eba 100644
--- a/testcases/kernel/device-drivers/rtc/.gitignore
+++ b/testcases/kernel/device-drivers/rtc/.gitignore
@@ -1 +1,2 @@
 /rtc01
+/rtc02
diff --git a/testcases/kernel/device-drivers/rtc/rtc02.c b/testcases/kernel/device-drivers/rtc/rtc02.c
new file mode 100644
index 000000000..a4c758fcd
--- /dev/null
+++ b/testcases/kernel/device-drivers/rtc/rtc02.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2020 Unisoc Communications Inc.
+ */
+
+/*\
+ * [DESCRIPTION]
+ *
+ * test rtc devices set time functioin
+ *
+ * The steps:
+ *
+ * - save rtc time and set a RTC time
+ * - read the RTC time after set RTC time at once
+ * - compare the set time and the read is identical
+ * - in the cleanup function, restore rtc time.
+ *
+\*/
+
+#include <stdio.h>
+#include "tst_rtctime.h"
+#include "tst_wallclock.h"
+#include "tst_test.h"
+
+static char *rtc_dev = "/dev/rtc";
+
+static char *rtctime_to_str(struct rtc_time *tm)
+{
+	static char rtctime_buf[20];
+
+	sprintf(rtctime_buf, "%04d-%02d-%02d %02d:%02d:%02d",
+		tm->tm_year + 1900,
+		tm->tm_mon + 1,
+		tm->tm_mday,
+		tm->tm_hour,
+		tm->tm_min,
+		tm->tm_sec);
+	return rtctime_buf;
+}
+
+static int rtc_tm_cmp(struct rtc_time *set_tm, struct rtc_time *read_tm)
+{
+	return !((set_tm->tm_sec == read_tm->tm_sec)
+		&& (set_tm->tm_min == read_tm->tm_min)
+		&& (set_tm->tm_hour == read_tm->tm_hour)
+		&& (set_tm->tm_mday == read_tm->tm_mday)
+		&& (set_tm->tm_mon == read_tm->tm_mon)
+		&& (set_tm->tm_year == read_tm->tm_year));
+}
+
+static void set_rtc_test(void)
+{
+	struct rtc_time read_tm;
+	int ret;
+
+	struct rtc_time set_tm = {
+		.tm_sec = 30,
+		.tm_min = 23,
+		.tm_hour = 13,
+		.tm_mday = 9,
+		.tm_mon = 9,
+		.tm_year = 120,
+	};
+
+	/* set rtc to 2020.10.9 13:23:30 */
+	tst_res(TINFO, "To set RTC date/time is: %s", rtctime_to_str(&set_tm));
+
+	ret = tst_rtc_settime(rtc_dev, &set_tm);
+	if (ret != 0) {
+		tst_res(TFAIL | TERRNO, "RTC_SET_TIME failed");
+		return;
+	}
+
+	/* Read current RTC Time */
+	ret = tst_rtc_gettime(rtc_dev, &read_tm);
+	if (ret != 0) {
+		tst_res(TFAIL | TERRNO, "RTC_RD_TIME failed");
+		return;
+	}
+	tst_res(TINFO, "read RTC date/time is: %s", rtctime_to_str(&read_tm));
+
+	if (rtc_tm_cmp(&set_tm, &read_tm)) {
+		tst_res(TFAIL | TERRNO, "RTC SET TEST Failed");
+		return;
+	}
+	tst_res(TPASS, "The read RTC time is consistent with set time");
+
+}
+
+static void rtc_setup(void)
+{
+	int exists = access(rtc_dev, F_OK);
+
+	if (exists < 0)
+		tst_brk(TCONF, "RTC device %s not available", rtc_dev);
+
+	tst_rtc_clock_save(rtc_dev);
+}
+
+static void rtc_cleanup(void)
+{
+	tst_rtc_clock_restore(rtc_dev);
+}
+
+static struct tst_test test = {
+	.setup = rtc_setup,
+	.test_all = set_rtc_test,
+	.cleanup = rtc_cleanup,
+	/* tests needs to run with UID=0 */
+	.needs_root = 1,
+};
-- 
2.25.1

