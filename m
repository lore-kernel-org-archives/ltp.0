Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 474FCC43334
	for <ltp@archiver.kernel.org>; Mon, 13 Jun 2022 14:39:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 306F03C9413
	for <ltp@archiver.kernel.org>; Mon, 13 Jun 2022 16:39:08 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E3FEF3C9427
 for <ltp@lists.linux.it>; Mon, 13 Jun 2022 16:38:35 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 57ECA600640
 for <ltp@lists.linux.it>; Mon, 13 Jun 2022 16:38:35 +0200 (CEST)
Received: by mail-wr1-x436.google.com with SMTP id m24so7383592wrb.10
 for <ltp@lists.linux.it>; Mon, 13 Jun 2022 07:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lo5JVObPqyHZlqzSHMg/lL8M+xIMSYWzuRdFcqRAtOQ=;
 b=CEI5XOlCxiF7DHqWdOcsVpFZga+b+gvvJ5XXiI+9ul1Xjc6D5WVDYYkg3tTLvz6WgO
 XJDag3Ouww90SQF3KkXBhlCgqyrKb3IHT4mbs7oexzDWzHAELLswt4jUNFwGwHs4ozoW
 YQ6ihya+QjHvmCT4E/RqRf9M0esp28SIISCCxR+gVjx13MDVjuI0ZwHbJqbhMPt8guH8
 Td37b633qFBbuzOkoZ1IkSv5sQdi+ynHkGq25LB+5HPX2b4hHQfo+v2jTsgvbyetuW0E
 QWb3yIjcyxgmpclKURHv0A14pmEK5f1og1PnvMEPwOt6SjMxJTyASKSfqMjrUkp2j7K7
 qBqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lo5JVObPqyHZlqzSHMg/lL8M+xIMSYWzuRdFcqRAtOQ=;
 b=PUGAx3DJc41jsp8CTPJuDSl8vbywrNNEIToIot5cjp0B77POnoDORsK26aparZFebE
 L8ieKXdp0RhFmToVZ1pjkSNfNOMpJZlE6rX1goiiyMSH04HMIaq644AK9cZXwiLBlH9r
 di5LIcrM8n8tJhN5+2+iOiytG7Fqs6MDLZfcxUTrbMmk1fWkb7BXTfWPhUfsVg313TUC
 K4CaY0sT0ZMZJnDfvwGCmx01n5yf26ujTcX5c1UPhdETnF8wcREVeev4WS6n3ZDrO/SR
 YOaS+xRYeOTT4nPblqnxU17AWPUp9aMcj9PS8ZdxoPIQzvew/jFie8/cDVqH9J/1ixD1
 m/Jw==
X-Gm-Message-State: AJIora9DVQv7iVQg6RPThXpDuXHxfHuODA8S7XlhCt7fwQM3RNbFaapk
 8az2E4lOvBW8iAGJS7mAhDk=
X-Google-Smtp-Source: AGRyM1sloCBPtKcyoBXEm/w1c830WzGxOcz0mJjcGEHx3gw26qpUKWfoKd3Kx/o6wwrBpmkZwnmkvg==
X-Received: by 2002:a05:6000:1a89:b0:219:b255:d874 with SMTP id
 f9-20020a0560001a8900b00219b255d874mr213589wry.50.1655131114665; 
 Mon, 13 Jun 2022 07:38:34 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local
 (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
 by smtp.gmail.com with ESMTPSA id
 o19-20020a05600c4fd300b0039c55bc2c97sm14833072wmq.16.2022.06.13.07.38.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jun 2022 07:38:34 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Mon, 13 Jun 2022 17:38:23 +0300
Message-Id: <20220613143826.1328830-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220613143826.1328830-1-amir73il@gmail.com>
References: <20220613143826.1328830-1-amir73il@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/5] syscalls/fanotify23: Introduce FAN_MARK_EVICTABLE
 test
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
Cc: Matthew Bobrowski <repnop@google.com>, Jan Kara <jack@suse.cz>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Verify that evictable mark does not pin inode to cache and that
drop_caches evicts inode from cache and removes the evictable mark.

Verify that evictable mark can be upgraded to non-evictable but not
downgraded to evictable afterwards.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/fanotify/.gitignore |   1 +
 testcases/kernel/syscalls/fanotify/fanotify.h |   4 +
 .../kernel/syscalls/fanotify/fanotify23.c     | 258 ++++++++++++++++++
 4 files changed, 264 insertions(+)
 create mode 100644 testcases/kernel/syscalls/fanotify/fanotify23.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 1259e41f1..e9ee6e5ba 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -612,6 +612,7 @@ fanotify19 fanotify19
 fanotify20 fanotify20
 fanotify21 fanotify21
 fanotify22 fanotify22
+fanotify23 fanotify23
 
 ioperm01 ioperm01
 ioperm02 ioperm02
diff --git a/testcases/kernel/syscalls/fanotify/.gitignore b/testcases/kernel/syscalls/fanotify/.gitignore
index 6d4ab4ca3..a0a7d20d3 100644
--- a/testcases/kernel/syscalls/fanotify/.gitignore
+++ b/testcases/kernel/syscalls/fanotify/.gitignore
@@ -20,4 +20,5 @@
 /fanotify20
 /fanotify21
 /fanotify22
+/fanotify23
 /fanotify_child
diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index eb690e332..0ad7ef21b 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -101,6 +101,10 @@ static inline int safe_fanotify_mark(const char *file, const int lineno,
 #ifndef FAN_MARK_FILESYSTEM
 #define FAN_MARK_FILESYSTEM	0x00000100
 #endif
+#ifndef FAN_MARK_EVICTABLE
+#define FAN_MARK_EVICTABLE	0x00000200
+#endif
+
 /* New dirent event masks */
 #ifndef FAN_ATTRIB
 #define FAN_ATTRIB		0x00000004
diff --git a/testcases/kernel/syscalls/fanotify/fanotify23.c b/testcases/kernel/syscalls/fanotify/fanotify23.c
new file mode 100644
index 000000000..64787d627
--- /dev/null
+++ b/testcases/kernel/syscalls/fanotify/fanotify23.c
@@ -0,0 +1,258 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022 CTERA Networks.  All Rights Reserved.
+ *
+ * Author: Amir Goldstein <amir73il@gmail.com>
+ */
+
+/*\
+ * [Description]
+ * Check evictable fanotify inode marks.
+ */
+
+#define _GNU_SOURCE
+#include "config.h"
+
+#include <stdio.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <errno.h>
+#include <string.h>
+#include <sys/syscall.h>
+#include "tst_test.h"
+
+#ifdef HAVE_SYS_FANOTIFY_H
+#include "fanotify.h"
+
+#define EVENT_MAX 1024
+/* size of the event structure, not counting name */
+#define EVENT_SIZE  (sizeof (struct fanotify_event_metadata))
+/* reasonable guess as to size of 1024 events */
+#define EVENT_BUF_LEN        (EVENT_MAX * EVENT_SIZE)
+
+#define MOUNT_PATH "fs_mnt"
+#define TEST_FILE MOUNT_PATH "/testfile"
+
+#define DROP_CACHES_FILE "/proc/sys/vm/drop_caches"
+#define CACHE_PRESSURE_FILE "/proc/sys/vm/vfs_cache_pressure"
+
+static int old_cache_pressure;
+static int fd_notify;
+
+static unsigned long long event_set[EVENT_MAX];
+
+static char event_buf[EVENT_BUF_LEN];
+
+static void fsync_file(const char *path)
+{
+	int fd = SAFE_OPEN(path, O_RDONLY);
+
+	SAFE_FSYNC(fd);
+	SAFE_CLOSE(fd);
+}
+
+/* Flush out all pending dirty inodes and destructing marks */
+static void mount_cycle(void)
+{
+	SAFE_UMOUNT(MOUNT_PATH);
+	SAFE_MOUNT(tst_device->dev, MOUNT_PATH, tst_device->fs_type, 0, NULL);
+}
+
+static int verify_mark_removed(const char *path, const char *when)
+{
+	int ret;
+
+	/*
+	 * We know that inode with evictable mark was evicted when a
+	 * bogus call remove ACCESS from event mask returns ENOENT.
+	 */
+	errno = 0;
+	ret = fanotify_mark(fd_notify, FAN_MARK_REMOVE,
+			    FAN_ACCESS, AT_FDCWD, path);
+	if (ret == -1 && errno == ENOENT) {
+		tst_res(TPASS,
+			"FAN_MARK_REMOVE failed with ENOENT as expected"
+			" %s", when);
+		return 1;
+	} else {
+		tst_res(TFAIL | TERRNO,
+			"FAN_MARK_REMOVE did not fail with ENOENT as expected"
+			" %s", when);
+		return 0;
+	}
+}
+
+static void test_fanotify(void)
+{
+	int ret, len, test_num = 0;
+	struct fanotify_event_metadata *event;
+	int tst_count = 0;
+
+	fd_notify = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF | FAN_REPORT_FID |
+				       FAN_NONBLOCK, O_RDONLY);
+
+	/*
+	 * Verify that evictable mark can be upgraded to non-evictable
+	 * and cannot be downgraded to evictable.
+	 */
+	SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_ADD | FAN_MARK_EVICTABLE,
+			   FAN_ACCESS,
+			   AT_FDCWD, TEST_FILE);
+	SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_ADD,
+			   FAN_ACCESS,
+			   AT_FDCWD, TEST_FILE);
+	errno = 0;
+	ret = fanotify_mark(fd_notify, FAN_MARK_ADD | FAN_MARK_EVICTABLE,
+			    FAN_ACCESS,
+			    AT_FDCWD, TEST_FILE);
+	if (ret == -1 && errno == EEXIST) {
+		tst_res(TPASS,
+			"FAN_MARK_ADD failed with EEXIST as expected"
+			" when trying to downgrade to evictable mark");
+	} else {
+		tst_res(TFAIL | TERRNO,
+			"FAN_MARK_ADD did not fail with EEXIST as expected"
+			" when trying to downgrade to evictable mark");
+	}
+	SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_REMOVE,
+			   FAN_ACCESS,
+			   AT_FDCWD, TEST_FILE);
+	verify_mark_removed(TEST_FILE, "after empty mask");
+
+
+	/*
+	 * Watch ATTRIB events on entire mount
+	 */
+	SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_ADD | FAN_MARK_FILESYSTEM,
+			   FAN_ATTRIB, AT_FDCWD, MOUNT_PATH);
+
+	/*
+	 * Generate events
+	 */
+	SAFE_CHMOD(TEST_FILE, 0600);
+	event_set[tst_count] = FAN_ATTRIB;
+	tst_count++;
+
+	/* Read events so far */
+	ret = SAFE_READ(0, fd_notify, event_buf, EVENT_BUF_LEN);
+	len = ret;
+
+	/*
+	 * Evictable mark on file ignores ATTRIB events
+	 */
+	SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_ADD | FAN_MARK_EVICTABLE |
+			   FAN_MARK_IGNORED_MASK | FAN_MARK_IGNORED_SURV_MODIFY,
+			   FAN_ATTRIB, AT_FDCWD, TEST_FILE);
+
+	/* ATTRIB event should be ignored */
+	SAFE_CHMOD(TEST_FILE, 0600);
+
+	/*
+	 * Read events to verify event was ignored
+	 */
+	ret = read(fd_notify, event_buf + len, EVENT_BUF_LEN - len);
+	if (ret < 0 && errno == EAGAIN) {
+		tst_res(TPASS, "Got no events as expected");
+	} else {
+		tst_res(TFAIL, "Got expected events");
+		len += ret;
+	}
+
+	/*
+	 * drop_caches should evict inode from cache and remove evictable mark
+	 */
+	fsync_file(TEST_FILE);
+	SAFE_FILE_PRINTF(DROP_CACHES_FILE, "3");
+
+	verify_mark_removed(TEST_FILE, "after drop_caches");
+
+	SAFE_CHMOD(TEST_FILE, 0600);
+	event_set[tst_count] = FAN_ATTRIB;
+	tst_count++;
+
+	/* Read events to verify ATTRIB event was properly generated */
+	ret = SAFE_READ(0, fd_notify, event_buf + len, EVENT_BUF_LEN - len);
+	len += ret;
+
+	/*
+	 * Check events
+	 */
+	event = (struct fanotify_event_metadata *)event_buf;
+
+	/* Iterate over and validate events against expected result set */
+	while (FAN_EVENT_OK(event, len) && test_num < tst_count) {
+		if (!(event->mask & event_set[test_num])) {
+			tst_res(TFAIL,
+				"got event: mask=%llx (expected %llx)",
+				(unsigned long long)event->mask,
+				event_set[test_num]);
+		} else {
+			tst_res(TPASS,
+				"got event: mask=%llx",
+				(unsigned long long)event->mask);
+		}
+		/*
+		 * Close fd and invalidate it so that we don't check it again
+		 * unnecessarily
+		 */
+		if (event->fd >= 0)
+			SAFE_CLOSE(event->fd);
+		event->fd = FAN_NOFD;
+		event->mask &= ~event_set[test_num];
+		/* No events left in current mask? Go for next event */
+		if (event->mask == 0) {
+			event = FAN_EVENT_NEXT(event, len);
+		}
+		test_num++;
+	}
+
+	while (FAN_EVENT_OK(event, len)) {
+		tst_res(TFAIL,
+			"got unnecessary event: mask=%llx",
+			(unsigned long long)event->mask);
+		if (event->fd != FAN_NOFD)
+			SAFE_CLOSE(event->fd);
+		event = FAN_EVENT_NEXT(event, len);
+	}
+
+	SAFE_CLOSE(fd_notify);
+	/* Flush out all pending dirty inodes and destructing marks */
+	mount_cycle();
+}
+
+static void setup(void)
+{
+	SAFE_TOUCH(TEST_FILE, 0666, NULL);
+
+	REQUIRE_MARK_TYPE_SUPPORTED_BY_KERNEL(FAN_MARK_EVICTABLE);
+	REQUIRE_FANOTIFY_EVENTS_SUPPORTED_ON_FS(FAN_CLASS_NOTIF|FAN_REPORT_FID,
+						FAN_MARK_FILESYSTEM,
+						FAN_ATTRIB, ".");
+
+	SAFE_FILE_SCANF(CACHE_PRESSURE_FILE, "%d", &old_cache_pressure);
+	/* Set high priority for evicting inodes */
+	SAFE_FILE_PRINTF(CACHE_PRESSURE_FILE, "500");
+}
+
+static void cleanup(void)
+{
+	if (fd_notify > 0)
+		SAFE_CLOSE(fd_notify);
+
+	SAFE_FILE_PRINTF(CACHE_PRESSURE_FILE, "%d", old_cache_pressure);
+}
+
+static struct tst_test test = {
+	.test_all = test_fanotify,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.mount_device = 1,
+	.mntpoint = MOUNT_PATH,
+	/* Shrinkers on other fs do not work reliably enough to guarantee mark eviction on drop_caches */
+	.dev_fs_type = "ext2",
+};
+
+#else
+	TST_TEST_TCONF("system doesn't have required fanotify support");
+#endif
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
