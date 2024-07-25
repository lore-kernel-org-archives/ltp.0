Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76299C3DA49
	for <ltp@archiver.kernel.org>; Thu, 25 Jul 2024 09:24:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DCF7B3D1CBC
	for <ltp@archiver.kernel.org>; Thu, 25 Jul 2024 11:24:24 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 43AEA3D0FA8
 for <ltp@lists.linux.it>; Thu, 25 Jul 2024 11:23:53 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9B3891405142
 for <ltp@lists.linux.it>; Thu, 25 Jul 2024 11:23:52 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D7B9521BF6;
 Thu, 25 Jul 2024 09:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721899431; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dJaIu1Pm28/TqoGXJLLUAdYTn5zzjl0eq/AH/74NdQ8=;
 b=uND26vSw8w5KcD5DHGk4kDfToSMciCSD2ywWVVey4nnzm/bNyPtSaGIDVQz7aikjN0ciDh
 KDVbq1/IYzrnd6WfUvVnXje9nyCnJD/yamjqb5OUrL/zINx9ZOHlp/KVNRobaW5WVqvg6X
 XKbHqYARKRQak92x0kywIuD1Sj7DIuk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721899431;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dJaIu1Pm28/TqoGXJLLUAdYTn5zzjl0eq/AH/74NdQ8=;
 b=D+C+1IEbnyBNgYHfxl5sW6bddEP9hcs+jLyhJTJO4Zqqkp+tbjJytCyQ6WDizBhhJueKm9
 ouyAOJ+wTLu/kkAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721899431; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dJaIu1Pm28/TqoGXJLLUAdYTn5zzjl0eq/AH/74NdQ8=;
 b=uND26vSw8w5KcD5DHGk4kDfToSMciCSD2ywWVVey4nnzm/bNyPtSaGIDVQz7aikjN0ciDh
 KDVbq1/IYzrnd6WfUvVnXje9nyCnJD/yamjqb5OUrL/zINx9ZOHlp/KVNRobaW5WVqvg6X
 XKbHqYARKRQak92x0kywIuD1Sj7DIuk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721899431;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dJaIu1Pm28/TqoGXJLLUAdYTn5zzjl0eq/AH/74NdQ8=;
 b=D+C+1IEbnyBNgYHfxl5sW6bddEP9hcs+jLyhJTJO4Zqqkp+tbjJytCyQ6WDizBhhJueKm9
 ouyAOJ+wTLu/kkAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 384FF13874;
 Thu, 25 Jul 2024 09:23:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UKIUCKcZombZNgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 25 Jul 2024 09:23:51 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 25 Jul 2024 11:23:11 +0200
MIME-Version: 1.0
Message-Id: <20240725-landlock-v4-1-66f5a1c0c693@suse.com>
References: <20240725-landlock-v4-0-66f5a1c0c693@suse.com>
In-Reply-To: <20240725-landlock-v4-0-66f5a1c0c693@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4750;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=5ajeyQCEkKy37Kin53CKtrJX/CRLZK7aMsJSIsHzt0c=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmohmPTkhf7v3Ef4T4ObMDv1aV1eq8Y3djmA+iq
 wKzK+Fu9/eJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZqIZjwAKCRDLzBqyILPm
 RtMBC/9Ft3oFXHdIHi9kNF1hMbggGc/CPg/7rk/lHkPwrcKpymwJj21fSyCrE5/fi1G2OdwPCgH
 jk+W9i7KJks7JMddm9PCMT4aP3Qot6E9xb+8T5Nq2OIrLhXejasLgVU8hrz/UBQIDQFAFWaSLzr
 FnN5NNOdgUL/q5Dd/PrvDIBMTvyj72jPtkG844WGdConJ2RRFT8bB5qa0jAp9kRzhL9fITYcv+h
 Hvqr+AmpbEYOeTsvnh760utu33H7V1IaNKPj6CdpVzbn5aTsMcxjlW6k1BRPgiieofB5yMfLkPi
 wzidAQ+LkGwd8H2vmGEXL+IfrCxL/2POJqfQ3tUvrNNcIsqN3xyuJgPwjCw5zcY7/VQnqXmBEd2
 nqAVdh/oLTOXbdLOgNmsuAd5NKX2Jxil7+BKkyI6f7BG7EOWNi3b+s2USO1OZnIs/oS7C7aE+MZ
 hQ4tZyxUT49GOj65qOtm56DximWFpaNjHY/r+p89EcumF0AJc5MMlR1K+LhDT1FlvpIYs=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-4.10 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 1/5] Add landlock03 test
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
Cc: mic@digikod.net, gnoack@google.com
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
 testcases/kernel/syscalls/landlock/landlock03.c | 128 ++++++++++++++++++++++++
 3 files changed, 130 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 8f9e06e73..9b3cba667 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -698,6 +698,7 @@ kill13 kill13
 
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
index 000000000..c70d23885
--- /dev/null
+++ b/testcases/kernel/syscalls/landlock/landlock03.c
@@ -0,0 +1,128 @@
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
+static void run_child(struct tcase *tc)
+{
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
+static void run(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+
+	if (!SAFE_FORK()) {
+		run_child(tc);
+		_exit(0);
+	}
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
+	.forks_child = 1,
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
