Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C92FC624C2
	for <ltp@archiver.kernel.org>; Mon, 31 Aug 2026 08:04:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D7EEC3E96B7
	for <ltp@archiver.kernel.org>; Mon, 31 Aug 2026 10:04:28 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0FB3E3E5B5A
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 10:00:25 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9B84E1400B62
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 10:00:24 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4478A1FB3C;
 Mon, 31 Aug 2026 08:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788163219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H2jNy1gHIE7bVQtvcjr4NohanEE47watmWZMDXblGQM=;
 b=bddx+oNaZXjq2p95KwrlPV5BjL+eUIK5+CSLYZmUdCwz3k7YBMOc9fsooFDsNyhA9ggkRU
 O9ptlzfnA7RV2R5nvIbf5osy/niV0HswXJPCDIB7uyYMKKA2ZdFBNmF/AxV3TQ2ltZ7Bs+
 JSHSuzZYIo5exilEqRF8FVtMKPffBhE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788163219;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H2jNy1gHIE7bVQtvcjr4NohanEE47watmWZMDXblGQM=;
 b=lr1w1V/kPoARJL4YUVl9sFKos+QB8DCpsVxjZOqihNcyimrG7HFJiA2Swy9T65emj7pGLJ
 IDWKnTyNAJK9abBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788163215; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H2jNy1gHIE7bVQtvcjr4NohanEE47watmWZMDXblGQM=;
 b=xDWVGP6LtBwcc58yLdFVFAwP3J5qVheeM98KPJI1fJryEpQxxzFdzibyia6ZqIggV930oo
 i192jUpn9xcdVUQhl1vyacc2Q2vFMB1eyoK70nWY09VusiAJdQfKWPTkV0ibLzy4IxcnsV
 qpVJOihmRnAumOqBHJWx0WnrfWKMKpk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788163215;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H2jNy1gHIE7bVQtvcjr4NohanEE47watmWZMDXblGQM=;
 b=iGFS3RWdttsAj22wly4VJSLLgGaUIyxABgtfvVUAiE3tpTWfSwqlSyquWIET9IBvtDjlFU
 M9pdPjA4Y/yxjcBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1EEF113800;
 Mon, 31 Aug 2026 08:00:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MJLsBYg0lWo9dQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 31 Aug 2026 08:00:08 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 31 Aug 2026 10:00:16 +0200
MIME-Version: 1.0
Message-Id: <20260831-fchroot-v4-15-57cceb68f927@suse.com>
References: <20260831-fchroot-v4-0-57cceb68f927@suse.com>
In-Reply-To: <20260831-fchroot-v4-0-57cceb68f927@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788163205; l=3643;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=rizwp30nhF2wuNGBiV5VdQyfH+PLy0ZN0dUUQ5IerOs=;
 b=Z386wC1v0CiX74HJXVi8CrgdhsYdwdbuDeZR9WGHbHXgvA75JtHi4deR3jPgJvO1RV6Wl9os8
 gpAvBvDFw+5CH1K+jGqD8wgFXJJ1IgiroohRt5cM2EsQvNDxc8jLxVD
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:mid,
 suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH STAGING v4 15/16] fchroot12: test failfs entry with
 shared fs_struct
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

Verify that unprivileged fchroot() into failfs is refused with a
shared fs_struct: a CLONE_FS sibling without no_new_privs could
execute a setuid binary with the failfs root, so entry requires
fs->users == 1, the same restriction setns() applies for the mount
namespace. The sibling bumps fs->users to 2, making the syscall fail
with EINVAL.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/staging                               |  1 +
 testcases/kernel/syscalls/fchroot/.gitignore  |  1 +
 testcases/kernel/syscalls/fchroot/fchroot12.c | 85 +++++++++++++++++++++++++++
 3 files changed, 87 insertions(+)

diff --git a/runtest/staging b/runtest/staging
index 137e3f99a..1655b6813 100644
--- a/runtest/staging
+++ b/runtest/staging
@@ -11,3 +11,4 @@ fchroot08 fchroot08
 fchroot09 fchroot09
 fchroot10 fchroot10
 fchroot11 fchroot11
+fchroot12 fchroot12
diff --git a/testcases/kernel/syscalls/fchroot/.gitignore b/testcases/kernel/syscalls/fchroot/.gitignore
index 650ef2690..e8a6730ee 100644
--- a/testcases/kernel/syscalls/fchroot/.gitignore
+++ b/testcases/kernel/syscalls/fchroot/.gitignore
@@ -10,3 +10,4 @@ fchroot08
 fchroot09
 fchroot10
 fchroot11
+fchroot12
diff --git a/testcases/kernel/syscalls/fchroot/fchroot12.c b/testcases/kernel/syscalls/fchroot/fchroot12.c
new file mode 100644
index 000000000..c08144ecc
--- /dev/null
+++ b/testcases/kernel/syscalls/fchroot/fchroot12.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Test that unprivileged :manpage:`fchroot(2)` into failfs is refused
+ * with a shared ``fs_struct``.
+ *
+ * ``no_new_privs`` is checked on the calling thread, but the root lives in
+ * the fs_struct shared with a :manpage:`clone(2)` ``CLONE_FS`` sibling. A
+ * sibling without no_new_privs could execute a setuid binary with the
+ * failfs root, so entry requires ``fs->users == 1``, the same restriction
+ * :manpage:`setns(2)` applies for the mount namespace. The sibling bumps
+ * ``fs->users`` to 2, making the syscall fail with ``EINVAL``.
+ *
+ * Root is required to drop to an unprivileged user in the forked child.
+ */
+
+#define _GNU_SOURCE
+#include <sys/wait.h>
+#include <pwd.h>
+#include <sched.h>
+#include <signal.h>
+#include <unistd.h>
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
+	if (SAFE_FORK())
+		return;
+
+	struct tst_clone_args args = {
+		.flags = CLONE_FS,
+		.exit_signal = SIGCHLD,
+	};
+	pid_t parent = getpid();
+	pid_t sib;
+
+	SAFE_SETRESUID(ltpuser->pw_uid, ltpuser->pw_uid,
+		ltpuser->pw_uid);
+
+	sib = SAFE_CLONE(&args);
+	if (!sib) {
+		/*
+		 * Parked sibling sharing the fs_struct with the
+		 * caller. It must die with the parent, otherwise it
+		 * would outlive the test.
+		 */
+		SAFE_PRCTL(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
+		if (getppid() == parent)
+			pause();
+		exit(0);
+	}
+
+	SAFE_PRCTL(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+
+	TST_EXP_FAIL(tst_syscall(__NR_fchroot, FD_FAILFS_ROOT, 0),
+		EINVAL, "fchroot() with a shared fs_struct");
+
+	SAFE_KILL(sib, SIGKILL);
+	SAFE_WAITPID(sib, NULL, 0);
+
+	exit(0);
+}
+
+static void setup(void)
+{
+	clone3_supported_by_kernel();
+
+	ltpuser = SAFE_GETPWNAM("nobody");
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.needs_root = 1,
+	.forks_child = 1,
+};

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
