Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D085C5DF81
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 21:27:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 129A13CD638
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 23:27:57 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F2A513CDA31
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 23:24:38 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A722F140099B
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 23:24:37 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3FBB93EDB;
 Wed, 19 Aug 2026 21:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787174672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wfNdmfA/n4bmPPmn8uQkZu/opEXvLkA/Dr78dG/7X4c=;
 b=RsIiemFduTxH3f0c6LTH8F7MLCKNrFpIhOSnKVyobwEFSE7xxWQI1MeDGx5eJEDXglXerA
 g4OYLEcSkuSrhMyYqO0Rxm83+Ip3pyF1naMqKQnTjw9E0X4r0B2F+p0kQoJSt9beGBkBmz
 mOHzFQ22MptOHqXH6VT/4GzED2UuUIw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787174672;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wfNdmfA/n4bmPPmn8uQkZu/opEXvLkA/Dr78dG/7X4c=;
 b=Z/pe5ZKef02iune64dekIdKunoQX+LYk+ljllGSVCnyAq+aTkvt2ryMst4pS8bJE4GGMw2
 tDhMLmPIG4HRQaDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787174668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wfNdmfA/n4bmPPmn8uQkZu/opEXvLkA/Dr78dG/7X4c=;
 b=XxSIXg8vU7Zbu2YEd0lEAEK+InTuW23DhoYjyK7DQnFPJ51gZ9RSpNBQ1IyTTxM3+kO9Zt
 mownCuBL6rfSusx3qUE7JT9sanEkkOqhfjr4r1oHSvOWwa2vvdMd2sXBUYQNpvBMHwKurh
 vY+9JLtepY3VQYljVxqeho4UiHOmxXI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787174668;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wfNdmfA/n4bmPPmn8uQkZu/opEXvLkA/Dr78dG/7X4c=;
 b=sHJs5ME1cmdom5ydOyeNMrlh/LwtHKcNFfbySQqN261DKECY1HHt1onEvFTdvcJLKaqoSd
 qIqLFHnpB5FBi9Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 51CD0367C;
 Wed, 19 Aug 2026 21:24:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IC3eEAUfhmqSGwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 19 Aug 2026 21:24:21 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 19 Aug 2026 23:24:20 +0200
MIME-Version: 1.0
Message-Id: <20260819-fchroot-v1-5-2dc2c3c3cf29@suse.com>
References: <20260819-fchroot-v1-0-2dc2c3c3cf29@suse.com>
In-Reply-To: <20260819-fchroot-v1-0-2dc2c3c3cf29@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787174658; l=3708;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=mBzTUoj9a1HT9iD5kqS2CHoSB3+kgqeYSl7w06JOegI=;
 b=ho8mhwLsqlH694bErfqGmXquMa7NzlmeAQVNh2qhQFLH4tM3QVYD6rbS7sg7jd2F8/btmj6vI
 li9AgD9Q/jAAVo2ikOqIaTUiQxnaeStW1tTkJFjhWGwFcK6paA8FEPi
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:mid,
 suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH STAGING 05/16] fchroot02: test fchroot() invalid
 arguments
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

Verify the fchroot() error paths: a non-zero flags argument fails with
EINVAL before anything else, an invalid fd fails with EBADF, including
the FD_PIDFS_ROOT and FD_NSFS_ROOT sentinels, and a fd referring to a
regular file fails with ENOTDIR. All these checks happen before the
CAP_SYS_CHROOT check, so no privileges are needed.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/staging                               |  1 +
 testcases/kernel/syscalls/fchroot/.gitignore  |  1 +
 testcases/kernel/syscalls/fchroot/fchroot02.c | 80 +++++++++++++++++++++++++++
 3 files changed, 82 insertions(+)

diff --git a/runtest/staging b/runtest/staging
index 733d5609a..e12230218 100644
--- a/runtest/staging
+++ b/runtest/staging
@@ -1,3 +1,4 @@
 # Tests for features that are not yet in the stable kernel ABI
 
 fchroot01 fchroot01
+fchroot02 fchroot02
diff --git a/testcases/kernel/syscalls/fchroot/.gitignore b/testcases/kernel/syscalls/fchroot/.gitignore
index 03ebdbe7a..fb3287612 100644
--- a/testcases/kernel/syscalls/fchroot/.gitignore
+++ b/testcases/kernel/syscalls/fchroot/.gitignore
@@ -1 +1,2 @@
 fchroot01
+fchroot02
diff --git a/testcases/kernel/syscalls/fchroot/fchroot02.c b/testcases/kernel/syscalls/fchroot/fchroot02.c
new file mode 100644
index 000000000..6e8aec820
--- /dev/null
+++ b/testcases/kernel/syscalls/fchroot/fchroot02.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Test the :manpage:`fchroot(2)` error paths for invalid arguments.
+ *
+ * fchroot() was introduced in Linux v7.3. The syscall checks its arguments
+ * in this order:
+ *
+ * - a non-zero flags argument fails with EINVAL before anything else,
+ *   including with the FD_FAILFS_ROOT sentinel and with an invalid fd
+ * - an invalid fd fails with EBADF, including the FD_PIDFS_ROOT and
+ *   FD_NSFS_ROOT sentinels which fchroot() does not accept
+ * - a fd referring to a regular file fails with ENOTDIR
+ *
+ * All these checks happen before the CAP_SYS_CHROOT check, so the test
+ * needs no privileges.
+ */
+
+#include <fcntl.h>
+#include "tst_test.h"
+#include "lapi/fcntl.h"
+#include "lapi/syscalls.h"
+
+#define FILENAME "file.txt"
+
+static int dir_fd = -1;
+static int file_fd = -1;
+static int bad_fd = -1;
+static int failfs_root = FD_FAILFS_ROOT;
+static int pidfs_root = FD_PIDFS_ROOT;
+static int nsfs_root = FD_NSFS_ROOT;
+
+static struct tcase {
+	int *fd;
+	unsigned int flags;
+	int exp_errno;
+	const char *desc;
+} tcases[] = {
+	{&dir_fd, 1, EINVAL, "non-zero flags with a directory fd"},
+	{&failfs_root, 1, EINVAL, "non-zero flags with FD_FAILFS_ROOT"},
+	{&bad_fd, 1, EINVAL, "non-zero flags with an invalid fd"},
+	{&bad_fd, 0, EBADF, "invalid fd"},
+	{&pidfs_root, 0, EBADF, "FD_PIDFS_ROOT sentinel"},
+	{&nsfs_root, 0, EBADF, "FD_NSFS_ROOT sentinel"},
+	{&file_fd, 0, ENOTDIR, "fd referring to a regular file"},
+};
+
+static void run(unsigned int i)
+{
+	struct tcase *tc = &tcases[i];
+
+	TST_EXP_FAIL(tst_syscall(__NR_fchroot, *tc->fd, tc->flags),
+		tc->exp_errno, "fchroot() with %s", tc->desc);
+}
+
+static void setup(void)
+{
+	dir_fd = SAFE_OPEN(".", O_PATH | O_DIRECTORY);
+	file_fd = SAFE_OPEN(FILENAME, O_CREAT | O_EXCL | O_WRONLY, 0644);
+}
+
+static void cleanup(void)
+{
+	if (dir_fd != -1)
+		SAFE_CLOSE(dir_fd);
+
+	if (file_fd != -1)
+		SAFE_CLOSE(file_fd);
+}
+
+static struct tst_test test = {
+	.test = run,
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+};

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
