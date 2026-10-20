Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F1D606A319
	for <ltp@archiver.kernel.org>; Tue, 20 Oct 2026 10:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=osmByPik;
	dkim=fail reason="signature verification failed" header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=rbhn5KR4;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=osmByPik;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=rbhn5KR4
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A0BFA3EA618
	for <ltp@archiver.kernel.org>; Tue, 20 Oct 2026 12:17:35 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9B7BA3E9E0F
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 12:16:35 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 109D96008C2
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 12:16:34 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 825501F7B6;
 Tue, 20 Oct 2026 10:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792491394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CbToNH8PQgAszf5pkz6s0oXVDo+PisMtltytsJSlCQ8=;
 b=osmByPikwfU1458vkc+0w1gyW17MvmjxWkZsBC+3pZHO13V05Hue/+0igDEZz7y5r/fcu2
 6c44uXNv+xUaGWbwnmbGfpbhzsq83xj4slhxq0zA7xbl2XJ+pVfIMB0cFKREn8HaB9nxyy
 EGoc8uNTlyULKIUEILE0msPP8GL9p5s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792491394;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CbToNH8PQgAszf5pkz6s0oXVDo+PisMtltytsJSlCQ8=;
 b=rbhn5KR4gAbaXH6OfdtjLnDFkm5I78z0X/lZQ5siKxohuEJrSkjJjirDOuzSvdyC5Qmq0Y
 j/87bxWAWtoW3UCQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=osmByPik;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=rbhn5KR4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792491394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CbToNH8PQgAszf5pkz6s0oXVDo+PisMtltytsJSlCQ8=;
 b=osmByPikwfU1458vkc+0w1gyW17MvmjxWkZsBC+3pZHO13V05Hue/+0igDEZz7y5r/fcu2
 6c44uXNv+xUaGWbwnmbGfpbhzsq83xj4slhxq0zA7xbl2XJ+pVfIMB0cFKREn8HaB9nxyy
 EGoc8uNTlyULKIUEILE0msPP8GL9p5s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792491394;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CbToNH8PQgAszf5pkz6s0oXVDo+PisMtltytsJSlCQ8=;
 b=rbhn5KR4gAbaXH6OfdtjLnDFkm5I78z0X/lZQ5siKxohuEJrSkjJjirDOuzSvdyC5Qmq0Y
 j/87bxWAWtoW3UCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 19C9B13876;
 Tue, 20 Oct 2026 10:16:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id B2PKGIA/12rCMgAAD6G6ig:T10
 (envelope-from <andrea.cervesato@suse.de>); Tue, 20 Oct 2026 10:16:34 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 20 Oct 2026 12:16:38 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <20261020-fchroot-v5-9-63aa6faff503@suse.com>
References: <20261020-fchroot-v5-0-63aa6faff503@suse.com>
In-Reply-To: <20261020-fchroot-v5-0-63aa6faff503@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792491392; l=2723;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=NHHVXMtKJw4Il/uPio/bbC35cSUgwHZ9hH5GZIzqho4=;
 b=nbKgvTKYYtCDugX8BApwOreqAR3SCqRZTtJ9b08li8gZo0I0lumnnkyxuZQQpLxtg7J/uzDxi
 GCFF/dH1rVuDi9+kd9vz/SbfzFfZPO96lJujAzziRoX+T8lCcVHt1Pp
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.com:email];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Level: 
X-Rspamd-Queue-Id: 825501F7B6
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 09/14] fchroot08: test failfs root fork inheritance
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

Verify that the root moved into failfs by fchroot() lives in the
fs_struct which is duplicated on fork, so a child of a process with
the failfs root also fails every absolute path lookup with
EOPNOTSUPP.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                              |  1 +
 testcases/kernel/syscalls/fchroot/.gitignore  |  1 +
 testcases/kernel/syscalls/fchroot/fchroot08.c | 52 +++++++++++++++++++++++++++
 3 files changed, 54 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index bc2dffdca..24d9b1b4a 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -323,6 +323,7 @@ fchroot04 fchroot04
 fchroot05 fchroot05
 fchroot06 fchroot06
 fchroot07 fchroot07
+fchroot08 fchroot08
 
 fcntl01 fcntl01
 fcntl01_64 fcntl01_64
diff --git a/testcases/kernel/syscalls/fchroot/.gitignore b/testcases/kernel/syscalls/fchroot/.gitignore
index bfa2a8ce1..0a2510d8a 100644
--- a/testcases/kernel/syscalls/fchroot/.gitignore
+++ b/testcases/kernel/syscalls/fchroot/.gitignore
@@ -6,3 +6,4 @@ fchroot05
 fchroot06
 fchroot07
 fchroot07_child
+fchroot08
diff --git a/testcases/kernel/syscalls/fchroot/fchroot08.c b/testcases/kernel/syscalls/fchroot/fchroot08.c
new file mode 100644
index 000000000..1b20e3162
--- /dev/null
+++ b/testcases/kernel/syscalls/fchroot/fchroot08.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Test that the failfs root is inherited across :manpage:`fork(2)`.
+ *
+ * The root moved into failfs by :manpage:`fchroot(2)` lives in the
+ * fs_struct which is duplicated on :manpage:`fork(2)`, so a child of a
+ * process with the failfs root also fails every absolute path lookup with
+ * ``EOPNOTSUPP``.
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
+		TST_EXP_FAIL2(open("/", O_PATH), EOPNOTSUPP,
+			"absolute lookup in a forked child");
+		return;
+	}
+
+	SAFE_WAITPID(pid, NULL, 0);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.needs_root = 1,
+	.forks_child = 1,
+};

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
