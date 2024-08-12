Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B3ABC52D7C
	for <ltp@archiver.kernel.org>; Mon, 12 Aug 2024 11:46:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B9CE93D2104
	for <ltp@archiver.kernel.org>; Mon, 12 Aug 2024 13:46:48 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 051573CD80A
 for <ltp@lists.linux.it>; Mon, 12 Aug 2024 13:46:31 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5AD211A003F2
 for <ltp@lists.linux.it>; Mon, 12 Aug 2024 13:46:30 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3D60F2245D;
 Mon, 12 Aug 2024 11:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1723463190; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Eh2OtSRLswT0molboooUTLf4wgSFU2w+maFcDJdrtNU=;
 b=yw+O5trXIFM6YsILm+MXfRxLLQzL1Pwu8WrN1OWNHFM2RhSY6VHN/zN6cs7qxPKS2WXJKD
 A2kOjgPbTxewHmxmGQLVMVPINqdaLbfUVGulH2F8zHOXcmM61v22+DZibBFBj6BAry/n9I
 5a77WdWe/XdtM14T4g3RGwzLgkvUqXQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1723463190;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Eh2OtSRLswT0molboooUTLf4wgSFU2w+maFcDJdrtNU=;
 b=X3yDyxt+Q3tlKOP9PgW3wwIDGS5ewNkcvypadAxwv3ZayfznjaZor20i7SPUVCRon1v4RQ
 wpyUTJcZ4cjE8yDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1723463190; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Eh2OtSRLswT0molboooUTLf4wgSFU2w+maFcDJdrtNU=;
 b=yw+O5trXIFM6YsILm+MXfRxLLQzL1Pwu8WrN1OWNHFM2RhSY6VHN/zN6cs7qxPKS2WXJKD
 A2kOjgPbTxewHmxmGQLVMVPINqdaLbfUVGulH2F8zHOXcmM61v22+DZibBFBj6BAry/n9I
 5a77WdWe/XdtM14T4g3RGwzLgkvUqXQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1723463190;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Eh2OtSRLswT0molboooUTLf4wgSFU2w+maFcDJdrtNU=;
 b=X3yDyxt+Q3tlKOP9PgW3wwIDGS5ewNkcvypadAxwv3ZayfznjaZor20i7SPUVCRon1v4RQ
 wpyUTJcZ4cjE8yDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1E5BD13AF3;
 Mon, 12 Aug 2024 11:46:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YI6YBRb2uWYTWwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 12 Aug 2024 11:46:30 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 12 Aug 2024 13:46:30 +0200
MIME-Version: 1.0
Message-Id: <20240812-process_mrelease-v2-3-e61249986a0a@suse.com>
References: <20240812-process_mrelease-v2-0-e61249986a0a@suse.com>
In-Reply-To: <20240812-process_mrelease-v2-0-e61249986a0a@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723463189; l=3297;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=W3LPAYgHQB6FdS04WnTFJ1e2LgCuaCY6VwHwSoWS6rc=;
 b=Y0eDXet9aL//Fjo1pduBDANooZzQiKJWCQvASvMzUaaKrJZRyPafpk4EYuZ6YBrx0REgxVDB2
 Wxm1nMNe5pbAgTCRNmz///233hklu0yrZJvchOpccXjpxMSlzYpgbiA
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.989]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/3] Add process_mrelease02 test
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

This test verifies that process_mrelease() syscall correctly raises
the errors.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                   |  1 +
 .../kernel/syscalls/process_mrelease/.gitignore    |  1 +
 .../syscalls/process_mrelease/process_mrelease02.c | 84 ++++++++++++++++++++++
 3 files changed, 86 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index de90e9ba3..f3cb7d465 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1074,6 +1074,7 @@ preadv203_64 preadv203_64
 profil01 profil01
 
 process_mrelease01 process_mrelease01
+process_mrelease02 process_mrelease02
 
 process_vm_readv01 process_vm01 -r
 process_vm_readv02 process_vm_readv02
diff --git a/testcases/kernel/syscalls/process_mrelease/.gitignore b/testcases/kernel/syscalls/process_mrelease/.gitignore
index 673983858..f1e7a8fea 100644
--- a/testcases/kernel/syscalls/process_mrelease/.gitignore
+++ b/testcases/kernel/syscalls/process_mrelease/.gitignore
@@ -1 +1,2 @@
 /process_mrelease01
+/process_mrelease02
diff --git a/testcases/kernel/syscalls/process_mrelease/process_mrelease02.c b/testcases/kernel/syscalls/process_mrelease/process_mrelease02.c
new file mode 100644
index 000000000..ced556243
--- /dev/null
+++ b/testcases/kernel/syscalls/process_mrelease/process_mrelease02.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * This test verifies that process_mrelease() syscall is raising errors:
+ * * EBADF when a bad file descriptor is given
+ * * EINVAL when flags is not zero
+ * * EINVAL when memory of a task cannot be released because it's still running
+ * * ESRCH when child has been closed
+ */
+
+#include "tst_test.h"
+#include "lapi/syscalls.h"
+
+static int badfd = -1;
+static int pidfd;
+
+enum {
+	NO_CHILD,
+	EXIT_CHILD,
+	WAIT_CHILD,
+};
+
+static struct tcase {
+	int child_type;
+	int *fd;
+	int flags;
+	int exp_errno;
+	char *msg;
+} tcases[] = {
+	{NO_CHILD, &badfd, 0, EBADF, "bad file descriptor"},
+	{WAIT_CHILD, &pidfd, -1, EINVAL, "flags is not 0"},
+	{WAIT_CHILD, &pidfd, 0, EINVAL, "task memory cannot be released"},
+	{EXIT_CHILD, &pidfd, 0, ESRCH, "child is not running"},
+};
+
+static void run(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+	int status;
+
+	if (tc->child_type != NO_CHILD) {
+		pid_t pid;
+
+		pid = SAFE_FORK();
+		if (!pid) {
+			if (tc->child_type == WAIT_CHILD)
+				TST_CHECKPOINT_WAIT(0);
+
+			exit(0);
+		}
+
+		tst_res(TINFO, "Spawned waiting child with pid=%d", pid);
+
+		pidfd = SAFE_PIDFD_OPEN(pid, 0);
+
+		if (tc->child_type == EXIT_CHILD)
+			SAFE_WAITPID(pid, &status, 0);
+	}
+
+	TST_EXP_FAIL(tst_syscall(__NR_process_mrelease, *tc->fd, tc->flags),
+		tc->exp_errno,
+		"%s", tc->msg);
+
+	if (tc->child_type != NO_CHILD) {
+		if (tc->child_type == WAIT_CHILD)
+			TST_CHECKPOINT_WAKE(0);
+
+		SAFE_CLOSE(pidfd);
+	}
+}
+
+static struct tst_test test = {
+	.test = run,
+	.tcnt = ARRAY_SIZE(tcases),
+	.needs_root = 1,
+	.forks_child = 1,
+	.min_kver = "5.15",
+	.needs_checkpoints = 1,
+};

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
