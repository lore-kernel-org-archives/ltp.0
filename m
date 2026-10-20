Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00762606A324
	for <ltp@archiver.kernel.org>; Tue, 20 Oct 2026 10:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=L7s1ZCu6;
	dkim=fail reason="signature verification failed" header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=8QsJgaDc;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=kQbitMux;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=cFYwu/AX
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B52BA3EA60A
	for <ltp@archiver.kernel.org>; Tue, 20 Oct 2026 12:18:59 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 107143EA604
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 12:16:36 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 976101000752
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 12:16:35 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E78A71F7BB;
 Tue, 20 Oct 2026 10:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792491395; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a6qQ8Q7XUBDiJ1LvIjxNFZvQjqpNPEzAfgrRvHECBLU=;
 b=L7s1ZCu69p5DStzYu+hpl5YZFtuIMlPt4MFqRWIOMG0JZa9xnZeyi81xWgLDX6UVbqjCdt
 HkqitAJWsPsiQ+YxI+slnCdVCQR9v5eRJTzg4hJE/3bP1a9sVYAf3BnNigYYAIkR6aREfE
 xi3YrxEDy0/IEtERRtn0+SuW83TnwUw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792491395;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a6qQ8Q7XUBDiJ1LvIjxNFZvQjqpNPEzAfgrRvHECBLU=;
 b=8QsJgaDcSCNPhtOyOhqvpoGZCDvYGLmMKGnuO0pLhb7I7nQyHhcZaIBD2UwV8n3HkxDNRx
 wXcXQXr4OfRZe4Dw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792491394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a6qQ8Q7XUBDiJ1LvIjxNFZvQjqpNPEzAfgrRvHECBLU=;
 b=kQbitMux9U5pYtgTWaRaeXmy5212Mo8YSGH2dNPAOmwHEdDxo/lNvgQq9Tybkx5Pf9KvNc
 MZSsSb70zdZ+LxCp95rrpbSbtIETGVwoJww90677MofA9DHln22LEsV2UiTM1fICzU00pD
 PF1qlZIEzszAoTZPiYljZLh5XRMknps=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792491394;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a6qQ8Q7XUBDiJ1LvIjxNFZvQjqpNPEzAfgrRvHECBLU=;
 b=cFYwu/AXJuT4ScbzwHnxoTPsGj6/uGf0D7mt2k2jsV4+kUMjBBB7xdrXWEwN4lzduBpstD
 YTygfZ6bVZ2GPkCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B0CC313793;
 Tue, 20 Oct 2026 10:16:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id B2PKGIA/12rCMgAAD6G6ig:T14
 (envelope-from <andrea.cervesato@suse.de>); Tue, 20 Oct 2026 10:16:34 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 20 Oct 2026 12:16:42 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <20261020-fchroot-v5-13-63aa6faff503@suse.com>
References: <20261020-fchroot-v5-0-63aa6faff503@suse.com>
In-Reply-To: <20261020-fchroot-v5-0-63aa6faff503@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792491392; l=3724;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=Zjg2UrCkXO1CEa7pAK/K+iF078lX8IgsyCGYWTqFXcI=;
 b=sS2wUX7s/78JoySu0g7/Ejfk0lnfvsKopSnmp9GNyG2r14rOqvpHrpZFYfMP73dEPLZfb9FY9
 NUV67p6oazJA0K21Q827/ozXgGxcpsR7aaX9dmtxzDZeJdC/fVfv94G
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.cz:email,
 suse.com:email]
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 13/14] fchroot12: test failfs entry with shared
 fs_struct
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

Verify that unprivileged fchroot() into failfs is refused with a
shared fs_struct: a CLONE_FS sibling without no_new_privs could
execute a setuid binary with the failfs root, so entry requires
fs->users == 1, the same restriction setns() applies for the mount
namespace. The sibling bumps fs->users to 2, making the syscall fail
with EINVAL.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                              |  1 +
 testcases/kernel/syscalls/fchroot/.gitignore  |  1 +
 testcases/kernel/syscalls/fchroot/fchroot12.c | 83 +++++++++++++++++++++++++++
 3 files changed, 85 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index bd7b352fd..bd3bbff4a 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -327,6 +327,7 @@ fchroot08 fchroot08
 fchroot09 fchroot09
 fchroot10 fchroot10
 fchroot11 fchroot11
+fchroot12 fchroot12
 
 fcntl01 fcntl01
 fcntl01_64 fcntl01_64
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
index 000000000..ebf92a741
--- /dev/null
+++ b/testcases/kernel/syscalls/fchroot/fchroot12.c
@@ -0,0 +1,83 @@
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
