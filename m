Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1Xwa3i-000436-NE
	for ltp-list@lists.sourceforge.net; Thu, 04 Dec 2014 17:19:18 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Xwa3g-0006wl-Vp
	for ltp-list@lists.sourceforge.net; Thu, 04 Dec 2014 17:19:18 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id sB4HJAYe030680
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 4 Dec 2014 17:19:11 GMT
Received: from userz7022.oracle.com (userz7022.oracle.com [156.151.31.86])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	sB4HJ92j012352
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Thu, 4 Dec 2014 17:19:10 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
	by userz7022.oracle.com (8.14.5+Sun/8.14.4) with ESMTP id
	sB4HJ9iP000611
	for <ltp-list@lists.sourceforge.net>; Thu, 4 Dec 2014 17:19:09 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu,  4 Dec 2014 20:20:56 +0300
Message-Id: <1417713657-2556-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH 1/2] device-drivers/ltp_acpi_cpufreq: move it to
	cpufreq/cpufreq_boost
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: vasily.isaenko@oracle.com

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 runtest/kernel_misc                                |    2 +-
 testcases/kernel/device-drivers/Makefile           |    1 +
 testcases/kernel/device-drivers/acpi/.gitignore    |    1 -
 testcases/kernel/device-drivers/acpi/Makefile      |    4 +-
 .../kernel/device-drivers/acpi/ltp_acpi_cpufreq.c  |  177 --------------------
 testcases/kernel/device-drivers/cpufreq/.gitignore |    1 +
 testcases/kernel/device-drivers/cpufreq/Makefile   |   22 +++
 .../kernel/device-drivers/cpufreq/cpufreq_boost.c  |  177 ++++++++++++++++++++
 8 files changed, 203 insertions(+), 182 deletions(-)
 delete mode 100644 testcases/kernel/device-drivers/acpi/ltp_acpi_cpufreq.c
 create mode 100644 testcases/kernel/device-drivers/cpufreq/.gitignore
 create mode 100644 testcases/kernel/device-drivers/cpufreq/Makefile
 create mode 100644 testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c

diff --git a/runtest/kernel_misc b/runtest/kernel_misc
index 01b0acb..c12c31e 100644
--- a/runtest/kernel_misc
+++ b/runtest/kernel_misc
@@ -5,6 +5,6 @@ block_dev block_dev
 tpci tpci
 tbio tbio
 ltp_acpi ltp_acpi
-ltp_acpi_cpufreq ltp_acpi_cpufreq
+cpufreq_boost cpufreq_boost
 uaccess uaccess
 rcu_torture rcu_torture.sh
diff --git a/testcases/kernel/device-drivers/Makefile b/testcases/kernel/device-drivers/Makefile
index 37b6c64..a5a1745 100644
--- a/testcases/kernel/device-drivers/Makefile
+++ b/testcases/kernel/device-drivers/Makefile
@@ -20,6 +20,7 @@ include $(top_srcdir)/include/mk/env_pre.mk
 
 SUBDIRS		:= acpi \
 		   block \
+		   cpufreq \
 		   pci \
 		   rcu \
 		   rtc \
diff --git a/testcases/kernel/device-drivers/acpi/.gitignore b/testcases/kernel/device-drivers/acpi/.gitignore
index 4872ffd..6aa2c12 100644
--- a/testcases/kernel/device-drivers/acpi/.gitignore
+++ b/testcases/kernel/device-drivers/acpi/.gitignore
@@ -1,6 +1,5 @@
 /ltp_acpi_cmds.ko
 /ltp_acpi
-/ltp_acpi_cpufreq
 /*.mod.c
 /modules.order
 /.tmp_versions
diff --git a/testcases/kernel/device-drivers/acpi/Makefile b/testcases/kernel/device-drivers/acpi/Makefile
index 526604d..31bf26b 100644
--- a/testcases/kernel/device-drivers/acpi/Makefile
+++ b/testcases/kernel/device-drivers/acpi/Makefile
@@ -25,9 +25,7 @@ include $(top_srcdir)/include/mk/testcases.mk
 
 REQ_VERSION_MAJOR	:= 2
 REQ_VERSION_PATCH	:= 6
-MAKE_TARGETS		:= ltp_acpi_cpufreq ltp_acpi ltp_acpi_cmds.ko
-
-ltp_acpi_cpufreq: LDLIBS += -lrt
+MAKE_TARGETS		:= ltp_acpi ltp_acpi_cmds.ko
 
 include $(top_srcdir)/include/mk/module.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/device-drivers/acpi/ltp_acpi_cpufreq.c b/testcases/kernel/device-drivers/acpi/ltp_acpi_cpufreq.c
deleted file mode 100644
index 423188e..0000000
--- a/testcases/kernel/device-drivers/acpi/ltp_acpi_cpufreq.c
+++ /dev/null
@@ -1,177 +0,0 @@
-/*
- * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software Foundation,
- * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
- * Author: Alexey Kodanev <alexey.kodanev@oracle.com>
- *
- * Check support for disabling dynamic overclocking in acpi_cpufreq driver.
- * Required Linux 3.7+.
- *
- * The test compares time spent on sum calculation with/without
- * boost-disable bit. If boost is enabled we can get a slightly shorter
- * time period. Measure elapsed time instead of sysfs cpuinfo_cur_freq value,
- * because after the upstream commit 8673b83bf2f013379453b4779047bf3c6ae387e4,
- * current cpu frequency became target cpu frequency.
- */
-
-#define _GNU_SOURCE
-#include <sched.h>
-#include <time.h>
-
-#include "test.h"
-#include "usctest.h"
-#include "lapi/posix_clocks.h"
-#include "safe_macros.h"
-#include "safe_stdio.h"
-
-char *TCID = "ltp_acpi_cpufreq";
-
-#define SYSFS_CPU_DIR "/sys/devices/system/cpu/"
-
-const char boost[]	= SYSFS_CPU_DIR "cpufreq/boost";
-static int boost_value;
-
-const char governor[]	= SYSFS_CPU_DIR "cpu0/cpufreq/scaling_governor";
-static char governor_name[16];
-
-const char setspeed[]	= SYSFS_CPU_DIR "cpu0/cpufreq/scaling_setspeed";
-const char maxspeed[]	= SYSFS_CPU_DIR "cpu0/cpufreq/scaling_max_freq";
-
-static void cleanup(void)
-{
-	SAFE_FILE_PRINTF(NULL, boost, "%d", boost_value);
-
-	if (governor[0] != '\0')
-		SAFE_FILE_PRINTF(NULL, governor, "%s", governor_name);
-
-	TEST_CLEANUP;
-}
-
-static void setup(void)
-{
-	int fd;
-	tst_require_root(NULL);
-
-	fd = open(boost, O_RDWR);
-	if (fd == -1) {
-		tst_brkm(TCONF, NULL,
-			"acpi-cpufreq not loaded or overclock not supported");
-	}
-	close(fd);
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	SAFE_FILE_SCANF(NULL, boost, "%d", &boost_value);
-
-	/* change cpu0 scaling governor */
-	SAFE_FILE_SCANF(NULL, governor, "%s", governor_name);
-	SAFE_FILE_PRINTF(cleanup, governor, "%s", "userspace");
-
-	/* use only cpu0 */
-	cpu_set_t set;
-	CPU_ZERO(&set);
-	CPU_SET(0, &set);
-	if (sched_setaffinity(0, sizeof(cpu_set_t), &set) < 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "failed to set CPU0");
-
-	struct sched_param params;
-	params.sched_priority = sched_get_priority_max(SCHED_FIFO);
-	if (sched_setscheduler(getpid(), SCHED_FIFO, &params)) {
-		tst_resm(TWARN | TERRNO,
-			"failed to set FIFO sched with max priority");
-	}
-}
-
-static void set_speed(int freq)
-{
-	int set_freq;
-	SAFE_FILE_SCANF(cleanup, setspeed, "%d", &set_freq);
-
-	if (set_freq != freq) {
-		tst_resm(TINFO, "change target speed from %d KHz to %d KHz",
-			set_freq, freq);
-		SAFE_FILE_PRINTF(cleanup, setspeed, "%d", freq);
-	} else {
-		tst_resm(TINFO, "target speed is %d KHz", set_freq);
-	}
-}
-
-static int load_cpu(int max_freq_khz)
-{
-	int sum = 0, i = 0, total_time_ms;
-	struct timespec tv_start, tv_end;
-
-	const int max_sum = max_freq_khz / 1000;
-	const int units = 1000000; /* Mhz */
-
-	clock_gettime(CLOCK_MONOTONIC_RAW, &tv_start);
-
-	do {
-		for (i = 0; i < units; ++i)
-			asm ("" : : : "memory");
-	} while (++sum < max_sum);
-
-	clock_gettime(CLOCK_MONOTONIC_RAW, &tv_end);
-
-	total_time_ms = (tv_end.tv_sec - tv_start.tv_sec) * 1000 +
-		(tv_end.tv_nsec - tv_start.tv_nsec) / 1000000;
-
-	if (!total_time_ms)
-		tst_brkm(TBROK, cleanup, "time period is 0");
-
-	tst_resm(TINFO, "elapsed time is %d ms", total_time_ms);
-
-	return total_time_ms;
-}
-
-static void test_run(void)
-{
-	int boost_time, boost_off_time, max_freq_khz;
-	SAFE_FILE_SCANF(cleanup, maxspeed, "%d", &max_freq_khz);
-	set_speed(max_freq_khz);
-
-	/* Enable boost */
-	if (boost_value == 0)
-		SAFE_FILE_PRINTF(cleanup, boost, "1");
-	tst_resm(TINFO, "load CPU0 with boost enabled");
-	boost_time = load_cpu(max_freq_khz);
-
-	/* Disable boost */
-	SAFE_FILE_PRINTF(cleanup, boost, "0");
-	tst_resm(TINFO, "load CPU0 with boost disabled");
-	boost_off_time = load_cpu(max_freq_khz);
-
-	boost_off_time *= .98;
-
-	tst_resm((boost_time < boost_off_time) ? TPASS : TFAIL,
-		"compare time spent with and without boost (-2%%)");
-}
-
-int main(int argc, char *argv[])
-{
-	const char *msg;
-	msg = parse_opts(argc, argv, NULL, NULL);
-	if (msg != NULL)
-		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
-
-	setup();
-
-	test_run();
-
-	cleanup();
-
-	tst_exit();
-}
diff --git a/testcases/kernel/device-drivers/cpufreq/.gitignore b/testcases/kernel/device-drivers/cpufreq/.gitignore
new file mode 100644
index 0000000..ee09908
--- /dev/null
+++ b/testcases/kernel/device-drivers/cpufreq/.gitignore
@@ -0,0 +1 @@
+/cpufreq_boost
diff --git a/testcases/kernel/device-drivers/cpufreq/Makefile b/testcases/kernel/device-drivers/cpufreq/Makefile
new file mode 100644
index 0000000..3021d22
--- /dev/null
+++ b/testcases/kernel/device-drivers/cpufreq/Makefile
@@ -0,0 +1,22 @@
+# Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
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
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+
+top_srcdir	?= ../../../..
+include $(top_srcdir)/include/mk/testcases.mk
+
+LDLIBS += -lrt
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c b/testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c
new file mode 100644
index 0000000..423188e
--- /dev/null
+++ b/testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c
@@ -0,0 +1,177 @@
+/*
+ * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write the Free Software Foundation,
+ * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ * Author: Alexey Kodanev <alexey.kodanev@oracle.com>
+ *
+ * Check support for disabling dynamic overclocking in acpi_cpufreq driver.
+ * Required Linux 3.7+.
+ *
+ * The test compares time spent on sum calculation with/without
+ * boost-disable bit. If boost is enabled we can get a slightly shorter
+ * time period. Measure elapsed time instead of sysfs cpuinfo_cur_freq value,
+ * because after the upstream commit 8673b83bf2f013379453b4779047bf3c6ae387e4,
+ * current cpu frequency became target cpu frequency.
+ */
+
+#define _GNU_SOURCE
+#include <sched.h>
+#include <time.h>
+
+#include "test.h"
+#include "usctest.h"
+#include "lapi/posix_clocks.h"
+#include "safe_macros.h"
+#include "safe_stdio.h"
+
+char *TCID = "ltp_acpi_cpufreq";
+
+#define SYSFS_CPU_DIR "/sys/devices/system/cpu/"
+
+const char boost[]	= SYSFS_CPU_DIR "cpufreq/boost";
+static int boost_value;
+
+const char governor[]	= SYSFS_CPU_DIR "cpu0/cpufreq/scaling_governor";
+static char governor_name[16];
+
+const char setspeed[]	= SYSFS_CPU_DIR "cpu0/cpufreq/scaling_setspeed";
+const char maxspeed[]	= SYSFS_CPU_DIR "cpu0/cpufreq/scaling_max_freq";
+
+static void cleanup(void)
+{
+	SAFE_FILE_PRINTF(NULL, boost, "%d", boost_value);
+
+	if (governor[0] != '\0')
+		SAFE_FILE_PRINTF(NULL, governor, "%s", governor_name);
+
+	TEST_CLEANUP;
+}
+
+static void setup(void)
+{
+	int fd;
+	tst_require_root(NULL);
+
+	fd = open(boost, O_RDWR);
+	if (fd == -1) {
+		tst_brkm(TCONF, NULL,
+			"acpi-cpufreq not loaded or overclock not supported");
+	}
+	close(fd);
+
+	tst_sig(FORK, DEF_HANDLER, cleanup);
+
+	SAFE_FILE_SCANF(NULL, boost, "%d", &boost_value);
+
+	/* change cpu0 scaling governor */
+	SAFE_FILE_SCANF(NULL, governor, "%s", governor_name);
+	SAFE_FILE_PRINTF(cleanup, governor, "%s", "userspace");
+
+	/* use only cpu0 */
+	cpu_set_t set;
+	CPU_ZERO(&set);
+	CPU_SET(0, &set);
+	if (sched_setaffinity(0, sizeof(cpu_set_t), &set) < 0)
+		tst_brkm(TBROK | TERRNO, cleanup, "failed to set CPU0");
+
+	struct sched_param params;
+	params.sched_priority = sched_get_priority_max(SCHED_FIFO);
+	if (sched_setscheduler(getpid(), SCHED_FIFO, &params)) {
+		tst_resm(TWARN | TERRNO,
+			"failed to set FIFO sched with max priority");
+	}
+}
+
+static void set_speed(int freq)
+{
+	int set_freq;
+	SAFE_FILE_SCANF(cleanup, setspeed, "%d", &set_freq);
+
+	if (set_freq != freq) {
+		tst_resm(TINFO, "change target speed from %d KHz to %d KHz",
+			set_freq, freq);
+		SAFE_FILE_PRINTF(cleanup, setspeed, "%d", freq);
+	} else {
+		tst_resm(TINFO, "target speed is %d KHz", set_freq);
+	}
+}
+
+static int load_cpu(int max_freq_khz)
+{
+	int sum = 0, i = 0, total_time_ms;
+	struct timespec tv_start, tv_end;
+
+	const int max_sum = max_freq_khz / 1000;
+	const int units = 1000000; /* Mhz */
+
+	clock_gettime(CLOCK_MONOTONIC_RAW, &tv_start);
+
+	do {
+		for (i = 0; i < units; ++i)
+			asm ("" : : : "memory");
+	} while (++sum < max_sum);
+
+	clock_gettime(CLOCK_MONOTONIC_RAW, &tv_end);
+
+	total_time_ms = (tv_end.tv_sec - tv_start.tv_sec) * 1000 +
+		(tv_end.tv_nsec - tv_start.tv_nsec) / 1000000;
+
+	if (!total_time_ms)
+		tst_brkm(TBROK, cleanup, "time period is 0");
+
+	tst_resm(TINFO, "elapsed time is %d ms", total_time_ms);
+
+	return total_time_ms;
+}
+
+static void test_run(void)
+{
+	int boost_time, boost_off_time, max_freq_khz;
+	SAFE_FILE_SCANF(cleanup, maxspeed, "%d", &max_freq_khz);
+	set_speed(max_freq_khz);
+
+	/* Enable boost */
+	if (boost_value == 0)
+		SAFE_FILE_PRINTF(cleanup, boost, "1");
+	tst_resm(TINFO, "load CPU0 with boost enabled");
+	boost_time = load_cpu(max_freq_khz);
+
+	/* Disable boost */
+	SAFE_FILE_PRINTF(cleanup, boost, "0");
+	tst_resm(TINFO, "load CPU0 with boost disabled");
+	boost_off_time = load_cpu(max_freq_khz);
+
+	boost_off_time *= .98;
+
+	tst_resm((boost_time < boost_off_time) ? TPASS : TFAIL,
+		"compare time spent with and without boost (-2%%)");
+}
+
+int main(int argc, char *argv[])
+{
+	const char *msg;
+	msg = parse_opts(argc, argv, NULL, NULL);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+	setup();
+
+	test_run();
+
+	cleanup();
+
+	tst_exit();
+}
-- 
1.7.1


------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=164703151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
