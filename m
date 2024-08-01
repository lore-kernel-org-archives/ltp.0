Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E7BC3DA64
	for <ltp@archiver.kernel.org>; Thu,  1 Aug 2024 14:31:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2EB743D1F06
	for <ltp@archiver.kernel.org>; Thu,  1 Aug 2024 16:31:39 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 598F03D1EFD
 for <ltp@lists.linux.it>; Thu,  1 Aug 2024 16:30:05 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BC944603A26
 for <ltp@lists.linux.it>; Thu,  1 Aug 2024 16:30:04 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B100E219CD;
 Thu,  1 Aug 2024 14:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722522603; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zxWZFOjbCyUuRtM5H3v5kv50BX36Tm/VO7gZJXz9OlE=;
 b=lwea5bLn7vLhZQnVz4iig3vQ5Npqxin6MHyroI6RUtl/eRPbN5K20iJWf7r6kZzmxzhJYl
 z8aBi7AV98cNT4rWEvxwOknidTb7OU6ecxfMVM2tfNWZYB7FFYd5qCoZZ404dPtDk3W73J
 6X0uO7Uak3ELDXz+bTP1CPT1VUP4VZU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722522603;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zxWZFOjbCyUuRtM5H3v5kv50BX36Tm/VO7gZJXz9OlE=;
 b=2H37fjmnLi/uTQ9uez53uIIZtxtl/ICoP39gYwmtapK9H9oZnR12w7QnoVZaXH8tKy4QmQ
 vY2nH0Pbv//ra+AA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lwea5bLn;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=2H37fjmn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722522603; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zxWZFOjbCyUuRtM5H3v5kv50BX36Tm/VO7gZJXz9OlE=;
 b=lwea5bLn7vLhZQnVz4iig3vQ5Npqxin6MHyroI6RUtl/eRPbN5K20iJWf7r6kZzmxzhJYl
 z8aBi7AV98cNT4rWEvxwOknidTb7OU6ecxfMVM2tfNWZYB7FFYd5qCoZZ404dPtDk3W73J
 6X0uO7Uak3ELDXz+bTP1CPT1VUP4VZU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722522603;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zxWZFOjbCyUuRtM5H3v5kv50BX36Tm/VO7gZJXz9OlE=;
 b=2H37fjmnLi/uTQ9uez53uIIZtxtl/ICoP39gYwmtapK9H9oZnR12w7QnoVZaXH8tKy4QmQ
 vY2nH0Pbv//ra+AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5E5C613946;
 Thu,  1 Aug 2024 14:30:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8JL4EOubq2Z2AwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 01 Aug 2024 14:30:03 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 01 Aug 2024 16:29:44 +0200
MIME-Version: 1.0
Message-Id: <20240801-fchmodat2-v4-5-7f2f11a53a09@suse.com>
References: <20240801-fchmodat2-v4-0-7f2f11a53a09@suse.com>
In-Reply-To: <20240801-fchmodat2-v4-0-7f2f11a53a09@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2700;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=wXJZ7rIxV9q31q/zWQi6OG9wH/Ihfs0JWHkpJvovaAg=;
 b=owEB7AET/pANAwAIAcvMGrIgs+ZGAcsmYgBmq5vnZWNxNj2r21dvOSlVVTGDU81H57n0rz/Jo
 xNGpIiE8m2JAbIEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZqub5wAKCRDLzBqyILPm
 RujPC/jmdhxdYJCEJiPKvT4zwR32LwieT29KDB/V5kfZSYMgcus30VdYN/q0qLOkbpDPSscVPVq
 HVK5q463A6s0mzn8mU5IzO2AcoyVU2QaoaqdYbxCBYYO7gHMVNq0k1KhgLiEjFW+IXcyrAhcUC7
 mkNOklvfyZjzTqHo9FUkgvc7w2sb8qiuF/vlU+QqEQkSoB6jj2o/IlcFrR+Vsmifith4veJVwAs
 9PiwaQmz9hT5xvbYLrmUA602SPipLaAG12pVVBzaWKJcB7/zd0Hc2Vjx5aHTWYZPcaa/pzwiWau
 kMubeJ1kEgf1R1DRkkndGNKgXCvwxXSu13s+bPEDZ2yALBV0SdWUZNkrs2mE9TVSg/k/Mo9cDhK
 L38EburSXM+dDvOzN1dkL/udX8wc4nCF7md2DtxlD+kD499t5XnBCiSuj1WCGQTNHJ8ePE7h3hS
 zTi8FtqgMTS5SXv77Yjo5DsYU/1AP7/+c6Sb7hT5ZgaOnQY+XYOexFE8ntRzCTL2NizA==
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.31 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 RCVD_TLS_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: B100E219CD
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 5/5] Add fchmodat2_02 test
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

This test verifies that fchmodat2() syscall properly raises errors with
invalid arguments.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                   |  1 +
 testcases/kernel/syscalls/fchmodat2/.gitignore     |  1 +
 testcases/kernel/syscalls/fchmodat2/fchmodat2_02.c | 68 ++++++++++++++++++++++
 3 files changed, 70 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 50298d01e..7292e5ae7 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -271,6 +271,7 @@ fchmodat01 fchmodat01
 fchmodat02 fchmodat02
 
 fchmodat2_01 fchmodat2_01
+fchmodat2_02 fchmodat2_02
 
 fchown01 fchown01
 fchown01_16 fchown01_16
diff --git a/testcases/kernel/syscalls/fchmodat2/.gitignore b/testcases/kernel/syscalls/fchmodat2/.gitignore
index 47d5e2427..9f713198c 100644
--- a/testcases/kernel/syscalls/fchmodat2/.gitignore
+++ b/testcases/kernel/syscalls/fchmodat2/.gitignore
@@ -1 +1,2 @@
 fchmodat2_01
+fchmodat2_02
diff --git a/testcases/kernel/syscalls/fchmodat2/fchmodat2_02.c b/testcases/kernel/syscalls/fchmodat2/fchmodat2_02.c
new file mode 100644
index 000000000..f8497d8a8
--- /dev/null
+++ b/testcases/kernel/syscalls/fchmodat2/fchmodat2_02.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * This test verifies that fchmodat2() syscall properly raises errors with
+ * invalid values.
+ */
+
+#include "tst_test.h"
+#include "lapi/fcntl.h"
+#include "lapi/syscalls.h"
+#include "tst_tmpdir.h"
+
+#define FILENAME "file.bin"
+
+static char *tmpdir;
+static int fd;
+static int fd_invalid = -1;
+
+static struct tcase {
+	int *fd;
+	char *fname;
+	int mode;
+	int flag;
+	int exp_errno;
+	char *msg;
+} tcases[] = {
+	{&fd_invalid, FILENAME, 0777, 0, EBADF, "bad file descriptor"},
+	{&fd, "doesnt_exist.txt", 0777, 0, ENOENT, "unexisting file"},
+	{&fd, FILENAME, 0777, -1, EINVAL, "invalid flags"},
+};
+
+static void run(unsigned int i)
+{
+	struct tcase *tc = &tcases[i];
+
+	TST_EXP_FAIL(tst_syscall(__NR_fchmodat2,
+		*tc->fd, tc->fname, tc->mode, tc->flag),
+		tc->exp_errno,
+		"Test %s", tc->msg);
+}
+
+static void setup(void)
+{
+	tmpdir = tst_tmpdir_path();
+
+	SAFE_TOUCH(FILENAME, 0640, NULL);
+	fd = SAFE_OPEN(tmpdir, O_PATH | O_DIRECTORY, 0640);
+}
+
+static void cleanup(void)
+{
+	if (fd != -1)
+		SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.test = run,
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+};
+

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
