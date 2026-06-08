Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A5E4CD8C9D
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 13:26:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 440863E5F8C
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 15:26:23 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C44763E4E74
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 15:25:52 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DFBB5200DCA
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 15:25:51 +0200 (CEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 657JU2pZ3739855; Mon, 8 Jun 2026 13:25:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=vUOmxFx2rE+0J39IP
 V0tR1WWz0P4Prn4K/r8Np2cahA=; b=ojDe5U5Fbq7ib4afyx/5ZjWdAaKtivV+E
 27rmYdCkavbEIbEGjkhy8WmVTgjtvzAAlBMwB6CoDXIOs5eLfe/RuerNJNTCgOLC
 owsOSZBCz6jjVcT3gIo59KziIm8yGJFaGO0c0druqWFaoucrKVYI+3qwYyj6gmRx
 HKC7h9PKWQ+kWCs1vWleaaQMlEz5TTIL68t6SFEPKrAw0Fra5Vqv1l6MdqIfUSOS
 2IrYKV77M7jLEFSW+nmujZSlA2erhxzMhLXoQIgNcHnB8WgukrQRFMuCqyimaQ/3
 GWjCIWhqXHs4Br9G+1ALAh3kVKBUH8WadYIAIm16R0XdIUaYz8/BA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb23qg1f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Jun 2026 13:25:49 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 658DJbfA022929;
 Mon, 8 Jun 2026 13:25:48 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emxvjnfaj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Jun 2026 13:25:48 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 658DPib046465398
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 8 Jun 2026 13:25:44 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7527220040;
 Mon,  8 Jun 2026 13:25:44 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9F88420043;
 Mon,  8 Jun 2026 13:25:43 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.59.193])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  8 Jun 2026 13:25:43 +0000 (GMT)
From: Praveen K Pandey <praveen@linux.ibm.com>
To: ltp@lists.linux.it
Date: Mon,  8 Jun 2026 18:55:22 +0530
Message-ID: <20260608132526.42325-2-praveen@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260608132526.42325-1-praveen@linux.ibm.com>
References: <20260608132526.42325-1-praveen@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=b4uCJNGx c=1 sm=1 tr=0 ts=6a26c2dd cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=omOdbC7AAAAA:8
 a=GFt3-ckvntq4hClCgXkA:9
X-Proofpoint-ORIG-GUID: bNy9oRYSHaEo6Oaf3ROCxd59jmmnIKwV
X-Proofpoint-GUID: bNy9oRYSHaEo6Oaf3ROCxd59jmmnIKwV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEyNCBTYWx0ZWRfX8GU2/ZLSwzkR
 GyCjiVGBkDQ9o+gGX6NOTb5Rzpo5Blx5ULUrqMDQozDZfjSmcKN5GBknZarUeyJgtriYO3fjsYe
 yAEE+F/yRZbn/aNCDFWZV2AFJTtkQZHD4oBDctAGSKi0GJwKN80CUeWY2XMjH6Ro5Q9/0ckMadR
 GNjPj+CKdkA0dO42kZxvfrIaPH5SdOf/XWS1EqKrStWXtx0J6GKiA+FA3GhfgESE10JQp3/Gs92
 6KwpXtIPZwS6hzl0P/EnRs+aC5mvWz2WHx9J7pgL6RDQPp8KULPjYAF3ZoES23WSJ14SaeZzXLF
 kR5OkSzXoaBXrS8xxNvPX7gh3wRIQeEvw5D/drlzkRCySieGGgZnoLFKVFPAvgRUEfZhcXuHmmQ
 roL66qex24nMg780AIKyCReatU86aLOIMBdWnAr8N8avV26GVtP1fNR+Qhly28wkbXwXBUNMcyl
 2VmuEaS8szKikVPrKWQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080124
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 1/5] ftrace: Add common library for C implementation
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

Add ftrace_lib.c and ftrace_lib.h to provide common functionality
for ftrace test cases. The library handles:

- Debugfs mounting and detection using tst_is_mounted()
- Ftrace initialization and cleanup
- Reading and writing ftrace files
- Saving and restoring ftrace settings
- Getting available tracers
- Setting current tracer using SAFE_FILE_PRINTF()

The library uses LTP's SAFE_* macros for robust error handling
and SAFE_ASPRINTF() for memory allocation.

Signed-off-by: Praveen K Pandey <praveen@linux.ibm.com>
---
 .../kernel/tracing/ftrace_test/ftrace_lib.c   | 371 ++++++++++++++++++
 .../kernel/tracing/ftrace_test/ftrace_lib.h   | 136 +++++++
 2 files changed, 507 insertions(+)
 create mode 100644 testcases/kernel/tracing/ftrace_test/ftrace_lib.c
 create mode 100644 testcases/kernel/tracing/ftrace_test/ftrace_lib.h

diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_lib.c b/testcases/kernel/tracing/ftrace_test/ftrace_lib.c
new file mode 100644
index 000000000..42f83538c
--- /dev/null
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_lib.c
@@ -0,0 +1,371 @@
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
+#include "tst_safe_file_ops.h"
+#include "tst_device.h"
+
+char *tracing_path;
+char *debugfs_path;
+static int debugfs_mounted_by_us;
+
+struct ftrace_saved_state saved_state;
+
+void ftrace_initialize(void)
+{
+	if (tst_is_mounted("/sys/kernel/debug")) {
+		debugfs_path = strdup("/sys/kernel/debug");
+		if (!debugfs_path)
+			tst_brk(TBROK | TERRNO, "strdup failed");
+	} else {
+		char *tmpdir = tst_tmpdir_path();
+
+		SAFE_ASPRINTF(&debugfs_path, "%s/debugfs", tmpdir);
+		SAFE_MKDIR(debugfs_path, 0755);
+		SAFE_MOUNT("debugfs", debugfs_path, "debugfs", 0, NULL);
+		debugfs_mounted_by_us = 1;
+	}
+
+	SAFE_ASPRINTF(&tracing_path, "%s/tracing", debugfs_path);
+
+	if (access(tracing_path, F_OK) != 0)
+		tst_brk(TCONF, "Tracing is not supported");
+
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
+	SAFE_ASPRINTF(&path, "%s/%s", tracing_path, filename);
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
+	while ((read = getline(&line, &len, fp)) != -1) {
+		char *new_content = realloc(content, total_size + read + 1);
+
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
+		FILE *fp = fopen("/proc/sys/kernel/stack_tracer_enabled", "r");
+
+		if (fp) {
+			saved_state.stack_tracer_enabled = malloc(32);
+			if (saved_state.stack_tracer_enabled)
+				fgets(saved_state.stack_tracer_enabled, 32, fp);
+			fclose(fp);
+		}
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
+
+		if (fp) {
+			fprintf(fp, "%s", saved_state.ftrace_enabled);
+			fclose(fp);
+		}
+	}
+
+	if (saved_state.stack_tracer_enabled && ftrace_file_exists("stack_max_size")) {
+		FILE *fp = fopen("/proc/sys/kernel/stack_tracer_enabled", "w");
+
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
+	if (saved_state.trace_options) {
+		char *options = strdup(saved_state.trace_options);
+		char *token = strtok(options, "\n");
+
+		while (token) {
+			ftrace_write_file("trace_options", token);
+			token = strtok(NULL, "\n");
+		}
+		free(options);
+	}
+
+	ftrace_clear_trace();
+
+	if (ftrace_file_exists("set_ftrace_filter"))
+		ftrace_write_file("set_ftrace_filter", "\n");
+}
+
+char **ftrace_get_available_tracers(int *count)
+{
+	char *path;
+	FILE *fp;
+	char **tracers = NULL;
+	char *line = NULL;
+	size_t len = 0;
+	int n = 0;
+	int capacity = 16;
+
+	path = ftrace_get_path("available_tracers");
+	if (!path) {
+		*count = 0;
+		return NULL;
+	}
+
+	fp = fopen(path, "r");
+	free(path);
+
+	if (!fp) {
+		*count = 0;
+		return NULL;
+	}
+
+	tracers = malloc(sizeof(char *) * capacity);
+	if (!tracers) {
+		fclose(fp);
+		*count = 0;
+		return NULL;
+	}
+
+	if (getline(&line, &len, fp) != -1) {
+		char *token;
+		char *saveptr;
+
+		token = strtok_r(line, " \n", &saveptr);
+		while (token) {
+			if (n >= capacity) {
+				capacity *= 2;
+				char **new_tracers = realloc(tracers, sizeof(char *) * capacity);
+
+				if (!new_tracers) {
+					while (n > 0)
+						free(tracers[--n]);
+					free(tracers);
+					free(line);
+					fclose(fp);
+					*count = 0;
+					return NULL;
+				}
+				tracers = new_tracers;
+			}
+
+			tracers[n] = strdup(token);
+			if (!tracers[n]) {
+				while (n > 0)
+					free(tracers[--n]);
+				free(tracers);
+				free(line);
+				fclose(fp);
+				*count = 0;
+				return NULL;
+			}
+			n++;
+			token = strtok_r(NULL, " \n", &saveptr);
+		}
+	}
+
+	free(line);
+	fclose(fp);
+
+	*count = n;
+	return tracers;
+}
+
+int ftrace_set_tracer(const char *tracer)
+{
+	char *path;
+	int ret;
+
+	path = ftrace_get_path("current_tracer");
+	if (!path)
+		return -1;
+
+	SAFE_FILE_PRINTF(path, "%s", tracer);
+	free(path);
+
+	return 0;
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
+// Made with Bob
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_lib.h b/testcases/kernel/tracing/ftrace_test/ftrace_lib.h
new file mode 100644
index 000000000..79fdfee28
--- /dev/null
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_lib.h
@@ -0,0 +1,136 @@
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
+extern char *tracing_path;
+extern char *debugfs_path;
+
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
+ * ftrace_initialize - Initialize ftrace test environment
+ *
+ * Checks if debugfs is mounted, mounts it if needed, verifies tracing
+ * support, and saves current ftrace settings.
+ */
+void ftrace_initialize(void);
+
+/**
+ * ftrace_cleanup - Cleanup and restore ftrace settings
+ *
+ * Restores all saved ftrace settings and unmounts debugfs if needed.
+ */
+void ftrace_cleanup(void);
+
+/**
+ * ftrace_save_settings - Save current ftrace settings
+ *
+ * Saves all ftrace configuration to restore later.
+ */
+void ftrace_save_settings(void);
+
+/**
+ * ftrace_restore_settings - Restore saved ftrace settings
+ *
+ * Restores ftrace configuration saved by ftrace_save_settings().
+ */
+void ftrace_restore_settings(void);
+
+/**
+ * ftrace_get_path - Get full path to a tracing file
+ * @filename: Name of the file in tracing directory
+ *
+ * Return: Allocated string with full path (caller must free)
+ */
+char *ftrace_get_path(const char *filename);
+
+/**
+ * ftrace_read_file - Read content from a tracing file
+ * @filename: Name of the file in tracing directory
+ *
+ * Return: Allocated string with file content (caller must free)
+ */
+char *ftrace_read_file(const char *filename);
+
+/**
+ * ftrace_write_file - Write content to a tracing file
+ * @filename: Name of the file in tracing directory
+ * @content: Content to write
+ *
+ * Return: 0 on success, -1 on failure
+ */
+int ftrace_write_file(const char *filename, const char *content);
+
+/**
+ * ftrace_file_exists - Check if a tracing file exists
+ * @filename: Name of the file in tracing directory
+ *
+ * Return: 1 if exists, 0 otherwise
+ */
+int ftrace_file_exists(const char *filename);
+
+/**
+ * ftrace_get_available_tracers - Get list of available tracers
+ * @count: Pointer to store number of tracers
+ *
+ * Return: Array of tracer names (caller must free)
+ */
+char **ftrace_get_available_tracers(int *count);
+
+/**
+ * ftrace_set_tracer - Set current tracer
+ * @tracer: Name of the tracer to set
+ *
+ * Return: 0 on success, -1 on failure
+ */
+int ftrace_set_tracer(const char *tracer);
+
+/**
+ * ftrace_clear_trace - Clear the trace buffer
+ */
+void ftrace_clear_trace(void);
+
+/**
+ * ftrace_enable_tracing - Enable tracing
+ */
+void ftrace_enable_tracing(void);
+
+/**
+ * ftrace_disable_tracing - Disable tracing
+ */
+void ftrace_disable_tracing(void);
+
+#endif /* FTRACE_LIB_H */
+
-- 
2.50.1

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
