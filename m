Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8C0606A31A
	for <ltp@archiver.kernel.org>; Tue, 20 Oct 2026 10:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=s2l9e7xp;
	dkim=fail reason="signature verification failed" header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=eKvP6HpB;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=dnNxiN5X;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=b1UgXuyB
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 690983EA612
	for <ltp@archiver.kernel.org>; Tue, 20 Oct 2026 12:19:34 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 50E4E3EA604
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 12:16:36 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C8C9E1400B73
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 12:16:35 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A70A421DAF;
 Tue, 20 Oct 2026 10:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792491394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zy4cFpy5rWx7oyc1dmN4U+7XvMdAdbGhIuS0kzWnD0s=;
 b=s2l9e7xpCyrwPTukFk0CPfvchjfhqMgr5ztjblRiHDQXlx4IKkF2OQhks3k1M9BDAdm4l7
 7FhAt+7+8kfV1iO47jsDZFPRaDCblcUl9b3weHgcSL3Llv1ody5BgyTstz1heeViwQpxMg
 RIXA5jD9WRQ28VMIovajLd5TahGzlQk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792491394;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zy4cFpy5rWx7oyc1dmN4U+7XvMdAdbGhIuS0kzWnD0s=;
 b=eKvP6HpBqWHfxdffKCW/O/TAZfexhujvqjUQsrdb///AEoNN2eeqRlh3h2ael/ScHpK+rg
 xP+2fRqYtv1FTfAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792491393; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zy4cFpy5rWx7oyc1dmN4U+7XvMdAdbGhIuS0kzWnD0s=;
 b=dnNxiN5X7PGO+4/AEykSEcyj/SrEDbZ66HKWmXiVmWvtQf0ITROZGDODpOf/tmx2mdzzW9
 5OIvdAx5AL9gcepWuq6Gtw7Y3HYQpnNxSgxV8iRd2FHaw0IMytv/TRB+w063xfs0rRVFlR
 PUKk65EbmTmQNTWTLJSlDfdcwlCuZP4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792491393;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zy4cFpy5rWx7oyc1dmN4U+7XvMdAdbGhIuS0kzWnD0s=;
 b=b1UgXuyBoq/Nd7HC5rdfd08aS5ZckqHrxUPaukk6yUTxe4f2gMaIy2DZXQkvIUeGvObB/V
 xQynMvHc9S9SNgDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3F4D413793;
 Tue, 20 Oct 2026 10:16:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id B2PKGIA/12rCMgAAD6G6ig:T5
 (envelope-from <andrea.cervesato@suse.de>); Tue, 20 Oct 2026 10:16:33 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 20 Oct 2026 12:16:33 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <20261020-fchroot-v5-4-63aa6faff503@suse.com>
References: <20261020-fchroot-v5-0-63aa6faff503@suse.com>
In-Reply-To: <20261020-fchroot-v5-0-63aa6faff503@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792491392; l=3147;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=dVXue2T+Y8q2Oqo/SBP7HTnsE8e5hD1l5KJMhKfmwr0=;
 b=iBvFpsGPCU1mxbiAnjMtwEG7YDNUBHEyKBEBm11o8vaKh+xlAwIi1H3iAyutJ+AEjfxTiPwp/
 Ywg+oRfaHqIBth7EmP9pQjmdEibcT7BtTldiqxg6gP89i4kymoBQAp3
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, suse.com:email,
 imap1.dmz-prg2.suse.org:helo]
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 04/14] fchroot03: test fchroot() permission checks
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Andrea Cervesato <andrea.cervesato@suse.com>

Verify that with a regular directory fd the kernel first checks the
execute permission on the directory and then CAP_SYS_CHROOT: an
unprivileged process with an accessible directory fails with EPERM and
a process without execute permission fails with EACCES.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                              |  1 +
 testcases/kernel/syscalls/fchroot/.gitignore  |  1 +
 testcases/kernel/syscalls/fchroot/fchroot03.c | 70 +++++++++++++++++++++++++++
 3 files changed, 72 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index c4070e970..3b05e15eb 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -318,6 +318,7 @@ fchownat03 fchownat03
 
 fchroot01 fchroot01
 fchroot02 fchroot02
+fchroot03 fchroot03
 
 fcntl01 fcntl01
 fcntl01_64 fcntl01_64
diff --git a/testcases/kernel/syscalls/fchroot/.gitignore b/testcases/kernel/syscalls/fchroot/.gitignore
index fb3287612..235befd99 100644
--- a/testcases/kernel/syscalls/fchroot/.gitignore
+++ b/testcases/kernel/syscalls/fchroot/.gitignore
@@ -1,2 +1,3 @@
 fchroot01
 fchroot02
+fchroot03
diff --git a/testcases/kernel/syscalls/fchroot/fchroot03.c b/testcases/kernel/syscalls/fchroot/fchroot03.c
new file mode 100644
index 000000000..56ec7b8a3
--- /dev/null
+++ b/testcases/kernel/syscalls/fchroot/fchroot03.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Test the :manpage:`fchroot(2)` permission checks with a regular directory
+ * fd:
+ *
+ * - an unprivileged process with an accessible directory fails with ``EPERM``
+ * - a process without execute permission on the directory fails with ``EACCES``
+ *
+ * Root is required to open the directory file descriptors before dropping
+ * to an unprivileged user in forked children.
+ */
+
+#include <fcntl.h>
+#include <pwd.h>
+#include "tst_test.h"
+#include "lapi/fcntl.h"
+#include "lapi/syscalls.h"
+
+static struct tcase {
+	const char *dir;
+	mode_t mode;
+	int exp_errno;
+	const char *desc;
+} tcases[] = {
+	{"pubdir", 0755, EPERM, "no CAP_SYS_CHROOT"},
+	{"privdir", 0600, EACCES, "no execute permission"},
+};
+
+static struct passwd *ltpuser;
+
+static void run(unsigned int i)
+{
+	struct tcase *tc = &tcases[i];
+
+	if (SAFE_FORK())
+		return;
+
+	int dfd = SAFE_OPEN(tc->dir, O_PATH | O_DIRECTORY);
+
+	SAFE_SETRESUID(ltpuser->pw_uid, ltpuser->pw_uid,
+		ltpuser->pw_uid);
+
+	TST_EXP_FAIL(tst_syscall(__NR_fchroot, dfd, 0),
+		tc->exp_errno, "fchroot() with %s", tc->desc);
+}
+
+static void setup(void)
+{
+	unsigned int i;
+
+	ltpuser = SAFE_GETPWNAM("nobody");
+
+	for (i = 0; i < ARRAY_SIZE(tcases); i++) {
+		SAFE_MKDIR(tcases[i].dir, tcases[i].mode);
+		SAFE_CHMOD(tcases[i].dir, tcases[i].mode);
+	}
+}
+
+static struct tst_test test = {
+	.test = run,
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.forks_child = 1,
+};

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
