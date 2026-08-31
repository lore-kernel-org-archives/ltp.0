Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B228C624A5
	for <ltp@archiver.kernel.org>; Mon, 31 Aug 2026 08:04:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 78A6F3E9487
	for <ltp@archiver.kernel.org>; Mon, 31 Aug 2026 10:04:44 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EB7A83E59AC
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 10:00:24 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B6A991A00990
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 10:00:23 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E24991FB9A;
 Mon, 31 Aug 2026 08:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788163219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qPBoLpiNN+de+HEovMirGDMmZqL3oWWmR49UR9C3pVE=;
 b=grrhmR47nHUJSPsuXBiHvZk0z/3uc56VLau+D53AzZdaY0xicou9jx/mEER/cfNHm5+J+r
 fnlEql6d6Qv70VlQ5HzlSsXDtACshdSztBgqqvNhi8P/Gzk2lk2/OlkHaZwq1vf9nzpwEY
 H6XfzlagcJBX1BKZJig8c1BPdGNVonQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788163219;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qPBoLpiNN+de+HEovMirGDMmZqL3oWWmR49UR9C3pVE=;
 b=bWlfj+ZEOisCsrRFjygtWBI2J+DuUtLSOwcpVuTkjJTTaL9bPtEyff1H8RxW2R2qcz59TR
 80vCL5seqZoDjLCg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=GZMZhJYE;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ZzejE6tF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788163214; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qPBoLpiNN+de+HEovMirGDMmZqL3oWWmR49UR9C3pVE=;
 b=GZMZhJYE8luCOkUDZQYtV1MpWBUCHzWhJU6mwhRfIixWgsoqG1y8yIGpLbizLXPoKt7G5E
 q5Yrl+PyuIf+ez6WV/4gwVV6GwKPck2kyoBPPyMhscZaSXQqOrCalgTN4diIoDOhr30kHI
 1+t5YH4vgkOyCJoFW+i+y4kjfyUb7jc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788163214;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qPBoLpiNN+de+HEovMirGDMmZqL3oWWmR49UR9C3pVE=;
 b=ZzejE6tFWwDkOw5md1vKGAxbj80F07EyKXn2KB4XY8xsmUksGn2d6YA135l1VI+1TtiNU8
 u6rZwLD7hodxN3DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8373B137D2;
 Mon, 31 Aug 2026 08:00:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yI91Hoc0lWo9dQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 31 Aug 2026 08:00:07 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 31 Aug 2026 10:00:12 +0200
MIME-Version: 1.0
Message-Id: <20260831-fchroot-v4-11-57cceb68f927@suse.com>
References: <20260831-fchroot-v4-0-57cceb68f927@suse.com>
In-Reply-To: <20260831-fchroot-v4-0-57cceb68f927@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788163205; l=3010;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=9PRUPNP2hapSSEyzlC04fbI4vdungvpbKZ5iNDdqs8k=;
 b=YzHZARfQXw9nmMDEmYcaEXQueyniJ9Ss7aXYt0JxAEktIGbRGM9DuvUbtjGxfkcYZWQo+3mWs
 VeFFlhPk7vIA3SMGtYtpjcIof7Ya8gQLvUr1gxc6TSvbIeGh3xeUk8g
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E24991FB9A
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH STAGING v4 11/16] fchroot08: test failfs root fork
 inheritance
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

Verify that the root moved into failfs by fchroot() lives in the
fs_struct which is duplicated on fork, so a child of a process with
the failfs root also fails every absolute path lookup with
EOPNOTSUPP.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/staging                               |  1 +
 testcases/kernel/syscalls/fchroot/.gitignore  |  1 +
 testcases/kernel/syscalls/fchroot/fchroot08.c | 69 +++++++++++++++++++++++++++
 3 files changed, 71 insertions(+)

diff --git a/runtest/staging b/runtest/staging
index b8954bb5a..8dfe95c4a 100644
--- a/runtest/staging
+++ b/runtest/staging
@@ -7,3 +7,4 @@ fchroot04 fchroot04
 fchroot05 fchroot05
 fchroot06 fchroot06
 fchroot07 fchroot07
+fchroot08 fchroot08
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
index 000000000..3180191e7
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
+ * fs_struct which is duplicated on :manpage:`fork(2)`, so a child of a process with the
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
