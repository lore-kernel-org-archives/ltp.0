Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EE62C61DD3
	for <ltp@archiver.kernel.org>; Mon, 31 Aug 2026 08:01:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EECD63E5A9A
	for <ltp@archiver.kernel.org>; Mon, 31 Aug 2026 10:01:55 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C15BE3E5ABF
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 10:00:20 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 866EA600915
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 10:00:18 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B81E11FB1D;
 Mon, 31 Aug 2026 08:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788163213; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k/EMPL3OqKJ5k/goWc12DSn+7PfgHvTaljX9Qt+fS2c=;
 b=xOWCcn8wdJu5ISDY9ltWOSRKsCBKtz2/sMVWsEDOXSRbmtNdgdg5AU+u7mxU0z4tlMra7f
 Fc5ENsn9lt76FATP1QDOEQNG2zsFLVReVVURO+/LeDcO8RrQOv+cT6rKGien3pmaxMuc4Y
 6t5ZVNzS6KiFB1VIs/Hm1r4Gw4ngMss=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788163213;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k/EMPL3OqKJ5k/goWc12DSn+7PfgHvTaljX9Qt+fS2c=;
 b=a+VMY8VnZQw8tktgBFwJlQGY8X91ZxfKQXd2m+b54SMC3Vm9ZfP9iS8gPb/2lGjgkrtCN8
 i1+D/0v5mQ3FP7BQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788163209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k/EMPL3OqKJ5k/goWc12DSn+7PfgHvTaljX9Qt+fS2c=;
 b=OOAPIBiWlJgQ3fzfKup8qJq7ecZb28lGzirt9MBlb8tlTXk368vITUkVwjh9TVqYVR/x9j
 MFJEdL78wlAS+oxC41X/n6Dkw+lidz+qtql0IhEwH6o8aUNCpSDfTRiTpcF7kUDqG31iEO
 EtFwkTrZ2IPVhyh7+bFZycDzkGDCGLE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788163209;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k/EMPL3OqKJ5k/goWc12DSn+7PfgHvTaljX9Qt+fS2c=;
 b=Ovx2re1WSc9WqmMrs++3imjQ7glcXGIm/fnH0AC6dJBvP18LymqmCdOFZ0Yna2fToZQNYs
 SHJgJ80jMIxsPyDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A472C136DB;
 Mon, 31 Aug 2026 08:00:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sKiAJoY0lWo9dQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 31 Aug 2026 08:00:06 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 31 Aug 2026 10:00:06 +0200
MIME-Version: 1.0
Message-Id: <20260831-fchroot-v4-5-57cceb68f927@suse.com>
References: <20260831-fchroot-v4-0-57cceb68f927@suse.com>
In-Reply-To: <20260831-fchroot-v4-0-57cceb68f927@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788163205; l=3484;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=NuX/2HKkoHoxeeFUE980glDbsE+iV6Gt7Mi/kodMrv8=;
 b=eeJWaaKNlHJNf1y6FQmbO6+pc4+xAni7SLaurOpB8B+tDn/DmwMTSOAFX4TogFGn2Cmgn+1rO
 /oeWxHhhioXAyrXQISTKBgS6s4oAAH7YXk96xneuTMjiO6EhMSHrhhz
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH STAGING v4 05/16] fchroot02: test fchroot() invalid
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
 testcases/kernel/syscalls/fchroot/fchroot02.c | 75 +++++++++++++++++++++++++++
 3 files changed, 77 insertions(+)

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
index 000000000..cf5bca874
--- /dev/null
+++ b/testcases/kernel/syscalls/fchroot/fchroot02.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Test the :manpage:`fchroot(2)` error paths for invalid arguments:
+ *
+ * - a non-zero flags argument fails with ``EINVAL``
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
