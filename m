Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A919CCD8C8E
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 05:50:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 997F93E1522
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 07:50:53 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AA3313C5601
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 07:50:23 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 82300601B06
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 07:50:22 +0200 (CEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 657ALcCZ3088318
 for <ltp@lists.linux.it>; Mon, 8 Jun 2026 05:50:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=FMHK8B81zgNmdQrkB
 l9B/sC+y+M8rOOy+DTHijUj0sI=; b=sJbonYHSVoVQTWx3Cq6G/PxzQ9ccFuNha
 AjLRMr0/qMbE2Z08E/9rjTZ3tUbnX2w//FzR7n/RplUzih2cvKdjiDZ2KFOsg7L4
 g+STjflfkVhA6+LSVKQCvvX14a55DrW0w8thm4VxLqFEO3W1DmMzX6vR9zNXRj27
 fSCJeAU6M/psx748DcJkoDgIxW7rI76qs5tVVRUgliu/JVt5BKptaSl1oC+yC8hA
 hTNaWJCgcb3KpV3xwSHId148kLhfhwF5OFdq/roaJwiLRwjQpDQjA/5Glk6IaAdj
 ZFVrSQUz46nr0cD+x39evIV0Pl0rgyDONBsmtriZHlc1f6ZTI9FJQ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em8yhp044-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Mon, 08 Jun 2026 05:50:20 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6585negh009981
 for <ltp@lists.linux.it>; Mon, 8 Jun 2026 05:50:19 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4emwvpv58j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Mon, 08 Jun 2026 05:50:19 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6585oG7454460790
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 8 Jun 2026 05:50:16 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0AC862004B;
 Mon,  8 Jun 2026 05:50:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 07DFD20043;
 Mon,  8 Jun 2026 05:50:15 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.59.193])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  8 Jun 2026 05:50:14 +0000 (GMT)
From: Praveen K Pandey <praveen@linux.ibm.com>
To: ltp@lists.linux.it
Date: Mon,  8 Jun 2026 11:19:56 +0530
Message-ID: <20260608055000.97154-2-praveen@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260608055000.97154-1-praveen@linux.ibm.com>
References: <20260608055000.97154-1-praveen@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA0OSBTYWx0ZWRfXxGslhk6guxa+
 QRfc9wd6TKbhbMyBj+ST4mLaFzwD96nRu6X+zwKFfj57uh48Y0cRraGtJ/3vFhFRnXbLXCR6TzV
 LW2fsZNR+pjyNH5mgNnaDTeAcLAL/IlAAHFQ/HEcQjapeZDdkZq5Atbq7++R7ud1X/juI6HSCnA
 ZysjYVKht+nkFLgoapYBgh5oJRw6un+VAQ4WOqsEcM+UD8KZ0YVhKh4uWhjPJBrjA5S2ftGEclO
 7fFf9tCzsYquT1pByn+la1yUTcchNIS0eVcusZxKvhifoU7NKDIXaWw7pS/HYpmBvG0GDhPzBuk
 R2ZeiXPb8MDtguJOIAtW5CaQLl4QryZAmgLeSuMDRe6rmzQc3kWypwc0dNThmGpnDxCdZ+QdKmQ
 jwujDTDO5RcifEAwSAt0UbtfgTPWMGOryv5J43XAmO5FxFzntYPVMqAvRO4DT6fsHG8n4XfHVh0
 Tw6BkSJMJ8dSzD/KVSA==
X-Authority-Analysis: v=2.4 cv=HvFG3UTS c=1 sm=1 tr=0 ts=6a26581c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=omOdbC7AAAAA:8
 a=ybYI2AAdH1HdCS0h_ZgA:9
X-Proofpoint-ORIG-GUID: e3wTCaVOQPYLo9LiWPWP-0bK834OIL-0
X-Proofpoint-GUID: e3wTCaVOQPYLo9LiWPWP-0bK834OIL-0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_01,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080049
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [LTP PATCH v4 1/5] ftrace: Add common library for C
 implementation
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

Add ftrace_lib.c and ftrace_lib.h to provide common functionality for
ftrace C test implementations. This library handles:

- Debugfs mounting and tracing path management
- Reading and writing ftrace files
- Saving and restoring ftrace settings
- Tracer enumeration and management

The library uses TST_NO_DEFAULT_MAIN to allow linking with LTP test
framework without defining multiple main() functions.

Signed-off-by: Praveen K Pandey <praveen@linux.ibm.com>
---
 .../kernel/tracing/ftrace_test/ftrace_lib.c   | 358 ++++++++++++++++++
 .../kernel/tracing/ftrace_test/ftrace_lib.h   | 139 +++++++
 2 files changed, 497 insertions(+)
 create mode 100644 testcases/kernel/tracing/ftrace_test/ftrace_lib.c
 create mode 100644 testcases/kernel/tracing/ftrace_test/ftrace_lib.h

diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_lib.c b/testcases/kernel/tracing/ftrace_test/ftrace_lib.c
new file mode 100644
index 000000000..8b93b9849
--- /dev/null
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_lib.c
@@ -0,0 +1,358 @@
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
+#define TST_NO_DEFAULT_MAIN
+#include "ftrace_lib.h"
+#include "tst_test.h"
+#include "tst_safe_macros.h"
+#include "tst_safe_stdio.h"
+
+char *tracing_path = NULL;
+char *debugfs_path = NULL;
+static int debugfs_mounted_by_us = 0;
+
+struct ftrace_saved_state saved_state = {0};
+
+void ftrace_initialize(void)
+{
+	FILE *fp;
+	char line[PATH_MAX];
+	int found = 0;
+
+	/* Check if debugfs is already mounted */
+	fp = SAFE_FOPEN("/proc/mounts", "r");
+	while (fgets(line, sizeof(line), fp)) {
+		if (strstr(line, "debugfs")) {
+			debugfs_path = strdup("/sys/kernel/debug");
+			found = 1;
+			break;
+		}
+	}
+	SAFE_FCLOSE(fp);
+
+	/* Mount debugfs if not already mounted */
+	if (!found) {
+		char *tmpdir = tst_tmpdir_path();
+		debugfs_path = malloc(PATH_MAX);
+		if (!debugfs_path)
+			tst_brk(TBROK | TERRNO, "malloc failed");
+		snprintf(debugfs_path, PATH_MAX, "%s/debugfs", tmpdir);
+		SAFE_MKDIR(debugfs_path, 0755);
+		SAFE_MOUNT("debugfs", debugfs_path, "debugfs", 0, NULL);
+		debugfs_mounted_by_us = 1;
+	}
+
+	/* Set tracing path */
+	tracing_path = malloc(PATH_MAX);
+	if (!tracing_path)
+		tst_brk(TBROK | TERRNO, "malloc failed");
+
+	snprintf(tracing_path, PATH_MAX, "%s/tracing", debugfs_path);
+
+	/* Check if tracing is supported */
+	if (access(tracing_path, F_OK) != 0)
+		tst_brk(TCONF, "Tracing is not supported");
+
+	/* Save current settings */
+	ftrace_save_settings();
+}
+
+void ftrace_cleanup(void)
+{
+	ftrace_restore_settings();
+
+	if (debugfs_mounted_by_us && debugfs_path) {
+		tst_umount(debugfs_path);
+		rmdir(debugfs_path);
+	}
+
+	free(tracing_path);
+	free(debugfs_path);
+
+	/* Free saved state */
+	free(saved_state.trace_options);
+	free(saved_state.tracing_on);
+	free(saved_state.buffer_size);
+	free(saved_state.tracing_cpumask);
+	free(saved_state.tracing_enabled);
+	free(saved_state.stack_tracer_enabled);
+	free(saved_state.ftrace_enabled);
+	free(saved_state.function_profile_enabled);
+}
+
+char *ftrace_get_path(const char *filename)
+{
+	char *path;
+
+	path = malloc(PATH_MAX);
+	if (!path)
+		return NULL;
+
+	snprintf(path, PATH_MAX, "%s/%s", tracing_path, filename);
+	return path;
+}
+
+char *ftrace_read_file(const char *filename)
+{
+	char *path;
+	FILE *fp;
+	char *content = NULL;
+	size_t len = 0;
+	ssize_t read;
+	char *line = NULL;
+	size_t total_size = 0;
+
+	path = ftrace_get_path(filename);
+	if (!path)
+		return NULL;
+
+	fp = fopen(path, "r");
+	free(path);
+
+	if (!fp)
+		return NULL;
+
+	/* Read entire file */
+	while ((read = getline(&line, &len, fp)) != -1) {
+		char *new_content = realloc(content, total_size + read + 1);
+		if (!new_content) {
+			free(content);
+			free(line);
+			fclose(fp);
+			return NULL;
+		}
+		content = new_content;
+		memcpy(content + total_size, line, read);
+		total_size += read;
+	}
+
+	if (content)
+		content[total_size] = '\0';
+
+	free(line);
+	fclose(fp);
+
+	return content;
+}
+
+int ftrace_write_file(const char *filename, const char *content)
+{
+	char *path;
+	FILE *fp;
+	int ret;
+
+	path = ftrace_get_path(filename);
+	if (!path)
+		return -1;
+
+	fp = fopen(path, "w");
+	free(path);
+
+	if (!fp)
+		return -1;
+
+	ret = fprintf(fp, "%s", content);
+	fclose(fp);
+
+	return (ret > 0) ? 0 : -1;
+}
+
+int ftrace_file_exists(const char *filename)
+{
+	char *path;
+	int ret;
+
+	path = ftrace_get_path(filename);
+	if (!path)
+		return 0;
+
+	ret = (access(path, F_OK) == 0);
+	free(path);
+
+	return ret;
+}
+
+void ftrace_save_settings(void)
+{
+	if (saved_state.saved)
+		return;
+
+	saved_state.trace_options = ftrace_read_file("trace_options");
+	saved_state.tracing_on = ftrace_read_file("tracing_on");
+	saved_state.buffer_size = ftrace_read_file("buffer_size_kb");
+
+	if (ftrace_file_exists("tracing_cpumask"))
+		saved_state.tracing_cpumask = ftrace_read_file("tracing_cpumask");
+
+	if (ftrace_file_exists("tracing_enabled"))
+		saved_state.tracing_enabled = ftrace_read_file("tracing_enabled");
+
+	if (ftrace_file_exists("stack_max_size")) {
+		char *path = strdup("/proc/sys/kernel/stack_tracer_enabled");
+		FILE *fp = fopen(path, "r");
+
+		if (fp) {
+			saved_state.stack_tracer_enabled = malloc(32);
+			if (saved_state.stack_tracer_enabled)
+				fgets(saved_state.stack_tracer_enabled, 32, fp);
+			fclose(fp);
+		}
+		free(path);
+	}
+
+	if (access("/proc/sys/kernel/ftrace_enabled", F_OK) == 0) {
+		FILE *fp = fopen("/proc/sys/kernel/ftrace_enabled", "r");
+
+		if (fp) {
+			saved_state.ftrace_enabled = malloc(32);
+			if (saved_state.ftrace_enabled)
+				fgets(saved_state.ftrace_enabled, 32, fp);
+			fclose(fp);
+		}
+	}
+
+	if (ftrace_file_exists("function_profile_enabled"))
+		saved_state.function_profile_enabled = ftrace_read_file("function_profile_enabled");
+
+	saved_state.saved = 1;
+}
+
+void ftrace_restore_settings(void)
+{
+	if (!saved_state.saved)
+		return;
+
+	/* Reset tracer and events */
+	ftrace_write_file("current_tracer", "nop\n");
+	ftrace_write_file("events/enable", "0\n");
+
+	if (ftrace_file_exists("tracing_max_latency"))
+		ftrace_write_file("tracing_max_latency", "0\n");
+
+	if (saved_state.tracing_cpumask)
+		ftrace_write_file("tracing_cpumask", saved_state.tracing_cpumask);
+
+	if (ftrace_file_exists("trace_clock"))
+		ftrace_write_file("trace_clock", "local\n");
+
+	if (saved_state.function_profile_enabled)
+		ftrace_write_file("function_profile_enabled", saved_state.function_profile_enabled);
+
+	if (saved_state.ftrace_enabled) {
+		FILE *fp = fopen("/proc/sys/kernel/ftrace_enabled", "w");
+		if (fp) {
+			fprintf(fp, "%s", saved_state.ftrace_enabled);
+			fclose(fp);
+		}
+	}
+
+	if (saved_state.stack_tracer_enabled && ftrace_file_exists("stack_max_size")) {
+		FILE *fp = fopen("/proc/sys/kernel/stack_tracer_enabled", "w");
+		if (fp) {
+			fprintf(fp, "%s", saved_state.stack_tracer_enabled);
+			fclose(fp);
+		}
+		ftrace_write_file("stack_max_size", "0\n");
+	}
+
+	if (saved_state.buffer_size)
+		ftrace_write_file("buffer_size_kb", saved_state.buffer_size);
+
+	if (saved_state.tracing_on)
+		ftrace_write_file("tracing_on", saved_state.tracing_on);
+
+	if (saved_state.tracing_enabled)
+		ftrace_write_file("tracing_enabled", saved_state.tracing_enabled);
+
+	/* Restore trace options */
+	if (saved_state.trace_options) {
+		char *options = strdup(saved_state.trace_options);
+		char *token = strtok(options, "\n");
+		while (token) {
+			ftrace_write_file("trace_options", token);
+			token = strtok(NULL, "\n");
+		}
+		free(options);
+	}
+
+	/* Clear trace */
+	ftrace_clear_trace();
+
+	/* Clear filter */
+	if (ftrace_file_exists("set_ftrace_filter"))
+		ftrace_write_file("set_ftrace_filter", "\n");
+}
+
+char **ftrace_get_available_tracers(int *count)
+{
+	char *content;
+	char **tracers = NULL;
+	int n = 0;
+	char *token;
+	char *saveptr;
+
+	content = ftrace_read_file("available_tracers");
+	if (!content) {
+		*count = 0;
+		return NULL;
+	}
+
+	/* Count tracers */
+	char *tmp = strdup(content);
+	token = strtok_r(tmp, " \n", &saveptr);
+	while (token) {
+		n++;
+		token = strtok_r(NULL, " \n", &saveptr);
+	}
+	free(tmp);
+
+	/* Allocate array */
+	tracers = malloc(sizeof(char *) * n);
+	if (!tracers) {
+		free(content);
+		*count = 0;
+		return NULL;
+	}
+
+	/* Fill array */
+	n = 0;
+	token = strtok_r(content, " \n", &saveptr);
+	while (token) {
+		tracers[n++] = strdup(token);
+		token = strtok_r(NULL, " \n", &saveptr);
+	}
+
+	free(content);
+	*count = n;
+	return tracers;
+}
+
+int ftrace_set_tracer(const char *tracer)
+{
+	char buf[256];
+	snprintf(buf, sizeof(buf), "%s\n", tracer);
+	return ftrace_write_file("current_tracer", buf);
+}
+
+void ftrace_clear_trace(void)
+{
+	ftrace_write_file("trace", "\n");
+}
+
+void ftrace_enable_tracing(void)
+{
+	ftrace_write_file("tracing_on", "1\n");
+}
+
+void ftrace_disable_tracing(void)
+{
+	ftrace_write_file("tracing_on", "0\n");
+}
+
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_lib.h b/testcases/kernel/tracing/ftrace_test/ftrace_lib.h
new file mode 100644
index 000000000..b40877ed1
--- /dev/null
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_lib.h
@@ -0,0 +1,139 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2010 FUJITSU LIMITED
+ * Copyright (c) 2024 Linux Test Project
+ * Copyright (c) IBM, 2026
+ *
+ * Author: Li Zefan <lizf@cn.fujitsu.com>
+ * Converted to C by: Praveen K Pandey <praveen@linux.ibm.com>
+ */
+
+#ifndef FTRACE_LIB_H
+#define FTRACE_LIB_H
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <sys/mount.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <errno.h>
+#include <limits.h>
+
+/* Global paths */
+extern char *tracing_path;
+extern char *debugfs_path;
+
+/* Saved settings for cleanup */
+struct ftrace_saved_state {
+	char *trace_options;
+	char *tracing_on;
+	char *buffer_size;
+	char *tracing_cpumask;
+	char *tracing_enabled;
+	char *stack_tracer_enabled;
+	char *ftrace_enabled;
+	char *function_profile_enabled;
+	int saved;
+};
+
+extern struct ftrace_saved_state saved_state;
+
+/**
+ * ftrace_initialize() - Initialize ftrace test environment
+ *
+ * This function:
+ * - Checks if debugfs is mounted, mounts it if needed
+ * - Verifies tracing support
+ * - Saves current ftrace settings
+ */
+void ftrace_initialize(void);
+
+/**
+ * ftrace_cleanup() - Cleanup and restore ftrace settings
+ *
+ * Restores all saved ftrace settings and unmounts debugfs if needed
+ */
+void ftrace_cleanup(void);
+
+/**
+ * ftrace_save_settings() - Save current ftrace settings
+ *
+ * Saves all ftrace configuration to restore later
+ */
+void ftrace_save_settings(void);
+
+/**
+ * ftrace_restore_settings() - Restore saved ftrace settings
+ *
+ * Restores ftrace configuration saved by ftrace_save_settings()
+ */
+void ftrace_restore_settings(void);
+
+/**
+ * ftrace_get_path() - Get full path to a tracing file
+ * @filename: Name of the file in tracing directory
+ *
+ * Returns: Allocated string with full path (caller must free)
+ */
+char *ftrace_get_path(const char *filename);
+
+/**
+ * ftrace_read_file() - Read content from a tracing file
+ * @filename: Name of the file in tracing directory
+ *
+ * Returns: Allocated string with file content (caller must free)
+ */
+char *ftrace_read_file(const char *filename);
+
+/**
+ * ftrace_write_file() - Write content to a tracing file
+ * @filename: Name of the file in tracing directory
+ * @content: Content to write
+ *
+ * Returns: 0 on success, -1 on failure
+ */
+int ftrace_write_file(const char *filename, const char *content);
+
+/**
+ * ftrace_file_exists() - Check if a tracing file exists
+ * @filename: Name of the file in tracing directory
+ *
+ * Returns: 1 if exists, 0 otherwise
+ */
+int ftrace_file_exists(const char *filename);
+
+/**
+ * ftrace_get_available_tracers() - Get list of available tracers
+ * @count: Pointer to store number of tracers
+ *
+ * Returns: Array of tracer names (caller must free)
+ */
+char **ftrace_get_available_tracers(int *count);
+
+/**
+ * ftrace_set_tracer() - Set current tracer
+ * @tracer: Name of the tracer to set
+ *
+ * Returns: 0 on success, -1 on failure
+ */
+int ftrace_set_tracer(const char *tracer);
+
+/**
+ * ftrace_clear_trace() - Clear the trace buffer
+ */
+void ftrace_clear_trace(void);
+
+/**
+ * ftrace_enable_tracing() - Enable tracing
+ */
+void ftrace_enable_tracing(void);
+
+/**
+ * ftrace_disable_tracing() - Disable tracing
+ */
+void ftrace_disable_tracing(void);
+
+#endif /* FTRACE_LIB_H */
-- 
2.50.1

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
