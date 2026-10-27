Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71B4606A31A
	for <ltp@archiver.kernel.org>; Tue, 27 Oct 2026 19:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=hJd3aWr3;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=tuta.io header.i=@tuta.io header.a=rsa-sha256 header.s=s1 header.b=HXTS3UaB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1793129843; h=date : to :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=pU5flZA6FuMksFH0mMiR9frw377/3+agB09EiEUfRpM=;
 b=hJd3aWr3ey9uZcRMUk2R8qw7ZjqiisHKDaeKRXNC5BKLdgFNYDf5rN06E9CuHPADu3s3J
 wTvXiNuYNwrrFpZKEoOKn2IehB96dzQg0XBpI/g7fQ92f4B56yVa104D/0AowkPYk+GLOaE
 8L6AFdYBrMyGlcC21lPLQ/aZsjrZoio=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 699AB3EA3E2
	for <ltp@archiver.kernel.org>; Tue, 27 Oct 2026 20:37:23 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D3C033CFD4D
 for <ltp@lists.linux.it>; Tue, 27 Oct 2026 20:37:03 +0100 (CET)
Received: from mail.w14.tutanota.de (mail.w14.tutanota.de [185.205.69.214])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2D44560084E
 for <ltp@lists.linux.it>; Tue, 27 Oct 2026 20:37:01 +0100 (CET)
Received: from tutadb.w10.tutanota.de (w10.api.tuta.com [IPv6:fd:ac::d:10])
 by mail.w14.tutanota.de (Postfix) with ESMTP id 6988519D89BBE
 for <ltp@lists.linux.it>; Tue, 27 Oct 2026 20:37:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1793129821; 
 s=s1; d=tuta.io;
 h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:Sender;
 bh=xabmCRSf2O54JcE5zMww+AfjUhpSt52iK10vkTCRmro=;
 b=HXTS3UaBgaCePPeQ418fH27a2tnj6gqpSbHPu9iNCiFEJq0zMgCvZ4gfH3+kxUQg
 MV5OlHpmbTlAY4ywpEvN6qK7+SScQms4Zh6+3ikzQULQgFwKGT4mFBKXniJvJAsl49O
 qFFoNJ6VxXVNrKS5o9vq7HsXi/Dz56tMXLsFkijv1R8C4W/MeZHWh9DiwqN8P1fSCWS
 gXk42zNETN5s6l6VyKv+BpZCSqb1r0PSsGj7v/UCedAF2MDvR16S84nRdqYyZePSIoG
 MVLoYn2J8z+lQiiux5Ytgfuj69yfxHWaTmh+94y84eSSw/icQVLHa/q7TYiBgMPctx8
 bArfuD8Kqg==
Date: Tue, 27 Oct 2026 20:37:01 +0100 (CET)
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
Message-ID: <P4yrQBp--N-9@tuta.io>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Feedback-ID: 0127f977f5e13e8051b46c6e7f57d0f95a0470d24b79d7c31d07fdf611cc427ab823e0f4692a810119c92d8768973a9281:TurnOnPrivacy!:tutamail
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH][STAGING] syscalls/fanotify26: Add test for nested
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

Link: https://lore.kernel.org/all/P4wV1J9--F-9@tuta.io/
Signed-off-by: Edvard Conrad <edvard@tuta.io>
---
 runtest/staging                               |   1 +
 testcases/kernel/syscalls/fanotify/.gitignore |   1 +
 .../kernel/syscalls/fanotify/fanotify26.c     | 185 ++++++++++++++++++
 3 files changed, 187 insertions(+)
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
index 000000000..529d09e25
--- /dev/null
+++ b/testcases/kernel/syscalls/fanotify/fanotify26.c
@@ -0,0 +1,185 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
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
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <errno.h>
+#include <string.h>
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
+ * this only has to outlast scheduling noise on a loaded machine.
+ */
+#define WAIT_MSEC	5000
+
+static int fd_notify = -1;
+static int filesystem_mark_unsupported;
+
+static struct tcase {
+	const char *tname;
+	int mark_backing;
+} tcases[] = {
+	{"Mark on the overlay", 0},
+	{"Mark on the overlay and on the backing filesystem", 1},
+};
+
+static void answer_one_event(void)
+{
+	struct fanotify_event_metadata event;
+	struct fanotify_response resp;
+
+	/* Blocks for good if the event fd generates a nested event. */
+	SAFE_READ(1, fd_notify, &event, sizeof(event));
+
+	if (event.mask != FAN_OPEN_PERM) {
+		tst_brk(TBROK, "Got unexpected event mask %llx",
+			(unsigned long long)event.mask);
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
+	if (tc->mark_backing && filesystem_mark_unsupported) {
+		tst_res(TCONF, "FAN_MARK_FILESYSTEM not supported");
+		return;
+	}
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
+		if (fd >= 0)
+			SAFE_CLOSE(fd);
+		exit(0);
+	}
+
+	/* The opener sleeps in the kernel once its event is queued. */
+	if (TST_PROCESS_STATE_WAIT(opener, 'D', WAIT_MSEC)) {
+		SAFE_CLOSE(fd_notify);
+		tst_brk(TBROK, "Open generated no permission event");
+	}
+
+	reader = SAFE_FORK();
+	if (!reader) {
+		answer_one_event();
+		exit(0);
+	}
+
+	if (TST_PROCESS_STATE_WAIT(reader, 'Z', WAIT_MSEC)) {
+		tst_res(TFAIL,
+			"Listener blocked in read() by a nested event");
+		SAFE_KILL(reader, SIGKILL);
+	} else {
+		tst_res(TPASS, "Listener answered the event");
+	}
+
+	SAFE_WAITPID(reader, NULL, 0);
+
+	/* Releases whatever is still queued, so the opener can finish. */
+	SAFE_CLOSE(fd_notify);
+	fd_notify = -1;
+
+	SAFE_WAITPID(opener, NULL, 0);
+}
+
+static void setup(void)
+{
+	/* The file has to exist in the lower layer to be opened through it. */
+	SAFE_UMOUNT(OVL_MNT);
+	SAFE_TOUCH(LOWER_FILE, 0644, NULL);
+	SAFE_MOUNT_OVERLAY();
+
+	require_fanotify_access_permissions_supported_on_fs(OVL_FILE);
+
+	filesystem_mark_unsupported =
+		fanotify_mark_supported_on_fs(FAN_MARK_FILESYSTEM, OVL_FILE) ||
+		fanotify_mark_supported_on_fs(FAN_MARK_FILESYSTEM, BACKING_MNT);
+}
+
+static void cleanup(void)
+{
+	if (fd_notify >= 0)
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
