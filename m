Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 433DAC3DA63
	for <ltp@archiver.kernel.org>; Tue, 23 Jul 2024 18:00:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ADEFB3D1C61
	for <ltp@archiver.kernel.org>; Tue, 23 Jul 2024 20:00:29 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 254E83D1C00
 for <ltp@lists.linux.it>; Tue, 23 Jul 2024 19:59:11 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 96CD91000D11
 for <ltp@lists.linux.it>; Tue, 23 Jul 2024 19:59:10 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7CE2E21C4E;
 Tue, 23 Jul 2024 17:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721757549; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M0rEv2nrfqt3ge1Vwty0JzWUB0Z5dm11yOrV+8qlVx0=;
 b=SYgypflILxi7BKRZj2WzD3kDY9oFG+IPbVl9j/jrWED+i3+Hw+7p1nMlEl63LlMtmlQGTD
 6gLOqM9l4ce7EbiZWCYtupuEhE5a/X3lKf4ufDTiXRHrC5xdHtN7Tz6EPp6ErktC/H1BKM
 lM3x361HoAYZmc8EKV7eSmoma//XECc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721757549;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M0rEv2nrfqt3ge1Vwty0JzWUB0Z5dm11yOrV+8qlVx0=;
 b=2L+v+aEjNJx/xOccFY/cygHVTQwrNfoKA0xcWStmvTcfG1kk+M5ZeW7LXlJRv9j2YbLOOd
 pSZwE3bl+fGn3wDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=SYgypflI;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=2L+v+aEj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721757549; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M0rEv2nrfqt3ge1Vwty0JzWUB0Z5dm11yOrV+8qlVx0=;
 b=SYgypflILxi7BKRZj2WzD3kDY9oFG+IPbVl9j/jrWED+i3+Hw+7p1nMlEl63LlMtmlQGTD
 6gLOqM9l4ce7EbiZWCYtupuEhE5a/X3lKf4ufDTiXRHrC5xdHtN7Tz6EPp6ErktC/H1BKM
 lM3x361HoAYZmc8EKV7eSmoma//XECc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721757549;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M0rEv2nrfqt3ge1Vwty0JzWUB0Z5dm11yOrV+8qlVx0=;
 b=2L+v+aEjNJx/xOccFY/cygHVTQwrNfoKA0xcWStmvTcfG1kk+M5ZeW7LXlJRv9j2YbLOOd
 pSZwE3bl+fGn3wDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4811B1377F;
 Tue, 23 Jul 2024 17:58:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yFyrDFXvn2aMEgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 23 Jul 2024 17:58:45 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 23 Jul 2024 17:41:07 +0200
MIME-Version: 1.0
Message-Id: <20240723-fchmodat2-v2-5-e658a98b113e@suse.com>
References: <20240723-fchmodat2-v2-0-e658a98b113e@suse.com>
In-Reply-To: <20240723-fchmodat2-v2-0-e658a98b113e@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2700;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=3NhMXj7DCJcgn1hU5AL0jVK6oGmlwbBr14uXLXw3MiU=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmn+9Xdse8SIaxZnyhxSsRiVVNisZdqVsRqx6JF
 lxlzpBCFkqJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZp/vVwAKCRDLzBqyILPm
 RrOZC/4hWM0C303MO8SIOgYorw6H6b1gAR4Z6hdr35aOHwntyUu0CcEBPDy5/pVf+yPMMig46lE
 V/iGUXVl8avAPE/9wwJBP0vloL10uLwBH90LTdVRwB7o+nX/ydCjJKs6DUtxA4+A0+OBc4tQd2Z
 E+62w5DqIwUEsxvXP3L6cuU//metxqyZJ+Pn7h5Rnlav1QVXCELXhoXoX8YFVFHz4afHF+gpEwr
 /7d+9XgYQybkUtKlIRJ74506JsDSmBRfxkz3YhDHWvqyI/+4ulJbJu85nllixFONMpTxv8gZ3Ue
 v/C5BjYoQev7mF1vTrS8nx7feD65XQ+A8WPIbB8o9aW8oB+MQ2/pavgnCx0mgqXkooEoubuhsLr
 dY8egmLA7z67qd//z6142DYtfbeyPTDJM8jsioje4gNzrhk6wuYXPgS3oLBdkCfzXun7pTnrdWr
 uP7EvVvbpXw80xCFzPZWwXE1+sUkTOHg7UyJrQYu3L80AEf8k6RlLb6v1IWvsmA6J2cbg=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 7CE2E21C4E
X-Spamd-Result: default: False [-4.31 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 5/5] Add fchmodat2_02 test
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
