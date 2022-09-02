Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55198C54EE9
	for <ltp@archiver.kernel.org>; Fri,  2 Sep 2022 08:17:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7CED43CA8C5
	for <ltp@archiver.kernel.org>; Fri,  2 Sep 2022 10:17:28 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4A8B73CA72B
 for <ltp@lists.linux.it>; Fri,  2 Sep 2022 10:17:19 +0200 (CEST)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3CE96600BFA
 for <ltp@lists.linux.it>; Fri,  2 Sep 2022 10:17:18 +0200 (CEST)
Received: by mail-qt1-x834.google.com with SMTP id e28so943805qts.1
 for <ltp@lists.linux.it>; Fri, 02 Sep 2022 01:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
 bh=PvVnjFKZv++wTrfy1n1uBxpIqTxk5hr72Mojv+G1W2M=;
 b=a94QJPIx/BDkTx+F/Wp+G/M7OrG4/KRQ2+Ftwvuvux17iqpgmwQLc1Vv0BsSbM7NE2
 fbTXTXx+MXO7UklKGohTOvimr0GAOtOyZOP7o+vZ64Oh9C45ib71j97DVPn2UCrxumBO
 Jg3ri2YGev3OOORG/Q2SW6HriuV/JACPM+dZHLuakgsa9+t58mXKIZ86ZtdtvxznNbgh
 GUl9HElwjM4WYm181+/lLN+k0sQQjkWaNIoREjm0SBtwuMegHePdSkbunuKLkcefzx+h
 cphGYkaICH8SqqQi80gGYkhpvPxN9Xty62mM0YhelHf7NsRXXoNEmoIdX/WXWAYgmkXj
 8rcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date;
 bh=PvVnjFKZv++wTrfy1n1uBxpIqTxk5hr72Mojv+G1W2M=;
 b=v9lm9fSFzmVlqW+kZkupM453n68BXc8of5J6OPDAJ6SZ5spkwjHFKOlFsmAgfcV4RO
 3LnjYtUXqsVmBb611xG/okA1A3J3rvma8kjrV6SbCSSjhkkwSom+ABv+psNqkJL+bHwA
 SYZlOPTo+pBp0IDp4LwRa1JBagRcum6irUy2x3vGkCo8JRrYtUYXyDZEpsscec2qJIaZ
 xqKnPkU+bdTlY8E/K22hUna1kXiWQdE28zn9ARXKHsDtbS/IrjVHWpCp0UgON5uoNYPo
 /V/QtkrDutYyB1CfmwAldBQLSPDMrYmoZfEa4Pjv8QE04A6TAyq5y20wN5OHIISE4qY9
 2qPQ==
X-Gm-Message-State: ACgBeo31guuedfPXMO5pItVbZmV8PCQeqIqoitqESKr7L12VUGKmowgp
 TDmBf0so9r7RXukW6/IE7SRiG2xX97m2bQ==
X-Google-Smtp-Source: AA6agR7RUtM7oC6pBnDY6ZVKUVTqvp2toGiAHpOIsA3ESHpxbO7z+61H+bm0j/EUTWb55InuNrwCNg==
X-Received: by 2002:a05:622a:290:b0:344:85a7:82be with SMTP id
 z16-20020a05622a029000b0034485a782bemr26980475qtw.687.1662106636651; 
 Fri, 02 Sep 2022 01:17:16 -0700 (PDT)
Received: from xzhouw.hosts.qa.psi.rdu2.redhat.com ([66.187.232.127])
 by smtp.gmail.com with ESMTPSA id
 m8-20020ac866c8000000b003445d06a622sm638689qtp.86.2022.09.02.01.17.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Sep 2022 01:17:16 -0700 (PDT)
From: Murphy Zhou <jencce.kernel@gmail.com>
To: ltp@lists.linux.it
Date: Fri,  2 Sep 2022 16:17:11 +0800
Message-Id: <20220902081711.1776943-1-jencce.kernel@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <YipkOjYIeY4NbQuh@pevik>
References: <YipkOjYIeY4NbQuh@pevik>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] kernel/fs/fsnotify-stress: fsnotify stress test
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

This is a stress test that exercises fanotify and inotify interfaces
while IO going on. It intentionally ignores failures or return values
of some syscalls to let the stress go on. If the kernel does not panic
or hang after a certain period of time of testing, test pass.

Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
---
v3 -> v4:
	Convert comment to docparse part.

 runtest/fs                                    |   2 +
 testcases/kernel/fs/fsnotify-stress/Makefile  |   9 +
 .../fs/fsnotify-stress/fsnotify-stress.c      | 476 ++++++++++++++++++
 3 files changed, 487 insertions(+)
 create mode 100644 testcases/kernel/fs/fsnotify-stress/Makefile
 create mode 100644 testcases/kernel/fs/fsnotify-stress/fsnotify-stress.c

diff --git a/runtest/fs b/runtest/fs
index 1d753e0dd..beb43aae4 100644
--- a/runtest/fs
+++ b/runtest/fs
@@ -87,3 +87,5 @@ binfmt_misc01 binfmt_misc01.sh
 binfmt_misc02 binfmt_misc02.sh
 
 squashfs01 squashfs01
+
+fsnotify-stress fsnotify-stress
diff --git a/testcases/kernel/fs/fsnotify-stress/Makefile b/testcases/kernel/fs/fsnotify-stress/Makefile
new file mode 100644
index 000000000..451f791f1
--- /dev/null
+++ b/testcases/kernel/fs/fsnotify-stress/Makefile
@@ -0,0 +1,9 @@
+#
+#    kernel/fs/fs-notify testcases Makefile.
+#
+
+top_srcdir	?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/fs/fsnotify-stress/fsnotify-stress.c b/testcases/kernel/fs/fsnotify-stress/fsnotify-stress.c
new file mode 100644
index 000000000..8130f7f12
--- /dev/null
+++ b/testcases/kernel/fs/fsnotify-stress/fsnotify-stress.c
@@ -0,0 +1,476 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2022 Red Hat, Inc.  All Rights Reserved.
+ * Author: Murphy Zhou <jencce.kernel@gmail.com>
+ * Copyright (c) Linux Test Project, 2001-2022
+ */
+
+/*\
+ * [Description]
+ *
+ * This is an irregular stress test for Linux kernel fanotify/inotify
+ * interfaces. It calls thoese interfaces with possible best coverage
+ * arguments, in a loop. It ignores some return values in the loop to
+ * let the stress going on. At the same time, it initiates IO traffics
+ * by calling IO syscalls.
+ *
+ * If kernel does no panic or hang after the test, test pass.
+ *
+ * It detected a leak in fsnotify code which was fixed by Amir through
+ * this Linux commit:
+ *     4396a731 fsnotify: fix sb_connectors leak
+ *
+ */
+
+#define _GNU_SOURCE     /* Needed to get O_LARGEFILE definition */
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <poll.h>
+#include <sys/fanotify.h>
+#include <sys/inotify.h>
+#include <sys/time.h>
+#include <unistd.h>
+#include <string.h>
+
+#include "tst_test.h"
+#include "../../syscalls/fanotify/fanotify.h"
+#include "../../syscalls/inotify/inotify.h"
+
+static int fd0;
+
+#define TESTDIR "testdir"
+#define TESTFILE "testdir/file"
+
+static void cleanup(void)
+{
+	if (fd0 > 0) {
+		SAFE_CLOSE(fd0);
+	}
+}
+
+static void setup(void)
+{
+	SAFE_MKDIR(TESTDIR, 0777);
+	fd0 = SAFE_OPEN(TESTFILE, O_CREAT|O_RDWR, 0666);
+}
+
+static void fanotify_flushes(char *fn)
+{
+	int fd;
+
+	fd = SAFE_FANOTIFY_INIT(FAN_CLOEXEC | FAN_CLASS_CONTENT | FAN_NONBLOCK,
+					   O_RDONLY | O_LARGEFILE);
+
+	while (tst_remaining_runtime() > 10) {
+		/* As a stress test, we ignore the return values here to
+		 * proceed with the stress.
+		 */
+		fanotify_mark(fd, FAN_MARK_ADD | FAN_MARK_MOUNT,
+			  FAN_ACCESS | FAN_MODIFY | FAN_OPEN_PERM | FAN_CLOSE |
+			  FAN_OPEN | FAN_ACCESS_PERM | FAN_ONDIR |
+			  FAN_EVENT_ON_CHILD, -1, fn);
+
+		fanotify_mark(fd, FAN_MARK_FLUSH | FAN_MARK_MOUNT,
+						0, -1, fn);
+
+		fanotify_mark(fd, FAN_MARK_ADD | FAN_MARK_MOUNT,
+			  FAN_ACCESS | FAN_MODIFY | FAN_OPEN_PERM | FAN_CLOSE |
+			  FAN_OPEN | FAN_ACCESS_PERM | FAN_ONDIR |
+			  FAN_EVENT_ON_CHILD, -1, fn);
+
+		fanotify_mark(fd, FAN_MARK_FLUSH, 0, -1, fn);
+	}
+
+	close(fd);
+	exit(EXIT_SUCCESS);
+}
+
+static void fanotify_inits(char *fn)
+{
+	int fd;
+
+	while (tst_remaining_runtime() > 10) {
+		/* As a stress test, we ignore the return values here to
+		 * proceed with the stress.
+		 */
+		fd = fanotify_init(FAN_CLOEXEC | FAN_CLASS_CONTENT |
+				FAN_NONBLOCK, O_RDONLY | O_LARGEFILE);
+		fanotify_mark(fd, FAN_MARK_ADD | FAN_MARK_MOUNT,
+				FAN_ACCESS | FAN_MODIFY | FAN_OPEN_PERM |
+				FAN_CLOSE | FAN_OPEN | FAN_ACCESS_PERM |
+				FAN_ONDIR | FAN_EVENT_ON_CHILD, -1, fn);
+		close(fd);
+	}
+	exit(EXIT_SUCCESS);
+}
+
+static void add_mark(int fd, uint64_t mask, char *path)
+{
+	fanotify_mark(fd, FAN_MARK_ADD, mask, -1, path);
+}
+
+static void remove_mark(int fd, uint64_t mask, char *path)
+{
+	fanotify_mark(fd, FAN_MARK_REMOVE, mask, -1, path);
+}
+
+static void fanotify_marks(char *fn)
+{
+	int fd;
+
+	fd = SAFE_FANOTIFY_INIT(FAN_CLOEXEC | FAN_CLASS_CONTENT | FAN_NONBLOCK,
+					   O_RDONLY | O_LARGEFILE);
+	while (tst_remaining_runtime() > 10) {
+		add_mark(fd, FAN_ACCESS, fn);
+		remove_mark(fd, FAN_ACCESS, fn);
+		add_mark(fd, FAN_MODIFY, fn);
+		remove_mark(fd, FAN_MODIFY, fn);
+		add_mark(fd, FAN_OPEN_PERM, fn);
+		remove_mark(fd, FAN_OPEN_PERM, fn);
+		add_mark(fd, FAN_CLOSE, fn);
+		remove_mark(fd, FAN_CLOSE, fn);
+		add_mark(fd, FAN_OPEN, fn);
+		remove_mark(fd, FAN_OPEN, fn);
+		add_mark(fd, FAN_ACCESS_PERM, fn);
+		remove_mark(fd, FAN_ACCESS_PERM, fn);
+		add_mark(fd, FAN_ONDIR, fn);
+		remove_mark(fd, FAN_ONDIR, fn);
+		add_mark(fd, FAN_EVENT_ON_CHILD, fn);
+		remove_mark(fd, FAN_EVENT_ON_CHILD, fn);
+	}
+	close(fd);
+	exit(EXIT_SUCCESS);
+}
+
+/* Read all available fanotify events from the file descriptor 'fd' */
+static void fa_handle_events(int fd)
+{
+	const struct fanotify_event_metadata *metadata;
+	struct fanotify_event_metadata buf[200];
+	ssize_t len;
+	struct fanotify_response response;
+
+	/* Loop while events can be read from fanotify file descriptor */
+	for (;;) {
+		/* Read some events */
+		len = read(fd, (void *) &buf, sizeof(buf));
+		if (len == -1 && errno != EAGAIN)
+			tst_brk(TBROK | TERRNO, "fanotify read events failed");
+		/* Check if end of available data reached */
+		if (len <= 0)
+			break;
+		/* Point to the first event in the buffer */
+		metadata = buf;
+		/* Loop over all events in the buffer */
+		while (FAN_EVENT_OK(metadata, len)) {
+			if (metadata->vers != FANOTIFY_METADATA_VERSION) {
+				tst_brk(TBROK | TERRNO,
+				"Mismatch of fanotify metadata version.\n");
+			}
+			/* metadata->fd contains either FAN_NOFD, indicating a
+			 * queue overflow, or a file descriptor (a nonnegative
+			 * integer). Here, we simply ignore queue overflow.
+			 */
+			if (metadata->fd >= 0) {
+				/* Handle open permission event */
+				if (metadata->mask & FAN_OPEN_PERM) {
+					/* Allow file to be opened */
+					response.fd = metadata->fd;
+					response.response = FAN_ALLOW;
+					write(fd, &response,
+					    sizeof(struct fanotify_response));
+				}
+
+				/* Handle access permission event */
+				if (metadata->mask & FAN_ACCESS_PERM) {
+					/* Allow file to be accessed */
+					response.fd = metadata->fd;
+					response.response = FAN_ALLOW;
+					write(fd, &response,
+					    sizeof(struct fanotify_response));
+				}
+				/* Ignore read/write access events */
+				/* Close the file descriptor of the event */
+				close(metadata->fd);
+			}
+			/* Advance to next event */
+			metadata = FAN_EVENT_NEXT(metadata, len);
+		}
+	}
+}
+
+/* This is from fanotify(7) man page example */
+static void fanotify_watch(void)
+{
+	int fd, poll_num, ecnt = 0;
+	nfds_t nfds;
+	struct pollfd fds[2];
+
+	fd = SAFE_FANOTIFY_INIT(FAN_CLOEXEC | FAN_CLASS_CONTENT | FAN_NONBLOCK,
+					   O_RDONLY | O_LARGEFILE);
+	/* Mark the mount for:
+	 * - permission events before opening files
+	 * - notification events after closing a write-enabled file descriptor
+	 */
+	SAFE_FANOTIFY_MARK(fd, FAN_MARK_ADD | FAN_MARK_MOUNT,
+			FAN_ACCESS | FAN_MODIFY | FAN_OPEN_PERM |
+			FAN_CLOSE | FAN_OPEN | FAN_ACCESS_PERM |
+			FAN_ONDIR | FAN_EVENT_ON_CHILD, -1, "/");
+
+	nfds = 1;
+	fds[0].fd = fd;
+	fds[0].events = POLLIN;
+
+	while (tst_remaining_runtime() > 10) {
+		poll_num = poll(fds, nfds, 10);
+		if (poll_num == -1)
+			tst_brk(TBROK | TERRNO, "fanotify watch poll failed");
+		if (poll_num > 0) {
+			if (fds[0].revents & POLLIN) {
+				/* Fanotify events are available */
+				fa_handle_events(fd);
+				ecnt++;
+			}
+		}
+	}
+	tst_printf("Got %d fanotify events\n", ecnt);
+	tst_flush();
+	exit(EXIT_SUCCESS);
+}
+
+static void freadfiles(char *fn)
+{
+	char buf[BUFSIZ];
+	FILE *f;
+
+	memset(buf, 1, BUFSIZ);
+	while (tst_remaining_runtime() > 10) {
+		f = fopen(fn, "r+");
+		if (f == NULL)
+			continue;
+		fread(buf, sizeof(char), BUFSIZ, f);
+		usleep(1);
+		fclose(f);
+	}
+}
+
+static void fwritefiles(char *fn)
+{
+	char buf[BUFSIZ];
+	FILE *f;
+
+	memset(buf, 1, BUFSIZ);
+	while (tst_remaining_runtime() > 10) {
+		f = fopen(fn, "w+");
+		if (f == NULL)
+			continue;
+		fwrite(buf, sizeof(char), BUFSIZ, f);
+		usleep(1);
+		fclose(f);
+	}
+}
+
+static void readfiles(char *fn)
+{
+	int fd;
+	char buf[BUFSIZ];
+
+	memset(buf, 1, BUFSIZ);
+	while (tst_remaining_runtime() > 10) {
+		fd = open(fn, O_RDONLY);
+		if (fd == -1)
+			continue;
+		read(fd, buf, BUFSIZ);
+		usleep(1);
+		close(fd);
+	}
+}
+
+static void writefiles(char *fn)
+{
+	int fd;
+	char buf[BUFSIZ];
+
+	memset(buf, 1, BUFSIZ);
+	while (tst_remaining_runtime() > 10) {
+		fd = open(fn, O_RDWR);
+		if (fd == -1)
+			continue;
+		write(fd, buf, BUFSIZ);
+		usleep(1);
+		close(fd);
+	}
+}
+
+static void inotify_add_rm(char *fn)
+{
+	int notify_fd;
+	int wd;
+
+	notify_fd = SAFE_MYINOTIFY_INIT1(IN_CLOEXEC);
+
+	while (tst_remaining_runtime() > 10) {
+		wd = inotify_add_watch(notify_fd, fn,
+			IN_ACCESS | IN_ATTRIB | IN_CLOSE_WRITE |
+			IN_CLOSE_NOWRITE | IN_CREATE | IN_DELETE |
+			IN_DELETE_SELF | IN_MODIFY | IN_MOVE_SELF |
+			IN_MOVED_FROM | IN_MOVED_TO | IN_OPEN);
+
+		inotify_rm_watch(notify_fd, wd);
+	}
+	close(notify_fd);
+}
+
+static void inotify_inits(void)
+{
+	int notify_fd;
+
+	while (tst_remaining_runtime() > 10) {
+		notify_fd = inotify_init1(IN_CLOEXEC);
+		close(notify_fd);
+	}
+}
+
+static void inotify_add_rm_watches(char *fn)
+{
+	int fd, wd;
+
+	fd = SAFE_MYINOTIFY_INIT();
+
+	while (tst_remaining_runtime() > 10) {
+		wd = inotify_add_watch(fd, fn, IN_MODIFY);
+		inotify_rm_watch(fd, wd);
+	}
+	close(fd);
+}
+
+static void i_handle_events(int fd)
+{
+	char buf[4096]
+		__attribute__((aligned(__alignof__(struct inotify_event))));
+	ssize_t len;
+
+	/* Loop while events can be read from inotify file descriptor. */
+	for (;;) {
+		len = read(fd, buf, sizeof(buf));
+		if (len == -1 && errno != EAGAIN)
+			tst_brk(TBROK | TERRNO, "inotify read event failed");
+		/* If the nonblocking read() found no events to read, then
+		 * it returns -1 with errno set to EAGAIN. In that case,
+		 * we exit the loop.
+		 */
+		if (len <= 0)
+			break;
+	}
+}
+
+static void inotify_watch(char *fn)
+{
+	int fd, poll_num, wd, ecnt = 0;
+	nfds_t nfds;
+	struct pollfd fds[2];
+
+	fd = SAFE_MYINOTIFY_INIT1(IN_NONBLOCK);
+
+	/* Mark directories for events
+	 * - file was opened
+	 * - file was closed
+	 */
+	wd = SAFE_MYINOTIFY_ADD_WATCH(fd, fn, IN_OPEN | IN_CLOSE);
+
+	nfds = 2;
+	fds[0].fd = STDIN_FILENO;       /* Console input */
+	fds[0].events = POLLIN;
+	fds[1].fd = fd;                 /* Inotify input */
+	fds[1].events = POLLIN;
+
+	/* Wait for events and/or terminal input. */
+	while (tst_remaining_runtime() > 10) {
+		poll_num = poll(fds, nfds, 10);
+		if (poll_num == -1)
+			tst_brk(TBROK | TERRNO, "inotify watch poll failed");
+		if (poll_num > 0) {
+			if (fds[1].revents & POLLIN) {
+				/* Inotify events are available. */
+				i_handle_events(fd);
+				ecnt++;
+			}
+		}
+	}
+
+	inotify_rm_watch(fd, wd);
+	close(fd);
+	tst_printf("Got %d inotify events\n", ecnt);
+	tst_flush();
+	exit(EXIT_SUCCESS);
+}
+
+struct tcase {
+	char *desc;
+	void (*func_test)(char *fn);
+	int ondir;  /* run stress on directory */
+	int onfile;  /* run stress on file */
+};
+static struct tcase tcases[] = {
+	{"fanotify_flush stress", fanotify_flushes, 1, 1},
+	{"fanotify_init stress", fanotify_inits, 1, 1},
+	{"fanotify_mark stress", fanotify_marks, 1, 1},
+	{"fanotify watching stress", fanotify_watch, 1, 0},
+	{"fread stress", freadfiles, 0, 1},
+	{"fwrite stress", fwritefiles, 0, 1},
+	{"inotify add rm stress", inotify_add_rm, 1, 1},
+	{"inotify init stress", inotify_inits, 1, 1},
+	{"inotify add rm watch stress", inotify_add_rm_watches, 1, 1},
+	{"inotify watching stress", inotify_watch, 1, 0},
+	{"read stress", readfiles, 0, 1},
+	{"write stress", writefiles, 0, 1}
+};
+
+static void run(void)
+{
+	int tcnt = ARRAY_SIZE(tcases);
+	int i = 0;
+	const struct tst_clone_args args = {
+		.exit_signal = SIGCHLD,
+	};
+
+	tst_res(TINFO, "Starting %d stresses\n", tcnt);
+
+	while (i < tcnt) {
+		if (tcases[i].ondir && !SAFE_CLONE(&args)) {
+			tst_res(TINFO, "Starting %s on dir\n", tcases[i].desc);
+			tcases[i].func_test(TESTDIR);
+			tst_res(TINFO, "Ending %s on dir\n", tcases[i].desc);
+			tst_flush();
+			exit(EXIT_SUCCESS);
+		}
+		if (tcases[i].onfile && !SAFE_CLONE(&args)) {
+			tst_res(TINFO, "Starting %s on file\n", tcases[i].desc);
+			tcases[i].func_test(TESTFILE);
+			tst_res(TINFO, "Ending %s on file\n", tcases[i].desc);
+			exit(EXIT_SUCCESS);
+		}
+		i++;
+	}
+	tst_reap_children();
+	tst_res(TPASS, "No panic no hang, test PASS");
+}
+
+static struct tst_test test = {
+	.tcnt = 1,
+	.max_runtime = 60,
+	.forks_child = 1,
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.test = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "4396a731 "},
+		{},
+	},
+};
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
