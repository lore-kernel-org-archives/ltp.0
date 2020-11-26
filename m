From: gengcixi@gmail.com <gengcixi@gmail.com>
Date: Thu, 26 Nov 2020 19:07:10 +0800
Subject: [LTP] [PATCH] device-drivers/rtc: add rtc02 test
Message-ID: <20201126110710.436277-1-gengcixi@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Cixi Geng <cixi.geng1@unisoc.com>

add new testcase for Real Time Clock driver

Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
Signed-off-by: Xiaopeng Bai <xiaopeng.bai@unisoc.com>
---
 runtest/kernel_misc                         |   1 +
 testcases/kernel/device-drivers/rtc/rtc02.c | 119 ++++++++++++++++++++
 2 files changed, 120 insertions(+)
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
diff --git a/testcases/kernel/device-drivers/rtc/rtc02.c b/testcases/kernel/device-drivers/rtc/rtc02.c
new file mode 100644
index 000000000..cce799670
--- /dev/null
+++ b/testcases/kernel/device-drivers/rtc/rtc02.c
@@ -0,0 +1,119 @@
+/*
+ * Test for the Real Time Clock driver.
+ * 
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Copyright (C) 2019, Unisoc Communications Inc.
+ *
+ * Author: Xiaopeng Bai <xiaopeng.bai@unisoc.com>
+ * Author: Cixi Geng  <cixi.gegn1@unisoc.com>
+ *
+ */
+
+#include <sys/ioctl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <linux/rtc.h>
+#include <errno.h>
+#include <time.h>
+
+#include "tst_test.h"
+
+int rtc_fd = -1;
+
+static char *rtc_dev = "/dev/rtc";
+
+static struct tst_option rtc_options[] = {
+	{"d:", &rtc_dev, "test driver device name"},
+	{NULL, NULL, NULL}
+};
+
+static void help(void)
+{
+	printf("  -d xxx --> rtc device node, default is %s\n",
+	rtc_dev);
+}
+
+static void rtc_setup(void)
+{
+	if (access(rtc_dev, F_OK) == -1)
+		tst_brk(TBROK | TERRNO, "setenv() failed");
+}
+
+static int rtc_tm_cmp(struct rtc_time *set_tm, struct rtc_time *read_tm)
+{
+	if ((set_tm->tm_sec == read_tm->tm_sec)
+		&& (set_tm->tm_min == read_tm->tm_min)
+		&& (set_tm->tm_hour == read_tm->tm_hour)
+		&& (set_tm->tm_mday == read_tm->tm_mday)
+		&& (set_tm->tm_mon == read_tm->tm_mon)
+		&& (set_tm->tm_year == read_tm->tm_year)) {
+		return 0;
+	}
+
+	return -1;
+}
+
+static void set_rtc_test(void)
+{
+	struct rtc_time set_tm, read_tm;
+	int ret;
+
+	rtc_fd = SAFE_OPEN(rtc_dev, O_RDONLY);
+
+	tst_res(TINFO, "RTC SET TEST :");
+
+	/* set rtc to 2020.10.9 13:23:30 */
+	set_tm.tm_sec = 30;
+	set_tm.tm_min = 23;
+	set_tm.tm_hour = 13;
+	set_tm.tm_mday = 9;
+	set_tm.tm_mon = 9;
+	set_tm.tm_year = 120;
+	tst_res(TINFO, "set RTC date/time is %d-%d-%d, %02d:%02d:%02d.",
+		 set_tm.tm_mday, set_tm.tm_mon + 1, set_tm.tm_year + 1900,
+		 set_tm.tm_hour, set_tm.tm_min, set_tm.tm_sec);
+
+	ret = ioctl(rtc_fd, RTC_SET_TIME, &set_tm);
+	if (ret != 0) {
+		tst_res(TFAIL | TERRNO, "RTC_SET_TIME ioctl failed");
+		return;
+	}
+
+	tst_res(TINFO, "RTC READ TEST:");
+	/* Read current RTC Time */
+	ret = ioctl(rtc_fd, RTC_RD_TIME, &read_tm);
+	if (ret !=0) {
+		tst_res(TFAIL | TERRNO, "RTC_RD_TIME ioctl failed");
+		return;
+	}
+	tst_res(TINFO, "read RTC date/time is %d-%d-%d, %02d:%02d:%02d.",
+		 read_tm.tm_mday, read_tm.tm_mon + 1, read_tm.tm_year + 1900,
+		 read_tm.tm_hour, read_tm.tm_min, read_tm.tm_sec);
+	tst_res(TPASS, "RTC READ TEST Passed");
+
+	if (rtc_tm_cmp(&set_tm, &read_tm)) {
+		tst_res(TFAIL | TERRNO, "RTC SET TEST Failed");
+		return;
+	}
+
+	tst_res(TPASS, "RTC SET TEST Passed");
+
+	tst_res(TINFO, "RTC Tests Done!");
+}
+
+static void rtc_cleanup(viod)
+{
+	if(rtc_fd > 0){
+		SAFE_CLOSE(rtc_fd);
+	}
+}
+
+static struct tst_test test={
+	.setup = rtc_setup,
+	.test_all = set_rtc_test,
+	.options = rtc_options,
+	.cleanup = rtc_cleanup,
+	.needs_root = 1,
+};
-- 
2.25.1

