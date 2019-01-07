From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Mon, 7 Jan 2019 17:15:15 +0800
Subject: [LTP] [PATCH] device-drivers/cpufreq_boost.c: skip test if turbo is
	disabled by BIOS or unavailable on processor
Message-ID: <1546852515-19045-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

If intel_pstate driver has been initialized but turbo is disabled by BIOS
or unavailable on processor(i.e. intel_pstate/no_turbo file exists but its
default value is 1), we cannot write data into intel_pstate/no_turbo and
return EPERM, as below:
------------------------------------------------------------------------
cpufreq_boost    1  TBROK  :  safe_file_ops.c:301: Failed to close FILE '/sys/devices/system/cpu/intel_pstate/no_turbo' at cpufreq_boost.c:151: errno=EPERM(1): Operation not permitted
cpufreq_boost    2  TBROK  :  safe_file_ops.c:301: Remaining cases broken
------------------------------------------------------------------------

We try to skip test in this case.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 .../kernel/device-drivers/cpufreq/cpufreq_boost.c  | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c b/testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c
index e345821..802461b 100644
--- a/testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c
+++ b/testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c
@@ -28,6 +28,7 @@
  */
 
 #define _GNU_SOURCE
+#include <errno.h>
 #include <sched.h>
 #include <time.h>
 
@@ -59,6 +60,22 @@ static char governor_name[16];
 
 const char maxspeed[]	= SYSFS_CPU_DIR "cpu0/cpufreq/scaling_max_freq";
 
+static void check_set_turbo(char *file, char *off)
+{
+	int fd;
+
+	fd = SAFE_OPEN(NULL, file, O_WRONLY);
+
+	/* We try to skip test when getting EPERM. */
+	if (write(fd, off, 1) == -1 && errno == EPERM) {
+		SAFE_CLOSE(NULL, fd);
+		tst_brkm(TCONF, NULL, "Turbo is disabled by "
+			 "BIOS or unavailable on processor");
+	}
+
+	SAFE_CLOSE(NULL, fd);
+}
+
 static void cleanup(void)
 {
 	FILE_PRINTF(cdrv[id].file, "%d", boost_value);
@@ -93,6 +110,13 @@ static void setup(void)
 
 	SAFE_FILE_SCANF(NULL, cdrv[i].file, "%d", &boost_value);
 
+	/* For intel_pstate, we cannot write data into intel_pstate/no_turbo
+	 * and return EPERM if turbo is disabled by BIOS or unavailable on
+	 * processor.  We should check this case by writing original data.
+	 */
+	if (!strcmp(cdrv[i].name, "intel_pstate") && boost_value == cdrv[i].off)
+		check_set_turbo(cdrv[i].file, cdrv[i].off_str);
+
 	/* change cpu0 scaling governor */
 	SAFE_FILE_SCANF(NULL, governor, "%s", governor_name);
 	SAFE_FILE_PRINTF(cleanup, governor, "%s", "performance");
-- 
1.8.3.1



