Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE02AC3DA42
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 17:58:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8982E3D38B1
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 19:58:42 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3B8243D3818
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 19:57:02 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6ABAA1000A6E
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 19:57:01 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 547CD1FB55;
 Wed, 10 Jul 2024 17:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720634219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TyGT0Y/vEGPZPNmAaPeltdIkPkxSua/Qv+7CrPAY9vY=;
 b=E8jkx5C0eFkqAgg+kzpAl3avuf5dcWnQ0EHzweNgijstZPEsjbWdnyVvcL1hFcqEwSiUXo
 7s20vJPs61jIuT2HYfyxOzbF60Ldr+8zkokVymJU+p97BiZStbkEF1JIaURJbBRT0rfhXP
 4af3qSSlnM9FORKQD3biyH6urau5d1k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720634219;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TyGT0Y/vEGPZPNmAaPeltdIkPkxSua/Qv+7CrPAY9vY=;
 b=Fp3hNI85mFdCG/We7qA4V9pCr6uKClBAkAXY/V2MTj7sIBb68Rd9jxRVFkeyjElg5hD8ac
 CkRkYnhyX18848Dw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=E8jkx5C0;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Fp3hNI85
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720634219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TyGT0Y/vEGPZPNmAaPeltdIkPkxSua/Qv+7CrPAY9vY=;
 b=E8jkx5C0eFkqAgg+kzpAl3avuf5dcWnQ0EHzweNgijstZPEsjbWdnyVvcL1hFcqEwSiUXo
 7s20vJPs61jIuT2HYfyxOzbF60Ldr+8zkokVymJU+p97BiZStbkEF1JIaURJbBRT0rfhXP
 4af3qSSlnM9FORKQD3biyH6urau5d1k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720634219;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TyGT0Y/vEGPZPNmAaPeltdIkPkxSua/Qv+7CrPAY9vY=;
 b=Fp3hNI85mFdCG/We7qA4V9pCr6uKClBAkAXY/V2MTj7sIBb68Rd9jxRVFkeyjElg5hD8ac
 CkRkYnhyX18848Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3361913A7F;
 Wed, 10 Jul 2024 17:56:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oJ44C2vLjmaZegAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 10 Jul 2024 17:56:59 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 10 Jul 2024 19:56:40 +0200
MIME-Version: 1.0
Message-Id: <20240710-landlock-v2-2-478d8c2f6bab@suse.com>
References: <20240710-landlock-v2-0-478d8c2f6bab@suse.com>
In-Reply-To: <20240710-landlock-v2-0-478d8c2f6bab@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5070;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=e0RkwiMeII0OEPo08C0G8E8ubmaPiBzM5Vxl+KW2RGM=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmjsteVpAWTBjN1w9Ltal1UdeOtOkEvdOU9IeY8
 u5Bf2EPaXeJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZo7LXgAKCRDLzBqyILPm
 Rr3QC/9bEkiyvAC+bq9uZLEZy4xJKy5f5w1gKkBm1D/0ao/nXYjvtgQUrl0+abEygJ8PyIc9TU7
 RcqQpfkED1LdBXNiGGApJM3t3YwxEbCUCu0/44mq1TK5dS8X0ao3oQ02f0OYLL4P93fpKDYN6Jc
 42w9klO7CE3bwIG3OfgrSzkB8Go5RZFW+9esA94TTUM+q3v3XuTxOdd57DoAApA5jz33I9zedJ+
 bnt+kd90W7Oipuu0s2FbAiQMAVKrQIhxMI4WgD2SMPBTyEH4Eqdto5FXOh/pis2wOIlyONyYfE0
 XwMMQWERYTnkjiA20PiR80tAfvmv3/MS11OmRy5xE8cCDwSISuwtXhKDSSgT/zNXEsQtOpFVwuz
 xD/N005RnXlTgTLGE09VZU+Kb/ELbz6W/tnE1i1W8PWbQYMk+ElNsIzE8VOPo/AvztmTwfwrOp3
 fEJR23lSFp+W8JkNm5I27BJC9Iqr8gsOMnBT8sg3WVl3x7nz3XfnbAq2bsPuRSGMF8Bso=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 TO_DN_SOME(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:email];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 547CD1FB55
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/7] Add landlock02 test
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
