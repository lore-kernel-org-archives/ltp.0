Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12FD6C5DF82
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 07:49:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 669633CE094
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 09:49:05 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BD49B3CE4B9
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 09:45:10 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2CD6614002DD
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 09:45:09 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8442984F96;
 Thu, 20 Aug 2026 07:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787211904; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N5A3Mok2VCveOFC9uk0lGYdQFjza60gZzv7EP2KkgeI=;
 b=d3+6QUT8/96bIiQIn1qUvbLefNprAu4bUz82ZKXLcaj5J9UgHryR9ZHl1n0kHxtdYWXJ13
 kccSXHkpcb5f7KloEKSDIobd1zRexeL3U+bdvWJjX1CljdQZSpGhTPbXhZeWDNfmpRZkIv
 SSedFD+mgAiq8BG2N9Voab8YkbR187Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787211904;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N5A3Mok2VCveOFC9uk0lGYdQFjza60gZzv7EP2KkgeI=;
 b=MfXB9Jw1yA+IDlIqxzqzHSxJTmzvZzTgm1b08bPzxmVqsbetuTahfVEC/DK9rvrhj56Q73
 EH5ZCdlqvBwBYxCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787211900; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N5A3Mok2VCveOFC9uk0lGYdQFjza60gZzv7EP2KkgeI=;
 b=IQME2GFoB4QwBpGIheCvhj9VJYYh3UWoKoKviG57jU1HR4YFR1NKzW8dD98TM5HgBud65H
 AzoKCZptnrlSEu0GBaez5d32cZYIZuXX0EFEgncPm5gcF1QbQvG/zwPr4/auIdhiUgiweO
 1U616cK7opiogcrEjrOf9KgzuZ5HyDY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787211900;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N5A3Mok2VCveOFC9uk0lGYdQFjza60gZzv7EP2KkgeI=;
 b=iT2s0HT1UB7eW4bavLMPtuFa1HebaDGVth9G649EvZ9UtoB9OlVw3HwYszeRLcfAFfgFxs
 Cs/b9DZlK19BnWCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A69853688;
 Thu, 20 Aug 2026 07:44:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gOuRJW+whmr3YgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 20 Aug 2026 07:44:47 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 20 Aug 2026 09:44:55 +0200
MIME-Version: 1.0
Message-Id: <20260820-fchroot-v2-15-062ed20957a0@suse.com>
References: <20260820-fchroot-v2-0-062ed20957a0@suse.com>
In-Reply-To: <20260820-fchroot-v2-0-062ed20957a0@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787211883; l=3641;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=pGwphBP/iMtOjo6q4L0Nd3Tz/rmv/fEIr0Prmwnebrg=;
 b=BnTXYwX5CASvKAQRlxlmwwu43RBXXAo2qHXrhi34Nd5s7qDz73eCOYWsQ+UHQ2lmez8G+jakB
 uKAUKlMG2z6DyHZ00ZXceh6cp/vIeZ6UBKFPFIOY4VsAje6AyMwpSdc
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH STAGING v2 15/16] fchroot12: test failfs entry with
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
