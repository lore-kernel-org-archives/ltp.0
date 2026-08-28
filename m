Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BE67C61DBD
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 14:13:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A3E903E5E00
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 16:13:40 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AAB413E9A6E
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 16:12:02 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id F010B600713
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 16:12:01 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5EE751FEC9;
 Fri, 28 Aug 2026 14:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787926317; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VNYPNs39YkdcnWOtBpd2M3+xsDIEOZnDW1em969cUYY=;
 b=kMF0D3gDSefcU8PTqr+QQaDqxnp8oWcFzPygez0jya6lFm5eYs1OUk0HS12k72Z5UBWSly
 YsAMMAXdRNip/2pGpm3RNNnBn6MImsICo8cSXUzZ2u2kby4uaoxDXS0BJNls1vyqFkBE9+
 jphuvGlEcRvYU/UGhn3M7yELls86AeA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787926317;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VNYPNs39YkdcnWOtBpd2M3+xsDIEOZnDW1em969cUYY=;
 b=5j9cb/khKNLnjILddmt3pb4dgFpGuAGH0Wp3itWpoa+M577GnGr9XgN6gj9ndaWA3bll3i
 1vDmYEAbBPukHNAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787926313; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VNYPNs39YkdcnWOtBpd2M3+xsDIEOZnDW1em969cUYY=;
 b=Of7AFt6PEMgWEMlLjoldWEMhDLIO/KmUI25M6cXADp4dUNRG3hkfHG4l1kiPpEFMX6RwIn
 HwZpwSrPkCz1r3hsFYlcE2HJdDf8aL36PKbHkbZ6jUEPpUZqxnQNIBhiNF+9VIt9qbUERa
 VD11o+lvUtplmkGJjWSi3k/KnvaquWo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787926313;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VNYPNs39YkdcnWOtBpd2M3+xsDIEOZnDW1em969cUYY=;
 b=Oo3092Xx5d6e/wZltd8LJVL99/fkgC0QSiKBNMohJWStrN+ZBlgWyTLzmLlB28diYy3Py3
 dKtnXir+32AqcEBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A2811136A2;
 Fri, 28 Aug 2026 14:11:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MNOzJSGXkWpoGwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 28 Aug 2026 14:11:45 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 28 Aug 2026 16:11:44 +0200
MIME-Version: 1.0
Message-Id: <20260828-fchroot-v3-10-656a2b515726@suse.com>
References: <20260828-fchroot-v3-0-656a2b515726@suse.com>
In-Reply-To: <20260828-fchroot-v3-0-656a2b515726@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787926304; l=5384;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=kqIs33gKN+jbGxT80ETyT1YukEkF5tLCpCDVdY4cfjU=;
 b=HuxBUuNI4eQ2X+jPGTyEBqBWCetDudDcB5xR6kh8u8ryP7pesKuMRIU9F5Msqzfl2ifuSxHJE
 HfCQ/oyy/DqAtzQHmBzLh1Dq3M/PKGhezrNCM2HjqSwiw7s36tY6ozQ
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
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH STAGING v3 10/15] fchroot07: test execve blocked by
 failfs root
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

Verify that after fchroot() moved the root into failfs, loading a
binary by absolute path fails with EOPNOTSUPP. The exec runs in a
grandchild so a wrongly successful exec is still detected through
the exit code.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/staging                                    |  2 +
 testcases/kernel/syscalls/fchroot/.gitignore       |  3 +
 testcases/kernel/syscalls/fchroot/fchroot07.c      | 56 ++++++++++++++++++
 .../kernel/syscalls/fchroot/fchroot07_child.c      | 16 +++++
 testcases/kernel/syscalls/fchroot/fchroot08.c      | 69 ++++++++++++++++++++++
 5 files changed, 146 insertions(+)

diff --git a/runtest/staging b/runtest/staging
index 8b6b1ecd9..8dfe95c4a 100644
--- a/runtest/staging
+++ b/runtest/staging
@@ -6,3 +6,5 @@ fchroot03 fchroot03
 fchroot04 fchroot04
 fchroot05 fchroot05
 fchroot06 fchroot06
+fchroot07 fchroot07
+fchroot08 fchroot08
diff --git a/testcases/kernel/syscalls/fchroot/.gitignore b/testcases/kernel/syscalls/fchroot/.gitignore
index 12151270a..0a2510d8a 100644
--- a/testcases/kernel/syscalls/fchroot/.gitignore
+++ b/testcases/kernel/syscalls/fchroot/.gitignore
@@ -4,3 +4,6 @@ fchroot03
 fchroot04
 fchroot05
 fchroot06
+fchroot07
+fchroot07_child
+fchroot08
diff --git a/testcases/kernel/syscalls/fchroot/fchroot07.c b/testcases/kernel/syscalls/fchroot/fchroot07.c
new file mode 100644
index 000000000..a57d3e6ce
--- /dev/null
+++ b/testcases/kernel/syscalls/fchroot/fchroot07.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Test that :manpage:`execve(2)` is blocked under the failfs root.
+ *
+ * After :manpage:`fchroot(2)` moved the process root into failfs, loading
+ * a binary by absolute path fails with ``EOPNOTSUPP``.
+ *
+ * Root is required because entering failfs with the ``FD_FAILFS_ROOT``
+ * sentinel requires ``CAP_SYS_CHROOT``.
+ */
+
+#define _GNU_SOURCE
+#include <unistd.h>
+#include "tst_test.h"
+#include "lapi/fcntl.h"
+#include "lapi/syscalls.h"
+
+#define CHILD_EXEC "fchroot07_child"
+
+static char child_path[PATH_MAX];
+
+static void run(void)
+{
+	if (SAFE_FORK())
+		return;
+
+	TST_EXP_PASS(tst_syscall(__NR_fchroot, FD_FAILFS_ROOT, 0),
+		"fchroot() with the FD_FAILFS_ROOT sentinel");
+
+	if (!SAFE_FORK()) {
+		TST_EXP_FAIL(execl(child_path, CHILD_EXEC, NULL), EOPNOTSUPP,
+			"absolute exec blocked by the failfs root");
+		exit(0);
+	}
+
+	SAFE_WAIT(NULL);
+	exit(0);
+}
+
+static void setup(void)
+{
+	if (tst_get_path(CHILD_EXEC, child_path, sizeof(child_path)))
+		tst_brk(TCONF, "Couldn't find %s in $PATH", CHILD_EXEC);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.needs_root = 1,
+	.forks_child = 1,
+	.child_needs_reinit = 1,
+};
diff --git a/testcases/kernel/syscalls/fchroot/fchroot07_child.c b/testcases/kernel/syscalls/fchroot/fchroot07_child.c
new file mode 100644
index 000000000..3d731781c
--- /dev/null
+++ b/testcases/kernel/syscalls/fchroot/fchroot07_child.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+#define TST_NO_DEFAULT_MAIN
+#include "tst_test.h"
+
+int main(void)
+{
+	tst_reinit();
+
+	tst_res(TFAIL, "child executed");
+
+	return 0;
+}
diff --git a/testcases/kernel/syscalls/fchroot/fchroot08.c b/testcases/kernel/syscalls/fchroot/fchroot08.c
new file mode 100644
index 000000000..3efe8d85f
--- /dev/null
+++ b/testcases/kernel/syscalls/fchroot/fchroot08.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Test that the failfs root is inherited across :manpage:`fork(2)`.
+ *
+ * The root moved into failfs by :manpage:`fchroot(2)` lives in the
+ * fs_struct which is duplicated on fork, so a child of a process with the
+ * failfs root also fails every absolute path lookup with ``EOPNOTSUPP``.
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
+#include <sys/wait.h>
+#include "tst_test.h"
+#include "lapi/fcntl.h"
+#include "lapi/syscalls.h"
+
+#define ABSDIR "abs"
+
+static void run(void)
+{
+	if (SAFE_FORK())
+		return;
+
+	pid_t pid;
+
+	TST_EXP_PASS(tst_syscall(__NR_fchroot, FD_FAILFS_ROOT, 0),
+		"fchroot() with the FD_FAILFS_ROOT sentinel");
+
+	pid = SAFE_FORK();
+	if (!pid) {
+		TST_EXP_FAIL2(open(ABSDIR, O_PATH), EOPNOTSUPP,
+			"absolute lookup in a forked child");
+		exit(0);
+	}
+
+	SAFE_WAITPID(pid, NULL, 0);
+
+	exit(0);
+}
+
+static void setup(void)
+{
+	char *tmpdir;
+	char abs_path[PATH_MAX];
+
+	tmpdir = tst_tmpdir_path();
+	snprintf(abs_path, sizeof(abs_path), "%s/%s", tmpdir, "target");
+
+	SAFE_TOUCH("target", 0644, NULL);
+	SAFE_SYMLINK(abs_path, ABSDIR);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.needs_root = 1,
+	.forks_child = 1,
+	.needs_tmpdir = 1,
+};

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
