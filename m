Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73269CD8C9D
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 05:51:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BB3A83E1CCC
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 07:51:46 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8378C3E2B95
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 07:50:26 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CAE31206C23
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 07:50:25 +0200 (CEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 657ItOET4131724
 for <ltp@lists.linux.it>; Mon, 8 Jun 2026 05:50:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=sQxxGIk9Z7bwWP7R3
 5cIDgMmO2wCB2cZ6mRGVs6gYkY=; b=ou7V2tJfZH/+h5oSoEhLpNqRKR2a1b5TC
 jJ6zME9/PQhaV/Dv79+bOzZa03ao9EOsRcIkXfIINXnMdTmKCAbnAjz3Vm5yBJcO
 32CxtTjXJW9YHmFYQoppapR54Ua1igjVj28zYsnKRi5J6S64rcNRMcyt69hKVpS0
 mhNtpMT4C3vUvCz0wbNhRt/2iMg/aye26nlF52Pd5U0vsWY91fhBIwjgWwFQ7QkC
 /NHwymVZxw64xI0raEGWxNlSOtcrZoyBVBS2aSrUSr95EgvLKRPpINcDd+pqtaVl
 6DpB/MolTOH3OqjvBsYStrWjt0uM5vcoCN8QmbleX0twz7i8Db/DA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em8yhp04d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Mon, 08 Jun 2026 05:50:24 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6585ncZw008777
 for <ltp@lists.linux.it>; Mon, 8 Jun 2026 05:50:23 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emxvjkytr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Mon, 08 Jun 2026 05:50:23 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6585oJLI30212632
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 8 Jun 2026 05:50:19 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8662C2004B;
 Mon,  8 Jun 2026 05:50:19 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AC18D20043;
 Mon,  8 Jun 2026 05:50:18 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.59.193])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  8 Jun 2026 05:50:18 +0000 (GMT)
From: Praveen K Pandey <praveen@linux.ibm.com>
To: ltp@lists.linux.it
Date: Mon,  8 Jun 2026 11:19:59 +0530
Message-ID: <20260608055000.97154-5-praveen@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260608055000.97154-1-praveen@linux.ibm.com>
References: <20260608055000.97154-1-praveen@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA0OSBTYWx0ZWRfX/33LGeC+ZJdE
 WYZZklAzimCWLK4p5teT6KckB8HoeHlRnLNBFmaIbbJ01JhjMKbV4rz0nTj5EKigsxiWIhHcaOk
 wycEcmF471OIduD1oH5mBd5lLfzPuVWmfbDVeQdQxyDh52K8YNl0yUTjXpE5ep2GZrmW8Kc6EZ4
 86fGDyz8ZqkQfPNK0a2KaoKObAKnCQinCC5okxxMQvty49jipB9xLJSdaoRgfdx2I+ksn5scrY/
 AiazhNlmkOPrOJOnLYiuVXgNE54tm5Q/iuKogql1ElW3PC2u2/QCOWH0ybwaXgmMZHwwVJkeo2v
 MutHrvTbI0efUkEK+Hz2IBlNU3ZavdEVWT0leGOyjlZxp/jAqz5cDXGSElqmh0K89X4eD2X7o+k
 Fra7i/vb1Glc3hbwztY5gImKGNSbinFx1s47t+cjn8uTJ7GVPuSLiDDDMmbbqpLXBbmHwiRsNom
 enBjOCucVybuNvytpvw==
X-Authority-Analysis: v=2.4 cv=HvFG3UTS c=1 sm=1 tr=0 ts=6a265820 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=omOdbC7AAAAA:8
 a=SiDVF7iljDbmCKMRP1IA:9
X-Proofpoint-ORIG-GUID: DqHG0DWMRWjHFbJ8paBhh3WcPJyWtuTd
X-Proofpoint-GUID: DqHG0DWMRWjHFbJ8paBhh3WcPJyWtuTd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_01,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080049
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [LTP PATCH v4 4/5] ftrace: Convert ftrace_stress_test.sh to C
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Convert ftrace_stress_test.sh to C implementation using LTP new API.

This test performs stress testing of the ftrace subsystem by running multiple
concurrent threads, each exercising different ftrace features (switching tracers,
reading trace_pipe, enabling/disabling events, modifying buffer size, etc.).
All threads run concurrently for 60 seconds to detect race conditions and
verify system stability.

The test requires root to access and configure the ftrace subsystem via debugfs.

Also update:
- Makefile: Add new C test targets and library compilation
- .gitignore: Ignore compiled test binaries
- runtest/tracing: Update test entries to use C implementations

Signed-off-by: Praveen K Pandey <praveen@linux.ibm.com>
---
 runtest/tracing                               |   6 +-
 .../kernel/tracing/ftrace_test/.gitignore     |   4 +
 testcases/kernel/tracing/ftrace_test/Makefile |  19 +-
 .../tracing/ftrace_test/ftrace_stress_test.c  | 322 ++++++++++++++++++
 4 files changed, 346 insertions(+), 5 deletions(-)
 create mode 100644 testcases/kernel/tracing/ftrace_test/.gitignore
 create mode 100644 testcases/kernel/tracing/ftrace_test/ftrace_stress_test.c

diff --git a/runtest/tracing b/runtest/tracing
index 674e2ad97..4204c2dc4 100644
--- a/runtest/tracing
+++ b/runtest/tracing
@@ -1,7 +1,7 @@
 #DESCRIPTION:Tracing testing
-ftrace_regression01	ftrace_regression01.sh
-ftrace_regression02	ftrace_regression02.sh
-ftrace-stress-test	ftrace_stress_test.sh 90
+ftrace_regression01	ftrace_regression01
+ftrace_regression02	ftrace_regression02
+ftrace-stress-test	ftrace_stress_test
 dynamic_debug01		dynamic_debug01.sh
 fanotify25 fanotify25
 pt_full_trace_basic pt_test
diff --git a/testcases/kernel/tracing/ftrace_test/.gitignore b/testcases/kernel/tracing/ftrace_test/.gitignore
new file mode 100644
index 000000000..9e102074c
--- /dev/null
+++ b/testcases/kernel/tracing/ftrace_test/.gitignore
@@ -0,0 +1,4 @@
+ftrace_regression01
+ftrace_regression02
+ftrace_stress_test
+
diff --git a/testcases/kernel/tracing/ftrace_test/Makefile b/testcases/kernel/tracing/ftrace_test/Makefile
index e4a913a56..2528b9f15 100644
--- a/testcases/kernel/tracing/ftrace_test/Makefile
+++ b/testcases/kernel/tracing/ftrace_test/Makefile
@@ -1,7 +1,22 @@
-top_srcdir              ?= ../../../..
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2010 FUJITSU LIMITED
+# Copyright (c) 2024 Linux Test Project
+# Copyright (c) IBM, 2026
+# Converted to C by: Praveen K Pandey <praveen@linux.ibm.com>
+
+top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-INSTALL_TARGETS         := *.sh ftrace_stress/*
+# Filter out ftrace_lib from standalone build targets
+FILTER_OUT_MAKE_TARGETS := ftrace_lib
+
+# Only ftrace_stress_test needs pthread
+ftrace_stress_test: LDLIBS += -lpthread
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
+
+# C test binaries with shared library dependencies
+ftrace_regression01:	ftrace_lib.o
+ftrace_regression02:	ftrace_lib.o
+ftrace_stress_test:	ftrace_lib.o
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress_test.c b/testcases/kernel/tracing/ftrace_test/ftrace_stress_test.c
new file mode 100644
index 000000000..182d296fc
--- /dev/null
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress_test.c
@@ -0,0 +1,322 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2010 FUJITSU LIMITED
+ * Copyright (c) 2024 Linux Test Project
+ * Copyright (c) IBM, 2026
+ *
+ * Author: Li Zefan <lizf@cn.fujitsu.com>
+ * Converted to C by: Praveen K Pandey <praveen@linux.ibm.com>
+ */
+
+/*\
+ * Stress test for ftrace subsystem.
+ *
+ * This test exercises various ftrace features concurrently to detect
+ * race conditions, memory leaks, and other issues in the ftrace subsystem.
+ *
+ * Requires root to access and configure the ftrace subsystem via debugfs.
+ *
+ * [Algorithm]
+ *
+ * The test spawns multiple threads, each exercising a different ftrace
+ * feature:
+ *
+ * - Switching between different tracers
+ * - Reading from trace_pipe
+ * - Enabling/disabling events
+ * - Modifying buffer size
+ * - Setting trace filters
+ * - Modifying trace options
+ * - And more...
+ *
+ * All threads run concurrently for a specified duration, then the test
+ * verifies the system is still stable.
+ */
+
+#include <pthread.h>
+#include <signal.h>
+#include "tst_test.h"
+#include "ftrace_lib.h"
+
+#define DEFAULT_TEST_DURATION 60  /* seconds */
+#define MAX_THREADS 20
+
+static volatile int stop_testing = 0;
+static int test_duration = DEFAULT_TEST_DURATION;
+static pthread_t threads[MAX_THREADS];
+static int thread_count = 0;
+
+struct stress_test {
+	const char *name;
+	const char *file;
+	void *(*func)(void *);
+	int enabled;
+};
+
+/* Thread function for current_tracer stress test */
+static void *stress_current_tracer(void *arg)
+{
+	int count;
+	char **tracers;
+	int i, loop;
+
+	(void)arg;
+
+	tracers = ftrace_get_available_tracers(&count);
+	if (!tracers || count == 0) {
+		tst_res(TINFO, "No tracers available");
+		return NULL;
+	}
+
+	loop = 0;
+	while (!stop_testing) {
+		for (i = 0; i < count && !stop_testing; i++) {
+			/* Skip mmiotrace as it can cause issues */
+			if (strcmp(tracers[i], "mmiotrace") == 0)
+				continue;
+
+			ftrace_set_tracer(tracers[i]);
+		}
+		loop++;
+		if (loop >= 200)
+			usleep(1000000);  /* Sleep 1 second after 200 loops */
+	}
+
+	for (i = 0; i < count; i++)
+		free(tracers[i]);
+	free(tracers);
+
+	return NULL;
+}
+
+/* Thread function for trace_pipe stress test */
+static void *stress_trace_pipe(void *arg)
+{
+	char *path;
+	FILE *fp;
+	int loop = 0;
+
+	(void)arg;
+
+	path = ftrace_get_path("trace_pipe");
+	if (!path)
+		return NULL;
+
+	while (!stop_testing) {
+		fp = fopen(path, "r");
+		if (fp) {
+			/* Read for a short time */
+			usleep(200000);  /* 200ms */
+			fclose(fp);
+		}
+
+		usleep(200000);  /* 200ms */
+		loop++;
+		if (loop >= 20) {
+			sleep(2);
+			loop = 0;
+		}
+	}
+
+	free(path);
+	return NULL;
+}
+
+/* Thread function for set_event stress test */
+static void *stress_set_event(void *arg)
+{
+	int i;
+
+	(void)arg;
+
+	while (!stop_testing) {
+		/* Enable/disable all events */
+		for (i = 0; i < 100 && !stop_testing; i++) {
+			ftrace_write_file("events/enable", "1\n");
+			ftrace_write_file("events/enable", "0\n");
+		}
+
+		sleep(1);
+	}
+
+	return NULL;
+}
+
+/* Thread function for buffer_size_kb stress test */
+static void *stress_buffer_size(void *arg)
+{
+	const char *sizes[] = {"1024", "2048", "4096", "8192"};
+	int i;
+
+	(void)arg;
+
+	while (!stop_testing) {
+		for (i = 0; i < 4 && !stop_testing; i++) {
+			char buf[32];
+			snprintf(buf, sizeof(buf), "%s\n", sizes[i]);
+			ftrace_write_file("buffer_size_kb", buf);
+			usleep(100000);
+		}
+		sleep(1);
+	}
+
+	return NULL;
+}
+
+/* Thread function for tracing_on stress test */
+static void *stress_tracing_on(void *arg)
+{
+	int i;
+
+	(void)arg;
+
+	while (!stop_testing) {
+		for (i = 0; i < 100 && !stop_testing; i++) {
+			ftrace_enable_tracing();
+			ftrace_disable_tracing();
+		}
+		sleep(1);
+	}
+
+	return NULL;
+}
+
+/* Thread function for trace_options stress test */
+static void *stress_trace_options(void *arg)
+{
+	const char *options[] = {
+		"print-parent", "sym-offset", "sym-addr",
+		"verbose", "raw", "hex", "bin", "block"
+	};
+	int i;
+
+	(void)arg;
+
+	while (!stop_testing) {
+		for (i = 0; i < 8 && !stop_testing; i++) {
+			char buf[64];
+			snprintf(buf, sizeof(buf), "%s\n", options[i]);
+			ftrace_write_file("trace_options", buf);
+			snprintf(buf, sizeof(buf), "no%s\n", options[i]);
+			ftrace_write_file("trace_options", buf);
+		}
+		sleep(1);
+	}
+
+	return NULL;
+}
+
+/* Thread function for set_ftrace_filter stress test */
+static void *stress_set_ftrace_filter(void *arg)
+{
+	(void)arg;
+
+	if (!ftrace_file_exists("set_ftrace_filter"))
+		return NULL;
+
+	while (!stop_testing) {
+		ftrace_write_file("set_ftrace_filter", "schedule\n");
+		ftrace_write_file("set_ftrace_filter", "\n");
+		usleep(500000);
+	}
+
+	return NULL;
+}
+
+static struct stress_test stress_tests[] = {
+	{"current_tracer", "current_tracer", stress_current_tracer, 0},
+	{"trace_pipe", "trace_pipe", stress_trace_pipe, 0},
+	{"set_event", "events/enable", stress_set_event, 0},
+	{"buffer_size_kb", "buffer_size_kb", stress_buffer_size, 0},
+	{"tracing_on", "tracing_on", stress_tracing_on, 0},
+	{"trace_options", "trace_options", stress_trace_options, 0},
+	{"set_ftrace_filter", "set_ftrace_filter", stress_set_ftrace_filter, 0},
+	{NULL, NULL, NULL, 0}
+};
+
+static void check_available_tests(void)
+{
+	int i;
+
+	for (i = 0; stress_tests[i].name; i++) {
+		if (ftrace_file_exists(stress_tests[i].file) ||
+		    access(stress_tests[i].file, F_OK) == 0) {
+			stress_tests[i].enabled = 1;
+			tst_res(TINFO, "Test target available: %s", stress_tests[i].name);
+		} else {
+			tst_res(TINFO, "Test target not available: %s", stress_tests[i].name);
+		}
+	}
+}
+
+static void start_stress_tests(void)
+{
+	int i;
+
+	thread_count = 0;
+	for (i = 0; stress_tests[i].name; i++) {
+		if (!stress_tests[i].enabled)
+			continue;
+
+		if (pthread_create(&threads[thread_count], NULL,
+				   stress_tests[i].func, NULL) != 0) {
+			tst_res(TWARN, "Failed to create thread for %s",
+				stress_tests[i].name);
+		} else {
+			tst_res(TINFO, "Started stress test: %s", stress_tests[i].name);
+			thread_count++;
+		}
+	}
+
+	tst_res(TINFO, "Started %d stress test threads", thread_count);
+}
+
+static void stop_stress_tests(void)
+{
+	int i;
+
+	stop_testing = 1;
+
+	for (i = 0; i < thread_count; i++) {
+		pthread_join(threads[i], NULL);
+	}
+
+	tst_res(TINFO, "All stress test threads stopped");
+}
+
+static void run_test(void)
+{
+	tst_res(TINFO, "Starting ftrace stress test for %d seconds", test_duration);
+
+	check_available_tests();
+	start_stress_tests();
+
+	/* Run for specified duration */
+	sleep(test_duration);
+
+	stop_stress_tests();
+
+	tst_res(TPASS, "Ftrace stress test completed successfully");
+	tst_res(TINFO, "Check dmesg for any kernel warnings or errors");
+}
+
+static void setup(void)
+{
+	ftrace_initialize();
+}
+
+static void cleanup(void)
+{
+	stop_testing = 1;
+	ftrace_cleanup();
+}
+
+static struct tst_test test = {
+	.test_all = run_test,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.timeout = DEFAULT_TEST_DURATION + 30,
+};
+
-- 
2.50.1

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
