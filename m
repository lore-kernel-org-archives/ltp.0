Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3119C02198
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 15:14:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 244BF3C98DB
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 16:14:32 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 475003C98B9
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 16:13:24 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 83F3E1182BA4
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 16:13:23 +0100 (CET)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43948021a45so7245335e9.1
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 07:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739200403; x=1739805203; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7wQmZFDr5WNCxl/wBTZjnbUTqJEj1/iRbENAfy8rvRs=;
 b=iXpN/Ntp85SACCLPY23Ii5eemcv1I2JotFgQugsRpWJ5ai0UH3s78Y6jcJv2pcdEcj
 SQ49pXYatZdaka3SXbBoRxa1VpfmDsZiW2uhmMmXAvCsC3HuoEvCVdndcGOscEA1LKWp
 8Nv1Ke4FW8uznLrY4N4fdWyroHEApewAd9tTdN74Jlw/XW57dH2nRp3i04SKT4qP8+Fs
 5mLt5J0g4LCQuOtgATO09RtAqzwUELmFADvSpSDfnrPUmbonXs06MKPSiWo9dRGp6SLh
 JOyG/7nSTuYbSAjGOXedrrB20ag07H+Gyn9i4C4/dAfaJRlvsQZwg+aoVb8isUv8l08l
 iVmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739200403; x=1739805203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7wQmZFDr5WNCxl/wBTZjnbUTqJEj1/iRbENAfy8rvRs=;
 b=qA4Re3EQjfJZsTLoKGabi2/JgiogPXAYxjOJTmMiIXQmupD05daLGwjEWJ02O4obR1
 HW5dGgM1paAbfMSjHElAJJG7MwbjMUrR9gOs/WTPUZ5rmW5hotsB0QytZs7pwRwmsGDf
 7hac9E8XjEAhdjk+bJgsjMxOhIElBNO2py5qShkInXGwGpDEJojh5TyWliNWOGdLhmo5
 IhMdLozjm0sZLLQkIVH+eJITCkzm3CR6hGINVmV1iHvGiKuZhb4ceuKv4c+M+w7RPk7F
 Ec82DRbyTsBK3X/3bSUaDaY/ldUddNtZO1mNBSzrfX5bdKWPOcajb/ruVxnaNE3FNB5Y
 Noyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXgoce+y0GyOqNS8gy6FPjDokF2/215AjWQ9dSpLDgQcARBn4IbygzxXRj2cqelkvbtg0=@lists.linux.it
X-Gm-Message-State: AOJu0YwXASv2hNGM/p7xm9LOh7ZrjAxUNcwGucA27PhcIf88mNstDoVR
 3cNEBVheWrBvtNBrTlBS1pRf5PctQN2jiXnuGiMoJ6kBgLkpi64x5Tdrwoz7
X-Gm-Gg: ASbGncufPb66d7J/nyDynnsPkzUkdvzPAG4Ex+QgdedAimo6O8cLykrsXi6qL9Zgntc
 +c0/1YsaTSEaO5PdpOXCwg621iFzugQZ9Fj6t/HRY/w4wa2G9UuzOMo4dGjBWzuHbhI3BUX8Skb
 6kG5/ipglgY8N+Qm13WBjhiiSHtms420e9BJGzl2+yyGm0pDVrK0tyZi1RhhZ5TtgxLnmJFxuhM
 uplSqk5OYZ0TFkp/sD+jWvvkFiqJ/4hklsIb6nLikXgdt9oI9QopVWdI1N0zu4D9zF7TVXQ0iV2
 c8nIFatuPvNWBLZDC2fIZmSFoJSQkmOqixDLAgR3xnlZP3KH6k87204ORoQ9cbe3SIBlzxY/R9l
 zyM3zUNxRTfim
X-Google-Smtp-Source: AGHT+IHU2D9+glQLOqGt4f0vCfRBk8khISvi3i829o3NNgFkCazrGUGNno254mUblpEGRjvyEk8+Lg==
X-Received: by 2002:a05:600c:1c92:b0:439:4589:1ab0 with SMTP id
 5b1f17b1804b1-43945891dd3mr30985455e9.13.1739200402346; 
 Mon, 10 Feb 2025 07:13:22 -0800 (PST)
Received: from amir-ThinkPad-T480.arnhem.chello.nl
 (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dce6f2c37sm9106869f8f.99.2025.02.10.07.13.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 07:13:21 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Mon, 10 Feb 2025 16:13:15 +0100
Message-Id: <20250210151316.246079-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250210151316.246079-1-amir73il@gmail.com>
References: <20250210151316.246079-1-amir73il@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/4] fanotify24: Add test for FAN_PRE_ACCESS and
 FAN_DENY_ERRNO
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Fork the test fanotify24 from test fanotify03, replacing the
permission event FAN_ACCESS_PERM with the new pre-content event
FAN_PRE_ACCESS.

The test is changed to use class FAN_CLASS_PRE_CONTENT, which is
required for FAN_PRE_ACCESS and this class also enabled the response
with cutomer error code FAN_DENY_ERRNO.

Unlike FAN_ACCESS_PERM, FAN_PRE_ACCESS is also created on write()
system call.  The test case expected results are adjusted to
respond with the default error (EPERM) to open() and write() and
to respond with custom errors (EIO, EBUSY) to read() and execve().

Not all fs support pre-content events, so run on all filesystems
to excercise FAN_PRE_ACCESS on all supported filesystems.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 include/lapi/fanotify.h                       |   7 +
 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/fanotify/.gitignore |   1 +
 testcases/kernel/syscalls/fanotify/fanotify.h |   3 +
 .../kernel/syscalls/fanotify/fanotify24.c     | 433 ++++++++++++++++++
 5 files changed, 445 insertions(+)
 create mode 100644 testcases/kernel/syscalls/fanotify/fanotify24.c

diff --git a/include/lapi/fanotify.h b/include/lapi/fanotify.h
index e5b930f4e..9076685e8 100644
--- a/include/lapi/fanotify.h
+++ b/include/lapi/fanotify.h
@@ -124,6 +124,13 @@
 #define FAN_EPIDFD		-2
 #endif
 
+/* errno other than EPERM can specified in upper byte of deny response */
+#ifndef FAN_DENY_ERRNO
+#define FAN_ERRNO(err) (((((__u32)(err)) & 0xff) << 24))
+#define FAN_DENY_ERRNO(err) (FAN_DENY | FAN_ERRNO(err))
+#define FAN_RESPONSE_ERRNO(res) ((int)((res) >> 24))
+#endif
+
 /* Flags required for unprivileged user group */
 #define FANOTIFY_REQUIRED_USER_INIT_FLAGS    (FAN_REPORT_FID)
 
diff --git a/runtest/syscalls b/runtest/syscalls
index 4ab8436d3..07a3d5907 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -649,6 +649,7 @@ fanotify20 fanotify20
 fanotify21 fanotify21
 fanotify22 fanotify22
 fanotify23 fanotify23
+fanotify24 fanotify24
 
 ioperm01 ioperm01
 ioperm02 ioperm02
diff --git a/testcases/kernel/syscalls/fanotify/.gitignore b/testcases/kernel/syscalls/fanotify/.gitignore
index a0a7d20d3..16af3db85 100644
--- a/testcases/kernel/syscalls/fanotify/.gitignore
+++ b/testcases/kernel/syscalls/fanotify/.gitignore
@@ -21,4 +21,5 @@
 /fanotify21
 /fanotify22
 /fanotify23
+/fanotify24
 /fanotify_child
diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index 48a44cc7e..7977b4aa4 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -277,6 +277,9 @@ static inline void fanotify_flags_err_msg(const char *flags_str,
 #define FANOTIFY_MARK_FLAGS_ERR_MSG(mark, fail) \
 	fanotify_flags_err_msg((mark)->name, __FILE__, __LINE__, tst_res_, (fail))
 
+#define FANOTIFY_EVENTS_ERR_MSG(event, fail) \
+	fanotify_flags_err_msg(#event, __FILE__, __LINE__, tst_res_, (fail))
+
 #define REQUIRE_FANOTIFY_INIT_FLAGS_SUPPORTED_ON_FS(flags, fname) \
 	fanotify_flags_err_msg(#flags, __FILE__, __LINE__, tst_brk_, \
 		fanotify_init_flags_supported_on_fs(flags, fname))
diff --git a/testcases/kernel/syscalls/fanotify/fanotify24.c b/testcases/kernel/syscalls/fanotify/fanotify24.c
new file mode 100644
index 000000000..a7aa2e052
--- /dev/null
+++ b/testcases/kernel/syscalls/fanotify/fanotify24.c
@@ -0,0 +1,433 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2013 SUSE.  All Rights Reserved.
+ * Copyright (c) 2025 CTERA Networks.  All Rights Reserved.
+ *
+ * Started by Jan Kara <jack@suse.cz>
+ */
+
+/*\
+ * [Description]
+ * - Test fanotify pre-content events
+ * - Test respond to permission/pre-content events with cutsom error code
+ */
+
+#define _GNU_SOURCE
+#include "config.h"
+
+#include <stdio.h>
+#include <unistd.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <errno.h>
+#include <string.h>
+#include <signal.h>
+#include <sys/syscall.h>
+#include <stdlib.h>
+#include "tst_test.h"
+
+#ifdef HAVE_SYS_FANOTIFY_H
+# include "fanotify.h"
+
+#define EVENT_MAX 1024
+/* size of the event structure, not counting name */
+#define EVENT_SIZE  (sizeof(struct fanotify_event_metadata))
+/* reasonable guess as to size of 1024 events */
+#define EVENT_BUF_LEN        (EVENT_MAX * EVENT_SIZE)
+/* Size large enough to hold a reasonable amount of expected event objects */
+#define EVENT_SET_MAX 16
+
+#define BUF_SIZE 256
+#define TST_TOTAL 3
+#define TEST_APP "fanotify_child"
+#define MOUNT_PATH "fs_mnt"
+#define FILE_EXEC_PATH MOUNT_PATH"/"TEST_APP
+
+static char fname[BUF_SIZE];
+static char buf[BUF_SIZE];
+static volatile int fd_notify;
+
+static pid_t child_pid;
+
+static char event_buf[EVENT_BUF_LEN];
+
+struct event {
+	unsigned long long mask;
+	unsigned int response;
+};
+
+static struct tcase {
+	const char *tname;
+	struct fanotify_mark_type mark;
+	unsigned long long mask;
+	int event_count;
+	struct event event_set[EVENT_SET_MAX];
+} tcases[] = {
+	{
+		"inode mark, FAN_OPEN_PERM | FAN_PRE_ACCESS events",
+		INIT_FANOTIFY_MARK_TYPE(INODE),
+		FAN_OPEN_PERM | FAN_PRE_ACCESS, 4,
+		{
+			{FAN_OPEN_PERM, FAN_ALLOW},
+			{FAN_PRE_ACCESS, FAN_DENY},
+			{FAN_PRE_ACCESS, FAN_DENY_ERRNO(EIO)},
+			{FAN_OPEN_PERM, FAN_DENY_ERRNO(EBUSY)}
+		}
+	},
+	{
+		"inode mark, FAN_PRE_ACCESS | FAN_OPEN_EXEC_PERM events",
+		INIT_FANOTIFY_MARK_TYPE(INODE),
+		FAN_PRE_ACCESS | FAN_OPEN_EXEC_PERM, 3,
+		{
+			{FAN_PRE_ACCESS, FAN_DENY},
+			{FAN_PRE_ACCESS, FAN_DENY_ERRNO(EIO)},
+			{FAN_OPEN_EXEC_PERM, FAN_DENY_ERRNO(EBUSY)}
+		}
+	},
+	{
+		"mount mark, FAN_OPEN_PERM | FAN_PRE_ACCESS events",
+		INIT_FANOTIFY_MARK_TYPE(MOUNT),
+		FAN_OPEN_PERM | FAN_PRE_ACCESS, 4,
+		{
+			{FAN_OPEN_PERM, FAN_ALLOW},
+			{FAN_PRE_ACCESS, FAN_DENY},
+			{FAN_PRE_ACCESS, FAN_DENY_ERRNO(EIO)},
+			{FAN_OPEN_PERM, FAN_DENY_ERRNO(EBUSY)}
+		}
+	},
+	{
+		"mount mark, FAN_PRE_ACCESS | FAN_OPEN_EXEC_PERM events",
+		INIT_FANOTIFY_MARK_TYPE(MOUNT),
+		FAN_PRE_ACCESS | FAN_OPEN_EXEC_PERM, 3,
+		{
+			{FAN_PRE_ACCESS, FAN_DENY},
+			{FAN_PRE_ACCESS, FAN_DENY_ERRNO(EIO)},
+			{FAN_OPEN_EXEC_PERM, FAN_DENY_ERRNO(EBUSY)}
+		}
+	},
+	{
+		"filesystem mark, FAN_OPEN_PERM | FAN_PRE_ACCESS events",
+		INIT_FANOTIFY_MARK_TYPE(FILESYSTEM),
+		FAN_OPEN_PERM | FAN_PRE_ACCESS, 4,
+		{
+			{FAN_OPEN_PERM, FAN_ALLOW},
+			{FAN_PRE_ACCESS, FAN_DENY},
+			{FAN_PRE_ACCESS, FAN_DENY_ERRNO(EIO)},
+			{FAN_OPEN_PERM, FAN_DENY_ERRNO(EBUSY)}
+		}
+	},
+	{
+		"filesystem mark, FAN_PRE_ACCESS | FAN_OPEN_EXEC_PERM events",
+		INIT_FANOTIFY_MARK_TYPE(FILESYSTEM),
+		FAN_PRE_ACCESS | FAN_OPEN_EXEC_PERM, 3,
+		{
+			{FAN_PRE_ACCESS, FAN_DENY},
+			{FAN_PRE_ACCESS, FAN_DENY_ERRNO(EIO)},
+			{FAN_OPEN_EXEC_PERM, FAN_DENY_ERRNO(EBUSY)}
+		}
+	},
+	{
+		"parent watching children, FAN_PRE_ACCESS | FAN_OPEN_EXEC_PERM events",
+		INIT_FANOTIFY_MARK_TYPE(PARENT),
+		FAN_PRE_ACCESS | FAN_OPEN_EXEC_PERM | FAN_EVENT_ON_CHILD, 3,
+		{
+			{FAN_PRE_ACCESS, FAN_DENY},
+			{FAN_PRE_ACCESS, FAN_DENY},
+			{FAN_OPEN_EXEC_PERM, FAN_DENY}
+		}
+	},
+	{
+		"parent not watching children, FAN_PRE_ACCESS | FAN_OPEN_EXEC_PERM events",
+		INIT_FANOTIFY_MARK_TYPE(PARENT),
+		FAN_PRE_ACCESS | FAN_OPEN_EXEC_PERM, 0,
+		{
+		}
+	},
+};
+
+static int expected_errno(unsigned int response)
+{
+	switch (response) {
+		case 0:
+		case FAN_ALLOW:
+			return 0;
+		case FAN_DENY:
+			return EPERM;
+		default:
+			return FAN_RESPONSE_ERRNO(response);
+	}
+}
+
+static void generate_events(struct tcase *tc)
+{
+	int fd;
+	char *const argv[] = {FILE_EXEC_PATH, NULL};
+	struct event* event = tc->event_set;
+	int exp_ret, exp_errno = 0;
+
+	if (event->mask == FAN_OPEN_PERM)
+		event++;
+
+	/*
+	 * Generate sequence of events
+	 */
+	fd = SAFE_OPEN(fname, O_RDWR | O_CREAT, 0700);
+
+	exp_errno = expected_errno(event->response);
+	event++;
+
+	exp_ret = exp_errno ? -1 : 1;
+	errno = 0;
+	/* FAN_PRE_ACCESS events are reported also on write */
+	if (write(fd, fname, 1) != exp_ret || errno != exp_errno) {
+		tst_res(TFAIL, "write() got errno %d (expected %d)", errno, exp_errno);
+		exit(3);
+	} else if (errno == exp_errno) {
+		tst_res(TINFO, "write() got errno %d as expected", errno);
+	}
+
+	SAFE_LSEEK(fd, 0, SEEK_SET);
+
+	exp_errno = expected_errno(event->response);
+	event++;
+
+	exp_ret = exp_errno ? -1 : 1;
+	errno = 0;
+	if (read(fd, buf, BUF_SIZE) != exp_ret || errno != exp_errno) {
+		tst_res(TFAIL, "read() got errno %d (expected %d)", errno, exp_errno);
+		exit(4);
+	} else if (errno == exp_errno) {
+		tst_res(TINFO, "read() got errno %d as expected", errno);
+	}
+
+	SAFE_CLOSE(fd);
+
+	exp_errno = expected_errno(event->response);
+	event++;
+
+	exp_ret = exp_errno ? -1 : 0;
+	errno = 0;
+	if (execve(FILE_EXEC_PATH, argv, environ) != exp_ret || errno != exp_errno) {
+		tst_res(TFAIL, "execve() got errno %d (expected %d)", errno, exp_errno);
+		exit(5);
+	} else if (errno == exp_errno) {
+		tst_res(TINFO, "execve() got errno %d as expected", errno);
+	}
+}
+
+static void child_handler(int tmp)
+{
+	(void)tmp;
+	/*
+	 * Close notification fd so that we cannot block while reading
+	 * from it
+	 */
+	SAFE_CLOSE(fd_notify);
+	fd_notify = -1;
+}
+
+static void run_child(struct tcase *tc)
+{
+	struct sigaction child_action;
+
+	child_action.sa_handler = child_handler;
+	sigemptyset(&child_action.sa_mask);
+	child_action.sa_flags = SA_NOCLDSTOP;
+
+	if (sigaction(SIGCHLD, &child_action, NULL) < 0) {
+		tst_brk(TBROK | TERRNO,
+			"sigaction(SIGCHLD, &child_action, NULL) failed");
+	}
+
+	child_pid = SAFE_FORK();
+
+	if (child_pid == 0) {
+		/* Child will generate events now */
+		SAFE_CLOSE(fd_notify);
+		generate_events(tc);
+		exit(0);
+	}
+}
+
+static void check_child(void)
+{
+	struct sigaction child_action;
+	int child_ret;
+
+	child_action.sa_handler = SIG_IGN;
+	sigemptyset(&child_action.sa_mask);
+	child_action.sa_flags = SA_NOCLDSTOP;
+	if (sigaction(SIGCHLD, &child_action, NULL) < 0) {
+		tst_brk(TBROK | TERRNO,
+			"sigaction(SIGCHLD, &child_action, NULL) failed");
+	}
+	SAFE_WAITPID(-1, &child_ret, 0);
+
+	if (WIFEXITED(child_ret) && WEXITSTATUS(child_ret) == 0)
+		tst_res(TPASS, "child exited correctly");
+	else
+		tst_res(TFAIL, "child %s", tst_strstatus(child_ret));
+}
+
+static int setup_mark(unsigned int n)
+{
+	unsigned int i = 0;
+	struct tcase *tc = &tcases[n];
+	struct fanotify_mark_type *mark = &tc->mark;
+	char *const files[] = {fname, FILE_EXEC_PATH};
+
+	tst_res(TINFO, "Test #%d: %s", n, tc->tname);
+
+	fd_notify = SAFE_FANOTIFY_INIT(FAN_CLASS_PRE_CONTENT, O_RDONLY);
+
+	if (mark->flag == FAN_MARK_PARENT) {
+		SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_ADD | mark->flag,
+				   tc->mask, AT_FDCWD, MOUNT_PATH);
+		return 0;
+	}
+
+	for (; i < ARRAY_SIZE(files); i++) {
+		SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_ADD | mark->flag,
+				  tc->mask, AT_FDCWD, files[i]);
+	}
+
+	return 0;
+}
+
+static void test_fanotify(unsigned int n)
+{
+	int ret, len = 0, i = 0, test_num = 0;
+	struct tcase *tc = &tcases[n];
+	struct event *event_set = tc->event_set;
+
+	if (setup_mark(n) != 0)
+		return;
+
+	run_child(tc);
+
+	/*
+	 * Process events
+	 *
+	 * tc->count + 1 is to accommodate for checking the child process
+	 * return value
+	 */
+	while (test_num < tc->event_count + 1 && fd_notify != -1) {
+		struct fanotify_event_metadata *event;
+
+		if (i == len) {
+			/* Get more events */
+			ret = read(fd_notify, event_buf + len,
+				   EVENT_BUF_LEN - len);
+			if (fd_notify == -1)
+				break;
+			if (ret < 0) {
+				tst_brk(TBROK,
+					"read(%d, buf, %zu) failed",
+					fd_notify, EVENT_BUF_LEN);
+			}
+			len += ret;
+		}
+
+		event = (struct fanotify_event_metadata *)&event_buf[i];
+		/* Permission events cannot be merged, so the event mask
+		 * reported should exactly match the event mask within the
+		 * event set.
+		 */
+		if (event->mask != event_set[test_num].mask) {
+			tst_res(TFAIL,
+				"got event: mask=%llx (expected %llx) "
+				"pid=%u fd=%d",
+				(unsigned long long)event->mask,
+				event_set[test_num].mask,
+				(unsigned int)event->pid, event->fd);
+		} else if (event->pid != child_pid) {
+			tst_res(TFAIL,
+				"got event: mask=%llx pid=%u "
+				"(expected %u) fd=%d",
+				(unsigned long long)event->mask,
+				(unsigned int)event->pid,
+				(unsigned int)child_pid,
+				event->fd);
+		} else {
+			tst_res(TPASS,
+				"got event: mask=%llx pid=%u fd=%d",
+				(unsigned long long)event->mask,
+				(unsigned int)event->pid, event->fd);
+		}
+
+		/* Write response to the permission event */
+		if (event_set[test_num].mask &
+			(LTP_ALL_PERM_EVENTS | LTP_PRE_CONTENT_EVENTS)) {
+			struct fanotify_response resp;
+
+			resp.fd = event->fd;
+			resp.response = event_set[test_num].response;
+			SAFE_WRITE(SAFE_WRITE_ALL, fd_notify, &resp, sizeof(resp));
+			tst_res(TPASS, "response=%x fd=%d\n", resp.response, resp.fd);
+		}
+
+		i += event->event_len;
+
+		if (event->fd != FAN_NOFD) {
+			char c;
+
+			/* Verify that read from event fd does not generate events */
+			SAFE_READ(0, event->fd, &c, 1);
+			SAFE_CLOSE(event->fd);
+		}
+
+		test_num++;
+	}
+
+	for (; test_num < tc->event_count; test_num++) {
+		tst_res(TFAIL, "didn't get event: mask=%llx",
+			event_set[test_num].mask);
+
+	}
+
+	check_child();
+
+	if (fd_notify > 0)
+		SAFE_CLOSE(fd_notify);
+}
+
+static void setup(void)
+{
+	sprintf(fname, MOUNT_PATH"/fname_%d", getpid());
+	SAFE_FILE_PRINTF(fname, "1");
+
+	REQUIRE_FANOTIFY_EVENTS_SUPPORTED_ON_FS(FAN_CLASS_PRE_CONTENT, FAN_MARK_FILESYSTEM,
+						FAN_PRE_ACCESS, fname);
+
+	SAFE_CP(TEST_APP, FILE_EXEC_PATH);
+}
+
+static void cleanup(void)
+{
+	if (fd_notify > 0)
+		SAFE_CLOSE(fd_notify);
+}
+
+static const char *const resource_files[] = {
+	TEST_APP,
+	NULL
+};
+
+static struct tst_test test = {
+	.timeout = 1,
+	.test = test_fanotify,
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.cleanup = cleanup,
+	.forks_child = 1,
+	.needs_root = 1,
+	.mount_device = 1,
+	.all_filesystems = 1,
+	.mntpoint = MOUNT_PATH,
+	.resource_files = resource_files
+};
+
+#else
+	TST_TEST_TCONF("system doesn't have required fanotify support");
+#endif
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
