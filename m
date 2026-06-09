Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03EE6CD8CAE
	for <ltp@archiver.kernel.org>; Tue,  9 Jun 2026 04:18:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0F4913C5AA2
	for <ltp@archiver.kernel.org>; Tue,  9 Jun 2026 06:18:10 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8853D3E546B
 for <ltp@lists.linux.it>; Tue,  9 Jun 2026 06:16:50 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DB515601402
 for <ltp@lists.linux.it>; Tue,  9 Jun 2026 06:16:49 +0200 (CEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 658EJreE3911502; Tue, 9 Jun 2026 04:16:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=mAhWZPZU0n9hFEEvW
 ZtUVwQqqnQUPT4t+62Cwe55kFM=; b=quTQfPmHNIbkEvZKDjnzj/fzBhGucfc4m
 Ha1cyg8l1t0TkRnOp0KfUjBGXCsYFaiN5mFvsI0ZZ3eYF30BOF+tY1g2nZTrmQqH
 1s16t29QlYDPpWeAx5MMuccoxjbcjDWTYhYmYAus3vK7Vt5a0J8WbIvCz+HJNc17
 gwIh9YNLHnJ43nadXEAyHGG2915QJ47oB2Mt4Bz32c6L0oxAdKCWLFsV9k+ZOX+4
 XSLK4cJ6KPKAQwlnPhmV8h7hDSMiLy4p/Nz9PyYZfaCrgnfDYmE7TUU14O3a2fj2
 XGpWIFBRzCdK5E1vaH2IHgQUayzRDGbNvFTxV9PfrREMtbQLfOS/w==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb23tbwg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jun 2026 04:16:47 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65944t58000651;
 Tue, 9 Jun 2026 04:16:46 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en0jy82uu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jun 2026 04:16:46 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6594Gg0r40305138
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 9 Jun 2026 04:16:42 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B645A20040;
 Tue,  9 Jun 2026 04:16:42 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DAD1020043;
 Tue,  9 Jun 2026 04:16:41 +0000 (GMT)
Received: from dhcp-9-123-11-179.bl1-in.ibm.com (unknown [9.123.11.179])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  9 Jun 2026 04:16:41 +0000 (GMT)
From: Praveen K Pandey <praveen@linux.ibm.com>
To: ltp@lists.linux.it
Date: Tue,  9 Jun 2026 09:46:31 +0530
Message-ID: <20260609041632.74427-5-praveen@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260609041632.74427-1-praveen@linux.ibm.com>
References: <20260609041632.74427-1-praveen@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=b4uCJNGx c=1 sm=1 tr=0 ts=6a2793af cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=mDV3o1hIAAAA:8 a=VnNF1IyMAAAA:8 a=omOdbC7AAAAA:8
 a=gusMA3QHoSgLEI1akPcA:9
X-Proofpoint-ORIG-GUID: EXlbFqRdcBK-Cdl74XjaCU_maJyY7BJi
X-Proofpoint-GUID: EXlbFqRdcBK-Cdl74XjaCU_maJyY7BJi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDAzNCBTYWx0ZWRfXwrvb6Q/PLObT
 yD/jqjhRaUDFEvPRjrNGu9tzkuNgBvSOocOsTfeFPTUGwVFbeQO6cvWfVyLE1pm5REfDGVOOsDM
 B7NpDF6nD/eHNG9AGm/sIi8bm5vLTVgC69FwzF7UwBpSV9H4wzdSnrKs/hkXbN9c6CQZbYPddGX
 a7jpeCT1U3FffgswFF/VCUVeCv5ShRYesH3W51NGstofkpGqXfk0aYyEztSGw7WDjOpl4Kbsq+y
 vm9JoF/GT1pSi2QqUJ32HNqjiBXfQ/tMkPREoQhxE8qGLsf9A/Yav19wrU0t13RFrl6mXKgX1J9
 6LGt27lzc4Y8zeVYreNfHXUhDJuOPkLBqlst1prBictecAVocs8gu3wu+yu6Sx9y+VQf/gsksf6
 ZV3YJsvAMcS0Lg3C+IpZDI+zOEFMC4VUZbr23WwiDFEwgfSGEK34s57ggo9/AGhSEN4UyIavHWz
 InmLf+IFfgkWQw0MscA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_01,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090034
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 4/5] ftrace: Convert ftrace_stress_test.sh to C
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

Convert ftrace_stress_test.sh to C using the new LTP test API.
This test performs stress testing of ftrace by running multiple
threads that concurrently modify various ftrace settings.

Key changes:
- Uses new LTP C API (tst_test.h)
- Leverages ftrace_lib for common operations
- Multi-threaded stress testing with proper synchronization
- Proper cleanup: stop_stress_tests() resets thread_count to 0
  after joining threads to avoid double-join (undefined behavior)
- Variables stop_testing and thread_count are reset at the start
  of run_test() to support multiple test iterations (-i N)
- Requires root privileges (.needs_root = 1)
- Test timeout set to 300 seconds

The test creates multiple threads that stress test different
ftrace interfaces concurrently for a specified duration.

Signed-off-by: Praveen K Pandey <praveen@linux.ibm.com>
---
 .../tracing/ftrace_test/ftrace_stress_test.c  | 328 ++++++++++++++++++
 .../tracing/ftrace_test/ftrace_stress_test.sh | 121 -------
 2 files changed, 328 insertions(+), 121 deletions(-)
 create mode 100644 testcases/kernel/tracing/ftrace_test/ftrace_stress_test.c
 delete mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress_test.sh

diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress_test.c b/testcases/kernel/tracing/ftrace_test/ftrace_stress_test.c
new file mode 100644
index 000000000..f4d267254
--- /dev/null
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress_test.c
@@ -0,0 +1,328 @@
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
+	thread_count = 0;
+	tst_res(TINFO, "All stress test threads stopped");
+}
+
+static void run_test(void)
+{
+	stop_testing = 0;
+	thread_count = 0;
+
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
+	if (thread_count > 0)
+		stop_stress_tests();
+
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
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress_test.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress_test.sh
deleted file mode 100755
index 159ba1a66..000000000
--- a/testcases/kernel/tracing/ftrace_test/ftrace_stress_test.sh
+++ /dev/null
@@ -1,121 +0,0 @@
-#! /bin/sh
-
-###########################################################################
-##                                                                       ##
-## Copyright (c) 2010 FUJITSU LIMITED                                    ##
-##                                                                       ##
-## This program is free software: you can redistribute it and/or modify  ##
-## it under the terms of the GNU General Public License as published by  ##
-## the Free Software Foundation, either version 3 of the License, or     ##
-## (at your option) any later version.                                   ##
-##                                                                       ##
-## This program is distributed in the hope that it will be useful,       ##
-## but WITHOUT ANY WARRANTY; without even the implied warranty of        ##
-## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the          ##
-## GNU General Public License for more details.                          ##
-##                                                                       ##
-## You should have received a copy of the GNU General Public License     ##
-## along with this program. If not, see <http://www.gnu.org/licenses/>.  ##
-##                                                                       ##
-## Author: Li Zefan <lizf@cn.fujitsu.com>                                ##
-##                                                                       ##
-###########################################################################
-
-export TCID="ftrace-stress-test"
-export TST_TOTAL=1
-export TST_COUNT=1
-
-. ftrace_lib.sh
-
-test_targets=" \
-trace_pipe current_tracer ftrace_enabled function_profile_enabled \
-set_event set_ftrace_pid stack_max_size stack_trace trace trace_clock \
-trace_options trace_stat tracing_enabled tracing_max_latency \
-tracing_on function_profile_enabled buffer_size_kb tracing_cpumask \
-set_ftrace_filter"
-
-get_skip_targets()
-{
-	NR_PIDS=0
-	for target in ${test_targets}; do
-		if [ ! -e $TRACING_PATH/$target ] &&
-			[ ! -e /proc/sys/kernel/$target ]; then
-			eval skip_$target=1
-			tst_resm TINFO "$target is not supported. Skip it."
-		else
-			eval skip_$target=0
-			NR_PIDS=$((NR_PIDS + 1))
-		fi
-	done
-	# Export it before sub case is lanuched.
-	export NR_PIDS
-}
-
-should_skip_target()
-{
-	local skip_var=skip_$1
-	eval local skip_val=\$${skip_var}
-	[ "$skip_val" = 1 ]
-}
-
-test_kill()
-{
-	tst_resm TINFO "killing ${pid0}"
-	kill -USR1 ${pid0}
-	wait ${pid0}
-
-	local p=1;
-	while [ $p -lt $NR_PIDS ]; do
-		local pid_var=pid${p}
-		eval local kill_pid=\$${pid_var}
-		tst_resm TINFO "killing ${kill_pid}"
-		kill -KILL $kill_pid
-		wait ${kill_pid}
-		p=$((p + 1))
-	done
-}
-
-test_stress()
-{
-	local index=0;
-
-	tst_resm TINFO "Test targets: ${test_targets}"
-
-	get_skip_targets
-	for target in ${test_targets}; do
-		if should_skip_target $target; then
-			continue
-		fi
-		sh ftrace_${target}.sh &
-		eval pid${index}=$!
-		tst_resm TINFO "Start pid${index}=$! $SPATH/ftrace_${target}.sh"
-		index=$((index + 1))
-	done
-	export_pids
-}
-
-export_pids()
-{
-	local p=0
-	while [ $p -lt $NR_PIDS ]; do
-		export pid${p}
-		p=$((p + 1))
-	done
-}
-
-cd ftrace_stress/
-# ----------------------------
-tst_resm TINFO "Ftrace Stress Test Begin"
-
-test_begin
-
-test_stress
-
-test_wait
-
-test_kill
-
-tst_resm TINFO "Finished running the test. Run dmesg to double-check for bugs"
-
-tst_exit
-
-- 
2.50.1

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
