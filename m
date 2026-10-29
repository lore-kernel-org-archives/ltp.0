Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A75606A31A
	for <ltp@archiver.kernel.org>; Thu, 29 Oct 2026 21:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=l5+OuSGu;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=tuta.io header.i=@tuta.io header.a=rsa-sha256 header.s=s1 header.b=c0Zq0php
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1793308907; h=date : to :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=dIBBSUmiuVLVaFqLVD680oLonwwfqKV9YqDGWsKsTH0=;
 b=l5+OuSGuhTbN9TrGRZ0ndUiDmaLeDcemtW5h9Kbq62kVt5cy78lS0st4XqhjjaaPUJ5WK
 aQ12u2CqiMIvWLozSEAKuOqLA15pORWXiEGtcbpp2sppk+xMM9XeZcgWwQR+8gM2p3ycHQ1
 GDhRcMAf0rMJI8XccJ8rtZTG9QAXaPk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 57B233EA3BC
	for <ltp@archiver.kernel.org>; Thu, 29 Oct 2026 22:21:47 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B5FC93C25E8
 for <ltp@lists.linux.it>; Thu, 29 Oct 2026 22:21:26 +0100 (CET)
Received: from mail.w14.tutanota.de (mail.w14.tutanota.de [185.205.69.214])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 90F921A0098C
 for <ltp@lists.linux.it>; Thu, 29 Oct 2026 22:21:25 +0100 (CET)
Received: from tutadb.w10.tutanota.de (w10.api.tuta.com [IPv6:fd:ac::d:10])
 by mail.w14.tutanota.de (Postfix) with ESMTP id 8FD3919EEF4AA
 for <ltp@lists.linux.it>; Thu, 29 Oct 2026 22:21:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1793308884; 
 s=s1; d=tuta.io;
 h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:Sender;
 bh=/khCvL3k5j4Xv/cRlBywuKwEzg3E3yJlUO/He4xfUvU=;
 b=c0Zq0php23StUyd8OLlIk1EGulP5Cx1MoqcAjY29C0UwIY6CnvraL2z5NhMhekNq
 3fteZXgbXjCUA595VoAQ7ZFnENbStf186h4q646im+p3V8yViWh65QKrQqH+I27wge+
 J21CtbHKrxMr0DkjUxZtzCrlKaFy+qCNE38rlusNi8qIWYRnCf0mvyh4zFqbE7Mt8c6
 rz0MpOXW2c2TUzk4kt3x9pS59+cXh/paUL9YMgGogkoyfQ2VvoQj84GMgEm4jZVTfM9
 PbqsBD/vfbIsB4VdBXqyHuZVzMPv2/jZ5WsWl4IUMN9R1VPpTqscMIqVLmcHAq9/elI
 i/8FfM41ug==
Date: Thu, 29 Oct 2026 22:21:24 +0100 (CET)
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
Message-ID: <P58XUlU--F-9@tuta.io>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Feedback-ID: 0127f977f5e13e8051b46c6e7f57d0f95a0470d24b79d7c31d07fdf611cc427ab823e0f4692a810119c92d8768973a9281:TurnOnPrivacy!:tutamail
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3][STAGING] syscalls/fanotify26: Add test for nested
 permission events
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Edvard Conrad via ltp <ltp@lists.linux.it>
Reply-To: Edvard Conrad <edvard@tuta.io>
Cc: Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
 Edvard Conrad <edvard@tuta.io>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The kernel creates the file descriptor it reports with a permission
event by an open that must not generate further events. When the
reported path is on a stacked filesystem, that open opens the real file
on the backing filesystem, and since commit ebe559609d78 ("fs: get rid
of __FMODE_NONOTIFY kludge") the backing file no longer inherits
FMODE_NONOTIFY. A listener that also watches the backing filesystem is
then sent a second permission event from inside its own read(2), which
only the listener itself can answer, so a single reader never returns.

Verify that a listener returns from read(2) and answers an open
permission event for a file on an overlayfs mount. The first test case
marks the overlay only and passes on any kernel, the second one also
marks the backing filesystem, which is the shape an anti-malware
scanner uses on an overlayfs root.

The second case fails on a kernel without the pending fix "fs: let
backing files inherit FMODE_NONOTIFY from the user file", so the test
is added to runtest/staging for now.

Link: https://lore.kernel.org/all/P58Wrer--F-9@tuta.io/
Signed-off-by: Edvard Conrad <edvard@tuta.io>
---
v2: https://lore.kernel.org/ltp/P50G-yE--F-9@tuta.io/

v3:
- Scale both process-state waits through tst_multiply_timeout(). The
  library scales all of its own deadlines, so on a KASAN or lockdep
  kernel a healthy but unscheduled listener was reported as blocked.
- Report TFAIL, not TBROK, for an unexpected event mask, and check the
  event's pid, following fanotify03.c. Answer the event either way, or
  the opener stays parked in the kernel.
- Probe FAN_CLASS_CONTENT + FAN_MARK_FILESYSTEM + FAN_OPEN_PERM with
  REQUIRE_FANOTIFY_EVENTS_SUPPORTED_ON_FS(), the combination run()
  actually uses. The two previous probes checked neither class nor mask.
- Use SAFE_READ_ALL rather than a literal 1, matching SAFE_WRITE_ALL.
- Drop the explicit SAFE_WAITPID() for the opener. tst_reap_children()
  runs after every iteration and checks the exit status this discarded.
- Drop three unused includes.

Amir's Reviewed-by from v2 is not carried over: the failure reporting
and the support probe changed since, so it needs a fresh look.

Not changed: the [STAGING] keyword stays in the patch subject rather
than the commit subject, which is the form ground_rules.rst documents.
Answered on the v2 thread.

Tested on mainline v7.3-16259-g6b4b543fa18 with and without the pending
fix: both cases pass with it, and the second fails without it.

 runtest/staging                               |   1 +
 testcases/kernel/syscalls/fanotify/.gitignore |   1 +
 .../kernel/syscalls/fanotify/fanotify26.c     | 199 ++++++++++++++++++
 3 files changed, 201 insertions(+)
 create mode 100644 testcases/kernel/syscalls/fanotify/fanotify26.c

diff --git a/runtest/staging b/runtest/staging
index ef1cdea15..2ce76b119 100644
--- a/runtest/staging
+++ b/runtest/staging
@@ -1 +1,2 @@
 # Tests for features that are not yet in the stable kernel ABI
+fanotify26 fanotify26
diff --git a/testcases/kernel/syscalls/fanotify/.gitignore b/testcases/kernel/syscalls/fanotify/.gitignore
index d6d0599f1..c13d9b33c 100644
--- a/testcases/kernel/syscalls/fanotify/.gitignore
+++ b/testcases/kernel/syscalls/fanotify/.gitignore
@@ -23,4 +23,5 @@
 /fanotify23
 /fanotify24
 /fanotify25
+/fanotify26
 /fanotify_child
diff --git a/testcases/kernel/syscalls/fanotify/fanotify26.c b/testcases/kernel/syscalls/fanotify/fanotify26.c
new file mode 100644
index 000000000..8741cd560
--- /dev/null
+++ b/testcases/kernel/syscalls/fanotify/fanotify26.c
@@ -0,0 +1,199 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Edvard Conrad <edvard@tuta.io>
+ */
+
+/*\
+ * Check that a permission event on a stacked filesystem does not deadlock the
+ * :manpage:`fanotify(7)` listener.
+ *
+ * When the kernel reports a permission event, it creates the event file
+ * descriptor with an open that must not generate further events. If the
+ * reported path is on a stacked filesystem, that open opens the real file on
+ * the backing filesystem. Should the backing file not inherit "generate no
+ * events", and the listener watch the backing filesystem as well, the kernel
+ * queues a second permission event to the same group while the listener is
+ * still inside :manpage:`read(2)`. Only the listener can answer it, so a
+ * listener that reads with a single thread never returns, and every task that
+ * touches a watched filesystem queues up behind it.
+ *
+ * The first test case marks the overlay only and must pass on any kernel. The
+ * second one marks the backing filesystem as well, which is the shape an
+ * anti-malware scanner uses on an overlayfs root.
+ *
+ * The test needs root to create permission events and to mount overlayfs.
+ */
+
+#define _GNU_SOURCE
+#include "config.h"
+
+#include <stdlib.h>
+#include <unistd.h>
+#include <signal.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include "tst_test.h"
+
+#ifdef HAVE_SYS_FANOTIFY_H
+#include "fanotify.h"
+
+#define BACKING_MNT	OVL_BASE_MNTPOINT
+#define FNAME		"test_file"
+#define OVL_FILE	OVL_MNT "/" FNAME
+#define LOWER_FILE	OVL_LOWER "/" FNAME
+
+/*
+ * The listener either answers the event at once or is blocked for good, so
+ * this only has to outlast scheduling noise. Scaled through
+ * tst_multiply_timeout() at the call sites, or a slow kernel build would
+ * report a healthy but unscheduled listener as blocked.
+ */
+#define WAIT_MSEC	5000
+
+static int fd_notify = -1;
+
+static struct tcase {
+	const char *tname;
+	int mark_backing;
+} tcases[] = {
+	{"Mark on the overlay", 0},
+	{"Mark on the overlay and on the backing filesystem", 1},
+};
+
+static void answer_one_event(pid_t opener)
+{
+	struct fanotify_event_metadata event;
+	struct fanotify_response resp;
+
+	/* Blocks for good if the event fd generates a nested event. */
+	SAFE_READ(SAFE_READ_ALL, fd_notify, &event, sizeof(event));
+
+	/*
+	 * A wrong mask or a stranger's event is a result, not harness
+	 * breakage, so report and still answer: the opener stays parked in
+	 * the kernel until something does.
+	 */
+	if (event.mask != FAN_OPEN_PERM) {
+		tst_res(TFAIL, "Got event mask %llx, expected %llx",
+			(unsigned long long)event.mask,
+			(unsigned long long)FAN_OPEN_PERM);
+	} else if (event.pid != opener) {
+		tst_res(TFAIL, "Got event from pid %u, expected %u",
+			(unsigned int)event.pid, (unsigned int)opener);
+	} else {
+		tst_res(TPASS, "Listener answered the event");
+	}
+
+	resp.fd = event.fd;
+	resp.response = FAN_ALLOW;
+	SAFE_WRITE(SAFE_WRITE_ALL, fd_notify, &resp, sizeof(resp));
+
+	if (event.fd != FAN_NOFD)
+		SAFE_CLOSE(event.fd);
+}
+
+static void run(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+	pid_t opener, reader;
+
+	tst_res(TINFO, "Test #%d: %s", n, tc->tname);
+
+	fd_notify = SAFE_FANOTIFY_INIT(FAN_CLASS_CONTENT, O_RDONLY);
+
+	SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_ADD | FAN_MARK_FILESYSTEM,
+			   FAN_OPEN_PERM, AT_FDCWD, OVL_MNT);
+
+	if (tc->mark_backing) {
+		SAFE_FANOTIFY_MARK(fd_notify,
+				   FAN_MARK_ADD | FAN_MARK_FILESYSTEM,
+				   FAN_OPEN_PERM, AT_FDCWD, BACKING_MNT);
+	}
+
+	opener = SAFE_FORK();
+	if (!opener) {
+		int fd;
+
+		/* Must not hold the group, it has to be released on close. */
+		SAFE_CLOSE(fd_notify);
+		/*
+		 * The kernel denies the event when a listener that never
+		 * answered it goes away, so a failure here is the fallout of
+		 * the test tearing a blocked listener down, not a result.
+		 */
+		fd = open(OVL_FILE, O_RDONLY);
+		if (fd != -1)
+			SAFE_CLOSE(fd);
+		exit(0);
+	}
+
+	/* The opener sleeps in the kernel once its event is queued. */
+	if (TST_PROCESS_STATE_WAIT(opener, 'D',
+				   tst_multiply_timeout(WAIT_MSEC)))
+		tst_brk(TBROK, "Open generated no permission event");
+
+	reader = SAFE_FORK();
+	if (!reader) {
+		answer_one_event(opener);
+		exit(0);
+	}
+
+	/*
+	 * The listener answers and exits, or is blocked for good. Only the
+	 * blocked case is handled here: the child reports its own success,
+	 * so a child that died some other way cannot be taken for one that
+	 * answered. The library reaps it on the normal path.
+	 */
+	if (TST_PROCESS_STATE_WAIT(reader, 'Z',
+				   tst_multiply_timeout(WAIT_MSEC))) {
+		tst_res(TFAIL,
+			"Listener blocked in read() by a nested event");
+		SAFE_KILL(reader, SIGKILL);
+		SAFE_WAITPID(reader, NULL, 0);
+	}
+
+	/*
+	 * Releases whatever is still queued, so the opener can finish. The
+	 * library reaps it and checks its exit status after this returns.
+	 */
+	SAFE_CLOSE(fd_notify);
+}
+
+static void setup(void)
+{
+	/* The file has to exist in the lower layer to be opened through it. */
+	SAFE_UMOUNT(OVL_MNT);
+	SAFE_TOUCH(LOWER_FILE, 0644, NULL);
+	SAFE_MOUNT_OVERLAY();
+
+	/*
+	 * Probe the combination run() uses, not a weaker proxy for it. Every
+	 * case marks the overlay; the second also marks the base.
+	 */
+	REQUIRE_FANOTIFY_EVENTS_SUPPORTED_ON_FS(FAN_CLASS_CONTENT,
+						FAN_MARK_FILESYSTEM,
+						FAN_OPEN_PERM, OVL_MNT);
+	REQUIRE_MARK_TYPE_SUPPORTED_ON_FS(FAN_MARK_FILESYSTEM, BACKING_MNT);
+}
+
+static void cleanup(void)
+{
+	if (fd_notify != -1)
+		SAFE_CLOSE(fd_notify);
+}
+
+static struct tst_test test = {
+	.test = run,
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.cleanup = cleanup,
+	.forks_child = 1,
+	.needs_root = 1,
+	.mount_device = 1,
+	.needs_overlay = 1,
+	.mntpoint = OVL_BASE_MNTPOINT,
+};
+
+#else
+	TST_TEST_TCONF("system doesn't have required fanotify support");
+#endif
-- 
2.56.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
