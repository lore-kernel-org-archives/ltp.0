Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F22DC3065A
	for <ltp@archiver.kernel.org>; Mon,  1 Jul 2024 15:44:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8A2503D3FE5
	for <ltp@archiver.kernel.org>; Mon,  1 Jul 2024 17:44:47 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 026FA3D3FD6
 for <ltp@lists.linux.it>; Mon,  1 Jul 2024 17:42:56 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0AC39600F9F
 for <ltp@lists.linux.it>; Mon,  1 Jul 2024 17:42:56 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EF35821A7B;
 Mon,  1 Jul 2024 15:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1719848575; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vmMYXHS/ti6xRn95/EPfCTvJsV4LVm2j9KTLCro6uxQ=;
 b=sVA1Xq5Sra59qxC91SHa5gmNTfKol+QPeXFcH3MZ02baTjY0DFK//HgvV1jV6JC52TJYeF
 5RmtxQIgHERJU0H8jPxpdq1i2O9Qg9k11wBOmSGP9ImLjT59uZ7yinlBsMdjhaWsLpoABw
 kNYzV6p95kwdLVWxxHHmc4c6gfW3xsE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1719848575;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vmMYXHS/ti6xRn95/EPfCTvJsV4LVm2j9KTLCro6uxQ=;
 b=mle45jdlTavFfjUlY5Sme0GeLXWZej1rjze3qcE9Jjfbo0V4NwWrkWJ29FmIdBKrS0fGdo
 2WKQ5r+lbXteAaCA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=vWMtTGTn;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=c63PpiRS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1719848574; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vmMYXHS/ti6xRn95/EPfCTvJsV4LVm2j9KTLCro6uxQ=;
 b=vWMtTGTnCItP6SPS6XtXHcuELLcq7GJ4nFnYFrNKQVy5MYsE4l8yMgV+Rx5JA7LzGLfnbZ
 UkaKw10qk1U+u0a5DnunKSo3eH1MLH+x3DBl+yJVOgmLOyHiu1pOc7C2U4t+ubAwr/UWJY
 UNOrwNzUTu3CymQXp6Pf7KhP6jaLXro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1719848574;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vmMYXHS/ti6xRn95/EPfCTvJsV4LVm2j9KTLCro6uxQ=;
 b=c63PpiRSW9WRhjmuAM/95as/JwJC6Gc/hFdIOGfgJB5fX2k7i51bY7P3OC7nfi/itQ6gml
 szVn4KiPioNi1xBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CFF2413A92;
 Mon,  1 Jul 2024 15:42:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EOe0MH7OgmZfCAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 01 Jul 2024 15:42:54 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 01 Jul 2024 17:42:11 +0200
MIME-Version: 1.0
Message-Id: <20240701-landlock-v1-6-58e9af649a72@suse.com>
References: <20240701-landlock-v1-0-58e9af649a72@suse.com>
In-Reply-To: <20240701-landlock-v1-0-58e9af649a72@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5028;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=SLsjsp+nE3n90DYcc8GA2yCV510snY7lzjXoOkV8oyI=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmgs50g7jtrC4Yitf9zUV8aNVQeSWZHPR5aDC0K
 RDUV+ekEqGJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZoLOdAAKCRDLzBqyILPm
 RsawC/0aKIWJSoR1n0+uw0dodFLZVMzJVbQkQiSY0BWUtqA4imhIt7Nw3DjYQ65zDvrkbUl5cX7
 TAjjcDdrCNWD/8AhKG8ZYy/DD73F5s3PTfF6Wv1SB6MZCBk16Y1soxezfbR57pRv6+rsZ5Zcn4H
 T0aH5JDC0Imr6MDLsshpA8DaIsKMGYgixssRa1zyToJ02IUABOkNeH0qcU1wxS7ucxvU4d1cLsk
 34dqOHfUouEI7h8JmK3XKJeq4YJhsHsw5VF5sBBtfjqiP2eKRrK2H3oSx4hCC6xL6EJi7msYELq
 yEXoWgcljHlHCIsjl6lLW2bDLP18/X+GUvCHVLUm9gT6H3/HB7JNb1DnCspTX7zIG6otEym++Kq
 6jPuXqfMqB+X1h9XNZJNzQZ8v9lj/MggZ7wk3dEqnqGWc+4n60JRJXMof3QDuPKO4XbWzCmEAd5
 fzUEbZpO5huPL4012fcoMzVUcBYviJzJorEstyJb2Lv76uCctn2H4PC1bZ8LSpM8eof9Q=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Rspamd-Queue-Id: EF35821A7B
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 06/10] Add landlock02 test
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

This test verifies that landlock_add_rule syscall fails with the
right error codes:

- EINVAL flags is not 0, or the rule accesses are inconsistent
- ENOMSG Empty accesses (i.e., rule_attr->allowed_access is 0)
- EBADF ruleset_fd  is  not  a  file  descriptor  for  the  current
  thread, or a member of rule_attr is not a file descriptor as
  expected
- EBADFD ruleset_fd is not a ruleset file descriptor, or a member of
  rule_attr is not the expected file descriptor type
- EFAULT rule_attr was not a valid address

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                |   1 +
 testcases/kernel/syscalls/landlock/.gitignore   |   1 +
 testcases/kernel/syscalls/landlock/landlock02.c | 153 ++++++++++++++++++++++++
 3 files changed, 155 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 4c566d95f..7f9c83292 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -685,6 +685,7 @@ kill12 kill12
 kill13 kill13
 
 landlock01 landlock01
+landlock02 landlock02
 
 lchown01 lchown01
 lchown01_16 lchown01_16
diff --git a/testcases/kernel/syscalls/landlock/.gitignore b/testcases/kernel/syscalls/landlock/.gitignore
index b69f9b94a..ffed4abd2 100644
--- a/testcases/kernel/syscalls/landlock/.gitignore
+++ b/testcases/kernel/syscalls/landlock/.gitignore
@@ -1 +1,2 @@
 landlock01
+landlock02
diff --git a/testcases/kernel/syscalls/landlock/landlock02.c b/testcases/kernel/syscalls/landlock/landlock02.c
new file mode 100644
index 000000000..0e2da7ef5
--- /dev/null
+++ b/testcases/kernel/syscalls/landlock/landlock02.c
@@ -0,0 +1,153 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * This test verifies that landlock_add_rule syscall fails with the right
+ * error codes:
+ *
+ * - EINVAL flags is not 0, or the rule accesses are inconsistent
+ * - ENOMSG Empty accesses (i.e., rule_attr->allowed_access is 0)
+ * - EBADF ruleset_fd  is  not  a  file  descriptor  for  the  current  thread,
+ *   or a member of rule_attr is not a file descriptor as expected
+ * - EBADFD ruleset_fd is not a ruleset file descriptor, or a member of
+ *   rule_attr is not the expected file descriptor type
+ * - EFAULT rule_attr was not a valid address
+ */
+
+#include "landlock_common.h"
+
+static struct landlock_ruleset_attr *ruleset_attr;
+static struct landlock_path_beneath_attr *path_beneath_attr;
+static struct landlock_path_beneath_attr *rule_null;
+static int ruleset_fd;
+static int invalid_fd = -1;
+
+static struct tcase {
+	int *fd;
+	enum landlock_rule_type rule_type;
+	struct landlock_path_beneath_attr **attr;
+	int access;
+	int parent_fd;
+	uint32_t flags;
+	int exp_errno;
+	char *msg;
+} tcases[] = {
+	{
+		&ruleset_fd,
+		0,
+		&path_beneath_attr,
+		LANDLOCK_ACCESS_FS_EXECUTE,
+		0,
+		1,
+		EINVAL,
+		"Invalid flags"
+	},
+	{
+		&ruleset_fd,
+		0,
+		&path_beneath_attr,
+		LANDLOCK_ACCESS_FS_EXECUTE,
+		0,
+		0,
+		EINVAL,
+		"Invalid rule type"
+	},
+	{
+		&ruleset_fd,
+		LANDLOCK_RULE_PATH_BENEATH,
+		&path_beneath_attr,
+		0,
+		0,
+		0,
+		ENOMSG,
+		"Empty accesses"
+	},
+	{
+		&invalid_fd,
+		0,
+		&path_beneath_attr,
+		LANDLOCK_ACCESS_FS_EXECUTE,
+		0,
+		0,
+		EBADF,
+		"Invalid file descriptor"
+	},
+	{
+		&ruleset_fd,
+		LANDLOCK_RULE_PATH_BENEATH,
+		&path_beneath_attr,
+		LANDLOCK_ACCESS_FS_EXECUTE,
+		-1,
+		0,
+		EBADF,
+		"Invalid parent fd"
+	},
+	{
+		&ruleset_fd,
+		LANDLOCK_RULE_PATH_BENEATH,
+		&rule_null,
+		0,
+		0,
+		0,
+		EFAULT,
+		"Invalid rule attr"
+	},
+};
+
+static void run(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+
+	if (*tc->attr) {
+		(*tc->attr)->allowed_access = tc->access;
+		(*tc->attr)->parent_fd = tc->parent_fd;
+	}
+
+	TST_EXP_FAIL(tst_syscall(__NR_landlock_add_rule,
+			*tc->fd, tc->rule_type, *tc->attr, tc->flags),
+		tc->exp_errno,
+		"%s",
+		tc->msg);
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
+}
+
+static void cleanup(void)
+{
+	if (ruleset_fd != -1)
+		SAFE_CLOSE(ruleset_fd);
+}
+
+static struct tst_test test = {
+	.test = run,
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.cleanup = cleanup,
+	.min_kver = "5.13",
+	.needs_root = 1,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_SECURITY_LANDLOCK=y",
+		NULL
+	},
+	.bufs = (struct tst_buffers []) {
+		{&ruleset_attr, .size = sizeof(struct landlock_ruleset_attr)},
+		{&path_beneath_attr, .size = sizeof(struct landlock_path_beneath_attr)},
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
