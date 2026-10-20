Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D2460A2603
	for <ltp@archiver.kernel.org>; Tue, 20 Oct 2026 10:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=b24stCIX;
	dkim=fail reason="signature verification failed" header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=HWCssYAC;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=UFjhNRc3;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=QOROy4oL
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 071183EA60A
	for <ltp@archiver.kernel.org>; Tue, 20 Oct 2026 12:20:03 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A0A273EA60A
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 12:16:35 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 109B310005A1
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 12:16:34 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5577621DAD;
 Tue, 20 Oct 2026 10:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792491394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6Fak2iSR2gGASCJq+h04b/LfAt26kXIpBi1AWsW6KaQ=;
 b=b24stCIXUcvtvSAAcZjDWz5t7z+ncnliw1j6ZSPh6RnEGza/mYmTvyt/jsR6XtN9LNUjEB
 Gs0yZS8RrORp6WeOZUslZnLItgyCnc1RwTDX2t2NOfrDLSPAY/d8RUzlYpOJVRwtzTKcKl
 mbbTog3Qers+0Cwl/RYDgvX55lXhsGw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792491394;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6Fak2iSR2gGASCJq+h04b/LfAt26kXIpBi1AWsW6KaQ=;
 b=HWCssYACsVm5GnWJ9k+LI8RdDWQcttEibMpj6SS/QWJa7uzdRYCNOMjhOprWsYXcwyzjLV
 Yk4de0DH7n2BkFDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792491393; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6Fak2iSR2gGASCJq+h04b/LfAt26kXIpBi1AWsW6KaQ=;
 b=UFjhNRc3s6N6gvFRncsZxCqfHvYmuSS9X4AF0lZLOMnhoj4N5G0gZQG5lfApk+qA1Sqr4m
 NPEp96fuwowr7tfXpuT2DdByUw4GSe6CCdOGRDvJLILob4AzgOF4MiFFXrVB+gY0LGlMcm
 KbYDUv7Vul2bI5tz/jzqxdNo2eplrQ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792491393;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6Fak2iSR2gGASCJq+h04b/LfAt26kXIpBi1AWsW6KaQ=;
 b=QOROy4oL9Aap0A1JaPs5NZCgwynApmzUALIvVrgPYXb6lNEbUgr/2+UJ4v6K1vwutlSXuF
 gn9Mc3/GdRIMxbBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 14DA613800;
 Tue, 20 Oct 2026 10:16:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id B2PKGIA/12rCMgAAD6G6ig:T4
 (envelope-from <andrea.cervesato@suse.de>); Tue, 20 Oct 2026 10:16:33 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 20 Oct 2026 12:16:32 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <20261020-fchroot-v5-3-63aa6faff503@suse.com>
References: <20261020-fchroot-v5-0-63aa6faff503@suse.com>
In-Reply-To: <20261020-fchroot-v5-0-63aa6faff503@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792491392; l=3563;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=AlYw7/73G0OZvpGw7IvQp4wHLzkLQj82CXSNZu5NiE8=;
 b=rLTqZeg9oEJB353zEIgNfrJk39OC3Cm1wsRgAgsdZXA1ZwiK8aEKeQlwC3/ATCDIBnzDSzAyq
 7FRTQeOOVKODEp1wKDkKckPhmnvvPsBLrbKpVYcD+NFZbqY4erLxOIQ
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, suse.com:email,
 imap1.dmz-prg2.suse.org:helo]
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 03/14] fchroot02: test fchroot() invalid arguments
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Andrea Cervesato <andrea.cervesato@suse.com>

Verify the fchroot() error paths: a non-zero flags argument fails with
EINVAL before anything else, an invalid fd fails with EBADF, including
the FD_PIDFS_ROOT and FD_NSFS_ROOT sentinels, and a fd referring to a
regular file fails with ENOTDIR. All these checks happen before the
CAP_SYS_CHROOT check, so no privileges are needed.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                              |  1 +
 testcases/kernel/syscalls/fchroot/.gitignore  |  1 +
 testcases/kernel/syscalls/fchroot/fchroot02.c | 75 +++++++++++++++++++++++++++
 3 files changed, 77 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 558ad1732..c4070e970 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -317,6 +317,7 @@ fchownat02 fchownat02
 fchownat03 fchownat03
 
 fchroot01 fchroot01
+fchroot02 fchroot02
 
 fcntl01 fcntl01
 fcntl01_64 fcntl01_64
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
