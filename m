Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F7DACED628
	for <ltp@archiver.kernel.org>; Wed,  9 Oct 2024 08:33:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2B3C13C4C87
	for <ltp@archiver.kernel.org>; Wed,  9 Oct 2024 10:33:42 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CA3E63C268C
 for <ltp@lists.linux.it>; Wed,  9 Oct 2024 10:29:28 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 55AE160199E
 for <ltp@lists.linux.it>; Wed,  9 Oct 2024 10:29:28 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B44211FB8D;
 Wed,  9 Oct 2024 08:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728462567; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EWpwrgFUvRSP/fZaeksGD8L6e0IMYXTYQ8XOtgWXzQo=;
 b=JSJ3E5kojy4vAmGiS7VDjIPmNzsSOptHUsso7dEHn/yRapC6KpU1rjioqtf8up2EyJ+iTj
 YzyPie/nJV+wU0d0MLS2yuPPLbIgduNryys4Ap4+41Kyn+NU79M4XyJgcRrmqbPvM/sS3S
 z+JbjHToPHaDRgGKzmeaMTmhdEsYCWY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728462567;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EWpwrgFUvRSP/fZaeksGD8L6e0IMYXTYQ8XOtgWXzQo=;
 b=khuqVv+axzQBwSJv0BZR0+3qUUF/7BCXKVEQnjc6YLLLUmiiIWmhy6/P9536hFXk3B7iHU
 4Sco6VWkrc0SpOBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728462567; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EWpwrgFUvRSP/fZaeksGD8L6e0IMYXTYQ8XOtgWXzQo=;
 b=JSJ3E5kojy4vAmGiS7VDjIPmNzsSOptHUsso7dEHn/yRapC6KpU1rjioqtf8up2EyJ+iTj
 YzyPie/nJV+wU0d0MLS2yuPPLbIgduNryys4Ap4+41Kyn+NU79M4XyJgcRrmqbPvM/sS3S
 z+JbjHToPHaDRgGKzmeaMTmhdEsYCWY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728462567;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EWpwrgFUvRSP/fZaeksGD8L6e0IMYXTYQ8XOtgWXzQo=;
 b=khuqVv+axzQBwSJv0BZR0+3qUUF/7BCXKVEQnjc6YLLLUmiiIWmhy6/P9536hFXk3B7iHU
 4Sco6VWkrc0SpOBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 48F5F136BA;
 Wed,  9 Oct 2024 08:29:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4FbbC+Y+BmeeTQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 09 Oct 2024 08:29:26 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 09 Oct 2024 10:29:16 +0200
MIME-Version: 1.0
Message-Id: <20241009-listmount_statmount-v7-14-d5ad31d47f68@suse.com>
References: <20241009-listmount_statmount-v7-0-d5ad31d47f68@suse.com>
In-Reply-To: <20241009-listmount_statmount-v7-0-d5ad31d47f68@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728462547; l=2717;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=mshebEN36WEro01R/0Oh9YJCm9sZuznGLIIGDssaGlY=;
 b=gLC763ghAcfpdfdKb4EI1dlNW4MU5HxKkFRJdqESbfcmYOmWl6v3BE0u+DxE0k3AQQyIIScWJ
 p2yrgpZpbZ9DWWOvORogpqHyLrWUjjesfLIlxeQZB9eAlvqrlNQoVPR
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.994]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7 14/16] Add statmount08 test
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

Verify that statmount() raises EPERM when mount point is not accessible.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                  |  1 +
 testcases/kernel/syscalls/statmount/.gitignore    |  1 +
 testcases/kernel/syscalls/statmount/statmount08.c | 65 +++++++++++++++++++++++
 3 files changed, 67 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index bf222e466..f8ae25344 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1581,6 +1581,7 @@ statmount04 statmount04
 statmount05 statmount05
 statmount06 statmount06
 statmount07 statmount07
+statmount08 statmount08
 
 statfs01 statfs01
 statfs01_64 statfs01_64
diff --git a/testcases/kernel/syscalls/statmount/.gitignore b/testcases/kernel/syscalls/statmount/.gitignore
index b2a55c077..6106fcf07 100644
--- a/testcases/kernel/syscalls/statmount/.gitignore
+++ b/testcases/kernel/syscalls/statmount/.gitignore
@@ -5,3 +5,4 @@ statmount04
 statmount05
 statmount06
 statmount07
+statmount08
diff --git a/testcases/kernel/syscalls/statmount/statmount08.c b/testcases/kernel/syscalls/statmount/statmount08.c
new file mode 100644
index 000000000..21b8b7342
--- /dev/null
+++ b/testcases/kernel/syscalls/statmount/statmount08.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify that statmount() raises EPERM when mount point is not accessible.
+ */
+
+#define _GNU_SOURCE
+
+#include <pwd.h>
+#include "statmount.h"
+#include "lapi/stat.h"
+
+static struct statmount *st_mount;
+static uint64_t root_id;
+static gid_t nobody_gid;
+static uid_t nobody_uid;
+
+static void run(void)
+{
+	if (SAFE_FORK())
+		return;
+
+	SAFE_SETEGID(nobody_gid);
+	SAFE_SETEUID(nobody_uid);
+
+	memset(st_mount, 0, sizeof(struct statmount));
+
+	TST_EXP_FAIL(statmount(root_id,	STATMOUNT_SB_BASIC, st_mount,
+		sizeof(struct statmount), 0), EPERM);
+
+	exit(0);
+}
+
+static void setup(void)
+{
+	struct ltp_statx sx;
+	struct passwd *pw;
+
+	pw = SAFE_GETPWNAM("nobody");
+	nobody_gid = pw->pw_gid;
+	nobody_uid = pw->pw_uid;
+
+	SAFE_STATX(AT_FDCWD, "/", 0, STATX_MNT_ID_UNIQUE, &sx);
+	root_id = sx.data.stx_mnt_id;
+
+	SAFE_CHROOT(tst_tmpdir_path());
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.forks_child = 1,
+	.min_kver = "6.8",
+	.bufs = (struct tst_buffers []) {
+		{&st_mount, .size = sizeof(struct statmount)},
+		{}
+	}
+};

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
