Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46FC4C3DA4A
	for <ltp@archiver.kernel.org>; Thu, 11 Jul 2024 11:20:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D0D143CF471
	for <ltp@archiver.kernel.org>; Thu, 11 Jul 2024 13:20:22 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 803F83CDE63
 for <ltp@lists.linux.it>; Thu, 11 Jul 2024 13:18:39 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0898320B64B
 for <ltp@lists.linux.it>; Thu, 11 Jul 2024 13:18:39 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 828CA21AA9;
 Thu, 11 Jul 2024 11:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720696718; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ADvYMECHdbN5oR771yGBndkcmdLDFx9a/2zyHZZe30g=;
 b=ZG3kK6LFy92O1bHeadzeIWbD3mFRI6qniBVA8JqY6spxH6jyPZxo3Sa5Z3qToLif4NDt1O
 ibIxnopewOgSjyjDLhvK8CFSKeXO3mD4p/dj88uFEHmWUAUB2uCZyNAOh2ZixoHwWxpIsb
 rbB1aSnr8OY1nmkWtlkT6A1h57QnEAA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720696718;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ADvYMECHdbN5oR771yGBndkcmdLDFx9a/2zyHZZe30g=;
 b=F7zTya1lZ8DbQJW4oyFGhiGuH9j94zp2HebDyOJDtUq3QYLplAyi2ceJmuynwa+72CJe0n
 1tsYCUSiioKFccCw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ZG3kK6LF;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=F7zTya1l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720696718; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ADvYMECHdbN5oR771yGBndkcmdLDFx9a/2zyHZZe30g=;
 b=ZG3kK6LFy92O1bHeadzeIWbD3mFRI6qniBVA8JqY6spxH6jyPZxo3Sa5Z3qToLif4NDt1O
 ibIxnopewOgSjyjDLhvK8CFSKeXO3mD4p/dj88uFEHmWUAUB2uCZyNAOh2ZixoHwWxpIsb
 rbB1aSnr8OY1nmkWtlkT6A1h57QnEAA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720696718;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ADvYMECHdbN5oR771yGBndkcmdLDFx9a/2zyHZZe30g=;
 b=F7zTya1lZ8DbQJW4oyFGhiGuH9j94zp2HebDyOJDtUq3QYLplAyi2ceJmuynwa+72CJe0n
 1tsYCUSiioKFccCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5D53E139E0;
 Thu, 11 Jul 2024 11:18:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eBfjFI6/j2bBVAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 11 Jul 2024 11:18:38 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 11 Jul 2024 13:18:18 +0200
MIME-Version: 1.0
Message-Id: <20240711-landlock-v3-7-c7b0e9edf9b0@suse.com>
References: <20240711-landlock-v3-0-c7b0e9edf9b0@suse.com>
In-Reply-To: <20240711-landlock-v3-0-c7b0e9edf9b0@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4615;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=HspuO1xZfOPuBXF08x8aCR10nKab24FOJV6YazByiyQ=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmj79/CM1HyPDX73eGWU36T1K3in3qF4nttuuT8
 LawiYYhK+aJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZo+/fwAKCRDLzBqyILPm
 Rj9qC/46KILVp/yTABrET0693cUfxBX86mxmD36C7CQABKZO7+ttodBA/W9HGOU/ekTGdlNw0Z5
 qh6vu6j2yrNYSYlnBFFGww3yxiP1Ert+dRMsg2vDM2G2ACxC208yAX7yNLt8XVbQ9s75JLi465t
 oDOmsak40+RTfnT5D9j6Xf5PnRHE1ktdsCfeLbxRkCbXxe89ypXR+2VOUWHvr0KMzLsll/RS0FA
 LKgrjseg4zK+PiLLWU2/fvxBbjvCXc9Kt5YrjFGm0Ry1JLrVQyY6TzCvVcCP7o8ubrm4bEweGqs
 UwWcMUs3q8fle48xgu6QJKGfcJ57NpYziBEjaPTFahO3yVorZUs3fa+nhArbOCvYB8gQ/YxqEuO
 LnYtwWNgfJgFeZAVH6fsbSWs8T9V5vfauaIyoUTY5cD3wk/X35dD4w1BMnQ3Rrp7Q9jew/FyP4e
 IPtu3OgFNl9O7IVZIoz0Lg0SkZALwqEm7cj2oNDpikhfmfyntamH2KDxGfuxhZq9YbQsg=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-5.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:email];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 828CA21AA9
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 07/11] Add landlock03 test
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

This test verifies that landlock_restrict_self syscall fails with the
right error codes:

- EINVAL flags is not 0
- EBADF ruleset_fd is not a file descriptor for the current thread
- EBADFD ruleset_fd is not a ruleset file descriptor
- EPERM ruleset doesn't have CAP_SYS_ADMIN in its namespace
- E2BIG The maximum number of stacked rulesets is reached for the
  current thread

Reviewed-by: Li Wang <liwang@redhat.com>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                |   1 +
 testcases/kernel/syscalls/landlock/.gitignore   |   1 +
 testcases/kernel/syscalls/landlock/landlock03.c | 119 ++++++++++++++++++++++++
 3 files changed, 121 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 3930abc92..f2b64c0df 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -687,6 +687,7 @@ kill13 kill13
 
 landlock01 landlock01
 landlock02 landlock02
+landlock03 landlock03
 
 lchown01 lchown01
 lchown01_16 lchown01_16
diff --git a/testcases/kernel/syscalls/landlock/.gitignore b/testcases/kernel/syscalls/landlock/.gitignore
index ffed4abd2..f79cd090b 100644
--- a/testcases/kernel/syscalls/landlock/.gitignore
+++ b/testcases/kernel/syscalls/landlock/.gitignore
@@ -1,2 +1,3 @@
 landlock01
 landlock02
+landlock03
diff --git a/testcases/kernel/syscalls/landlock/landlock03.c b/testcases/kernel/syscalls/landlock/landlock03.c
new file mode 100644
index 000000000..6511e24a7
--- /dev/null
+++ b/testcases/kernel/syscalls/landlock/landlock03.c
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * This test verifies that landlock_restrict_self syscall fails with the right
+ * error codes:
+ *
+ * - EINVAL flags is not 0
+ * - EBADF ruleset_fd is not a file descriptor for the current thread
+ * - EBADFD ruleset_fd is not a ruleset file descriptor
+ * - EPERM ruleset doesn't have CAP_SYS_ADMIN in its namespace
+ * - E2BIG The maximum number of stacked rulesets is reached for the current
+ *   thread
+ */
+
+#include "landlock_common.h"
+
+#define MAX_STACKED_RULESETS 16
+
+static struct landlock_ruleset_attr *ruleset_attr;
+static int ruleset_fd = -1;
+static int ruleset_invalid = -1;
+static int file_fd = -1;
+
+static struct tst_cap dropadmin = {
+	.action = TST_CAP_DROP,
+	.id = CAP_SYS_ADMIN,
+	.name = "CAP_SYS_ADMIN",
+};
+
+static struct tst_cap needadmin = {
+	.action = TST_CAP_REQ,
+	.id = CAP_SYS_ADMIN,
+	.name = "CAP_SYS_ADMIN",
+};
+
+static struct tcase {
+	int *fd;
+	uint32_t flags;
+	int exp_errno;
+	char *msg;
+} tcases[] = {
+	{&ruleset_fd, -1, EINVAL, "Invalid flags"},
+	{&ruleset_invalid, 0, EBADF, "Invalid file descriptor"},
+	{&file_fd, 0, EBADFD, "Not a ruleset file descriptor"},
+	{&ruleset_fd, 0, EPERM, "File descriptor doesn't have CAP_SYS_ADMIN"},
+	{&ruleset_fd, 0, E2BIG, "Maximum number of stacked rulesets is reached"},
+};
+
+static void run(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+
+	if (tc->exp_errno == EPERM)
+		tst_cap_action(&dropadmin);
+
+	if (tc->exp_errno == E2BIG) {
+		for (int i = 0; i < MAX_STACKED_RULESETS; i++) {
+			TST_EXP_PASS_SILENT(tst_syscall(__NR_landlock_restrict_self,
+				*tc->fd, tc->flags));
+			if (TST_RET == -1)
+				return;
+		}
+	}
+
+	TST_EXP_FAIL(tst_syscall(__NR_landlock_restrict_self, *tc->fd, tc->flags),
+		tc->exp_errno,
+		"%s", tc->msg);
+
+	if (tc->exp_errno == EPERM)
+		tst_cap_action(&needadmin);
+}
+
+static void setup(void)
+{
+	verify_landlock_is_enabled();
+
+	ruleset_attr->handled_access_fs = LANDLOCK_ACCESS_FS_EXECUTE;
+
+	ruleset_fd = TST_EXP_FD_SILENT(tst_syscall(__NR_landlock_create_ruleset,
+		ruleset_attr, sizeof(struct landlock_ruleset_attr), 0));
+
+	file_fd = SAFE_OPEN("junk.bin", O_CREAT, 0777);
+}
+
+static void cleanup(void)
+{
+	if (ruleset_fd != -1)
+		SAFE_CLOSE(ruleset_fd);
+
+	if (file_fd != -1)
+		SAFE_CLOSE(file_fd);
+}
+
+static struct tst_test test = {
+	.test = run,
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.cleanup = cleanup,
+	.min_kver = "5.13",
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_SECURITY_LANDLOCK=y",
+		NULL
+	},
+	.bufs = (struct tst_buffers []) {
+		{&ruleset_attr, .size = sizeof(struct landlock_ruleset_attr)},
+		{},
+	},
+	.caps = (struct tst_cap []) {
+		TST_CAP(TST_CAP_REQ, CAP_SYS_ADMIN),
+		{}
+	},
+};

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
