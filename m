Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A52D6E64A93
	for <ltp@archiver.kernel.org>; Tue,  3 Dec 2024 13:37:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 06FAA3DE0B7
	for <ltp@archiver.kernel.org>; Tue,  3 Dec 2024 14:37:21 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E2DF53DE0BA
 for <ltp@lists.linux.it>; Tue,  3 Dec 2024 14:36:47 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 77E991A0D2F7
 for <ltp@lists.linux.it>; Tue,  3 Dec 2024 14:36:47 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 07DFA1F45E
 for <ltp@lists.linux.it>; Tue,  3 Dec 2024 13:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733233007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M+U5RJVIqFwZWD12oJEmRUhCdLb4Rz2bAhslQHFoCQM=;
 b=KR+RYWPKoedyaFyODqMtLBKoXVAag9eOiomADdQIkw9VhIs/N7gqmTnxF3cPLbiw7vTaQs
 GhSg9RJh1uKnnCHYzsZ/o0Fsv+j/ZatPOKofUu5QYwLV6xcShrTu+KCpYlq2kcxJ2MSjOB
 bacCk+BQC+rwd9B1TUXdEeJkz97Fg1E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733233007;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M+U5RJVIqFwZWD12oJEmRUhCdLb4Rz2bAhslQHFoCQM=;
 b=/HQ3DPM/r56hc1Ch6mNaJgoGycULVDxCq0IhiHGZflvsVBPN1G9wlUGVDC7A4fal2c7hut
 UB5IJh6tRB5+Q4Ag==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=KR+RYWPK;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/HQ3DPM/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733233007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M+U5RJVIqFwZWD12oJEmRUhCdLb4Rz2bAhslQHFoCQM=;
 b=KR+RYWPKoedyaFyODqMtLBKoXVAag9eOiomADdQIkw9VhIs/N7gqmTnxF3cPLbiw7vTaQs
 GhSg9RJh1uKnnCHYzsZ/o0Fsv+j/ZatPOKofUu5QYwLV6xcShrTu+KCpYlq2kcxJ2MSjOB
 bacCk+BQC+rwd9B1TUXdEeJkz97Fg1E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733233007;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M+U5RJVIqFwZWD12oJEmRUhCdLb4Rz2bAhslQHFoCQM=;
 b=/HQ3DPM/r56hc1Ch6mNaJgoGycULVDxCq0IhiHGZflvsVBPN1G9wlUGVDC7A4fal2c7hut
 UB5IJh6tRB5+Q4Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E7FA913A15
 for <ltp@lists.linux.it>; Tue,  3 Dec 2024 13:36:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0E65Nm4JT2fbIgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Tue, 03 Dec 2024 13:36:46 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 03 Dec 2024 14:36:37 +0100
MIME-Version: 1.0
Message-Id: <20241203-madvise_guard_install-v1-2-c0485abbfc73@suse.com>
References: <20241203-madvise_guard_install-v1-0-c0485abbfc73@suse.com>
In-Reply-To: <20241203-madvise_guard_install-v1-0-c0485abbfc73@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733233004; l=3817;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=s22ytwC5nmhKK99Y3cEz5llT1dJfb+WZxjgpi9ymCF0=;
 b=aeh+S1hexywtagCW127hT/8t1SowQpJBMRd6w0A79pDJt8j3z7zVA5BI25qsTC5BwAWpgGUBk
 gs3SqXqRcnFB1AToiOQNLE6ERoW1Jjxfvz6nTRYHFenkbenmTp508Ie
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: 07DFA1F45E
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
 MIME_TRACE(0.00)[0:+];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] Add madvise12 test
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

Verify that MADV_GUARD_INSTALL is causing SIGSEGV when someone is
trying to access memory advised with it.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/madvise/.gitignore  |   1 +
 testcases/kernel/syscalls/madvise/madvise12.c | 102 ++++++++++++++++++++++++++
 3 files changed, 104 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 5fd62617df1a116b1d94c57ff30f74693320a2ab..ded035ee82d0e97c67cc1e7c487b010634b2d1a0 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1000,6 +1000,7 @@ madvise08 madvise08
 madvise09 madvise09
 madvise10 madvise10
 madvise11 madvise11
+madvise12 madvise12
 
 newuname01 newuname01
 
diff --git a/testcases/kernel/syscalls/madvise/.gitignore b/testcases/kernel/syscalls/madvise/.gitignore
index 722ac3c34306bac414313f1ce36ca98d715cd04c..758e601a9c4e7682a925f16184d14f2357009bc2 100644
--- a/testcases/kernel/syscalls/madvise/.gitignore
+++ b/testcases/kernel/syscalls/madvise/.gitignore
@@ -8,3 +8,4 @@
 /madvise09
 /madvise10
 /madvise11
+/madvise12
diff --git a/testcases/kernel/syscalls/madvise/madvise12.c b/testcases/kernel/syscalls/madvise/madvise12.c
new file mode 100644
index 0000000000000000000000000000000000000000..2bdf843f016a7c9d175a31b76ae805d63c4cbc80
--- /dev/null
+++ b/testcases/kernel/syscalls/madvise/madvise12.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2024 Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify that MADV_GUARD_INSTALL is causing SIGSEGV when someone is accessing
+ * memory advised with it.
+ *
+ * [Algorithm]
+ *
+ * - allocate a certain amount of memory
+ * - advise memory with MADV_GUARD_INSTALL
+ * - access to memory from within a child and verify it gets killed by SIGSEGV
+ * - release memory with MADV_GUARD_REMOVE
+ * - verify that memory has not been modified before child got killed
+ * - modify memory within a new child
+ * - verify that memory is accessable and child was not killed by SIGSEGV
+ */
+
+#include "tst_test.h"
+#include "lapi/mmap.h"
+
+#define MAP_SIZE (8 * TST_KB)
+
+static char *addr;
+
+static void run(void)
+{
+	pid_t pid;
+	int status;
+
+	memset(addr, 0, MAP_SIZE);
+
+	TST_EXP_PASS(madvise(addr, MAP_SIZE, MADV_GUARD_INSTALL));
+
+	pid = SAFE_FORK();
+	if (!pid) {
+		tst_res(TINFO, "Modifying memory content");
+
+		memset(addr, 'a', MAP_SIZE);
+		exit(0);
+	}
+
+	SAFE_WAITPID(pid, &status, 0);
+
+	if (WIFSIGNALED(status) && WTERMSIG(status) == SIGSEGV)
+		tst_res(TPASS, "Child ended by SIGSEGV as expected");
+	else
+		tst_res(TFAIL, "Child: %s", tst_strstatus(status));
+
+	TST_EXP_PASS(madvise(addr, MAP_SIZE, MADV_GUARD_REMOVE));
+
+	for (int i = 0; i < MAP_SIZE; i++) {
+		if (addr[i] == 'a') {
+			tst_res(TFAIL, "Memory content has been modified");
+			return;
+		}
+	}
+
+	tst_res(TPASS, "Memory content didn't change");
+
+	pid = SAFE_FORK();
+	if (!pid) {
+		tst_res(TINFO, "Modifying memory content");
+
+		memset(addr, 'b', MAP_SIZE);
+		exit(0);
+	}
+
+	SAFE_WAITPID(pid, &status, 0);
+
+	if (!WIFSIGNALED(status))
+		tst_res(TPASS, "Child ended without being signaled");
+	else
+		tst_res(TFAIL, "Child ended with %s", tst_strstatus(status));
+}
+
+static void setup(void)
+{
+	addr = SAFE_MMAP(NULL, MAP_SIZE,
+			PROT_READ | PROT_WRITE,
+			MAP_PRIVATE | MAP_ANONYMOUS,
+			-1, 0);
+}
+
+static void cleanup(void)
+{
+	if (addr)
+		SAFE_MUNMAP(addr, MAP_SIZE);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.forks_child = 1,
+	.min_kver = "6.13",
+};

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
