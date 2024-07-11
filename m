Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16EC2C3DA4A
	for <ltp@archiver.kernel.org>; Thu, 11 Jul 2024 11:19:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A270F3CF470
	for <ltp@archiver.kernel.org>; Thu, 11 Jul 2024 13:19:47 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 734213C0FBE
 for <ltp@lists.linux.it>; Thu, 11 Jul 2024 13:18:39 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BE5881A000B1
 for <ltp@lists.linux.it>; Thu, 11 Jul 2024 13:18:38 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5282A21A90;
 Thu, 11 Jul 2024 11:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720696718; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/Vqi3wLbZ/Ezc84nFNqMydz/P7eNp2D/leKanjEaXd4=;
 b=p2akn3B08QeXC8cMCGYkEvhWfwYT6ukN9W32FsYALhuMv1fBoFwHMwR3NzLxScYsvFwOvd
 j71p0Q8wf5FsfgyRPNai+0kus8PgmlDpckzlij/pBhDBy9pLOV9rDBn5KrTffCHksiO3XC
 u5KwufA5C5TMCqkJ/XlLRh+0VOCeXAY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720696718;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/Vqi3wLbZ/Ezc84nFNqMydz/P7eNp2D/leKanjEaXd4=;
 b=Zk5YQiAo4d56EIIFu1Fuh6ul5uP2+Gce8ap0HU5bdzHWA//lTv1LHOe72se4xi5RU4g/cB
 UXvQ6AIwZbU1XjCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720696718; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/Vqi3wLbZ/Ezc84nFNqMydz/P7eNp2D/leKanjEaXd4=;
 b=p2akn3B08QeXC8cMCGYkEvhWfwYT6ukN9W32FsYALhuMv1fBoFwHMwR3NzLxScYsvFwOvd
 j71p0Q8wf5FsfgyRPNai+0kus8PgmlDpckzlij/pBhDBy9pLOV9rDBn5KrTffCHksiO3XC
 u5KwufA5C5TMCqkJ/XlLRh+0VOCeXAY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720696718;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/Vqi3wLbZ/Ezc84nFNqMydz/P7eNp2D/leKanjEaXd4=;
 b=Zk5YQiAo4d56EIIFu1Fuh6ul5uP2+Gce8ap0HU5bdzHWA//lTv1LHOe72se4xi5RU4g/cB
 UXvQ6AIwZbU1XjCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2CA18139E7;
 Thu, 11 Jul 2024 11:18:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oNH9CI6/j2bBVAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 11 Jul 2024 11:18:38 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 11 Jul 2024 13:18:17 +0200
MIME-Version: 1.0
Message-Id: <20240711-landlock-v3-6-c7b0e9edf9b0@suse.com>
References: <20240711-landlock-v3-0-c7b0e9edf9b0@suse.com>
In-Reply-To: <20240711-landlock-v3-0-c7b0e9edf9b0@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5070;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=+FzAmi9oToyv+XG8VhpKKxVj4PNNm3MoBaPpzK2T7Es=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmj79/a/RiMsO+mBUsdzKkCrrox5glAhA0DaX3K
 thSggelNN2JAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZo+/fwAKCRDLzBqyILPm
 RuGkDAC0iVQsF2grQtuUuuPr88yogDq9HLXOSBxC1cYwvPWihWpJqVgCcvRlLm9ODB6smz8R8Uu
 gRv+azPX5awYugF0bBGGiTZ3aildMA0WsTtYOS0lXABt1JU1Bc3Fd8uJ2shJH+N+/dXXThZOJSQ
 OD9VKM2raKbK+imQt6Yls3rFJ1u1Cj0TzjRpojo5BSHjL2TQ5Lr31PKLJqvyAbupB7biZQxZ3ig
 VQYbaf7LCTTK33CdNsG+fwEN+1wOdOHp4EljMafLZQ6yzknCY5fSfWJ1B4gkB3BBhGWF5fl5qPb
 3feGTM5Ir3Aq39ZvkCvBTSKUKulYaMJ/bayIxSOrlqZE0zGA/llGwoF9iwZuy3DquOtZVi7dKOJ
 NFtibezIdYXdgymnyNXUVAFJNpLc3S8MC5E/kfLkzdacKNHM1yrjqr/dH1iVd6F5Q4DSQbNkMsL
 65lATko9/PTkpvdyagI0ZJ2WARproxzTsZ+6VcnbpTzTGVpdIfgSNnijdNauMEvvMA3Sg=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 06/11] Add landlock02 test
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

Reviewed-by: Li Wang <liwang@redhat.com>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                |   1 +
 testcases/kernel/syscalls/landlock/.gitignore   |   1 +
 testcases/kernel/syscalls/landlock/landlock02.c | 153 ++++++++++++++++++++++++
 3 files changed, 155 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index d0a9bd14e..3930abc92 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -686,6 +686,7 @@ kill12 kill12
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
