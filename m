Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340D0606A31D
	for <ltp@archiver.kernel.org>; Tue, 20 Oct 2026 10:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=eVP1m9ej;
	dkim=fail reason="signature verification failed" header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=CU31cOF9;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=eVP1m9ej;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=CU31cOF9
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CD3B63EA620
	for <ltp@archiver.kernel.org>; Tue, 20 Oct 2026 12:18:45 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0E5D53EA603
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 12:16:36 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 96B981A00906
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 12:16:35 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BB6DE1F7B9;
 Tue, 20 Oct 2026 10:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792491394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z80XIPZSb4K2c6BBANcd7w3C7PTzaJ4jhFBcXsUb/dw=;
 b=eVP1m9ejSPK40Y3BiOOnyWzMMpZ0OlJK74cGRqqv45eMj0rW2gBbzjrJ5A3Ly5r8MMly9t
 Rk5Y4tkgoELd/5oPSkQNVNNVomBzT7ZpJT6xWn8fY0E82L5Yklu2H4n7MPxuDblYIEngWf
 EEY6eJWSxSjCpKpphqUXYNUe58ZPiwA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792491394;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z80XIPZSb4K2c6BBANcd7w3C7PTzaJ4jhFBcXsUb/dw=;
 b=CU31cOF9dfxU3l7vfWTF/WUCuU5pHrnNxTEhkMJ04fJpgtouxk/pEGIP2md7UX8V10K7gH
 CLTO5hR1FzGabpBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=eVP1m9ej;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=CU31cOF9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792491394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z80XIPZSb4K2c6BBANcd7w3C7PTzaJ4jhFBcXsUb/dw=;
 b=eVP1m9ejSPK40Y3BiOOnyWzMMpZ0OlJK74cGRqqv45eMj0rW2gBbzjrJ5A3Ly5r8MMly9t
 Rk5Y4tkgoELd/5oPSkQNVNNVomBzT7ZpJT6xWn8fY0E82L5Yklu2H4n7MPxuDblYIEngWf
 EEY6eJWSxSjCpKpphqUXYNUe58ZPiwA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792491394;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z80XIPZSb4K2c6BBANcd7w3C7PTzaJ4jhFBcXsUb/dw=;
 b=CU31cOF9dfxU3l7vfWTF/WUCuU5pHrnNxTEhkMJ04fJpgtouxk/pEGIP2md7UX8V10K7gH
 CLTO5hR1FzGabpBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 613A413883;
 Tue, 20 Oct 2026 10:16:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id B2PKGIA/12rCMgAAD6G6ig:T12
 (envelope-from <andrea.cervesato@suse.de>); Tue, 20 Oct 2026 10:16:34 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 20 Oct 2026 12:16:40 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <20261020-fchroot-v5-11-63aa6faff503@suse.com>
References: <20261020-fchroot-v5-0-63aa6faff503@suse.com>
In-Reply-To: <20261020-fchroot-v5-0-63aa6faff503@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792491392; l=2911;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=V8qmt34WSOPV28U93JyrLF095nZX45iEWFT5X1fw3Yc=;
 b=odPNJ6eqCQCiTIJ4k7CXEgD8blwFoF9h0qowi8vloj1j64mffl1tsrv6beMbvZ5/fCz6KgtXE
 1K6Kkk32h02Byea+9EeaDsT1CczQunptWTVVC5tC/xSdG0TaM73EL0t
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: BB6DE1F7B9
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.de:dkim,suse.com:email];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -4.51
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 11/14] fchroot10: test failfs entry without
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

Verify that unprivileged fchroot() into failfs is refused without
no_new_privs: without it a setuid binary on a regular mount is still
reachable via an inherited directory fd, and executing it with an
unusable root directory is the classic confused deputy, so the kernel
refuses the syscall with EPERM.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                              |  1 +
 testcases/kernel/syscalls/fchroot/.gitignore  |  1 +
 testcases/kernel/syscalls/fchroot/fchroot10.c | 52 +++++++++++++++++++++++++++
 3 files changed, 54 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index b4723fee4..429e2740c 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -325,6 +325,7 @@ fchroot06 fchroot06
 fchroot07 fchroot07
 fchroot08 fchroot08
 fchroot09 fchroot09
+fchroot10 fchroot10
 
 fcntl01 fcntl01
 fcntl01_64 fcntl01_64
diff --git a/testcases/kernel/syscalls/fchroot/.gitignore b/testcases/kernel/syscalls/fchroot/.gitignore
index b577da61f..53a1fa1d0 100644
--- a/testcases/kernel/syscalls/fchroot/.gitignore
+++ b/testcases/kernel/syscalls/fchroot/.gitignore
@@ -8,3 +8,4 @@ fchroot07
 fchroot07_child
 fchroot08
 fchroot09
+fchroot10
diff --git a/testcases/kernel/syscalls/fchroot/fchroot10.c b/testcases/kernel/syscalls/fchroot/fchroot10.c
new file mode 100644
index 000000000..202e536b3
--- /dev/null
+++ b/testcases/kernel/syscalls/fchroot/fchroot10.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Test that unprivileged :manpage:`fchroot(2)` into failfs is refused
+ * without no_new_privs.
+ *
+ * Without no_new_privs a setuid binary on a regular mount is still
+ * reachable via an inherited directory file descriptor, and executing it
+ * with an unusable root directory is the classic confused deputy, so the
+ * kernel refuses the syscall with ``EPERM``.
+ *
+ * Root is required to drop to an unprivileged user in the forked child.
+ */
+
+#define _GNU_SOURCE
+#include <pwd.h>
+#include "tst_test.h"
+#include "lapi/fcntl.h"
+#include "lapi/prctl.h"
+#include "lapi/syscalls.h"
+
+static struct passwd *ltpuser;
+
+static void run(void)
+{
+	if (SAFE_FORK())
+		return;
+
+	SAFE_SETRESUID(ltpuser->pw_uid, ltpuser->pw_uid,
+		ltpuser->pw_uid);
+
+	TST_EXP_FAIL(tst_syscall(__NR_fchroot, FD_FAILFS_ROOT, 0),
+		EPERM, "unprivileged fchroot() without no_new_privs");
+}
+
+static void setup(void)
+{
+	ltpuser = SAFE_GETPWNAM("nobody");
+
+	if (SAFE_PRCTL(PR_GET_NO_NEW_PRIVS, 0, 0, 0, 0))
+		tst_brk(TCONF, "PR_GET_NO_NEW_PRIVS is already set");
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
