Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B8DFE7717D
	for <ltp@archiver.kernel.org>; Wed, 11 Dec 2024 12:22:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 248A53E8905
	for <ltp@archiver.kernel.org>; Wed, 11 Dec 2024 13:22:55 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C2C853E88FB
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 13:20:29 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2DE98140B5A9
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 13:20:29 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 046401F74B
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 12:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733919627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U58GSWe4DdDcBPWWrN1BkeneKex/aMiVeJ5yVCTsTxQ=;
 b=ZJNYlrI8iys60DdZ3HRMxilcnhJ/IHKRP5NRoAqQ1idj8O3wbIfHwz/I/DkJYWIsEeWQ3B
 fXCi9yxK/C0M+Bs1+EVVCkkm7rk7RHji+rgawwxXjfTgOaOXDTVbLJaSPHn2KlxkZHHG2c
 5bcEC9TDMxUssotYVivU+wyj9JK+ppI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733919627;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U58GSWe4DdDcBPWWrN1BkeneKex/aMiVeJ5yVCTsTxQ=;
 b=pUR3rCCG6WgyP66ZEI2tzAAcn27JNnY2mv9xHI4NcUnGRK/e7JvaC0hSaJGZiGD3EfXgCL
 rh22IgUyi92knXAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733919627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U58GSWe4DdDcBPWWrN1BkeneKex/aMiVeJ5yVCTsTxQ=;
 b=ZJNYlrI8iys60DdZ3HRMxilcnhJ/IHKRP5NRoAqQ1idj8O3wbIfHwz/I/DkJYWIsEeWQ3B
 fXCi9yxK/C0M+Bs1+EVVCkkm7rk7RHji+rgawwxXjfTgOaOXDTVbLJaSPHn2KlxkZHHG2c
 5bcEC9TDMxUssotYVivU+wyj9JK+ppI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733919627;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U58GSWe4DdDcBPWWrN1BkeneKex/aMiVeJ5yVCTsTxQ=;
 b=pUR3rCCG6WgyP66ZEI2tzAAcn27JNnY2mv9xHI4NcUnGRK/e7JvaC0hSaJGZiGD3EfXgCL
 rh22IgUyi92knXAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F051213998
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 12:20:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yC9aOoqDWWdNAwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 12:20:26 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 11 Dec 2024 13:20:33 +0100
MIME-Version: 1.0
Message-Id: <20241211-fix_setsid_tests-v1-10-e103f36c6462@suse.com>
References: <20241211-fix_setsid_tests-v1-0-e103f36c6462@suse.com>
In-Reply-To: <20241211-fix_setsid_tests-v1-0-e103f36c6462@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733919626; l=3265;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=IKg+lBwFGbHy86VIvjdWZm4lIKxTlK9YtqFa7OaaRFw=;
 b=Yk2hwcjhW1FcCFzPTaW43pqHJjIX0Wlq2589GN4M/LN9gtHSaJ1rguQLdt3iNiiCg2/oVnUz5
 odkTot2zAAnCaknTdjc68M/oqDBCvK3sYP637KrHq4V7UTviWFl58Fo
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 10/10] Add pty09 test
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

Verify that slave pseudo-terminal can be opened multiple times
in parallel.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/pty                     |  1 +
 testcases/kernel/pty/.gitignore |  1 +
 testcases/kernel/pty/pty09.c    | 89 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 91 insertions(+)

diff --git a/runtest/pty b/runtest/pty
index 365a46ee9730aa36b22dbbdbfba82ac0d491ac94..4b1abe7a602a14456877f3bc42f2275a3be0f8f0 100644
--- a/runtest/pty
+++ b/runtest/pty
@@ -7,6 +7,7 @@ pty05 pty05
 pty06 pty06
 pty07 pty07
 pty08 pty08
+pty09 pty09
 ptem01 ptem01
 ptem02 ptem02
 ptem03 ptem03
diff --git a/testcases/kernel/pty/.gitignore b/testcases/kernel/pty/.gitignore
index 7d8d4dceda84f2e2695a8bee39abfe894288b8b6..2d0c8bb6ff7d6883abfc7838e257b9be50244b69 100644
--- a/testcases/kernel/pty/.gitignore
+++ b/testcases/kernel/pty/.gitignore
@@ -13,3 +13,4 @@
 /pty06
 /pty07
 /pty08
+/pty09
diff --git a/testcases/kernel/pty/pty09.c b/testcases/kernel/pty/pty09.c
new file mode 100644
index 0000000000000000000000000000000000000000..a9adf6ef619334b858fb99d5c388c0adac3976f5
--- /dev/null
+++ b/testcases/kernel/pty/pty09.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) International Business Machines  Corp., 2002
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify that slave pseudo-terminal can be opened multiple times in parallel.
+ */
+
+#define _GNU_SOURCE
+
+#include "tst_test.h"
+
+#define MASTERCLONE "/dev/ptmx"
+
+static unsigned int count_avail_pid(void)
+{
+	DIR *dir;
+	struct dirent *ent;
+	struct rlimit limit;
+	unsigned int count = 0;
+	unsigned int max_pid_num;
+
+	if (access(MASTERCLONE, F_OK))
+		tst_brk(TBROK, "%s device doesn't exist", MASTERCLONE);
+
+	SAFE_GETRLIMIT(RLIMIT_NOFILE, &limit);
+
+	dir = SAFE_OPENDIR("/proc/self/fd");
+	while ((ent = SAFE_READDIR(dir)))
+		count++;
+
+	SAFE_CLOSEDIR(dir);
+
+	max_pid_num = limit.rlim_cur - count;
+
+	tst_res(TINFO, "Available number of pids: %u", max_pid_num);
+
+	return max_pid_num;
+}
+
+static void run(void)
+{
+	int masterfd;
+	char *slavename;
+	unsigned int max_pid_num;
+
+	masterfd = SAFE_OPEN(MASTERCLONE, O_RDWR);
+
+	slavename = ptsname(masterfd);
+	if (slavename == NULL)
+		tst_brk(TBROK | TERRNO, "ptsname() error");
+
+	tst_res(TINFO, "pts device location is %s", slavename);
+
+	if (grantpt(masterfd) == -1)
+		tst_brk(TBROK | TERRNO, "grantpt() error");
+
+	if (unlockpt(masterfd) == -1)
+		tst_brk(TBROK | TERRNO, "unlockpt() error");
+
+	max_pid_num = count_avail_pid();
+
+	int slavefd[max_pid_num];
+
+	for (uint32_t i = 0; i < max_pid_num; i++)
+		slavefd[i] = SAFE_OPEN(slavename, O_RDWR);
+
+	tst_res(TPASS, "%s has been opened %d times", slavename, max_pid_num);
+
+	for (uint32_t i = 0; i < max_pid_num; i++)
+		SAFE_CLOSE(slavefd[i]);
+
+	SAFE_CLOSE(masterfd);
+}
+
+static void setup(void)
+{
+	if (access(MASTERCLONE, F_OK))
+		tst_brk(TBROK, "%s device doesn't exist", MASTERCLONE);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+};

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
