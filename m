Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E701C3DA41
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 17:59:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D0D5E3D38D5
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 19:59:19 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 03D453D386A
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 19:57:05 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id EEBF6602968
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 19:57:04 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7335521BEE;
 Wed, 10 Jul 2024 17:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720634219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iUbO1hbdVu1HM9hhS/xB7D4ptVEQ8sClRhRF94m1TSU=;
 b=E8MqAjuB/GNga1bPQCPgRBSwkafw4OYzJJvfBXmd90euVZ/Lhs/HMUhxDOkwU3wl67qOlU
 A/xqDnodLB2Dwd6bmTE+1O+T/AjFhBoryv8kC5CDwMb1PBNMuQVzKQGTGkJSOrSHiRbqBq
 KYO+yq73z2owHjWdR5LPW2YST7gJvF8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720634219;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iUbO1hbdVu1HM9hhS/xB7D4ptVEQ8sClRhRF94m1TSU=;
 b=9T8OW6b+zfw/F17YWY1/TTMEBe5Fs5AKDvPu79mXcHn16cH4pZzNmxgaxg0xAItrxV9xE5
 pCvwmIeK7j2KlABQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=E8MqAjuB;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9T8OW6b+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720634219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iUbO1hbdVu1HM9hhS/xB7D4ptVEQ8sClRhRF94m1TSU=;
 b=E8MqAjuB/GNga1bPQCPgRBSwkafw4OYzJJvfBXmd90euVZ/Lhs/HMUhxDOkwU3wl67qOlU
 A/xqDnodLB2Dwd6bmTE+1O+T/AjFhBoryv8kC5CDwMb1PBNMuQVzKQGTGkJSOrSHiRbqBq
 KYO+yq73z2owHjWdR5LPW2YST7gJvF8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720634219;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iUbO1hbdVu1HM9hhS/xB7D4ptVEQ8sClRhRF94m1TSU=;
 b=9T8OW6b+zfw/F17YWY1/TTMEBe5Fs5AKDvPu79mXcHn16cH4pZzNmxgaxg0xAItrxV9xE5
 pCvwmIeK7j2KlABQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 56CF0137D2;
 Wed, 10 Jul 2024 17:56:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oPPfE2vLjmaZegAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 10 Jul 2024 17:56:59 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 10 Jul 2024 19:56:41 +0200
MIME-Version: 1.0
Message-Id: <20240710-landlock-v2-3-478d8c2f6bab@suse.com>
References: <20240710-landlock-v2-0-478d8c2f6bab@suse.com>
In-Reply-To: <20240710-landlock-v2-0-478d8c2f6bab@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4615;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=I65CG4OFA8c95lJSnWS2Ev39wVPWqRfrwggdzP/0rIw=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmjste2hb6yEgiutsMpOFCwOl4+6qP2M1PZq/wp
 v/zOwNIhXCJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZo7LXgAKCRDLzBqyILPm
 RgzvC/95z5mdTSwfG5DKm6CAKr9gQje2TuXMh/w0IIjx5La9+/GoxshFE8Ip4f0dL0m9jwAn6aW
 cHQKKnu9+mOR1Orkp/PbS+qpr4W5SsnG6qHENnOYVKh7QioFEe8dNhohVcmer1vUmYrV26cYuNO
 Lk56ETaxYxAIgbNG1m6nvgKn2Q3V17i5CtSy3UAjwQh4ww1TV66guot4FfZyN/6x6QqE7TgjAOR
 mVxO0NuM6/D4UjWhcxy/fO0HM3uJxEAafGO35IsBbXHpPoCSMxPPUTBXQW3BG9TVa8NoypcuEad
 76rqEn8wG8lWdO/bnT82c50y4rEBhwy5TViWuGZwvz9ZJvZYOhi9h91teUpVcuszev+Zc273NXG
 2MeGN4CBkUmMpgS7O9DytGO0TgytKjLbktlQ3j4IUJaGUOOlatRrrSGEGMXXKb3hOiOaHd14eIO
 BocGlAVBWh8Xdge0LYjmA84LPM3pNN7qPbLaZkEC7LF9JE4FiGpXXHaQBSQsqG2zFJ5SQ=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Rspamd-Queue-Id: 7335521BEE
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
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/7] Add landlock03 test
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
index 25a99e6f1..269cf24b1 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -686,6 +686,7 @@ kill13 kill13
 
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
