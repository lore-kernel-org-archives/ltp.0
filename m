Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1XmKtf-00041P-BY
	for ltp-list@lists.sourceforge.net; Thu, 06 Nov 2014 11:06:35 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XmKte-000460-3s
	for ltp-list@lists.sourceforge.net; Thu, 06 Nov 2014 11:06:35 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id sA6B6R65012645
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 6 Nov 2014 11:06:28 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	sA6B6QSR021695
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Thu, 6 Nov 2014 11:06:27 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	sA6B6QdY004985
	for <ltp-list@lists.sourceforge.net>; Thu, 6 Nov 2014 11:06:26 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu,  6 Nov 2014 14:08:17 +0400
Message-Id: <1415268497-8921-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH v3] device-drivers/ltp_acpi_cpufreq: use simple
	counter instead of cur_freq
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

Right now the test gives false results on kernels since v3.9. That's because
of the following commit:
acpi-cpufreq: set current frequency based on target P-State
8673b83bf2f013379453b4779047bf3c6ae387e4

So the sysfs 'cpuinfo_cur_freq' gives target frequency which is set by
acpi-cpufreq driver itself.

One possible way to find out that boost is actually off is to calculate
average integer counter frequency on the tested CPU (this is how is done in
the patch).

Another way is to utilize MSR APERF/MPERF registers and TSC in Intel
processors. That can be done by reading MSR from /dev/cpu/0/msr. But
this will require additional checks in configure of asm/msr-index.h file
and built-in non-portable __get_cpuid() function, also reading TSC register
using asm instructions. And who knows what else for AMD silicons.

Let's not complicate things too much and use the first method.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
v3: I've changed load_cpu() and it now directly depends on maximum CPU
    frequency. Therefore, ideally, each sum calculation will be no longer
    than 1 sec. Also, don't use volatile variables because it significantly
    slows things down. Instead, use asm instruction with 'memory' clobber.

 testcases/kernel/device-drivers/acpi/Makefile      |    2 +-
 .../kernel/device-drivers/acpi/ltp_acpi_cpufreq.c  |   99 ++++++++++----------
 2 files changed, 49 insertions(+), 52 deletions(-)

diff --git a/testcases/kernel/device-drivers/acpi/Makefile b/testcases/kernel/device-drivers/acpi/Makefile
index ce1ab34..526604d 100644
--- a/testcases/kernel/device-drivers/acpi/Makefile
+++ b/testcases/kernel/device-drivers/acpi/Makefile
@@ -27,7 +27,7 @@ REQ_VERSION_MAJOR	:= 2
 REQ_VERSION_PATCH	:= 6
 MAKE_TARGETS		:= ltp_acpi_cpufreq ltp_acpi ltp_acpi_cmds.ko
 
-ltp_acpi_cpufreq: LDLIBS += -lpthread
+ltp_acpi_cpufreq: LDLIBS += -lrt
 
 include $(top_srcdir)/include/mk/module.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/device-drivers/acpi/ltp_acpi_cpufreq.c b/testcases/kernel/device-drivers/acpi/ltp_acpi_cpufreq.c
index 73fb430..eea723e 100644
--- a/testcases/kernel/device-drivers/acpi/ltp_acpi_cpufreq.c
+++ b/testcases/kernel/device-drivers/acpi/ltp_acpi_cpufreq.c
@@ -20,19 +20,23 @@
  * Check support for disabling dynamic overclocking in acpi_cpufreq driver.
  * Required Linux 3.7+.
  *
- * The test loads CPU0 in a thread. When the loading approaches to the end
- * (2/3 elapsed), the test will check processor frequency. if boost is enabled
- * we can get a slightly higher speed under load.
+ * The test calculates counter frequency with and without boost-disable bit.
+ * If boost is enabled we can get a slightly higher counter frequency.
+ * Use simple counter instead of sysfs cpuinfo_cur_freq value, because after
+ * the upstream commit 8673b83bf2f013379453b4779047bf3c6ae387e4, current
+ * cpu frequency became target cpu frequency.
  */
 
 #define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <sched.h>
+#include <time.h>
 #include <sys/time.h>
-#include <pthread.h>
+#include <sys/resource.h>
 #include <sys/types.h>
 #include <sys/stat.h>
+#include <unistd.h>
 #include <fcntl.h>
 
 #include "test.h"
@@ -51,7 +55,6 @@ const char governor[]	= SYSFS_CPU_DIR "cpu0/cpufreq/scaling_governor";
 static char governor_name[16];
 
 const char setspeed[]	= SYSFS_CPU_DIR "cpu0/cpufreq/scaling_setspeed";
-const char curspeed[]	= SYSFS_CPU_DIR "cpu0/cpufreq/cpuinfo_cur_freq";
 const char maxspeed[]	= SYSFS_CPU_DIR "cpu0/cpufreq/scaling_max_freq";
 
 static void cleanup(void)
@@ -90,6 +93,13 @@ static void setup(void)
 	CPU_SET(0, &set);
 	if (sched_setaffinity(0, sizeof(cpu_set_t), &set) < 0)
 		tst_brkm(TBROK | TERRNO, cleanup, "failed to set CPU0");
+
+	struct sched_param params;
+	params.sched_priority = sched_get_priority_max(SCHED_FIFO);
+	if (sched_setscheduler(getpid(), SCHED_FIFO, &params)) {
+		tst_resm(TWARN | TERRNO,
+			"failed to set FIFO sched with max priority");
+	}
 }
 
 static void set_speed(int freq)
@@ -98,78 +108,65 @@ static void set_speed(int freq)
 	SAFE_FILE_SCANF(cleanup, setspeed, "%d", &set_freq);
 
 	if (set_freq != freq) {
-		tst_resm(TINFO, "change speed from %d to %d...",
+		tst_resm(TINFO, "change target speed from %d KHz to %d KHz",
 			set_freq, freq);
 		SAFE_FILE_PRINTF(cleanup, setspeed, "%d", freq);
 	} else {
-		tst_resm(TINFO, "set speed is %d", set_freq);
+		tst_resm(TINFO, "target speed is %d KHz", set_freq);
 	}
 }
 
-void *thread_fn(void *val)
+static int load_cpu(int max_freq_khz)
 {
-	struct timeval tv_start;
-	struct timeval tv_end;
-	int i, res = 0;
-	intptr_t timeout = (intptr_t) val;
-
-	gettimeofday(&tv_start, NULL);
-	tst_resm(TINFO, "load CPU0 for %ld sec...", timeout);
+	int sum = 0, i = 0, total_time_ms;
+	struct timespec tv_start, tv_end;
 
-	do {
-		for (i = 1; i < 10000; ++i)
-			res += i * i;
-		gettimeofday(&tv_end, NULL);
-		sched_yield();
-	} while ((tv_end.tv_sec - tv_start.tv_sec) < timeout);
-
-	tst_resm(TINFO, "CPU0 load done: insignificant value '%d'", res);
+	const int max_sum = max_freq_khz / 1000;
+	const int units = 1000000; /* Mhz */
 
-	return NULL;
-}
+	clock_gettime(CLOCK_MONOTONIC_RAW, &tv_start);
 
-static int load_cpu(intptr_t timeout)
-{
-	pthread_t thread_id;
+	do {
+		for (i = 0; i < units; ++i)
+			asm ("" : : : "memory");
+	} while (++sum < max_sum);
 
-	if (pthread_create(&thread_id, 0, thread_fn,
-		(void *) timeout) != 0) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			"pthread_create failed at %s:%d",
-			__FILE__, __LINE__);
-	}
+	clock_gettime(CLOCK_MONOTONIC_RAW, &tv_end);
 
-	sleep(2 * timeout / 3);
+	total_time_ms = (tv_end.tv_sec - tv_start.tv_sec) * 1000 +
+		(tv_end.tv_nsec - tv_start.tv_nsec) / 1000000;
 
-	int cur_freq;
-	SAFE_FILE_SCANF(cleanup, curspeed, "%d", &cur_freq);
-	tst_resm(TINFO, "got cpu freq under load: %d", cur_freq);
+	if (!total_time_ms)
+		tst_brkm(TBROK, cleanup, "can't calc freq, time period is 0");
 
-	pthread_join(thread_id, NULL);
+	tst_resm(TINFO, "elapsed time is %d ms", total_time_ms);
 
-	return cur_freq;
+	return sum * 1000 / total_time_ms;
 }
 
 static void test_run(void)
 {
-	int cur_freq, max_freq;
-	SAFE_FILE_SCANF(cleanup, maxspeed, "%d", &max_freq);
-	set_speed(max_freq);
+	int boost_freq, boost_off_freq, max_freq_khz;
+	SAFE_FILE_SCANF(cleanup, maxspeed, "%d", &max_freq_khz);
+	set_speed(max_freq_khz);
 
 	/* Enable boost */
 	if (boost_value == 0)
 		SAFE_FILE_PRINTF(cleanup, boost, "1");
-	cur_freq = load_cpu(30);
-	tst_resm((cur_freq >= max_freq) ? TPASS : TFAIL,
-		"compare current speed %d and max speed %d",
-		cur_freq, max_freq);
+	boost_freq = load_cpu(max_freq_khz);
+	tst_resm(TINFO, "counter freq with boost enabled: %d MHz", boost_freq);
 
 	/* Disable boost */
 	SAFE_FILE_PRINTF(cleanup, boost, "0");
-	cur_freq = load_cpu(30);
-	tst_resm((cur_freq < max_freq) ? TPASS : TFAIL,
-		"compare current speed %d and max speed %d",
-		cur_freq, max_freq);
+	boost_off_freq = load_cpu(max_freq_khz);
+
+	tst_resm(TINFO, "counter freq with boost disabled: %d MHz",
+		boost_off_freq);
+
+	boost_off_freq *= 1.01;
+
+	tst_resm((boost_freq > boost_off_freq) ? TPASS : TFAIL,
+		"compare counter frequencies (with and without boost + 1%%)");
 }
 
 int main(int argc, char *argv[])
-- 
1.7.1


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
