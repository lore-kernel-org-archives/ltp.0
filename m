Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA535606A31C
	for <ltp@archiver.kernel.org>; Tue, 20 Oct 2026 10:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=VXOGUMjn;
	dkim=fail reason="signature verification failed" header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=QGzS6P3T;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=VXOGUMjn;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=QGzS6P3T
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 888553EA615
	for <ltp@archiver.kernel.org>; Tue, 20 Oct 2026 12:19:20 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3E86E3EA609
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 12:16:36 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 997701A00917
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 12:16:35 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 508011F79E;
 Tue, 20 Oct 2026 10:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792491394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nJPi4/sr02veF32u+UKBymKwopGSCi64ZxKhQjA+VoM=;
 b=VXOGUMjnKZ52RApAqAgaYsS2K1hUUZzai4alsX1SE9TLU2OAr4dMYi/+0FYS1PvqiOq5JG
 RIsY2Umovkbrzl4irxYBxz2nn7oUdYrNcMqb5ghfwSucUAzybTbS5yiVfnrpJF+dUuLTcR
 b9vFsm3YsgNFlySMakFgHxz0u4nl6Gg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792491394;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nJPi4/sr02veF32u+UKBymKwopGSCi64ZxKhQjA+VoM=;
 b=QGzS6P3TnzfBNr9+oPWm1LG6Q3SnnB/V40g8md18utguKYjZ9GTjJcND9C9Ch1NcYG+vyu
 G8TqmOVqZDUq1+Cw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792491394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nJPi4/sr02veF32u+UKBymKwopGSCi64ZxKhQjA+VoM=;
 b=VXOGUMjnKZ52RApAqAgaYsS2K1hUUZzai4alsX1SE9TLU2OAr4dMYi/+0FYS1PvqiOq5JG
 RIsY2Umovkbrzl4irxYBxz2nn7oUdYrNcMqb5ghfwSucUAzybTbS5yiVfnrpJF+dUuLTcR
 b9vFsm3YsgNFlySMakFgHxz0u4nl6Gg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792491394;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nJPi4/sr02veF32u+UKBymKwopGSCi64ZxKhQjA+VoM=;
 b=QGzS6P3TnzfBNr9+oPWm1LG6Q3SnnB/V40g8md18utguKYjZ9GTjJcND9C9Ch1NcYG+vyu
 G8TqmOVqZDUq1+Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BD18D13865;
 Tue, 20 Oct 2026 10:16:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id B2PKGIA/12rCMgAAD6G6ig:T8
 (envelope-from <andrea.cervesato@suse.de>); Tue, 20 Oct 2026 10:16:33 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 20 Oct 2026 12:16:36 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <20261020-fchroot-v5-7-63aa6faff503@suse.com>
References: <20261020-fchroot-v5-0-63aa6faff503@suse.com>
In-Reply-To: <20261020-fchroot-v5-0-63aa6faff503@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792491392; l=4686;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=qrvneNZ8hoeF39zPGKbU1Sv5KLw3qBG972qOY2xQWOY=;
 b=n95Wy36Tzt52YiNWff9kEbl4+zl7525hlAlS5IV14lpnd47qtfqCg0w0IpsaFvVZ1+nuXt6Th
 416oOUTILYqARy+OVHiPL1uzJRCq7k3thXsffvha3h/y8sGvRI+62G/
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 07/14] fchroot06: test path walks under failfs root
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

Verify that once the root is in failfs only lookups anchored at a
file descriptor keep working: relative lookups from the working
directory and from a pre-opened directory fd succeed, absolute
symlinks fail with EOPNOTSUPP and ".." walks clamp at the top of the
mount tree, landing on the real root.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/fchroot/.gitignore  |   1 +
 testcases/kernel/syscalls/fchroot/fchroot06.c | 124 ++++++++++++++++++++++++++
 3 files changed, 126 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index a5ed6792e..8b688cbe2 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -321,6 +321,7 @@ fchroot02 fchroot02
 fchroot03 fchroot03
 fchroot04 fchroot04
 fchroot05 fchroot05
+fchroot06 fchroot06
 
 fcntl01 fcntl01
 fcntl01_64 fcntl01_64
diff --git a/testcases/kernel/syscalls/fchroot/.gitignore b/testcases/kernel/syscalls/fchroot/.gitignore
index 0697f10eb..12151270a 100644
--- a/testcases/kernel/syscalls/fchroot/.gitignore
+++ b/testcases/kernel/syscalls/fchroot/.gitignore
@@ -3,3 +3,4 @@ fchroot02
 fchroot03
 fchroot04
 fchroot05
+fchroot06
diff --git a/testcases/kernel/syscalls/fchroot/fchroot06.c b/testcases/kernel/syscalls/fchroot/fchroot06.c
new file mode 100644
index 000000000..d7d7dfc50
--- /dev/null
+++ b/testcases/kernel/syscalls/fchroot/fchroot06.c
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Test path walks under the failfs root.
+ *
+ * Once :manpage:`fchroot(2)` moved the process root into failfs, only
+ * lookups anchored at a file descriptor keep working:
+ *
+ * - lookups relative to the working directory, which stays in the real
+ *   filesystem, keep working
+ * - lookups anchored at a pre-opened directory fd keep working, including
+ *   resolution of relative symlinks
+ * - absolute symlinks restart the walk at the failfs root and fail with
+ *   ``EOPNOTSUPP``
+ * - ".." walks clamp at the top of the mount tree, not at the failfs
+ *   root, so walking up from the working directory lands on the real
+ *   root
+ *
+ * Root is required because entering failfs with the ``FD_FAILFS_ROOT``
+ * sentinel requires ``CAP_SYS_CHROOT``.
+ *
+ * The test runs in a forked child so the root of the parent process is
+ * left untouched.
+ */
+
+#define _GNU_SOURCE
+#include <fcntl.h>
+#include <string.h>
+#include <sys/stat.h>
+#include "tst_test.h"
+#include "lapi/fcntl.h"
+#include "lapi/syscalls.h"
+
+#define RELDIR "rel"
+#define ABSDIR "abs"
+
+static char upwards[PATH_MAX];
+
+static void run(void)
+{
+	if (SAFE_FORK())
+		return;
+
+	struct stat realroot, st;
+	int dfd, fd;
+
+	SAFE_STAT("/", &realroot);
+	dfd = SAFE_OPEN(".", O_RDONLY | O_DIRECTORY);
+
+	TST_EXP_PASS(tst_syscall(__NR_fchroot, FD_FAILFS_ROOT, 0),
+		"fchroot() with the FD_FAILFS_ROOT sentinel");
+
+	fd = TST_EXP_FD(openat(AT_FDCWD, ".", O_RDONLY | O_DIRECTORY));
+	if (fd != -1)
+		SAFE_CLOSE(fd);
+
+	fd = TST_EXP_FD(openat(dfd, "canary", O_WRONLY | O_CREAT, 0600));
+	if (fd != -1) {
+		SAFE_WRITE(SAFE_WRITE_ALL, fd, "x", 1);
+		SAFE_CLOSE(fd);
+	}
+
+	fd = TST_EXP_FD(openat(dfd, RELDIR, O_RDONLY));
+	if (fd != -1)
+		SAFE_CLOSE(fd);
+
+	TST_EXP_FAIL2(openat(dfd, ABSDIR, O_RDONLY), EOPNOTSUPP,
+		"resolution of an absolute symlink");
+
+	fd = TST_EXP_FD(openat(AT_FDCWD, upwards, O_PATH));
+	if (fd != -1) {
+		SAFE_FSTAT(fd, &st);
+		SAFE_CLOSE(fd);
+
+		TST_EXP_EXPR(st.st_dev == realroot.st_dev &&
+			st.st_ino == realroot.st_ino,
+			"'..' walk clamps at the top of the mount tree");
+	}
+
+	SAFE_CLOSE(dfd);
+}
+
+static void setup(void)
+{
+	char *tmpdir;
+	char abs_path[PATH_MAX];
+	struct stat root_st, st;
+	int off;
+
+	tmpdir = tst_tmpdir_path();
+	snprintf(abs_path, sizeof(abs_path), "%s/%s", tmpdir, "target");
+
+	SAFE_TOUCH("target", 0644, NULL);
+	SAFE_SYMLINK("target", RELDIR);
+	SAFE_SYMLINK(abs_path, ABSDIR);
+
+	SAFE_STAT("/", &root_st);
+
+	strcpy(upwards, "..");
+	off = 2;
+	while (1) {
+		SAFE_STAT(upwards, &st);
+
+		if (st.st_dev == root_st.st_dev && st.st_ino == root_st.st_ino)
+			break;
+
+		if ((size_t)off + sizeof("/..") > sizeof(upwards))
+			tst_brk(TBROK, "Path to root too long");
+
+		strcpy(upwards + off, "/..");
+		off += 3;
+	}
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.forks_child = 1,
+};

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
