Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B23DEC3DA4A
	for <ltp@archiver.kernel.org>; Fri,  2 Aug 2024 11:00:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 47D323D1F52
	for <ltp@archiver.kernel.org>; Fri,  2 Aug 2024 13:00:54 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CB7E33D1F4C
 for <ltp@lists.linux.it>; Fri,  2 Aug 2024 12:59:15 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1B39E100186F
 for <ltp@lists.linux.it>; Fri,  2 Aug 2024 12:59:15 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9310D1FBA1;
 Fri,  2 Aug 2024 10:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722596354; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yr4udwYxweLRdhBMc8ZuFcBm86ivuIzdckg7xFhkAn4=;
 b=HVhSOptVJcPEn98kkdnjGlsUjBaX9r6RxgaMInP73PYgcI/ztTfvP9rFnc7D//72nQLvRx
 SGzuqM+gaugmd8AWDuyikCamVDU2AuDowEULeDH4K31RltdQUu++okNmGgoqSSAqK5fFBd
 HolhuFfv6SU8uvFxjtm8Wgt0pz1YsW0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722596354;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yr4udwYxweLRdhBMc8ZuFcBm86ivuIzdckg7xFhkAn4=;
 b=W9to1orlRateyIdGmddXFq8v9tf/ua/3tG8kM8QOibncDcS/3MmApg15o6L/2TF4ZCGYgy
 ScOEy5VUGCDytKDg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=HVhSOptV;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=W9to1orl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722596354; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yr4udwYxweLRdhBMc8ZuFcBm86ivuIzdckg7xFhkAn4=;
 b=HVhSOptVJcPEn98kkdnjGlsUjBaX9r6RxgaMInP73PYgcI/ztTfvP9rFnc7D//72nQLvRx
 SGzuqM+gaugmd8AWDuyikCamVDU2AuDowEULeDH4K31RltdQUu++okNmGgoqSSAqK5fFBd
 HolhuFfv6SU8uvFxjtm8Wgt0pz1YsW0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722596354;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yr4udwYxweLRdhBMc8ZuFcBm86ivuIzdckg7xFhkAn4=;
 b=W9to1orlRateyIdGmddXFq8v9tf/ua/3tG8kM8QOibncDcS/3MmApg15o6L/2TF4ZCGYgy
 ScOEy5VUGCDytKDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1E3EB13AED;
 Fri,  2 Aug 2024 10:59:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iMhEAQK8rGbRQgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 02 Aug 2024 10:59:14 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 02 Aug 2024 12:59:08 +0200
MIME-Version: 1.0
Message-Id: <20240802-fchmodat2-v6-5-dcb0293979b3@suse.com>
References: <20240802-fchmodat2-v6-0-dcb0293979b3@suse.com>
In-Reply-To: <20240802-fchmodat2-v6-0-dcb0293979b3@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2742;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=Y9lYSQNv9u+qUODHzO1j1t3+EHDzHYwhITXsU6JeyYA=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmrLv9kfmmvqXhxWUGbPi5MaEkvsdcwvdsMibOt
 qGFcpk4qYqJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZqy7/QAKCRDLzBqyILPm
 RrFNC/41qgumaKfYLqqD0VbOLTyfPXHzWW2GZRzhMh+QQQVjfGjyt/hcFdSHg4fXuRd+mmir2vo
 xhOyFVXMm46XUCR9gh4sR/lmCHAyxIsMhjX4BLjO9bPAXQPGz1al/AG5Zr49fl4NfhSMBQ1oOt6
 OIFqhoMxWfPrqG2HUIkCIm6r8itgSY10NLX350iCh625RMzXfgbW9nhpsUk84c40gNjGx7Ex9+2
 b5XXJCJDkujLd66YhIcxzBULot7h+038bUhYozx+QawGKVwYvwXqXlqRtI9sYT4vQuhNkUwCYZC
 Z5aUO71cSjej/xk90/V81kVCdelIoPRPzODx8wIWMgVcUV8L0cu2+dTRzg7pIGDO5O50P30o1AI
 2v0Y4UrzH9try44rLpFOV7n4tTQEpu5N3FccB6XKzwq17e+9iSED+gceA8LclaGhiQJcKhFmViQ
 hLk2aumGR+04dpDzt8Ecf16emxVAtZEJESJXfAEQP0LhLisKZp/HxxFkKFo6lIi+6SQFQ=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 9310D1FBA1
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.de:dkim,suse.cz:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 5/5] Add fchmodat2_02 test
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

Reviewed-by: Petr Vorel <pvorel@suse.cz>
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
