Return-Path: <SRS0=gHvU=PP=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D001C433F5
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 09:45:55 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 390CB6103C
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 09:45:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 390CB6103C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux.it
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B2C673C69E6
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 11:45:52 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A85A33C0E9D
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 11:45:42 +0200 (CEST)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E854D601B13
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 11:45:41 +0200 (CEST)
Received: by mail-pf1-x42f.google.com with SMTP id t184so2261928pfd.0
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 02:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=PkWJPcEkG5yRV9AJJ2rJVJo95Aks/t1YIk8C9uE3ulE=;
 b=U8+egL7RFbMSUMMnBh+zorkKzGcJSxoNX6HK1VBCCWueri+berKS+Tn2ADZS3vVoyD
 /eT3OJo65CWOjP3NtyAgonbY658QDsf7oMrhtGc8L5T9HskOvrb3pPHFQX0KD/dj67Lo
 R+HzWE2kNTEVhGRJvvlWxAZ8uO0+nqmQ5KPM7+JyW2HNuENXdyYNAAy78jzdP+MRP4As
 1HP3JXVNQq2WBtijFdkI5zrMhwhJhVaDfXBjmn2Hym7E5FHuodw6pqVeDr2Ls0av+3+0
 OG7zLkaFlglnMMjJXG4cX1uT/DQZ3vQSgT1akLOqqIveHCxixJa5ozBBnoWUGXR2XzH5
 u7Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=PkWJPcEkG5yRV9AJJ2rJVJo95Aks/t1YIk8C9uE3ulE=;
 b=SEaOB84zCLYJmr3Bq1XNMul87J3wP23hepkZX99OBXETVLhd4HhDsvvszN7SB+c/SD
 HeR4BMVEFKcziiSiJJ+oNsTxM+Uwthzm4qt1HqIyy8ARSHpS6NSV8gmCbS/zGg1h4MpZ
 g2jqnwsu1Gq2V1plNnveL8NwzPm+jDfyaWM3PbEVACZfE3YOjTwKaD11RN2UdyL9Stgo
 uNp12M3KyyF1UKsI0rZCKOHCzkVQw/kPVPd/uwaJhXDR3RO7i0fQXI7g3F+ZK4u9qvWF
 qXaCun/xIwR/z2GA7oKgPx5Xa5WJrFj8qHdSO/PYXJ/EsHpVBRfK/OC+ssUQXKT9h5aZ
 H7QA==
X-Gm-Message-State: AOAM53195agKstKQ8yOKptA1k4cJFHfVUQbLPmiDsGO/SoeN6yPE30mV
 FVqCW8Q9PVICwjkZ7twBJGq/67dHF6k0Lw==
X-Google-Smtp-Source: ABdhPJyE6PUkmoWXRq5Dm/eLGDPSu66CgfvGcl2TMT2/e5zvLkSmUXQgKLdCamk8aTZE1vTPD44cWQ==
X-Received: by 2002:a63:3585:: with SMTP id c127mr4875066pga.431.1635327939964; 
 Wed, 27 Oct 2021 02:45:39 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:ac4c:4230:ca81:632e])
 by smtp.gmail.com with ESMTPSA id i5sm21916459pgo.36.2021.10.27.02.45.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Oct 2021 02:45:39 -0700 (PDT)
Date: Wed, 27 Oct 2021 20:45:28 +1100
To: ltp@lists.linux.it
Message-ID: <0012c7cfcad11e83ec4e9d06634c4dbe4a02e48f.1635327490.git.repnop@google.com>
References: <cover.1635327490.git.repnop@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1635327490.git.repnop@google.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] syscalls/fanotify21: add new test checking the
 returned pidfd from fanotify in FAN_REPORT_PIDFD mode
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
From: Matthew Bobrowski via ltp <ltp@lists.linux.it>
Reply-To: Matthew Bobrowski <repnop@google.com>
Cc: jack@suse.cz
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

A new test that performs verification on the values returned within the
struct fanotify_event_info_pidfd record when notification group intialized
in FAN_REPORT_PIDFD mode.

Signed-off-by: Matthew Bobrowski <repnop@google.com>
---
 testcases/kernel/syscalls/fanotify/.gitignore |   1 +
 .../kernel/syscalls/fanotify/fanotify21.c     | 363 ++++++++++++++++++
 2 files changed, 364 insertions(+)
 create mode 100644 testcases/kernel/syscalls/fanotify/fanotify21.c

diff --git a/testcases/kernel/syscalls/fanotify/.gitignore b/testcases/kernel/syscalls/fanotify/.gitignore
index c99e6fff7..35e73b91e 100644
--- a/testcases/kernel/syscalls/fanotify/.gitignore
+++ b/testcases/kernel/syscalls/fanotify/.gitignore
@@ -18,4 +18,5 @@
 /fanotify18
 /fanotify19
 /fanotify20
+/fanotify21
 /fanotify_child
diff --git a/testcases/kernel/syscalls/fanotify/fanotify21.c b/testcases/kernel/syscalls/fanotify/fanotify21.c
new file mode 100644
index 000000000..f64f8fef4
--- /dev/null
+++ b/testcases/kernel/syscalls/fanotify/fanotify21.c
@@ -0,0 +1,363 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2021 Google. All Rights Reserved.
+ *
+ * Started by Matthew Bobrowski <repnop@google.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * A test which verifies whether the returned struct
+ * fanotify_event_info_pidfd in FAN_REPORT_PIDFD mode contains the
+ * expected set of information.
+ */
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <ctype.h>
+#include <stdlib.h>
+#include <string.h>
+#include "tst_test.h"
+#include "tst_safe_stdio.h"
+#include "lapi/pidfd_open.h"
+
+#ifdef HAVE_SYS_FANOTIFY_H
+#include "fanotify.h"
+
+#define BUF_SZ		4096
+#define MOUNT_PATH	"fs_mnt"
+#define TEST_FILE	MOUNT_PATH "/testfile"
+
+struct pidfd_fdinfo_t {
+	int pos;
+	int flags;
+	int mnt_id;
+	int pid;
+	int ns_pid;
+};
+
+struct test_case_t {
+	char *name;
+	int fork;
+	int want_pidfd_err;
+} test_cases[] = {
+	{
+		"return a valid pidfd for event created by self",
+		0,
+		0,
+	},
+	{
+		"return invalid pidfd for event created by terminated child",
+		1,
+		FAN_NOPIDFD,
+	},
+};
+
+static int fanotify_fd;
+static char event_buf[BUF_SZ];
+static struct pidfd_fdinfo_t *self_pidfd_fdinfo = NULL;
+
+static char *trim(char *line)
+{
+	char *start = line;
+	char *end = line + strlen(line);
+
+	while(*start && isspace(*start))
+		start++;
+
+	while(end > start && isspace(*(end - 1)))
+		end--;
+
+	*end = '\0';
+	return start;
+}
+
+static int parse_pidfd_fdinfo_line(char *line,
+				   struct pidfd_fdinfo_t *pidfd_fdinfo)
+{
+	char *ptr, *key, *value;
+
+	ptr = strchr(line, ':');
+	if (ptr == NULL)
+		return -1;
+
+	*ptr++ = '\0';
+	key = trim(line);
+	value = trim(ptr);
+
+	/*
+	 * Ensure to cover all keys of interest that may be found within the
+	 * pidfd fdinfo. If we encounter an unexpected key, skip it.
+	 */
+	if (strcmp(key, "pos") == 0)
+		pidfd_fdinfo->pos = atoi(value);
+	else if (strcmp(key, "flags") == 0)
+		pidfd_fdinfo->flags = (int)strtol(value, NULL, 16);
+	else if (strcmp(key, "mnt_id") == 0)
+		pidfd_fdinfo->mnt_id = atoi(value);
+	else if (strcmp(key, "Pid") == 0)
+		pidfd_fdinfo->pid = atoi(value);
+	else if (strcmp(key, "NSpid") == 0)
+		pidfd_fdinfo->ns_pid = atoi(value);
+
+	return 0;
+}
+
+static struct pidfd_fdinfo_t *read_pidfd_fdinfo(int pidfd)
+{
+	FILE *f;
+	size_t len;
+	char *line = NULL, *fdinfo_path;
+	struct pidfd_fdinfo_t *pidfd_fdinfo;
+
+	pidfd_fdinfo = SAFE_MALLOC(sizeof(struct pidfd_fdinfo_t));
+
+	SAFE_ASPRINTF(&fdinfo_path, "/proc/self/fdinfo/%d", pidfd);
+
+	f = SAFE_FOPEN(fdinfo_path, "r");
+
+	while (getline(&line, &len, f) != -1) {
+		if (parse_pidfd_fdinfo_line(line, pidfd_fdinfo)) {
+			pidfd_fdinfo = NULL;
+			break;
+		}
+	}
+
+	free(line);
+	free(fdinfo_path);
+	SAFE_FCLOSE(f);
+
+	return pidfd_fdinfo;
+}
+
+static void generate_event(void)
+{
+	int fd;
+
+	/* Generate a single FAN_OPEN event on the watched object. */
+	fd = SAFE_OPEN(TEST_FILE, O_RDONLY);
+	SAFE_CLOSE(fd);
+}
+
+static void do_fork(void)
+{
+	int status;
+	pid_t child;
+
+	child = SAFE_FORK();
+	if (child == 0) {
+		SAFE_CLOSE(fanotify_fd);
+		generate_event();
+		exit(EXIT_SUCCESS);
+	}
+
+	SAFE_WAITPID(child, &status, 0);
+	if (WIFEXITED(status) && WEXITSTATUS(status) != 0)
+		tst_brk(TBROK,
+			"child process terminated incorrectly");
+}
+
+static void do_setup(void)
+{
+	int ret, pidfd;
+
+	SAFE_TOUCH(TEST_FILE, 0666, NULL);
+
+	/*
+	 * An explicit check for FAN_REPORT_PIDFD is performed early
+	 * on in the test initialization as it's a prerequisite for
+	 * all test cases.
+	 */
+	if ((ret = fanotify_init_flags_supported_by_kernel(FAN_REPORT_PIDFD))) {
+		fanotify_init_flags_err_msg("FAN_REPORT_PIDFD", __FILE__,
+					    __LINE__, tst_brk_, ret);
+	}
+
+	fanotify_fd = SAFE_FANOTIFY_INIT(FAN_REPORT_PIDFD, O_RDONLY);
+	SAFE_FANOTIFY_MARK(fanotify_fd, FAN_MARK_ADD, FAN_OPEN, AT_FDCWD,
+			   TEST_FILE);
+
+	pidfd = pidfd_open(getpid(), 0);
+	if (pidfd < 0) {
+		tst_brk(TBROK | TERRNO,
+			"pidfd=%d, pidfd_open(%d, 0) failed",
+			pidfd, getpid());
+	}
+
+	self_pidfd_fdinfo = read_pidfd_fdinfo(pidfd);
+	if (self_pidfd_fdinfo == NULL) {
+		tst_brk(TBROK,
+			"pidfd=%d, failed to read pidfd fdinfo",
+			pidfd);
+	}
+}
+
+static void do_test(unsigned int num)
+{
+	int i = 0, len;
+	struct test_case_t *tc = &test_cases[num];
+
+	tst_res(TINFO, "Test #%d: %s", num, tc->name);
+
+	/*
+	 * Generate the event in either self or a child process. Event
+	 * generation in a child process is done so that the FAN_NOPIDFD case
+	 * can be verified.
+	 */
+	if (tc->fork)
+		do_fork();
+	else
+		generate_event();
+
+	/*
+	 * Read all of the queued events into the provided event
+	 * buffer.
+	 */
+	len = SAFE_READ(0, fanotify_fd, event_buf, sizeof(event_buf));
+	while(i < len) {
+		struct fanotify_event_metadata *event;
+		struct fanotify_event_info_pidfd *info;
+		struct pidfd_fdinfo_t *event_pidfd_fdinfo = NULL;
+
+		event = (struct fanotify_event_metadata *)&event_buf[i];
+		info = (struct fanotify_event_info_pidfd *)(event + 1);
+
+		/*
+		 * Checks ensuring that pidfd information record object header
+		 * fields are set correctly.
+		 */
+		if (info->hdr.info_type != FAN_EVENT_INFO_TYPE_PIDFD) {
+			tst_res(TFAIL,
+				"unexpected info_type received in info "
+				"header (expected: %d, got: %d",
+				FAN_EVENT_INFO_TYPE_PIDFD,
+				info->hdr.info_type);
+			info = NULL;
+			goto next_event;
+		} else if (info->hdr.len !=
+			   sizeof(struct fanotify_event_info_pidfd)) {
+			tst_res(TFAIL,
+				"unexpected info object length "
+				"(expected: %lu, got: %d",
+				sizeof(struct fanotify_event_info_pidfd),
+				info->hdr.len);
+			info = NULL;
+			goto next_event;
+		}
+
+		/*
+		 * Check if pidfd information object reported any errors during
+		 * creation and whether they're expected.
+		 */
+		if (info->pidfd < 0 && !tc->want_pidfd_err) {
+			tst_res(TFAIL,
+				"pidfd creation failed for pid: %u with pidfd error value "
+				"set to: %d",
+				(unsigned)event->pid,
+				info->pidfd);
+			goto next_event;
+		} else if (tc->want_pidfd_err &&
+			   info->pidfd != tc->want_pidfd_err) {
+			tst_res(TFAIL,
+				"pidfd set to an unexpected error: %d for pid: %u",
+				info->pidfd,
+				(unsigned)event->pid);
+			goto next_event;
+		} else if (tc->want_pidfd_err &&
+			   info->pidfd == tc->want_pidfd_err) {
+			tst_res(TPASS,
+				"pid: %u terminated before pidfd was created, "
+				"pidfd set to the value of: %d, as expected",
+				(unsigned)event->pid,
+				FAN_NOPIDFD);
+			goto next_event;
+		}
+
+		/*
+		 * No pidfd errors occurred, continue with verifying pidfd
+		 * fdinfo validity.
+		 */
+		event_pidfd_fdinfo = read_pidfd_fdinfo(info->pidfd);
+		if (event_pidfd_fdinfo == NULL) {
+			tst_brk(TBROK,
+				"reading fdinfo for pidfd: %d "
+				"describing pid: %u failed",
+				info->pidfd,
+				(unsigned)event->pid);
+			goto next_event;
+		} else if (event_pidfd_fdinfo->pid != event->pid) {
+			tst_res(TFAIL,
+				"pidfd provided for incorrect pid "
+				"(expected pidfd for pid: %u, got pidfd for "
+				"pid: %u)",
+				(unsigned)event->pid,
+				(unsigned)event_pidfd_fdinfo->pid);
+			goto next_event;
+		} else if (memcmp(event_pidfd_fdinfo, self_pidfd_fdinfo,
+				  sizeof(struct pidfd_fdinfo_t))) {
+			tst_res(TFAIL,
+				"pidfd fdinfo values for self and event differ "
+				"(expected pos: %d, flags: %x, mnt_id: %d, "
+				"pid: %d, ns_pid: %d, got pos: %d, "
+				"flags: %x, mnt_id: %d, pid: %d, ns_pid: %d",
+				self_pidfd_fdinfo->pos,
+				self_pidfd_fdinfo->flags,
+				self_pidfd_fdinfo->mnt_id,
+				self_pidfd_fdinfo->pid,
+				self_pidfd_fdinfo->ns_pid,
+				event_pidfd_fdinfo->pos,
+				event_pidfd_fdinfo->flags,
+				event_pidfd_fdinfo->mnt_id,
+				event_pidfd_fdinfo->pid,
+				event_pidfd_fdinfo->ns_pid);
+			goto next_event;
+		} else {
+			tst_res(TPASS,
+				"got an event with a valid pidfd info record, "
+				"mask: %lld, pid: %u, fd: %d, "
+				"pidfd: %d, info_type: %d, info_len: %d",
+				(unsigned long long)event->mask,
+				(unsigned)event->pid,
+				event->fd,
+				info->pidfd,
+				info->hdr.info_type,
+				info->hdr.len);
+		}
+
+next_event:
+		i += event->event_len;
+		if (event->fd >= 0)
+			SAFE_CLOSE(event->fd);
+
+		if (info && info->pidfd >= 0)
+			SAFE_CLOSE(info->pidfd);
+
+		if (event_pidfd_fdinfo)
+			free(event_pidfd_fdinfo);
+	}
+}
+
+static void do_cleanup(void)
+{
+	if (fanotify_fd >= 0)
+		SAFE_CLOSE(fanotify_fd);
+
+	if (self_pidfd_fdinfo)
+		free(self_pidfd_fdinfo);
+}
+
+static struct tst_test test = {
+	.setup = do_setup,
+	.test = do_test,
+	.tcnt = ARRAY_SIZE(test_cases),
+	.cleanup = do_cleanup,
+	.all_filesystems = 1,
+	.needs_root = 1,
+	.mntpoint = MOUNT_PATH,
+	.forks_child = 1,
+};
+
+#else
+	TST_TEST_TCONF("system doesn't have required fanotify support");
+#endif /* HAVE_SYS_FANOTIFY_H */
-- 
2.33.0.1079.g6e70778dc9-goog

/M

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
