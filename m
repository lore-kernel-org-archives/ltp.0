Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8344C3DA42
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 18:04:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5CA653D47C6
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 20:04:21 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 622253D073A
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 20:02:21 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B2EAC1007C95
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 20:02:20 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 96E6021BF1;
 Wed, 10 Jul 2024 18:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720634539; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TyGT0Y/vEGPZPNmAaPeltdIkPkxSua/Qv+7CrPAY9vY=;
 b=Htv7M+55U76s8QCIgTT0hrDUPT2FDtXTxZUOgbUUa7MBhSqe0OakYHDj7QvSASfrT6B4IP
 V44QIMFWq+3GatB2QAmSMIkLyrRFERECDthOdMoORjSig+aAgeycNgIc3w/FAC5u1QpeDE
 nO+Hg492KDMMRgC+7+gKg5IDvagqgJs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720634539;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TyGT0Y/vEGPZPNmAaPeltdIkPkxSua/Qv+7CrPAY9vY=;
 b=kjB654GVb63kdXw18X9is2wimI2H1Vybg8LJcTZUnehxVVMRDmvlp7OGCapPDjxHhw9dNR
 opq+QqAnUSRIadBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720634539; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TyGT0Y/vEGPZPNmAaPeltdIkPkxSua/Qv+7CrPAY9vY=;
 b=Htv7M+55U76s8QCIgTT0hrDUPT2FDtXTxZUOgbUUa7MBhSqe0OakYHDj7QvSASfrT6B4IP
 V44QIMFWq+3GatB2QAmSMIkLyrRFERECDthOdMoORjSig+aAgeycNgIc3w/FAC5u1QpeDE
 nO+Hg492KDMMRgC+7+gKg5IDvagqgJs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720634539;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TyGT0Y/vEGPZPNmAaPeltdIkPkxSua/Qv+7CrPAY9vY=;
 b=kjB654GVb63kdXw18X9is2wimI2H1Vybg8LJcTZUnehxVVMRDmvlp7OGCapPDjxHhw9dNR
 opq+QqAnUSRIadBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7C24F137D2;
 Wed, 10 Jul 2024 18:02:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sPgCHavMjmZJfAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 10 Jul 2024 18:02:19 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 10 Jul 2024 20:02:01 +0200
MIME-Version: 1.0
Message-Id: <20240710-landlock-v2-6-ff79db017d57@suse.com>
References: <20240710-landlock-v2-0-ff79db017d57@suse.com>
In-Reply-To: <20240710-landlock-v2-0-ff79db017d57@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5070;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=e0RkwiMeII0OEPo08C0G8E8ubmaPiBzM5Vxl+KW2RGM=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmjsye/eG+yXBwcR6EgM/XF70Xw3qLqR1aN0lml
 rJ0oznNjP+JAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZo7MngAKCRDLzBqyILPm
 RmYxC/9ytTb6eJdolg8aDBYSqbK5R8qN9bJi8Jt+4H60e3dHnq1F3kBPEgUswQE9/MRqb4+HUw1
 AF0vN7/uwSNjgqGvcOrJC9C8DmJiMKZI1DVQT+mXjgRnM4WqXUnFkpc19d4LkDfCaDrHJz9ZzMQ
 NffVOMBRyS6unj4oau72z/HxQNo5rHs6LfIH3spTCza4Ypq82gCouHPZhvDkygdO0/Db9OmmUnQ
 AX929z0WnPUHcTcMi2mZlbv2LjcPNAHrlg64KcK/7DPKYYTAsdWdDAPzV7odBjl2kvksxT2V/wT
 QbsxWdE4vT0NWeSDhNd0e/FSy0Fmq/DfskBbdmUcjaoyUhBCQ27chyicxXNs7fh4hABwByKiJQ8
 2BeqTHisHqEJuUmczCgOvVxHbrVDHjPeGWBYSyHc8x4NcsqEt0Z6hAznkdE37G8VDSDQj4PRdA7
 jJ9i4w1Lop5s+UQzrcHaZLBJOPtUM7Ktm73tJ6zGJ82RFVXBrSbhJeo+kLyVtrb/yoMtM=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 06/11] Add landlock02 test
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
index 667e419a3..25a99e6f1 100644
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
