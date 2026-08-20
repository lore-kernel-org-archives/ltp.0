Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69C16C5DF81
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 07:46:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EBF733CE52A
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 09:46:55 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5823E3CE782
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 09:45:01 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D9B896002C7
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 09:45:00 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4089684F99;
 Thu, 20 Aug 2026 07:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787211896; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9ZXK5oik8mt3K4YxQpdv0kltsVxTjxTxPz17MhKq5fQ=;
 b=z0ZZwaakn7sGlonnjrMnTAAOIZ2IhuCsRDpkGKRAQDWRqJlsxoJ/SYZ//wpkjphhWZ/G/r
 pXgZW52lJ/fMa2reDcRqSzLZgFZFUMpC+8jcSrypuHk/JGix9j2ewgKqLDl4gxyBgihHU4
 RmZSp2V/cdXJNOCQmwRoX1YYbwydrw0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787211896;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9ZXK5oik8mt3K4YxQpdv0kltsVxTjxTxPz17MhKq5fQ=;
 b=e9EXZHLlugQNcADdAW6OBH6ZfntmCVTHWbg2ZVLp/0TwsQsO0eFj4TqgIftVZdsrhT5YPj
 KOd7y+3Xu+ffwdDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787211892; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9ZXK5oik8mt3K4YxQpdv0kltsVxTjxTxPz17MhKq5fQ=;
 b=SFKwcP3brOUqxQr0KcbJ+q0Q/9zvAfnwICM0UjMqa5MbhVzgXvIvnmrFTEOIYByhtxVxgu
 VwQ/qNfIeq4PiCWxJvQlpUkjykW2axmZ2njIJUIUX60qTgpIr3VbuE9DHO7ah2SaaHGRVv
 afDNOSr2QW9xZ8v+gk4/Lu9cakhYcTE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787211892;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9ZXK5oik8mt3K4YxQpdv0kltsVxTjxTxPz17MhKq5fQ=;
 b=VWftDSd/F4gPyj4a9jeiSDUDUjvd1iMmjG/r2sldGz2NiCBZDAXxPmARti86O8Y2IhhH5Y
 ysofiweGfgA8uRDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 081CE367C;
 Thu, 20 Aug 2026 07:44:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KLl/Omywhmr3YgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 20 Aug 2026 07:44:44 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 20 Aug 2026 09:44:45 +0200
MIME-Version: 1.0
Message-Id: <20260820-fchroot-v2-5-062ed20957a0@suse.com>
References: <20260820-fchroot-v2-0-062ed20957a0@suse.com>
In-Reply-To: <20260820-fchroot-v2-0-062ed20957a0@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787211883; l=3760;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=xBbw2pitrEy5FQkY5zaKlWubJ0ryLzxMI15/q4aW32Q=;
 b=cOAzqnBdtkqrBU6EYvg5BbZ2yCHib9eFU87Jje77evjtgklXMXuqJkF6VO+IXMYQstoyvtQtn
 fMZB/xO5d3GAb441kELwL+UyQuSapLYp06pOx9obVG9rmFXx4MJv91D
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.com:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH STAGING v2 05/16] fchroot02: test fchroot() invalid
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
index 000000000..96be00d70
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
+ * :manpage:`fchroot(2)` was introduced in Linux v7.3. The syscall checks its
+ * arguments in this order:
+ *
+ * - a non-zero flags argument fails with ``EINVAL`` before anything else,
+ *   including with the ``FD_FAILFS_ROOT`` sentinel and with an invalid fd
+ * - an invalid fd fails with ``EBADF``, including the ``FD_PIDFS_ROOT`` and
+ *   ``FD_NSFS_ROOT`` sentinels which :manpage:`fchroot(2)` does not accept
+ * - a fd referring to a regular file fails with ``ENOTDIR``
+ *
+ * All these checks happen before the ``CAP_SYS_CHROOT`` check, so the test
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
