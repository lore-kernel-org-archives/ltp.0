Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95BA6C61DCB
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 14:14:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 29B6C3E2692
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 16:14:52 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2DAED3E9A61
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 16:12:03 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7A9CE1000544
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 16:12:02 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C1E91223CD;
 Fri, 28 Aug 2026 14:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787926318; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H2jNy1gHIE7bVQtvcjr4NohanEE47watmWZMDXblGQM=;
 b=Cb1Cb+WQwuurqKSK5C+pBZ3OuQDweacQuqSxlLZHzB+HsPZxITpvpgaodnHGFEHzyl2rdI
 RyYzQF4C4lv7yXl/FfGDxdpYHc+aJuoijD0dYyYv6k7adFeXeVcH3QH1nYkN5EOxoiQTuh
 fLfNDsUtxBb+Pl4nBkP9cIJa5SLkg2U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787926318;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H2jNy1gHIE7bVQtvcjr4NohanEE47watmWZMDXblGQM=;
 b=QvMDsUWvpS8Sr9d4uSKiV2v1WegmO5dHuEd6u/UWT70dy9ltWewmKIXBxH3d4QFrjFs+er
 s3AdYz+jotqqNfCw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=QLd6NJtq;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=a+hqK23D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787926313; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H2jNy1gHIE7bVQtvcjr4NohanEE47watmWZMDXblGQM=;
 b=QLd6NJtqFPa8tdZekxRLT9kbOztotCSL5JIkfNxm7xXbHxWH/fzOoUXvM6ksud7jusrO4Q
 XGeQ0rsQBVpbJrFeqixtN0Ntm2g+8iiKjJYpGtD6EHyjjdVeCmwDwS2j6DdtCUKkSfmlPL
 /p9BmTxECa8Mdy6vkP3Ws9Iuf2qpXp4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787926313;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H2jNy1gHIE7bVQtvcjr4NohanEE47watmWZMDXblGQM=;
 b=a+hqK23DRWljQ3Nv540oIDJd0Md3wtaVdCp1SxrB1vRMnHF3F9NWxw+MDDvM9ExBS2eb8M
 pZaCLz20GkFiq3Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 307891375D;
 Fri, 28 Aug 2026 14:11:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wJ5LCiKXkWpoGwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 28 Aug 2026 14:11:46 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 28 Aug 2026 16:11:48 +0200
MIME-Version: 1.0
Message-Id: <20260828-fchroot-v3-14-656a2b515726@suse.com>
References: <20260828-fchroot-v3-0-656a2b515726@suse.com>
In-Reply-To: <20260828-fchroot-v3-0-656a2b515726@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787926304; l=3643;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=rizwp30nhF2wuNGBiV5VdQyfH+PLy0ZN0dUUQ5IerOs=;
 b=TLPE15thrytGVj3P157eZnUKetQW4ifOq3Gco5Uu9rFC6BdL2TW1ZfEKeADYIYlngdposdgr4
 yWKTFDZj2rACOAhq2hcCRNC+CGVpG1aSNob3uxyiUzICaKWWv+rJVaB
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: C1E91223CD
X-Spamd-Result: default: False [-5.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH STAGING v3 14/15] fchroot12: test failfs entry with
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
