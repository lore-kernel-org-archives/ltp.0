Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99CA8C433EF
	for <ltp@archiver.kernel.org>; Thu,  3 Mar 2022 03:06:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EDEF93C9D4E
	for <ltp@archiver.kernel.org>; Thu,  3 Mar 2022 04:06:37 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9A4E33C9AEA
 for <ltp@lists.linux.it>; Thu,  3 Mar 2022 04:06:27 +0100 (CET)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0D9B6600C60
 for <ltp@lists.linux.it>; Thu,  3 Mar 2022 04:06:26 +0100 (CET)
Received: by mail-qt1-x831.google.com with SMTP id c4so3553871qtx.1
 for <ltp@lists.linux.it>; Wed, 02 Mar 2022 19:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=VMvdmIGrg/FgG35VtFp2fxr9hG52ptmPvosEW2W69Fs=;
 b=XgllRSGawFNjYJSeruqgl5BKsE5eiSo+ARxwOJ1QKv6vdbnd1wtLbY7xKD2nKy230q
 I5HB8f5boMEMPmPK33PSxMcO2BuQOSpxUL7pO5+zFfPj2AhiNO6ISqYgHnoUEv/bcA0m
 OtUseeO2iIFNmSjd+gKPMSwPys9zgSUJOslptIAJ3V/0zjAyALLQ/g2XiIGfsHW3iwC2
 W0/wcZL8gMAjXGHLNapfIWLl7S8GYdq9pGu4dJjJjf1sGblTQpjbzmYG1ER6BZWzOlRJ
 0nfUx6rfLS9Cr5VAlBleSiLsvyp7gd6KXxoAfmxw6mIvVvf80LlwoAaTy9ofQZ6mXu2j
 xJrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=VMvdmIGrg/FgG35VtFp2fxr9hG52ptmPvosEW2W69Fs=;
 b=TFf47exoifN1Bgh28Cwubid9r7LzzNuassIASlth0g6ffquIrATfcewPi4AexNa5OX
 gFliU/1lSgU6Fx7A+zfZalfqwuxY0qy0HBX5Fpjwz4mztYYL+joSUJlu4vOAEQSo1y1n
 lQMAcr/SnrwqubIqTWXcW4dMggXEBUKCt7Za/siSq6m4ruvqRjzxpV6zbQu8zqBm92dQ
 0KkjXqiU1fTkU3AF2ggeJdDYsLgTQFpsCSVdvt2PXRGjM3urBqKt2/0tLEAAgHWCFpL/
 ILWWaxjx1j/LdSKiUltBSrL+tWsqTLpF7dD8rCDAZ6zcnCxV+zoou2Lv7+7OgTiWf4xn
 qekQ==
X-Gm-Message-State: AOAM533wtBkPwNzypTl/cOPOiNLR+jE/p6OtGSHihJvI9VKkUf4i79Yj
 2HHrvd9TF/HNbvQjYLJn2bs=
X-Google-Smtp-Source: ABdhPJzNwtaHykgQMifKwa19BvmzuYrS/PdvUG7aYXZBG55eVKFaWVJ1gieMrNlnXIrvKzB6m28Tzg==
X-Received: by 2002:ac8:5a48:0:b0:2e0:198:1924 with SMTP id
 o8-20020ac85a48000000b002e001981924mr15829723qta.481.1646276784404; 
 Wed, 02 Mar 2022 19:06:24 -0800 (PST)
Received: from xzhouw.hosts.qa.psi.rdu2.redhat.com ([66.187.232.127])
 by smtp.gmail.com with ESMTPSA id
 y16-20020a05622a121000b002deaa0af9e2sm635753qtx.49.2022.03.02.19.06.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Mar 2022 19:06:23 -0800 (PST)
Date: Thu, 3 Mar 2022 11:06:23 +0800
From: Murphy Zhou <jencce.kernel@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YiAqwHabM9qCUjAU@xzhouw.hosts>
References: <20220125024718.jszwoussimqk6trf@xzhoux.usersys.redhat.com>
 <Ye/ZOo2tlA+Jf+Cf@yuki>
 <CADJHv_tRGHhLg2YLssu8hQpNU_PLa_iD1qhMWadBRpbTatoFiA@mail.gmail.com>
 <Yhxu8elhUJakYJHH@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yhxu8elhUJakYJHH@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] kernel/fs/fsnotify-stress: fsnotify stress test
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This is a stress tests that exercises fanotify and inotify interfaces
while IO going on. It ignores some failures of syscalls to let the
stress go on. If the kernel does not panic or hang after a certain
period of time of testing, test pass.

Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
---
v2:
	Merge all into one C programme.
	Changed dirname of the testcase.
	Run fs_racer.sh from this.

 runtest/fs                                    |   2 +
 testcases/kernel/fs/fsnotify-stress/Makefile  |  13 +
 .../fs/fsnotify-stress/fsnotify-stress.c      | 671 ++++++++++++++++++
 3 files changed, 686 insertions(+)
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
index 000000000..cf4a28e42
--- /dev/null
+++ b/testcases/kernel/fs/fsnotify-stress/Makefile
@@ -0,0 +1,13 @@
+#
+#    kernel/fs/fs-notify testcases Makefile.
+#
+
+top_srcdir	?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+INSTALL_TARGETS	:= fsnotify-stress
+
+MAKE_TARGETS	:= fsnotify-stress
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/fs/fsnotify-stress/fsnotify-stress.c b/testcases/kernel/fs/fsnotify-stress/fsnotify-stress.c
new file mode 100644
index 000000000..229b10c17
--- /dev/null
+++ b/testcases/kernel/fs/fsnotify-stress/fsnotify-stress.c
@@ -0,0 +1,671 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * This is an irregular stress test for Linux kernel fanotify/inotify
+ * interfaces. It calls thoese interfaces with possible best coverage
+ * arguments, in a loop. It ignores some return values in the loop to
+ * let the stress going on. At the same time, it initiates IO traffics
+ * by calling IO functions and fs_racer.sh in LTP.
+ *
+ * If kernel does no panic or hang after the test, test pass.
+ *
+ * It detected a leak in fsnotify code which was fixed by Amir through
+ * this Linux commit:
+ *     4396a731 fsnotify: fix sb_connectors leak
+ *
+ * Author: Murphy Zhou <jencce.kernel@gmail.com>
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
+static char *str_timeout;
+static int arg_timeout = 60;
+
+#define TESTDIR "testdir"
+#define TESTFILE "testdir/file"
+
+static void cleanup(void)
+{
+	if (fd0 > 0) {
+		SAFE_CLOSE(fd0);
+		SAFE_UNLINK(TESTFILE);
+	}
+	SAFE_RMDIR(TESTDIR);
+}
+
+static void setup(void)
+{
+	if (tst_parse_int(str_timeout, &arg_timeout, 1, INT_MAX))
+		tst_brk(TBROK, "Invalid timeout '%s'", str_timeout);
+	SAFE_MKDIR(TESTDIR, 0777);
+	fd0 = SAFE_OPEN(TESTFILE, O_CREAT|O_RDWR, 0666);
+}
+
+static void fanotify_flushes(char *fn, unsigned int timeout)
+{
+	int fd, ret;
+	struct timeval ts;
+	struct timeval te;
+
+	/* Create the file descriptor for accessing the fanotify API */
+	fd = SAFE_FANOTIFY_INIT(FAN_CLOEXEC | FAN_CLASS_CONTENT | FAN_NONBLOCK,
+					   O_RDONLY | O_LARGEFILE);
+
+	ret = gettimeofday(&ts, NULL);
+	if (ret == -1)
+		tst_brk(TBROK | TERRNO, "gettimeofday failed");
+
+	/* Loop marking all kinds of events and flush */
+	while (1) {
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
+
+		ret = gettimeofday(&te, NULL);
+		if (ret == -1)
+			tst_brk(TBROK | TERRNO, "gettimeofday failed");
+		if (te.tv_sec - ts.tv_sec > timeout)
+			break;
+	}
+
+	close(fd);
+	exit(EXIT_SUCCESS);
+}
+
+static void fanotify_inits(char *fn, unsigned int timeout)
+{
+	int fd, ret;
+	struct timeval ts;
+	struct timeval te;
+
+	ret = gettimeofday(&ts, NULL);
+	if (ret == -1)
+		tst_brk(TBROK | TERRNO, "gettimeofday failed");
+
+	while (1) {
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
+		ret = gettimeofday(&te, NULL);
+		if (ret == -1)
+			tst_brk(TBROK | TERRNO, "gettimeofday failed");
+		if (te.tv_sec - ts.tv_sec > timeout)
+			break;
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
+static void fanotify_marks(char *fn, unsigned int timeout)
+{
+	int fd, ret;
+	struct timeval ts;
+	struct timeval te;
+
+	/* Create the file descriptor for accessing the fanotify API */
+	fd = SAFE_FANOTIFY_INIT(FAN_CLOEXEC | FAN_CLASS_CONTENT | FAN_NONBLOCK,
+					   O_RDONLY | O_LARGEFILE);
+	ret = gettimeofday(&ts, NULL);
+	if (ret == -1)
+		tst_brk(TBROK | TERRNO, "gettimeofday failed");
+	/* Loop marking all kinds of events */
+	while (1) {
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
+		ret = gettimeofday(&te, NULL);
+		if (ret == -1)
+			tst_brk(TBROK | TERRNO, "gettimeofday failed");
+		if (te.tv_sec - ts.tv_sec > timeout)
+			break;
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
+static void fanotify_watch(char *fn, unsigned int timeout)
+{
+	int fd, poll_num, ret, ecnt = 0;
+	nfds_t nfds;
+	struct pollfd fds[2];
+	struct timeval ts;
+	struct timeval te;
+
+	/* Create the file descriptor for accessing the fanotify API */
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
+	/* Prepare for polling */
+	nfds = 1;
+	/* Fanotify input */
+	fds[0].fd = fd;
+	fds[0].events = POLLIN;
+
+	ret = gettimeofday(&ts, NULL);
+	if (ret == -1)
+		tst_brk(TBROK | TERRNO, "gettimeofday failed");
+
+	/* This is the loop to wait for incoming events */
+	while (1) {
+		poll_num = poll(fds, nfds, timeout/2);
+		if (poll_num == -1)
+			tst_brk(TBROK | TERRNO, "fanotify watch poll failed");
+		if (poll_num > 0) {
+			if (fds[0].revents & POLLIN) {
+				/* Fanotify events are available */
+				fa_handle_events(fd);
+				ecnt++;
+			}
+		}
+		ret = gettimeofday(&te, NULL);
+		if (ret == -1)
+			tst_brk(TBROK | TERRNO, "gettimeofday failed");
+		if (te.tv_sec - ts.tv_sec > timeout)
+			break;
+	}
+	tst_printf("Got %d fanotify events\n", ecnt);
+	tst_flush();
+	exit(EXIT_SUCCESS);
+}
+
+static void freadfiles(char *fn, unsigned int timeout)
+{
+	int ret;
+	char buf[BUFSIZ];
+	FILE *f;
+	struct timeval ts;
+	struct timeval te;
+
+	ret = gettimeofday(&ts, NULL);
+	if (ret == -1)
+		tst_brk(TBROK | TERRNO, "gettimeofday failed");
+
+	memset(buf, 1, BUFSIZ);
+	while (1) {
+		f = fopen(fn, "r+");
+		if (f == NULL) {
+			ret = gettimeofday(&te, NULL);
+			if (ret == -1)
+				tst_brk(TBROK | TERRNO, "gettimeofday failed");
+			if (te.tv_sec - ts.tv_sec > timeout)
+				break;
+			continue;
+		}
+		ret = fread(buf, sizeof(char), BUFSIZ, f);
+		usleep(1);
+		fclose(f);
+		ret = gettimeofday(&te, NULL);
+		if (ret == -1)
+			tst_brk(TBROK | TERRNO, "gettimeofday failed");
+		if (te.tv_sec - ts.tv_sec > timeout)
+			break;
+	}
+}
+
+static void fwritefiles(char *fn, unsigned int timeout)
+{
+	int ret;
+	char buf[BUFSIZ];
+	FILE *f;
+	struct timeval ts;
+	struct timeval te;
+
+	ret = gettimeofday(&ts, NULL);
+	if (ret == -1)
+		tst_brk(TBROK | TERRNO, "gettimeofday failed");
+
+	memset(buf, 1, BUFSIZ);
+	while (1) {
+		f = fopen(fn, "w+");
+		if (f == NULL) {
+			ret = gettimeofday(&te, NULL);
+			if (ret == -1)
+				tst_brk(TBROK | TERRNO, "gettimeofday failed");
+			if (te.tv_sec - ts.tv_sec > timeout)
+				break;
+			continue;
+		}
+		fwrite(buf, sizeof(char), BUFSIZ, f);
+		usleep(1);
+		fclose(f);
+		ret = gettimeofday(&te, NULL);
+		if (ret == -1)
+			tst_brk(TBROK | TERRNO, "gettimeofday failed");
+		if (te.tv_sec - ts.tv_sec > timeout)
+			break;
+	}
+}
+
+static void readfiles(char *fn, unsigned int timeout)
+{
+	int fd, ret;
+	char buf[BUFSIZ];
+	struct timeval ts;
+	struct timeval te;
+
+	ret = gettimeofday(&ts, NULL);
+	if (ret == -1)
+		tst_brk(TBROK | TERRNO, "gettimeofday failed");
+
+	memset(buf, 1, BUFSIZ);
+	while (1) {
+		fd = open(fn, O_RDONLY);
+		if (fd == -1) {
+			ret = gettimeofday(&te, NULL);
+			if (ret == -1)
+				tst_brk(TBROK | TERRNO, "gettimeofday failed");
+			if (te.tv_sec - ts.tv_sec > timeout)
+				break;
+			continue;
+		}
+		ret = read(fd, buf, BUFSIZ);
+		usleep(1);
+		close(fd);
+		ret = gettimeofday(&te, NULL);
+		if (ret == -1)
+			tst_brk(TBROK | TERRNO, "gettimeofday failed");
+		if (te.tv_sec - ts.tv_sec > timeout)
+			break;
+	}
+}
+
+static void writefiles(char *fn, unsigned int timeout)
+{
+	int ret, fd;
+	char buf[BUFSIZ];
+	struct timeval ts;
+	struct timeval te;
+
+	ret = gettimeofday(&ts, NULL);
+	if (ret == -1)
+		tst_brk(TBROK | TERRNO, "gettimeofday failed");
+
+	memset(buf, 1, BUFSIZ);
+	while (1) {
+		fd = open(fn, O_RDWR);
+		if (fd == -1) {
+			ret = gettimeofday(&te, NULL);
+			if (ret == -1)
+				tst_brk(TBROK | TERRNO, "gettimeofday failed");
+			if (te.tv_sec - ts.tv_sec > timeout)
+				break;
+			continue;
+		}
+		ret = write(fd, buf, BUFSIZ);
+		usleep(1);
+		close(fd);
+		ret = gettimeofday(&te, NULL);
+		if (ret == -1)
+			tst_brk(TBROK | TERRNO, "gettimeofday failed");
+		if (te.tv_sec - ts.tv_sec > timeout)
+			break;
+	}
+}
+
+static void inotify_add_rm(char *fn, unsigned int timeout)
+{
+	int notify_fd;
+	int wd, ret;
+	struct timeval ts;
+	struct timeval te;
+
+	notify_fd = SAFE_MYINOTIFY_INIT1(IN_CLOEXEC);
+
+	ret = gettimeofday(&ts, NULL);
+	if (ret == -1)
+		tst_brk(TBROK | TERRNO, "gettimeofday failed");
+
+	while (1) {
+		wd = inotify_add_watch(notify_fd, fn,
+			IN_ACCESS | IN_ATTRIB | IN_CLOSE_WRITE |
+			IN_CLOSE_NOWRITE | IN_CREATE | IN_DELETE |
+			IN_DELETE_SELF | IN_MODIFY | IN_MOVE_SELF |
+			IN_MOVED_FROM | IN_MOVED_TO | IN_OPEN);
+
+		inotify_rm_watch(notify_fd, wd);
+		ret = gettimeofday(&te, NULL);
+		if (ret == -1)
+			tst_brk(TBROK | TERRNO, "gettimeofday failed");
+		if (te.tv_sec - ts.tv_sec > timeout)
+			break;
+	}
+	close(notify_fd);
+}
+
+static void inotify_inits(char *fn, unsigned int timeout)
+{
+	int notify_fd, ret;
+	struct timeval ts;
+	struct timeval te;
+
+	ret = gettimeofday(&ts, NULL);
+	if (ret == -1)
+		tst_brk(TBROK | TERRNO, "gettimeofday failed");
+
+	while (1) {
+		notify_fd = inotify_init1(IN_CLOEXEC);
+		close(notify_fd);
+		ret = gettimeofday(&te, NULL);
+		if (ret == -1)
+			tst_brk(TBROK | TERRNO, "gettimeofday failed");
+		if (te.tv_sec - ts.tv_sec > timeout)
+			break;
+	}
+}
+
+static void inotify_add_rm_watches(char *fn, unsigned int timeout)
+{
+	int ret, fd, wd;
+	struct timeval ts;
+	struct timeval te;
+
+	fd = SAFE_MYINOTIFY_INIT();
+
+	ret = gettimeofday(&ts, NULL);
+	if (ret == -1)
+		tst_brk(TBROK | TERRNO, "gettimeofday failed");
+
+	while (1) {
+		wd = inotify_add_watch(fd, fn, IN_MODIFY);
+		inotify_rm_watch(fd, wd);
+		ret = gettimeofday(&te, NULL);
+		if (ret == -1)
+			tst_brk(TBROK | TERRNO, "gettimeofday failed");
+		if (te.tv_sec - ts.tv_sec > timeout)
+			break;
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
+static void inotify_watch(char *fn, unsigned int timeout)
+{
+	int fd, poll_num, wd, ret, ecnt = 0;
+	nfds_t nfds;
+	struct pollfd fds[2];
+	struct timeval ts;
+	struct timeval te;
+
+	/* Create the file descriptor for accessing the inotify API. */
+	fd = SAFE_MYINOTIFY_INIT1(IN_NONBLOCK);
+
+	/* Mark directories for events
+	 * - file was opened
+	 * - file was closed
+	 */
+	wd = SAFE_MYINOTIFY_ADD_WATCH(fd, fn, IN_OPEN | IN_CLOSE);
+
+	/* Prepare for polling. */
+	nfds = 2;
+	fds[0].fd = STDIN_FILENO;       /* Console input */
+	fds[0].events = POLLIN;
+	fds[1].fd = fd;                 /* Inotify input */
+	fds[1].events = POLLIN;
+
+	ret = gettimeofday(&ts, NULL);
+	if (ret == -1)
+		tst_brk(TBROK | TERRNO, "gettimeofday failed");
+
+	/* Wait for events and/or terminal input. */
+	while (1) {
+		poll_num = poll(fds, nfds, timeout/2);
+		if (poll_num == -1)
+			tst_brk(TBROK | TERRNO, "inotify watch poll failed");
+		if (poll_num > 0) {
+			if (fds[1].revents & POLLIN) {
+				/* Inotify events are available. */
+				i_handle_events(fd);
+				ecnt++;
+			}
+		}
+		ret = gettimeofday(&te, NULL);
+		if (ret == -1)
+			tst_brk(TBROK | TERRNO, "gettimeofday failed");
+		if (te.tv_sec - ts.tv_sec > timeout)
+			break;
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
+	void (*func_test)(char *fn, unsigned int timeout);
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
+	setup();
+	tst_printf("Starting %d stresses\n", tcnt+1);
+	tst_flush();
+
+	while (i < tcnt) {
+		if (tcases[i].ondir && !SAFE_CLONE(&args)) {
+			tst_printf("Starting %s on dir\n", tcases[i].desc);
+			tst_flush();
+			tcases[i].func_test(TESTDIR, arg_timeout);
+			tst_printf("Ending %s on dir\n", tcases[i].desc);
+			tst_flush();
+			exit(EXIT_SUCCESS);
+		}
+		if (tcases[i].onfile && !SAFE_CLONE(&args)) {
+			tst_printf("Starting %s on file\n", tcases[i].desc);
+			tst_flush();
+			tcases[i].func_test(TESTFILE, arg_timeout);
+			tst_printf("Ending %s on file\n", tcases[i].desc);
+			tst_flush();
+			exit(EXIT_SUCCESS);
+		}
+		i++;
+	}
+	if (!SAFE_CLONE(&args)) {
+		char *path = getenv("PATH");
+		char *str = SAFE_MALLOC(4096);
+		char *sto = SAFE_MALLOC(1024);
+
+		snprintf(str, 4096, "PATH=%s fs_racer.sh", path);
+		snprintf(sto, 1024, "%d", arg_timeout);
+
+		const char *const cmd[] = {str, "-t", sto, NULL};
+
+		tst_printf("Starting %s -t %d\n", str, arg_timeout);
+		tst_flush();
+		tst_cmd(cmd, NULL, NULL, 0);
+		free(str);
+		free(sto);
+		exit(EXIT_SUCCESS);
+	}
+	tst_reap_children();
+	cleanup();
+	tst_res(TPASS, "No panic or hang, test pass!");
+}
+
+static struct tst_test test = {
+	.tcnt = 1,
+	.forks_child = 1,
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.needs_cmds = 0,
+	.needs_cgroup_ver = 0,
+	.needs_cgroup_ctrls = 0,
+	.test = run,
+	.options = (struct tst_option[]) {
+		{"t:", &str_timeout, "Seconds for tiemout (default 60)"},
+		{}
+	},
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "4396a731 "},
+		{},
+	},
+};
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
