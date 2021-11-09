Return-Path: <SRS0=8di7=P4=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F562C433EF
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 10:06:15 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB3E4611BD
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 10:06:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CB3E4611BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux.it
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8EFAA3C07C1
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 11:06:13 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4A92A3C01FC
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 11:06:03 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2BE0A14125C9
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 11:06:02 +0100 (CET)
Received: by mail-pl1-x632.google.com with SMTP id p18so19939330plf.13
 for <ltp@lists.linux.it>; Tue, 09 Nov 2021 02:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=a9FHoC055G4Fjm847gU/ogM2Muz6IqfbnuBzPMtBADc=;
 b=LsizKRb8oILIah6ml4EhrVz9vQyUKwCENAUZAMrDNLAp+7vY3Intrlrq5H7uZ+ayd+
 RcYpwY+FNQ3PdlZlT8QMEL7BzvDxBL7tyeQf7vsLVkNteJAgQNEjQvw0dJ7/AOJ7sWDI
 dqGpQNMe9q1Nc3XcP4Ea6g/d1ZnIpavksyLVPz/QOm4b9tJBFyHCWCZXWwUZLhnA+7/9
 4flwOEhMNGr0AvN6NgCqvcn08h7YyWH6+H+HPPUD/Zrd5yU2jiv52ExaFpxergyY9Por
 6wDc5lWuepASP9zmJN+01M+aVlwQux+e7eesIq/eqr9dI6ek3FTrRuSyj1Jjm81mRtDu
 DPKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=a9FHoC055G4Fjm847gU/ogM2Muz6IqfbnuBzPMtBADc=;
 b=HRlgPVym2RJ869GvYOUrGzpOXlBluWq4b2rTXUaNk6JJzRxLGXYLVTkAKyh9GPbXbL
 TSkshdqYnwjTm2Gih6R+24d7XFwEQr6DbPBx0SEz68hF+3Gg4sa7sJqPvOd8tHuxqn1j
 7y4WbfUw9eTP1wHR0/fFVxXdyh/EM94vm3Pl7Jb4qOBz/GqW7aaO2GHKIZAUtuM/m4hr
 vkTT85UA5u1lD02FJd+uVQk2VHyd56oyyrK3X0No77hgraJfbDBNwMpzeuAiYaAKGoSF
 DkGcRsaJ4Aal8JxDA/wBJeCDDPpn/QBpZyiCImpDMSADNkjhd19a/UbbHjSajfSkZODk
 jIzA==
X-Gm-Message-State: AOAM531IwzBiwdtEGjFy4SLQEZckATIYAFP8yp8X2Ani/Mr4keDjQzv8
 KSONUYB4Fsk7MUVYhwJfI9lcFb1rnNfUqA==
X-Google-Smtp-Source: ABdhPJzOLG0xoDCDWqfTqRalHR4Tfrj56qJcTgyI4czNeE0PKJMTg8RkIwbxdVs261vyhHOjchNX6w==
X-Received: by 2002:a17:902:934a:b0:142:6ed6:5327 with SMTP id
 g10-20020a170902934a00b001426ed65327mr6090697plp.85.1636452360273; 
 Tue, 09 Nov 2021 02:06:00 -0800 (PST)
Received: from google.com ([2401:fa00:9:211:49d1:39e8:a7a5:de38])
 by smtp.gmail.com with ESMTPSA id l21sm18559203pfu.213.2021.11.09.02.05.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Nov 2021 02:05:59 -0800 (PST)
Date: Tue, 9 Nov 2021 21:05:49 +1100
To: ltp@lists.linux.it
Message-ID: <e75ba818f75faf3cc57d6a23788b1d5a4a3c9835.1636451496.git.repnop@google.com>
References: <cover.1636451496.git.repnop@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1636451496.git.repnop@google.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 3/3] syscalls/fanotify21: test returned pidfd from
 fanotify in FAN_REPORT_PIDFD mode
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

This is a new test that performs verification on the values returned
within the struct fanotify_event_info_pidfd record when the
notification group has been initialized with the FAN_REPORT_PIDFD
flag.

Signed-off-by: Matthew Bobrowski <repnop@google.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
---
 testcases/kernel/syscalls/fanotify/.gitignore |   1 +
 .../kernel/syscalls/fanotify/fanotify21.c     | 306 ++++++++++++++++++
 2 files changed, 307 insertions(+)
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
index 000000000..e842dad17
--- /dev/null
+++ b/testcases/kernel/syscalls/fanotify/fanotify21.c
@@ -0,0 +1,306 @@
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
+static struct pidfd_fdinfo_t *read_pidfd_fdinfo(int pidfd)
+{
+	char *fdinfo_path;
+	struct pidfd_fdinfo_t *pidfd_fdinfo;
+
+	pidfd_fdinfo = SAFE_MALLOC(sizeof(struct pidfd_fdinfo_t));
+
+	SAFE_ASPRINTF(&fdinfo_path, "/proc/self/fdinfo/%d", pidfd);
+	SAFE_FILE_LINES_SCANF(fdinfo_path, "pos: %d", &pidfd_fdinfo->pos);
+	SAFE_FILE_LINES_SCANF(fdinfo_path, "flags: %d", &pidfd_fdinfo->flags);
+	SAFE_FILE_LINES_SCANF(fdinfo_path, "mnt_id: %d", &pidfd_fdinfo->mnt_id);
+	SAFE_FILE_LINES_SCANF(fdinfo_path, "Pid: %d", &pidfd_fdinfo->pid);
+	SAFE_FILE_LINES_SCANF(fdinfo_path, "NSpid: %d", &pidfd_fdinfo->ns_pid);
+
+	free(fdinfo_path);
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
+	int pidfd;
+
+	SAFE_TOUCH(TEST_FILE, 0666, NULL);
+
+	/*
+	 * An explicit check for FAN_REPORT_PIDFD is performed early
+	 * on in the test initialization as it's a prerequisite for
+	 * all test cases.
+	 */
+	REQUIRE_FANOTIFY_INIT_FLAGS_SUPPORTED_BY_KERNEL(FAN_REPORT_PIDFD);
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
2.34.0.rc0.344.g81b53c2807-goog

/M

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
