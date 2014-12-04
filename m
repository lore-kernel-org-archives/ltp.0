Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1Xwa3k-0000Ps-LV
	for ltp-list@lists.sourceforge.net; Thu, 04 Dec 2014 17:19:20 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Xwa3j-0003dq-Jt
	for ltp-list@lists.sourceforge.net; Thu, 04 Dec 2014 17:19:20 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id sB4HJChv016800
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 4 Dec 2014 17:19:13 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	sB4HJCa9018150
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Thu, 4 Dec 2014 17:19:12 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	sB4HJBgt018143
	for <ltp-list@lists.sourceforge.net>; Thu, 4 Dec 2014 17:19:12 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu,  4 Dec 2014 20:20:57 +0300
Message-Id: <1417713657-2556-2-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1417713657-2556-1-git-send-email-alexey.kodanev@oracle.com>
References: <1417713657-2556-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH 2/2] device-drivers/cpufreq: add intel_pstate driver
	to boost test
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
 .../kernel/device-drivers/cpufreq/cpufreq_boost.c  |   67 +++++++++++---------
 1 files changed, 37 insertions(+), 30 deletions(-)

diff --git a/testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c b/testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c
index 423188e..941e4db 100644
--- a/testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c
+++ b/testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
+ * Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as
@@ -37,22 +37,33 @@
 #include "safe_macros.h"
 #include "safe_stdio.h"
 
-char *TCID = "ltp_acpi_cpufreq";
+char *TCID = "cpufreq_boost";
 
 #define SYSFS_CPU_DIR "/sys/devices/system/cpu/"
 
-const char boost[]	= SYSFS_CPU_DIR "cpufreq/boost";
+struct cpufreq_driver_info {
+	char *name;
+	int off;
+	char *on_str;
+	char *off_str;
+	char *file;
+};
+static const struct cpufreq_driver_info cdrv[] = {
+	{ "acpi_cpufreq", 0, "1", "0", SYSFS_CPU_DIR "cpufreq/boost" },
+	{ "intel_pstate", 1, "0", "1", SYSFS_CPU_DIR "intel_pstate/no_turbo" },
+};
+static int id = -1;
+
 static int boost_value;
 
 const char governor[]	= SYSFS_CPU_DIR "cpu0/cpufreq/scaling_governor";
 static char governor_name[16];
 
-const char setspeed[]	= SYSFS_CPU_DIR "cpu0/cpufreq/scaling_setspeed";
 const char maxspeed[]	= SYSFS_CPU_DIR "cpu0/cpufreq/scaling_max_freq";
 
 static void cleanup(void)
 {
-	SAFE_FILE_PRINTF(NULL, boost, "%d", boost_value);
+	SAFE_FILE_PRINTF(NULL, cdrv[id].file, "%d", boost_value);
 
 	if (governor[0] != '\0')
 		SAFE_FILE_PRINTF(NULL, governor, "%s", governor_name);
@@ -63,22 +74,32 @@ static void cleanup(void)
 static void setup(void)
 {
 	int fd;
+	unsigned int i;
 	tst_require_root(NULL);
 
-	fd = open(boost, O_RDWR);
-	if (fd == -1) {
-		tst_brkm(TCONF, NULL,
-			"acpi-cpufreq not loaded or overclock not supported");
+	for (i = 0; i < ARRAY_SIZE(cdrv); ++i) {
+		fd = open(cdrv[i].file, O_RDWR);
+		if (fd == -1)
+			continue;
+
+		id = i;
+		close(fd);
+		break;
 	}
-	close(fd);
+
+	if (id == -1)
+		tst_brkm(TCONF, NULL, "overclock not supported");
+
+	tst_resm(TINFO, "found '%s' driver, sysfs knob '%s'",
+		cdrv[id].name, cdrv[id].file);
 
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
-	SAFE_FILE_SCANF(NULL, boost, "%d", &boost_value);
+	SAFE_FILE_SCANF(NULL, cdrv[i].file, "%d", &boost_value);
 
 	/* change cpu0 scaling governor */
 	SAFE_FILE_SCANF(NULL, governor, "%s", governor_name);
-	SAFE_FILE_PRINTF(cleanup, governor, "%s", "userspace");
+	SAFE_FILE_PRINTF(cleanup, governor, "%s", "performance");
 
 	/* use only cpu0 */
 	cpu_set_t set;
@@ -95,20 +116,6 @@ static void setup(void)
 	}
 }
 
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
 static int load_cpu(int max_freq_khz)
 {
 	int sum = 0, i = 0, total_time_ms;
@@ -141,16 +148,16 @@ static void test_run(void)
 {
 	int boost_time, boost_off_time, max_freq_khz;
 	SAFE_FILE_SCANF(cleanup, maxspeed, "%d", &max_freq_khz);
-	set_speed(max_freq_khz);
+	tst_resm(TINFO, "maximum speed is %d KHz", max_freq_khz);
 
 	/* Enable boost */
-	if (boost_value == 0)
-		SAFE_FILE_PRINTF(cleanup, boost, "1");
+	if (boost_value == cdrv[id].off)
+		SAFE_FILE_PRINTF(cleanup, cdrv[id].file, cdrv[id].on_str);
 	tst_resm(TINFO, "load CPU0 with boost enabled");
 	boost_time = load_cpu(max_freq_khz);
 
 	/* Disable boost */
-	SAFE_FILE_PRINTF(cleanup, boost, "0");
+	SAFE_FILE_PRINTF(cleanup, cdrv[id].file, cdrv[id].off_str);
 	tst_resm(TINFO, "load CPU0 with boost disabled");
 	boost_off_time = load_cpu(max_freq_khz);
 
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
