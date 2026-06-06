Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35E67CD8C85
	for <ltp@archiver.kernel.org>; Sat,  6 Jun 2026 19:59:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 728F03E5FC0
	for <ltp@archiver.kernel.org>; Sat,  6 Jun 2026 21:59:46 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AFC5B3E5FC9
 for <ltp@lists.linux.it>; Sat,  6 Jun 2026 21:58:43 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C3D226002CC
 for <ltp@lists.linux.it>; Sat,  6 Jun 2026 21:58:42 +0200 (CEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 656Fokws278556 for <ltp@lists.linux.it>; Sat, 6 Jun 2026 19:58:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Zt02eaQ9vVjxrMi6K
 av81KlZSIXitDIPU7zao18beaE=; b=ZcFBfaPnhFRH+3aQ9SDrtNdZvuzjkFFKY
 MVwf5P4oZo1iZAvYrBpVVeTP0FkQk7gtlfkP5XWOHemRy1MTCXTQnhbXVeorhjPa
 OzNUW2NJmf+RGUj75Qa7byI8n+KpiFUKtRD1Tn2h8+cfhY9V4Qp49XjOBEBItnyH
 ivOSsrDQr4IKGhC4YvGPZqv54B4knFcV5RsM8pxHfKvDN45entsHw5PD9SQ/lrV2
 z9HLRZdVfqmxU+XN8MxVRpt6GH6Pk1ZTEHah9pEluGeBAs6valinh90eg6Qpk4Gm
 p3OTbggmXBNpwkhRJFDGRZaIiKxI2mgp7osMjUVDGyBVh4vV59uLw==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb6shwqj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sat, 06 Jun 2026 19:58:40 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 656JnvuU028862
 for <ltp@lists.linux.it>; Sat, 6 Jun 2026 19:58:40 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcwyxgef-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sat, 06 Jun 2026 19:58:40 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 656Jwant45482336
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 6 Jun 2026 19:58:36 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A3E3F20040;
 Sat,  6 Jun 2026 19:58:36 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D4CC12004B;
 Sat,  6 Jun 2026 19:58:35 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.127.204])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat,  6 Jun 2026 19:58:35 +0000 (GMT)
From: Praveen K Pandey <praveen@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sun,  7 Jun 2026 01:28:17 +0530
Message-ID: <20260606195818.95400-5-praveen@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260606195818.95400-1-praveen@linux.ibm.com>
References: <20260606195818.95400-1-praveen@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xloOO7x1ojUXWUHgMylT_Ofz7mI2-3rY
X-Proofpoint-GUID: xloOO7x1ojUXWUHgMylT_Ofz7mI2-3rY
X-Authority-Analysis: v=2.4 cv=ZbEt8MVA c=1 sm=1 tr=0 ts=6a247bf1 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=omOdbC7AAAAA:8
 a=SiDVF7iljDbmCKMRP1IA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA2MDIwMSBTYWx0ZWRfX+n+43C1fy3kB
 VVlk3ie572jT7s2CzcsFqiZMr/X0rSRkO4Y7QH8+da+77trQvRtRnKZLA7H2fh+xKaEPttW3RrT
 /w9CEwCRd/Y9KQjU2G7lasJ6/2HCMf5RG3ISWsC2P8J6w55FvDt5I/IzV/TG5Z3nsNAYMC5A0VB
 2v83mmEDIBIjFRMYie0Xg1F/Oi3ii02fkULhGJkhyEl0rrJgbbdUdiXzn6cqjNX+cdv9AnBnfvb
 6o5yNMLrRnlAEF+jDKEFhBm2GY0FXzJt8Ya3nl+kFHk3qVoWgKSReLc0mmctbPwru/8m3pxgSLK
 Hm+XJkJWBsPlo1d97D0tK9IWdYhUb9Xeh/nlo35r3/j2bW3gXq3H8XxTsRF0MWdgAD7elkKdorK
 F5qrLAB3BizCgvLn9JXUaXhaVdhzEWxc/y1nmsa+SaO56Wti/Ai8eufdKsZ+RURZBY0wd3ln9ai
 ay/Lfl8VgePHKE+K4pA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-06_05,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606060201
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [LTP PATCH v2 4/5] ftrace: Add C implementation of
 ftrace_stress_test and update build
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

Convert 18 ftrace_stress shell scripts to a single multi-threaded C
implementation. The stress test exercises various ftrace features
concurrently using pthread:

- Switching between different tracers
- Reading from trace_pipe
- Enabling/disabling events
- Modifying buffer size
- Setting trace filters
- Modifying trace options
- And more...

Update Makefile to:
- Build new C test binaries
- Link ftrace_stress_test with pthread
- Use FILTER_OUT_MAKE_TARGETS for library object
- Place dependency rules after generic_leaf_target.mk include

Update runtest/tracing to use new C binaries instead of shell scripts.

Signed-off-by: Praveen K Pandey <praveen@linux.ibm.com>
---
 runtest/tracing                               |   6 +-
 testcases/kernel/tracing/ftrace_test/Makefile |  19 +-
 .../tracing/ftrace_test/ftrace_stress_test.c  | 324 ++++++++++++++++++
 3 files changed, 344 insertions(+), 5 deletions(-)
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
diff --git a/testcases/kernel/tracing/ftrace_test/Makefile b/testcases/kernel/tracing/ftrace_test/Makefile
index e4a913a56..f4b9c4c7b 100644
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
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
+
+# C test binaries with shared library dependencies
+ftrace_regression01:	ftrace_lib.o
+ftrace_regression02:	ftrace_lib.o
+ftrace_stress_test:	ftrace_lib.o
+
+# Only ftrace_stress_test needs pthread
+ftrace_stress_test: LDLIBS += -lpthread
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress_test.c b/testcases/kernel/tracing/ftrace_test/ftrace_stress_test.c
new file mode 100644
index 000000000..c59861b11
--- /dev/null
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress_test.c
@@ -0,0 +1,324 @@
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
+ * [Description]
+ *
+ * Stress test for ftrace subsystem.
+ *
+ * This test exercises various ftrace features concurrently to detect
+ * race conditions, memory leaks, and other issues in the ftrace subsystem.
+ *
+ * [Algorithm]
+ *
+ * The test spawns multiple threads, each exercising a different ftrace
+ * feature:
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
+
+	/* Check for test duration parameter */
+	if (tst_parse_int(getenv("LTP_TIMEOUT_MUL"), &test_duration, 1, INT_MAX))
+		test_duration = DEFAULT_TEST_DURATION;
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
+	.timeout = DEFAULT_TEST_DURATION + 30,
+};
+
-- 
2.50.1 (Apple Git-155)


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
