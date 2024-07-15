Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CC4FC3DA4B
	for <ltp@archiver.kernel.org>; Mon, 15 Jul 2024 12:19:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 285CC3D1A34
	for <ltp@archiver.kernel.org>; Mon, 15 Jul 2024 14:19:29 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5B7F23D1A0E
 for <ltp@lists.linux.it>; Mon, 15 Jul 2024 14:18:57 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9D6FB60045F
 for <ltp@lists.linux.it>; Mon, 15 Jul 2024 14:18:56 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 07BF021BAE;
 Mon, 15 Jul 2024 12:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721045936; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4K0nEUyEmtTt+/JvQVlIhkJwVXBIDzK2IBU2Ewqwx2E=;
 b=FvqUpZvV9XJ1IcK/ls4zQZXJCfWceIKI5noSEiTFRlsKcSq7eyyPk2A+MfLeM+usGhcfe+
 e9W9KhvmVkBcVfPHv5h+TzvecdzHKxXUtVGFwEDRZaCMjYEb3PWE0TQAY5LhRR7dclH/4J
 VLaaY6kvHOMbuLZ3pgIcecyXhY/6rA4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721045936;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4K0nEUyEmtTt+/JvQVlIhkJwVXBIDzK2IBU2Ewqwx2E=;
 b=yQEAVLomjwCfqibHDZRXMRNxDGe8yNOXDyHS25rtI9L3z1Hhpt15pYm9JR75AkjPt/5Y44
 GDZKcIcxTel2LpCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721045936; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4K0nEUyEmtTt+/JvQVlIhkJwVXBIDzK2IBU2Ewqwx2E=;
 b=FvqUpZvV9XJ1IcK/ls4zQZXJCfWceIKI5noSEiTFRlsKcSq7eyyPk2A+MfLeM+usGhcfe+
 e9W9KhvmVkBcVfPHv5h+TzvecdzHKxXUtVGFwEDRZaCMjYEb3PWE0TQAY5LhRR7dclH/4J
 VLaaY6kvHOMbuLZ3pgIcecyXhY/6rA4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721045936;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4K0nEUyEmtTt+/JvQVlIhkJwVXBIDzK2IBU2Ewqwx2E=;
 b=yQEAVLomjwCfqibHDZRXMRNxDGe8yNOXDyHS25rtI9L3z1Hhpt15pYm9JR75AkjPt/5Y44
 GDZKcIcxTel2LpCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E69811395F;
 Mon, 15 Jul 2024 12:18:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cHnzNq8TlWbpQAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 15 Jul 2024 12:18:55 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 15 Jul 2024 14:18:35 +0200
MIME-Version: 1.0
Message-Id: <20240715-cachestat-v2-4-55817ad1a408@suse.com>
References: <20240715-cachestat-v2-0-55817ad1a408@suse.com>
In-Reply-To: <20240715-cachestat-v2-0-55817ad1a408@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3627;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=uWyT0tGPyEZgkpMYto9J2ify1VaBQunLO5B2qOFv8cg=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmlROhEc61M2Z3+fFq4f/oRYytX5eY7MlkSMiPv
 Oc6t3/sqGWJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZpUToQAKCRDLzBqyILPm
 RiHwDAC1vDh0rVmHZVONLEdrXavrCwUX6svODy4F1qAqGHJ/FEeJU5Xm6Y4jWpZ81vkpRwDjtdC
 /cTBYPAeCgEFpRfLFt6vJwAHbXuPjHMJ+foBCc8bm7j8qAstoIiYMW0DUi2vVbv7cRdybSQSjvF
 DlWMLuPEF1JQV45IFLX2TPX5uXa38QnX+tEOHV3iR8sjbJbnThAxUeFMa1TJFmPUgdo4pZzlM86
 a2Z5pgwdfWNcwnedsFotkidU320+lf55DGH/AARb3qR/V+uXNoHIbMUMAHp8h7hwnS6KIZTXwEL
 QKyVQkjJEAXS5XHLiDgKfOnq3bpHxgDF9StmCEj3UXk91r4oTkSxn6zAUvd3O2VwKh2Ut2nr50D
 hb1eKayFNQZV1TPOUdSB+B9WqjlavX78Z01t4FUmJFKkHF1i+Sc3lHlMIc0zElO70yhQHcGZcCH
 pPBDrWUbpID6IiwpcapFY9ho30Y95WcptzMPsPq0GzLofXfDs0wr9vaAXm9uMT4rSIKi8=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 4/4] Add cachestat03 test
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
index 887ac217b..de5a21749 100644
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
