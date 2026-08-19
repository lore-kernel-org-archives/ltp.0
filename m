Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE78DC5B572
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 21:29:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 53BEE3CE11E
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 23:29:02 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0A01B3CD718
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 23:24:47 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 921631400DAC
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 23:24:46 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9D5763EF2;
 Wed, 19 Aug 2026 21:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787174680; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H2/ccMF0gHp8uIiDfMtrCSTHDuuLBeEPpI9/01ns5Ew=;
 b=tXuqbrzRCd2OWLKkk5Swo2ZISUXjEHaKxnYNRtA5TDiSPoykRyyEAFrvPbI6HMoDgl2onM
 9ht0JMnMWF6LPR2KfgdpxheNEjA+2hXn1nZ0MLnWITm9raUVlL239bkADlP11kA2993D9q
 XDu4FIEgyRSVDqDBMBKri/g6aNR+jYA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787174680;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H2/ccMF0gHp8uIiDfMtrCSTHDuuLBeEPpI9/01ns5Ew=;
 b=PoERzT3TgOMY/aD+GbcDmavme11+u6A+ej7ovOGbgV5j33urlQUtI46GJDmNBbiz09srlL
 OXzWcoioaCiUF5Dg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787174676; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H2/ccMF0gHp8uIiDfMtrCSTHDuuLBeEPpI9/01ns5Ew=;
 b=ZhsxlBxNhoT4v+hHBC7DEWBKvV1GTLR68puyNPE+nh7fw6AjNDXrl5ZL9OXsUB6LMl0tDV
 mqO5w5r1nA1ZCE+qqEvZMwC7rjsyGwQuJKB1QbEnKKcs32tidQmqj0sKmbjc12kNcjKoNT
 JyEucgvnPDNXa2KGsak/+O+GLrT27Wk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787174676;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H2/ccMF0gHp8uIiDfMtrCSTHDuuLBeEPpI9/01ns5Ew=;
 b=nWSCGvris9n6yvf6xTQ4nbU+r6YqcUjTViVh74yqFEtk2YWAj1kQlrdJxOAZPc0FuDuPRj
 A55WkbGYe7gi+UDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 36AD23689;
 Wed, 19 Aug 2026 21:24:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iE83CggfhmqSGwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 19 Aug 2026 21:24:24 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 19 Aug 2026 23:24:31 +0200
MIME-Version: 1.0
Message-Id: <20260819-fchroot-v1-16-2dc2c3c3cf29@suse.com>
References: <20260819-fchroot-v1-0-2dc2c3c3cf29@suse.com>
In-Reply-To: <20260819-fchroot-v1-0-2dc2c3c3cf29@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787174658; l=2998;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=7Yzdsy1ykGrpkrprRNmBdjaYuhm0CcKC9Ae/PzUf0Zo=;
 b=OCSlMQJ3NAST/5xQX7LZOFR7vcz1aujeNGZLL7Fog6hakjU1XU/IHXgLzLLgcvVus9P3UaL04
 M3F4AU1RpSTDQtU8DgXr/0yXlUVQpOljPDOc4BFUiH6quJ957xkdz9h
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:mid,
 suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH STAGING 16/16] fchroot13: test failfs entry when
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
 testcases/kernel/syscalls/fchroot/fchroot13.c | 62 +++++++++++++++++++++++++++
 3 files changed, 64 insertions(+)

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
index de8ca0688..0c4461611 100644
--- a/testcases/kernel/syscalls/fchroot/.gitignore
+++ b/testcases/kernel/syscalls/fchroot/.gitignore
@@ -10,3 +10,4 @@ fchroot09
 fchroot10
 fchroot11
 fchroot12
+fchroot13
diff --git a/testcases/kernel/syscalls/fchroot/fchroot13.c b/testcases/kernel/syscalls/fchroot/fchroot13.c
new file mode 100644
index 000000000..4bedd0180
--- /dev/null
+++ b/testcases/kernel/syscalls/fchroot/fchroot13.c
@@ -0,0 +1,62 @@
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
+ * openat(fd, "..") with a pre-opened directory fd, so the kernel refuses
+ * the syscall with EPERM.
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
+	if (!SAFE_FORK()) {
+		SAFE_CHROOT(JAILDIR);
+		SAFE_CHDIR("/");
+
+		SAFE_SETRESUID(ltpuser->pw_uid, ltpuser->pw_uid,
+			ltpuser->pw_uid);
+
+		SAFE_PRCTL(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+
+		TST_EXP_FAIL(tst_syscall(__NR_fchroot, FD_FAILFS_ROOT, 0),
+			EPERM, "fchroot() from a chrooted process");
+
+		exit(0);
+	}
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
