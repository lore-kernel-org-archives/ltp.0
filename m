Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E058360A261F
	for <ltp@archiver.kernel.org>; Tue, 20 Oct 2026 10:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=kUcoPIx5;
	dkim=fail reason="signature verification failed" header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=0J8iM6YT;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=kUcoPIx5;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=0J8iM6YT
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9D47B3E9E10
	for <ltp@archiver.kernel.org>; Tue, 20 Oct 2026 12:19:48 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 57A203EA60A
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 12:16:36 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D8780200976
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 12:16:35 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C04B51F7BA;
 Tue, 20 Oct 2026 10:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792491394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yUeaWRDe9Lfflgj3K6xHbEaEQ+ku0P1mVm5gvqYm9PE=;
 b=kUcoPIx5F1b7+hshXyW5EVocoB9mmMO6V8AjMm5sNdyS1W8bE3+ikRMU0EBiS/LSjr/jkH
 k0oF1X1PXz5LpF1TZcCpGe4xrZd3yNxBP1QslSiRP9/peG3XsimBbRh19ga9sNM/+i6pCL
 gWln96Yem2MnXFnoLAzLJaJyGwYwxjo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792491394;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yUeaWRDe9Lfflgj3K6xHbEaEQ+ku0P1mVm5gvqYm9PE=;
 b=0J8iM6YTK+qS/0TS/SkNfp3lLn/cIZTDo+9wgVg9HuM8b/JWslmO/QlSb4zvPD1gOGM80Y
 01FHEY5Q8S2a6aAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792491394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yUeaWRDe9Lfflgj3K6xHbEaEQ+ku0P1mVm5gvqYm9PE=;
 b=kUcoPIx5F1b7+hshXyW5EVocoB9mmMO6V8AjMm5sNdyS1W8bE3+ikRMU0EBiS/LSjr/jkH
 k0oF1X1PXz5LpF1TZcCpGe4xrZd3yNxBP1QslSiRP9/peG3XsimBbRh19ga9sNM/+i6pCL
 gWln96Yem2MnXFnoLAzLJaJyGwYwxjo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792491394;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yUeaWRDe9Lfflgj3K6xHbEaEQ+ku0P1mVm5gvqYm9PE=;
 b=0J8iM6YTK+qS/0TS/SkNfp3lLn/cIZTDo+9wgVg9HuM8b/JWslmO/QlSb4zvPD1gOGM80Y
 01FHEY5Q8S2a6aAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8DE0113865;
 Tue, 20 Oct 2026 10:16:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id B2PKGIA/12rCMgAAD6G6ig:T13
 (envelope-from <andrea.cervesato@suse.de>); Tue, 20 Oct 2026 10:16:34 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 20 Oct 2026 12:16:41 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <20261020-fchroot-v5-12-63aa6faff503@suse.com>
References: <20261020-fchroot-v5-0-63aa6faff503@suse.com>
In-Reply-To: <20261020-fchroot-v5-0-63aa6faff503@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792491392; l=3686;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=GyGytgwk2uE3D2avZKdGSqrQBIROeIAg/pTBD6OCL/0=;
 b=ig3HnyQ+o7nHUnyrdIPmdKJJyXRkrfBE7SjS8QnjPlmzaOq3sGpuT9XRpsbqOl5IJAsfRCnQS
 WWG7zT/yOrcAk8mdah3YjSvnfLg5jpCXEjYq+5kcBjZbWuTIyGi8MUV
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
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 12/14] fchroot11: test failfs entry with
 no_new_privs
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

Verify that an unprivileged process may enter failfs when it
committed to no_new_privs, since setuid binaries then pose no
confused deputy risk anymore. The test also verifies that a process
which entered failfs counts as chrooted: it can no longer create a
user namespace with unshare() to regain CAP_SYS_CHROOT.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                              |  1 +
 testcases/kernel/syscalls/fchroot/.gitignore  |  1 +
 testcases/kernel/syscalls/fchroot/fchroot11.c | 85 +++++++++++++++++++++++++++
 3 files changed, 87 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 429e2740c..bd7b352fd 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -326,6 +326,7 @@ fchroot07 fchroot07
 fchroot08 fchroot08
 fchroot09 fchroot09
 fchroot10 fchroot10
+fchroot11 fchroot11
 
 fcntl01 fcntl01
 fcntl01_64 fcntl01_64
diff --git a/testcases/kernel/syscalls/fchroot/.gitignore b/testcases/kernel/syscalls/fchroot/.gitignore
index 53a1fa1d0..650ef2690 100644
--- a/testcases/kernel/syscalls/fchroot/.gitignore
+++ b/testcases/kernel/syscalls/fchroot/.gitignore
@@ -9,3 +9,4 @@ fchroot07_child
 fchroot08
 fchroot09
 fchroot10
+fchroot11
diff --git a/testcases/kernel/syscalls/fchroot/fchroot11.c b/testcases/kernel/syscalls/fchroot/fchroot11.c
new file mode 100644
index 000000000..03aaed886
--- /dev/null
+++ b/testcases/kernel/syscalls/fchroot/fchroot11.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Test unprivileged :manpage:`fchroot(2)` into failfs with no_new_privs
+ * set.
+ *
+ * An unprivileged process may enter failfs when it committed to
+ * no_new_privs, since setuid binaries then pose no confused deputy risk
+ * anymore. The test also verifies that a process which entered failfs
+ * counts as chrooted: it can no longer create a user namespace with
+ * :manpage:`unshare(2)` to regain ``CAP_SYS_CHROOT``.
+ *
+ * The user namespace check requires ``CONFIG_USER_NS``, which is enforced
+ * with ``.needs_kconfigs``.
+ *
+ * Root is required to drop to an unprivileged user in the forked child.
+ */
+
+#define _GNU_SOURCE
+#include <fcntl.h>
+#include <pwd.h>
+#include <sched.h>
+#include <sys/wait.h>
+#include "tst_test.h"
+#include "lapi/fcntl.h"
+#include "lapi/prctl.h"
+#include "lapi/sched.h"
+#include "lapi/syscalls.h"
+
+static struct passwd *ltpuser;
+
+static void run(void)
+{
+	int status;
+	pid_t pid;
+
+	if (SAFE_FORK())
+		return;
+
+	SAFE_SETRESUID(ltpuser->pw_uid, ltpuser->pw_uid,
+		ltpuser->pw_uid);
+
+	SAFE_PRCTL(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+
+	pid = SAFE_FORK();
+	if (!pid) {
+		if (unshare(CLONE_NEWUSER) == -1)
+			exit(1);
+		return;
+	}
+
+	SAFE_WAITPID(pid, &status, 0);
+
+	TST_EXP_PASS(tst_syscall(__NR_fchroot, FD_FAILFS_ROOT, 0),
+		"unprivileged fchroot() with no_new_privs");
+
+	TST_EXP_FAIL2(open("/dev/zero", O_RDONLY), EOPNOTSUPP,
+		"absolute lookup after entering failfs");
+
+	if (WIFEXITED(status) && WEXITSTATUS(status) == 0) {
+		TST_EXP_FAIL(unshare(CLONE_NEWUSER), EPERM,
+			"user namespace creation blocked by the failfs root");
+	} else {
+		tst_res(TCONF, "unprivileged user namespaces are not supported");
+	}
+}
+
+static void setup(void)
+{
+	ltpuser = SAFE_GETPWNAM("nobody");
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.needs_root = 1,
+	.forks_child = 1,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_USER_NS=y",
+		NULL,
+	}
+};

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
