Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05123C3DA59
	for <ltp@archiver.kernel.org>; Mon, 22 Jul 2024 14:29:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 556B13D1BD5
	for <ltp@archiver.kernel.org>; Mon, 22 Jul 2024 16:29:58 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6A6103D0BC9
 for <ltp@lists.linux.it>; Mon, 22 Jul 2024 16:29:26 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 80C8E6013EF
 for <ltp@lists.linux.it>; Mon, 22 Jul 2024 16:29:25 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 109571FD06;
 Mon, 22 Jul 2024 14:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721658565; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+aI5/A9bCeAbsod8PLVisqTrtVPSr9kNWkI57RobPlg=;
 b=xuMq2ga+VTGcBE2BvQGAAuRQFRRyTwDTqcScw+xfUUmUDrhg8t9N2HbHOXLfpQ5Q+yGuJb
 0kYMv1GHX16/6mRF8eYgkCNzIjaSBMbkgyL1zF0rT4erl5iMAoGnJqxKSxk4wiCKBGq1/u
 wGn2kmdZBQxHP9I20l2zsirwB9vCmmM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721658565;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+aI5/A9bCeAbsod8PLVisqTrtVPSr9kNWkI57RobPlg=;
 b=l/EFWt1lLGu8p6c5WIVWdZFWpU5sZfLI9UD7CJ4fn9TyF9osOWR+cENIdKPtA0TvJBtfwy
 VTC7HxSNf2mBUhAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xuMq2ga+;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="l/EFWt1l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721658565; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+aI5/A9bCeAbsod8PLVisqTrtVPSr9kNWkI57RobPlg=;
 b=xuMq2ga+VTGcBE2BvQGAAuRQFRRyTwDTqcScw+xfUUmUDrhg8t9N2HbHOXLfpQ5Q+yGuJb
 0kYMv1GHX16/6mRF8eYgkCNzIjaSBMbkgyL1zF0rT4erl5iMAoGnJqxKSxk4wiCKBGq1/u
 wGn2kmdZBQxHP9I20l2zsirwB9vCmmM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721658565;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+aI5/A9bCeAbsod8PLVisqTrtVPSr9kNWkI57RobPlg=;
 b=l/EFWt1lLGu8p6c5WIVWdZFWpU5sZfLI9UD7CJ4fn9TyF9osOWR+cENIdKPtA0TvJBtfwy
 VTC7HxSNf2mBUhAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E74D51398E;
 Mon, 22 Jul 2024 14:29:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CAaTNsRsnmazSwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 22 Jul 2024 14:29:24 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 22 Jul 2024 16:28:43 +0200
MIME-Version: 1.0
Message-Id: <20240722-cachestat-v3-4-a0386f7cdaaa@suse.com>
References: <20240722-cachestat-v3-0-a0386f7cdaaa@suse.com>
In-Reply-To: <20240722-cachestat-v3-0-a0386f7cdaaa@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3627;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=iE2E3tR9ImwC0SsKWtotDqGe5U1PqnXGHHfk2QGnL8c=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmnmyvwrbOA+PAt0/c0vHPDYV2iZ+s8WLcnjo/5
 /g2a3N8SBaJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZp5srwAKCRDLzBqyILPm
 RjbnC/45AgF/Ys+Bg3XMWtFYnzWT/4/sJiE0/yd3lDjH/JEeT/bx0cTul8T6x8HcbFTdAgd8nuz
 mzZfXU/u6xJj9lmndY1vP8PC9raDNibE6kNwf/YnHliesKD6jSAJ/MFurXse31y2R1yGv+mCsow
 5G/WZRODt5PrxTO778GIE+TKzRQxoJupkxU4KOzQ4DcqTxE+LPqKf+g6aRbidS9fwJ1INbDzJHK
 HDITBxCxSGXqK5p63+WuSrDhlAtxD9zMA4XNK6mfwNUs22FnoGo24ydlPgJrzHIvI90h0twFui9
 2qDd3kc6xk8i4ZM1QKJN49gom48yfmKBJ5c41BBf40AJqSSZ+ENnBFztOsqzutyWC4y5IsPXG64
 3fp/ch31Un1yrsFF6Hia3uvV/PT8p/7jlSAn89sIUCF8honC2EAEvIsVyjmUbRSZa2M4y6ha8PT
 yj/9ejKSnIniAzwLjas2O7j/u+h3eVh6rFYk351Y3XChsyi3Xbe8GYKc3xE2Qlq+9vxFc=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-1.31 / 50.00]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim]; RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.de:dkim];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 109571FD06
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 4/5] Add cachestat03 test
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

This test verifies that cachestat() syscall is properly failing with
relative error codes according to input parameters.

- EFAULT: cstat or cstat_range points to an illegal address
- EINVAL: invalid flags
- EBADF: invalid file descriptor
- EOPNOTSUPP: file descriptor is of a hugetlbfs file

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                  |  1 +
 testcases/kernel/syscalls/cachestat/.gitignore    |  1 +
 testcases/kernel/syscalls/cachestat/cachestat03.c | 80 +++++++++++++++++++++++
 3 files changed, 82 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 294e3cebf..8a297429b 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -64,6 +64,7 @@ cacheflush01 cacheflush01
 
 cachestat01 cachestat01
 cachestat02 cachestat02
+cachestat03 cachestat03
 
 chdir01 chdir01
 chdir01A symlink01 -T chdir01
diff --git a/testcases/kernel/syscalls/cachestat/.gitignore b/testcases/kernel/syscalls/cachestat/.gitignore
index 0f70fb801..6cfa3fa10 100644
--- a/testcases/kernel/syscalls/cachestat/.gitignore
+++ b/testcases/kernel/syscalls/cachestat/.gitignore
@@ -1,2 +1,3 @@
 cachestat01
 cachestat02
+cachestat03
diff --git a/testcases/kernel/syscalls/cachestat/cachestat03.c b/testcases/kernel/syscalls/cachestat/cachestat03.c
new file mode 100644
index 000000000..35f6bdfb3
--- /dev/null
+++ b/testcases/kernel/syscalls/cachestat/cachestat03.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * This test verifies that cachestat() syscall is properly failing with relative
+ * error codes according to input parameters.
+ *
+ * - EFAULT: cstat or cstat_range points to an illegal address
+ * - EINVAL: invalid flags
+ * - EBADF: invalid file descriptor
+ * - EOPNOTSUPP: file descriptor is of a hugetlbfs file
+ */
+
+#define MNTPOINT "mnt"
+
+#include "cachestat.h"
+
+static int fd;
+static int fd_hugepage;
+static int invalid_fd = -1;
+static struct cachestat *cs;
+static struct cachestat *cs_null;
+static struct cachestat_range *cs_range;
+static struct cachestat_range *cs_range_null;
+
+static struct tcase {
+	int *fd;
+	struct cachestat_range **range;
+	struct cachestat **data;
+	int flags;
+	int exp_errno;
+	char *msg;
+} tcases[] = {
+	{&invalid_fd, &cs_range, &cs, 0, EBADF, "Invalid fd (-1)"},
+	{&fd, &cs_range_null, &cs, 0, EFAULT, "Invalid range (NULL)"},
+	{&fd, &cs_range, &cs_null, 0, EFAULT, "Invalid data (NULL)"},
+	{&fd, &cs_range, &cs, -1, EINVAL, "Invalid args (-1)"},
+	{&fd_hugepage, &cs_range, &cs, 0, EOPNOTSUPP, "Unsupported hugetlbfs"},
+};
+
+static void run(unsigned int i)
+{
+	struct tcase *tc = &tcases[i];
+
+	TST_EXP_FAIL(cachestat(*tc->fd, *tc->range, *tc->data, tc->flags),
+		tc->exp_errno, "%s", tc->msg);
+}
+
+static void setup(void)
+{
+	fd = SAFE_OPEN("test", O_CREAT | O_RDWR, 0700);
+	fd_hugepage = SAFE_OPEN(MNTPOINT"/test", O_CREAT | O_RDWR, 0700);
+}
+
+static void cleanup(void)
+{
+	SAFE_CLOSE(fd);
+	SAFE_CLOSE(fd_hugepage);
+}
+
+static struct tst_test test = {
+	.test = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.mntpoint = MNTPOINT,
+	.needs_hugetlbfs = 1,
+	.hugepages = {1, TST_NEEDS},
+	.tcnt = ARRAY_SIZE(tcases),
+	.min_kver = "6.5",
+	.needs_tmpdir = 1,
+	.bufs = (struct tst_buffers []) {
+		{&cs, .size = sizeof(struct cachestat)},
+		{&cs_range, .size = sizeof(struct cachestat_range)},
+		{}
+	},
+};

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
