Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97FC4C5B572
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 21:28:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 20F303CD600
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 23:28:49 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A17953CD718
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 23:24:45 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7AB64200963
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 23:24:45 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9B55B3EF0;
 Wed, 19 Aug 2026 21:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787174680; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lfp6eFgYu1wUwTBFvTP75KvfURvJoUIAvhd/mAwskEc=;
 b=Vdvfa/yjcHiLhm9wciTeppxRxSUIN12TZx6Vho1+l5ArvVYLldVnSkxr+q6Q6sIIWdGHzr
 uqrPvqr+3mi0CtLK7BC9f9XuJ0ce+2lioSked1q/oJwZIv0D53TOwdwfmYyIdd6D8QzjSr
 zHbBACir85QzediCbFGKOJbfxKVzZUI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787174680;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lfp6eFgYu1wUwTBFvTP75KvfURvJoUIAvhd/mAwskEc=;
 b=7DWqgGBdI8oLX3Al1F0YK2gUi5jgJgltmTTAupkLqrWtzFvkAxhopiJ3gpAozONsz0VeFI
 sxsq+mzs5Rob4WDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787174676; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lfp6eFgYu1wUwTBFvTP75KvfURvJoUIAvhd/mAwskEc=;
 b=A4PoL5JCkq4xhYfgz2UIxxo5DX7tAAD0jbptEuaA/7bDRV9D01YS65BA0ocFCaZHStHFvg
 mT2/GsG+dMdpyqE2kHSRFnaXJaVrXhgyABM7YldbKWlnlnrySUPhWMRxxIge44Pys3ZQez
 zJoNeOX6hPcI61slMggK4nuxiMy6SwQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787174676;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lfp6eFgYu1wUwTBFvTP75KvfURvJoUIAvhd/mAwskEc=;
 b=X8DKvlbz+EozEPWYD1z/sPCW5+sIWooMCo0kbx/aKrL5nF1fYU90paZeBhwCNfOBxYt1V3
 iCYnsX37G0c7J7Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E9BF13688;
 Wed, 19 Aug 2026 21:24:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AOX4NQcfhmqSGwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 19 Aug 2026 21:24:23 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 19 Aug 2026 23:24:30 +0200
MIME-Version: 1.0
Message-Id: <20260819-fchroot-v1-15-2dc2c3c3cf29@suse.com>
References: <20260819-fchroot-v1-0-2dc2c3c3cf29@suse.com>
In-Reply-To: <20260819-fchroot-v1-0-2dc2c3c3cf29@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787174658; l=3600;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=Kiop3ejll/inGfAonCRfFU3zBfH32O8X5CeFw0XUVsg=;
 b=iBWpZx13F2W/J6NLP4nBi4HlPQLw2DkX005PRi0eEivm4+o0J36TQheZBhy4XPMD0aqdNuKHt
 ADXLIeTNff8CoK4G9yZARvfpqkqBGiSEnfBgVtrHSt6L01e1A4JgXm/
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH STAGING 15/16] fchroot12: test failfs entry with
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
 testcases/kernel/syscalls/fchroot/fchroot12.c | 82 +++++++++++++++++++++++++++
 3 files changed, 84 insertions(+)

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
index 0eca20548..de8ca0688 100644
--- a/testcases/kernel/syscalls/fchroot/.gitignore
+++ b/testcases/kernel/syscalls/fchroot/.gitignore
@@ -9,3 +9,4 @@ fchroot08
 fchroot09
 fchroot10
 fchroot11
+fchroot12
diff --git a/testcases/kernel/syscalls/fchroot/fchroot12.c b/testcases/kernel/syscalls/fchroot/fchroot12.c
new file mode 100644
index 000000000..97fefb9fa
--- /dev/null
+++ b/testcases/kernel/syscalls/fchroot/fchroot12.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Test that unprivileged :manpage:`fchroot(2)` into failfs is refused
+ * with a shared fs_struct.
+ *
+ * no_new_privs is checked on the calling thread, but the root lives in
+ * the fs_struct shared with a :manpage:`clone(2)` CLONE_FS sibling. A
+ * sibling without no_new_privs could execute a setuid binary with the
+ * failfs root, so entry requires fs->users == 1, the same restriction
+ * :manpage:`setns(2)` applies for the mount namespace. The sibling bumps
+ * fs->users to 2, making the syscall fail with EINVAL.
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
+	if (!SAFE_FORK()) {
+		struct tst_clone_args args = {
+			.flags = CLONE_FS,
+			.exit_signal = SIGCHLD,
+		};
+		pid_t parent = getpid();
+		pid_t sib;
+
+		SAFE_SETRESUID(ltpuser->pw_uid, ltpuser->pw_uid,
+			ltpuser->pw_uid);
+
+		sib = SAFE_CLONE(&args);
+		if (!sib) {
+			/*
+			 * Parked sibling sharing the fs_struct with the
+			 * caller. It must die with the parent, otherwise it
+			 * would outlive the test.
+			 */
+			SAFE_PRCTL(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
+			if (getppid() == parent)
+				pause();
+			exit(0);
+		}
+
+		SAFE_PRCTL(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+
+		TST_EXP_FAIL(tst_syscall(__NR_fchroot, FD_FAILFS_ROOT, 0),
+			EINVAL, "fchroot() with a shared fs_struct");
+
+		SAFE_KILL(sib, SIGKILL);
+		SAFE_WAITPID(sib, NULL, 0);
+
+		exit(0);
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
+};

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
