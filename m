Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CDD2C61DCB
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 14:16:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5856A3E9A72
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 16:16:17 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 96BE23E5E15
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 16:12:10 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 10674600472
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 16:12:09 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 679E421BD1;
 Fri, 28 Aug 2026 14:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787926325; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RgObFFTGxv/gv0VNLW/fwshWPqB281yygmhHUpYuuB8=;
 b=z3C400v77/iw2ETsDumsl2mBc3PuEkWYN54sblFXJUfZYGrXdhgQ//EIYUClP3NAqQoyW1
 EABkZ18Ppc+OqRyWzTIuMmjuupzqFyGXQ/uTwpGtDDVrVLQ2vsX4hnCQSVhKqBMXEp9UM1
 MbPT+a2XDgCJEUmgG28YdGAgIdQqeSs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787926325;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RgObFFTGxv/gv0VNLW/fwshWPqB281yygmhHUpYuuB8=;
 b=roqAvdtj2xRzxL5NCCEagMTOg4f1X/wYBxw5g8A2raoq9vi6kyPzNtOEBQGPGuphytbQiN
 i5tni500ahblzBCw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=jAhqXEjC;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="mdju2hv/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787926321; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RgObFFTGxv/gv0VNLW/fwshWPqB281yygmhHUpYuuB8=;
 b=jAhqXEjCoZsKMCsToOuuYgG2YKgqjlWqya0IYB1GLsF1XNauN7/ITBilT9KfHXBULULolN
 BGiY8GavZuOOjTWmJ5TcPP/KgeDgZ3gcnUqc7Wg6Aqu/ajKtEKZ9rvar4weIOY8wnO3CIM
 qtup22iSa+OD0i1qAgbASP73cPu/izs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787926321;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RgObFFTGxv/gv0VNLW/fwshWPqB281yygmhHUpYuuB8=;
 b=mdju2hv/fUJwaQgS4NXw0l2EvRVHa6Rq4y/9iTD2u8LJdYWw9GjSGa9CaDU3ybWi/wSjmQ
 60Zh5ImxgR6iEDCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 521AD13763;
 Fri, 28 Aug 2026 14:11:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0CWJEiKXkWpoGwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 28 Aug 2026 14:11:46 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 28 Aug 2026 16:11:49 +0200
MIME-Version: 1.0
Message-Id: <20260828-fchroot-v3-15-656a2b515726@suse.com>
References: <20260828-fchroot-v3-0-656a2b515726@suse.com>
In-Reply-To: <20260828-fchroot-v3-0-656a2b515726@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787926304; l=3005;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=Frdr0EWc7VJ3+NedtLt0rw5ysc/qYRUox7XrYQ5uBJM=;
 b=7s6CDotVNT5Ame55ZlCBIxyLMmHXeUArrTshYerVd/mhW6InV5SCMNumFtNP70mIRXi4hv6fe
 37wMT+4eoKLDZ3oNtRwJhrG0nkmB0c57Eincbq6WtPmHBfVTKynV7Zh
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 679E421BD1
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:email,suse.com:mid];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH STAGING v3 15/15] fchroot13: test failfs entry when
 chrooted
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

Verify that unprivileged fchroot() into failfs is refused when the
process is already chrooted: moving the root of a chrooted task into
failfs would allow it to escape its chroot via openat(fd, "..") with
a pre-opened directory fd, so the kernel refuses the syscall with
EPERM.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/staging                               |  1 +
 testcases/kernel/syscalls/fchroot/.gitignore  |  1 +
 testcases/kernel/syscalls/fchroot/fchroot13.c | 63 +++++++++++++++++++++++++++
 3 files changed, 65 insertions(+)

diff --git a/runtest/staging b/runtest/staging
index 1655b6813..95e777ffb 100644
--- a/runtest/staging
+++ b/runtest/staging
@@ -12,3 +12,4 @@ fchroot09 fchroot09
 fchroot10 fchroot10
 fchroot11 fchroot11
 fchroot12 fchroot12
+fchroot13 fchroot13
diff --git a/testcases/kernel/syscalls/fchroot/.gitignore b/testcases/kernel/syscalls/fchroot/.gitignore
index e8a6730ee..3e77e3762 100644
--- a/testcases/kernel/syscalls/fchroot/.gitignore
+++ b/testcases/kernel/syscalls/fchroot/.gitignore
@@ -11,3 +11,4 @@ fchroot09
 fchroot10
 fchroot11
 fchroot12
+fchroot13
diff --git a/testcases/kernel/syscalls/fchroot/fchroot13.c b/testcases/kernel/syscalls/fchroot/fchroot13.c
new file mode 100644
index 000000000..e90e6f663
--- /dev/null
+++ b/testcases/kernel/syscalls/fchroot/fchroot13.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Test that unprivileged :manpage:`fchroot(2)` into failfs is refused
+ * when the process is already chrooted.
+ *
+ * The root directory is what confines ".." resolution and the failfs root
+ * can never be reached by walking up a real mount tree. Moving the root
+ * of a chrooted task into failfs would allow it to escape its chroot via
+ * ``openat(fd, "..")`` with a pre-opened directory fd, so the kernel refuses
+ * the syscall with ``EPERM``.
+ *
+ * Root is required to create the chroot jail before dropping to an
+ * unprivileged user in the forked child.
+ */
+
+#define _GNU_SOURCE
+#include <pwd.h>
+#include <unistd.h>
+#include "tst_test.h"
+#include "lapi/fcntl.h"
+#include "lapi/prctl.h"
+#include "lapi/syscalls.h"
+
+#define JAILDIR "jail"
+
+static struct passwd *ltpuser;
+
+static void run(void)
+{
+	if (SAFE_FORK())
+		return;
+
+	SAFE_CHROOT(JAILDIR);
+	SAFE_CHDIR("/");
+
+	SAFE_SETRESUID(ltpuser->pw_uid, ltpuser->pw_uid,
+		ltpuser->pw_uid);
+
+	SAFE_PRCTL(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+
+	TST_EXP_FAIL(tst_syscall(__NR_fchroot, FD_FAILFS_ROOT, 0),
+		EPERM, "fchroot() from a chrooted process");
+
+	exit(0);
+}
+
+static void setup(void)
+{
+	ltpuser = SAFE_GETPWNAM("nobody");
+	SAFE_MKDIR(JAILDIR, 0755);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.forks_child = 1,
+};

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
