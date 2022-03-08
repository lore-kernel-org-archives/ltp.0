Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB703C433F5
	for <ltp@archiver.kernel.org>; Tue,  8 Mar 2022 01:39:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 113143C2224
	for <ltp@archiver.kernel.org>; Tue,  8 Mar 2022 02:39:08 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B46713C1BD6
 for <ltp@lists.linux.it>; Tue,  8 Mar 2022 02:38:57 +0100 (CET)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4CCE4600481
 for <ltp@lists.linux.it>; Tue,  8 Mar 2022 02:38:56 +0100 (CET)
Received: by mail-qv1-xf36.google.com with SMTP id jo29so1254263qvb.5
 for <ltp@lists.linux.it>; Mon, 07 Mar 2022 17:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=xiwwa7eCBF19fVsnFudpB5qdAIhFSgMG9TpnbXZ45TE=;
 b=LSXpY4K0az4pNORjRMwQ2VapwVt/T7XfVjVnGmkjmVLWiAh3UENVMfpXU6HK4QANSV
 cVBTeBHdo4vQTSj0hiskSushIg/IGeQ941/ohvKQeTrGjyipRedOAxSwDJg2bUKsDAB/
 fm34aPSSrGiUVBSzsiCU4trrQeQoC1WTZt4mEthUYCgROGujecQYKMi1GF/NoPnKDn20
 C6AzsFCidwuGAMkLTTRIa3GutvlwmDXj2821V5RyA7bwvClM+EqUMaePwHHgh2fa/sNx
 kj2LMWUZJSDT4MPOiTu9KIMX8lqhCaP65swuDU2fjRiW49DzhIXGajdX9/+TaQaPpnMS
 Cf8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=xiwwa7eCBF19fVsnFudpB5qdAIhFSgMG9TpnbXZ45TE=;
 b=0vsFz63ivOciSMJ05Tb3bfI7LLeX8+TPzrXvcYj+eJkP0bD1r6g65dIfrJGNoJOWSv
 LA5jKDS61INcLzhE2ERBcZWMNFX2jk4h4oUloKUbus4k3bHutkVH9bNAtuGy77Indkbo
 zxAl9bGnnoFYfptKGe4ViNEkNou0J5Mxnhz3FKC0ahRMFYSF7M7mZmLy+borRUxwtZoq
 d2qCDSZ8G9GeXgQPMrl/hIezKg4PP+RPEkID7RjWzM0kjxybVqVEwkFC3+UJbXWgqoVw
 6t9ToaermYBkUuaVSqoB0tQSAlF4KO0/TYGikS7v/LAXHiPfDBjufY6YTew50ie9xZ2/
 PBqg==
X-Gm-Message-State: AOAM533liIOmMMHZ6z0N1mZ4bUTcJ7vzSGH1e29LVTtYPHWtXwmJq7dB
 QPpnm04C23oXZRzZZLJwZnc=
X-Google-Smtp-Source: ABdhPJwV+R1ohSCn4uh9MBmFPfBJTt1IlSC2a0JWg3rGN7IOUgbfirvOlD4kd2+4cBFejGlRkaG/kQ==
X-Received: by 2002:ad4:576c:0:b0:435:493d:98e9 with SMTP id
 r12-20020ad4576c000000b00435493d98e9mr10479033qvx.128.1646703534967; 
 Mon, 07 Mar 2022 17:38:54 -0800 (PST)
Received: from xzhouw.hosts.qa.psi.rdu2.redhat.com ([66.187.232.127])
 by smtp.gmail.com with ESMTPSA id
 z1-20020a05622a028100b002e06cd1f623sm1516152qtw.9.2022.03.07.17.38.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Mar 2022 17:38:54 -0800 (PST)
Date: Tue, 8 Mar 2022 09:38:53 +0800
From: Murphy Zhou <jencce.kernel@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <20220308013853.yr5qhlkcdjy3a5d2@xzhouw.hosts.qa.psi.rdu2.redhat.com>
References: <20220125024718.jszwoussimqk6trf@xzhoux.usersys.redhat.com>
 <Ye/ZOo2tlA+Jf+Cf@yuki>
 <CADJHv_tRGHhLg2YLssu8hQpNU_PLa_iD1qhMWadBRpbTatoFiA@mail.gmail.com>
 <Yhxu8elhUJakYJHH@pevik> <YiAqwHabM9qCUjAU@xzhouw.hosts>
 <YiDdRhIdh12/23HM@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YiDdRhIdh12/23HM@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] kernel/fs/fsnotify-stress: fsnotify stress test
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
v3:
	remove fs_racer.sh part.

 runtest/fs                                    |   2 +
 testcases/kernel/fs/fsnotify-stress/Makefile  |  13 +
 .../fs/fsnotify-stress/fsnotify-stress.c      | 654 ++++++++++++++++++
 3 files changed, 669 insertions(+)
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
index 000000000..8297cad25
--- /dev/null
+++ b/testcases/kernel/fs/fsnotify-stress/fsnotify-stress.c
@@ -0,0 +1,654 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
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
+	tst_printf("Starting %d stresses\n", tcnt);
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
