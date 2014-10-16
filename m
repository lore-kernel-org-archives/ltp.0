Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1XehMk-0001RX-Kr
	for ltp-list@lists.sourceforge.net; Thu, 16 Oct 2014 09:29:02 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XehMj-0008Vn-GM
	for ltp-list@lists.sourceforge.net; Thu, 16 Oct 2014 09:29:02 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s9G9StCP029236
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 16 Oct 2014 09:28:55 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s9G9Ssk0015799
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Thu, 16 Oct 2014 09:28:55 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s9G9SsRi023996
	for <ltp-list@lists.sourceforge.net>; Thu, 16 Oct 2014 09:28:54 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 16 Oct 2014 13:30:47 +0400
Message-Id: <1413451847-10433-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH v2] device-drivers/ltp_acpi_cpufreq: use simple
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
the patch). Results show that the calculated counter frequency is close to
actual CPU frequency if no other threads with the highest priority are
running on the test CPU. The above condition is true for most cases.

Another way is to utilize MSR APERF/MPERF registers and TSC in Intel
processors. That can be done by reading MSR from /dev/cpu/0/msr. But
this will require additional checks in configure of asm/msr-index.h file
and built-in non-portable __get_cpuid() function, also reading TSC register
using asm instructions. And who knows what else for AMD silicons.

Let's not complicate things too much and use the first method.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
v2: set 'SCHED_FIFO' scheduler as it will always be scheduled ahead of
    any 'SCHED_OTHER' thread.

 .../kernel/device-drivers/acpi/ltp_acpi_cpufreq.c  |   69 ++++++++++++--------
 1 files changed, 42 insertions(+), 27 deletions(-)

diff --git a/testcases/kernel/device-drivers/acpi/ltp_acpi_cpufreq.c b/testcases/kernel/device-drivers/acpi/ltp_acpi_cpufreq.c
index 73fb430..8214291 100644
--- a/testcases/kernel/device-drivers/acpi/ltp_acpi_cpufreq.c
+++ b/testcases/kernel/device-drivers/acpi/ltp_acpi_cpufreq.c
@@ -20,9 +20,12 @@
  * Check support for disabling dynamic overclocking in acpi_cpufreq driver.
  * Required Linux 3.7+.
  *
- * The test loads CPU0 in a thread. When the loading approaches to the end
- * (2/3 elapsed), the test will check processor frequency. if boost is enabled
- * we can get a slightly higher speed under load.
+ * The test loads CPU0 in a thread. It will calc counter frequency on each
+ * load-run with and without boost-disable bit. If boost is enabled we can
+ * get a slightly higher counter frequency. Use simple counter and don't rely
+ * on sysfs cpuinfo_cur_freq value, because after the upstream commit
+ * 8673b83bf2f013379453b4779047bf3c6ae387e4, current cpu frequency becomes
+ * target cpu frequency.
  */
 
 #define _GNU_SOURCE
@@ -30,9 +33,11 @@
 #include <stdlib.h>
 #include <sched.h>
 #include <sys/time.h>
+#include <sys/resource.h>
 #include <pthread.h>
 #include <sys/types.h>
 #include <sys/stat.h>
+#include <unistd.h>
 #include <fcntl.h>
 
 #include "test.h"
@@ -54,6 +59,8 @@ const char setspeed[]	= SYSFS_CPU_DIR "cpu0/cpufreq/scaling_setspeed";
 const char curspeed[]	= SYSFS_CPU_DIR "cpu0/cpufreq/cpuinfo_cur_freq";
 const char maxspeed[]	= SYSFS_CPU_DIR "cpu0/cpufreq/scaling_max_freq";
 
+const int units = 1000000; /* Mhz */
+
 static void cleanup(void)
 {
 	SAFE_FILE_PRINTF(NULL, boost, "%d", boost_value);
@@ -110,26 +117,34 @@ void *thread_fn(void *val)
 {
 	struct timeval tv_start;
 	struct timeval tv_end;
-	int i, res = 0;
-	intptr_t timeout = (intptr_t) val;
+	int i;
+	unsigned long long res = 0;
+	intptr_t timeout = (intptr_t) val, ret;
+
+	struct sched_param params;
+	params.sched_priority = sched_get_priority_max(SCHED_FIFO);
+	if (pthread_setschedparam(pthread_self(), SCHED_FIFO, &params)) {
+		tst_resm(TWARN | TERRNO,
+			"failed to set FIFO sched with max priority");
+	}
 
 	gettimeofday(&tv_start, NULL);
 	tst_resm(TINFO, "load CPU0 for %ld sec...", timeout);
 
 	do {
-		for (i = 1; i < 10000; ++i)
-			res += i * i;
+		for (i = 0; i < units; ++i)
+			++res;
 		gettimeofday(&tv_end, NULL);
-		sched_yield();
 	} while ((tv_end.tv_sec - tv_start.tv_sec) < timeout);
 
-	tst_resm(TINFO, "CPU0 load done: insignificant value '%d'", res);
+	ret = res / units / timeout;
 
-	return NULL;
+	return ((void *)ret);
 }
 
 static int load_cpu(intptr_t timeout)
 {
+	void *ret;
 	pthread_t thread_id;
 
 	if (pthread_create(&thread_id, 0, thread_fn,
@@ -139,37 +154,37 @@ static int load_cpu(intptr_t timeout)
 			__FILE__, __LINE__);
 	}
 
-	sleep(2 * timeout / 3);
-
-	int cur_freq;
-	SAFE_FILE_SCANF(cleanup, curspeed, "%d", &cur_freq);
-	tst_resm(TINFO, "got cpu freq under load: %d", cur_freq);
-
-	pthread_join(thread_id, NULL);
+	pthread_join(thread_id, &ret);
 
-	return cur_freq;
+	return (intptr_t)ret;
 }
 
 static void test_run(void)
 {
-	int cur_freq, max_freq;
+	int boost_freq, boost_off_freq, max_freq;
 	SAFE_FILE_SCANF(cleanup, maxspeed, "%d", &max_freq);
 	set_speed(max_freq);
 
+	/* make sure the process gets to run with the highest priority */
+	load_cpu(5);
+
 	/* Enable boost */
 	if (boost_value == 0)
 		SAFE_FILE_PRINTF(cleanup, boost, "1");
-	cur_freq = load_cpu(30);
-	tst_resm((cur_freq >= max_freq) ? TPASS : TFAIL,
-		"compare current speed %d and max speed %d",
-		cur_freq, max_freq);
+	boost_freq = load_cpu(12);
+	tst_resm(TINFO, "avg counter freq with boost enabled: %d MHz", boost_freq);
 
 	/* Disable boost */
 	SAFE_FILE_PRINTF(cleanup, boost, "0");
-	cur_freq = load_cpu(30);
-	tst_resm((cur_freq < max_freq) ? TPASS : TFAIL,
-		"compare current speed %d and max speed %d",
-		cur_freq, max_freq);
+	boost_off_freq = load_cpu(12);
+
+	tst_resm(TINFO, "avg counter freq with boost disabled: %d MHz", boost_off_freq);
+
+	boost_off_freq *= 1.01;
+
+	tst_resm((boost_freq > boost_off_freq) ? TPASS : TFAIL,
+		"compare boost speed %d and speed without boost + 1%% %d",
+		boost_freq, boost_off_freq);
 }
 
 int main(int argc, char *argv[])
-- 
1.7.1


------------------------------------------------------------------------------
Comprehensive Server Monitoring with Site24x7.
Monitor 10 servers for $9/Month.
Get alerted through email, SMS, voice calls or mobile push notifications.
Take corrective actions from your mobile device.
http://p.sf.net/sfu/Zoho
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
