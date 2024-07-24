Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33E79C3DA63
	for <ltp@archiver.kernel.org>; Wed, 24 Jul 2024 09:47:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BE5C93D1C4D
	for <ltp@archiver.kernel.org>; Wed, 24 Jul 2024 11:47:52 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BF7A83D1C1D
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 11:46:10 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B21101A01988
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 11:46:09 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AEB0C1F799;
 Wed, 24 Jul 2024 09:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721814368; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M0rEv2nrfqt3ge1Vwty0JzWUB0Z5dm11yOrV+8qlVx0=;
 b=iIYEVxUfNzMXU0f98An9+nzxDaonK64mqKNvne1tkk173docPHSlrw/6wAREyyT/XK3lPS
 Rz4tyuRFiILpwKLol9phqrQjEvQ1U7SX20RzSnDtCfJOcrvrl4NPRX0uLFAR9MhJ9ZFUNh
 KS4hcTm969Q5uj03odR40F13ej36edw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721814368;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M0rEv2nrfqt3ge1Vwty0JzWUB0Z5dm11yOrV+8qlVx0=;
 b=qakqwV2pX8qucOrpNydXcu+5EgymOCOyWh7T5ajCM/SM5lZqFP+c4ytBxkmnGFsCs87oro
 ipALgEBBAyUh7mAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721814368; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M0rEv2nrfqt3ge1Vwty0JzWUB0Z5dm11yOrV+8qlVx0=;
 b=iIYEVxUfNzMXU0f98An9+nzxDaonK64mqKNvne1tkk173docPHSlrw/6wAREyyT/XK3lPS
 Rz4tyuRFiILpwKLol9phqrQjEvQ1U7SX20RzSnDtCfJOcrvrl4NPRX0uLFAR9MhJ9ZFUNh
 KS4hcTm969Q5uj03odR40F13ej36edw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721814368;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M0rEv2nrfqt3ge1Vwty0JzWUB0Z5dm11yOrV+8qlVx0=;
 b=qakqwV2pX8qucOrpNydXcu+5EgymOCOyWh7T5ajCM/SM5lZqFP+c4ytBxkmnGFsCs87oro
 ipALgEBBAyUh7mAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0F12D13411;
 Wed, 24 Jul 2024 09:46:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sAEzNF/NoGYxWwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 24 Jul 2024 09:46:07 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 24 Jul 2024 11:45:35 +0200
MIME-Version: 1.0
Message-Id: <20240724-fchmodat2-v3-5-1dc7cfc634b8@suse.com>
References: <20240724-fchmodat2-v3-0-1dc7cfc634b8@suse.com>
In-Reply-To: <20240724-fchmodat2-v3-0-1dc7cfc634b8@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2700;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=3NhMXj7DCJcgn1hU5AL0jVK6oGmlwbBr14uXLXw3MiU=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmoM1E2tECZuEE7S0va05y7j+7X2GQ2MavFvZR8
 ck0no12lfuJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZqDNRAAKCRDLzBqyILPm
 RmALC/9oPRmhWLDT5kTQ0DG2s39goo4K8dlRwHsNO1VfR5Skwx80Xk8Y8i3yWCVkIrC8vup0iLC
 YYAF8/7ckGDcidIAAQ3Ox2S4KAHijj3mftO06+SGA/uxyxZJXDpoObDZ4RhrLBetUqXfevDMo83
 qHjC5+DXJPYuaaTVGAQE2Xr0rza1P1nw1lyr2/7R7ejHp00CGsowzCObuCf2xQ/YWG01BdlEual
 OTARqjNlkhnBZ/IqYnvF8zFkqQL+IGbVBd5Qdb+kP0/T/QMsHQYJz4pQZt/UV2x9RRsX6zALrDH
 KpuX+J01jsO3gjNWve7CDYwY8JkAq9xtiFdUiDs6EddtYgPru5QTAkIlvC0U07q4lX+Zpl7XP8H
 jMoaHf9rJXE3MYhNkl+ERLvc2ZLatOPcz3lbr+wkS2aTVUXtAkB20WXfQGgICLUEfGsovmTU5Ji
 /zEKAS4Ydx2oVQijApKF3EVafaxYVirVXslyVZ5R1IP5Ia3lTqW96D8J2KqlI+Om91O2o=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-4.10 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 5/5] Add fchmodat2_02 test
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
index b4bb4f391..5cbcf3a4c 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -266,6 +266,7 @@ fchmodat01 fchmodat01
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
