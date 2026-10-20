Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D527606A332
	for <ltp@archiver.kernel.org>; Tue, 20 Oct 2026 10:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=mFOUPX4r;
	dkim=fail reason="signature verification failed" header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=BwedLmy+;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=JpXuhZ6Y;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=c6vLIysn
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B571E3EA603
	for <ltp@archiver.kernel.org>; Tue, 20 Oct 2026 12:18:02 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AFD373EA602
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 12:16:35 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 108D6600909
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 12:16:34 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D90F821DB2;
 Tue, 20 Oct 2026 10:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792491394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fyy9zNkuns3akvqMC7BNVXW6MI01tvwjY4vVECqRTKg=;
 b=mFOUPX4rwKR6VANQgihZihv8Jl9CG5ZBffqypOScTe9EhTaS2JlopKTX9UBRVSmClHjigH
 8gx+lGrL+3/TA/ct3nGTu1PMP/cwCOoW9np6u8YU1io9wjhdCK2N4eDIL3d6mbjtYSdJgE
 rSvy04todC+Ucx9DxYS3T6dB5r6BWp4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792491394;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fyy9zNkuns3akvqMC7BNVXW6MI01tvwjY4vVECqRTKg=;
 b=BwedLmy+8PajRqeV7u56gUEOEvrczBP3rqjU8Ny6ED0Z2pDxdMfWNC0nOTyOLabl6+FrAK
 JFqYNSjyb2OKEkBg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=JpXuhZ6Y;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=c6vLIysn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792491393; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fyy9zNkuns3akvqMC7BNVXW6MI01tvwjY4vVECqRTKg=;
 b=JpXuhZ6Yi5yVUox0jLE06j1VjuISSZZFgXEZW3j5fzLzD+esyfGhwyorRd6UyoAOlv2WK2
 kUa13HDnN0N9qoEvwZiDpjr7fDBQSAf/I7gwP0CuMGzJ234wiXJM0frdHSyXPNsza+VO3Y
 GOPU1Eg6Zh93U56amH3IcaEsVamLBMc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792491393;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fyy9zNkuns3akvqMC7BNVXW6MI01tvwjY4vVECqRTKg=;
 b=c6vLIysnq0zONxyYNMKH+8elCME/bc8tquYeLkpieDL6a8h2zkjjqRmFwAG9iOhYWKk9T0
 i53yvyOB34nOBVCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 69D4413808;
 Tue, 20 Oct 2026 10:16:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id B2PKGIA/12rCMgAAD6G6ig:T6
 (envelope-from <andrea.cervesato@suse.de>); Tue, 20 Oct 2026 10:16:33 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 20 Oct 2026 12:16:34 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <20261020-fchroot-v5-5-63aa6faff503@suse.com>
References: <20261020-fchroot-v5-0-63aa6faff503@suse.com>
In-Reply-To: <20261020-fchroot-v5-0-63aa6faff503@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792491392; l=3464;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=WdOCoNq9V8RtPkaXCt4Nkg1v71EJxQC8vdNIU3q60AU=;
 b=xTc5kGjE6kl0wwYj/dSafvSfaOcbXGnMfiNo+UFN10WlZwGYsN0Rq/+z7+VLgzKUSpV0vaKbp
 nDeEgtr2CTeAizmbGgQId5JLUVFEXgLOrL+OB73bFUKmUFV7eE2h+G+
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.cz:email,suse.de:dkim];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Level: 
X-Rspamd-Queue-Id: D90F821DB2
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 05/14] fchroot04: test fchroot() into failfs as root
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

Verify that entering failfs with the FD_FAILFS_ROOT sentinel succeeds
with CAP_SYS_CHROOT and that every absolute path lookup then fails
with EOPNOTSUPP, while the working directory is reported as
unreachable by getcwd().

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                              |  1 +
 testcases/kernel/syscalls/fchroot/.gitignore  |  1 +
 testcases/kernel/syscalls/fchroot/fchroot04.c | 67 +++++++++++++++++++++++++++
 3 files changed, 69 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 3b05e15eb..a7483f97b 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -319,6 +319,7 @@ fchownat03 fchownat03
 fchroot01 fchroot01
 fchroot02 fchroot02
 fchroot03 fchroot03
+fchroot04 fchroot04
 
 fcntl01 fcntl01
 fcntl01_64 fcntl01_64
diff --git a/testcases/kernel/syscalls/fchroot/.gitignore b/testcases/kernel/syscalls/fchroot/.gitignore
index 235befd99..9270c1408 100644
--- a/testcases/kernel/syscalls/fchroot/.gitignore
+++ b/testcases/kernel/syscalls/fchroot/.gitignore
@@ -1,3 +1,4 @@
 fchroot01
 fchroot02
 fchroot03
+fchroot04
diff --git a/testcases/kernel/syscalls/fchroot/fchroot04.c b/testcases/kernel/syscalls/fchroot/fchroot04.c
new file mode 100644
index 000000000..a087a39e6
--- /dev/null
+++ b/testcases/kernel/syscalls/fchroot/fchroot04.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Test :manpage:`fchroot(2)` with the ``FD_FAILFS_ROOT`` sentinel as a
+ * privileged process.
+ *
+ * :manpage:`fchroot(2)` was introduced in Linux v7.3 together with failfs,
+ * a kernel internal filesystem where every operation fails with
+ * ``EOPNOTSUPP``. The ``FD_FAILFS_ROOT`` sentinel moves the process root
+ * there without needing a file descriptor: it is the ``fs_struct`` equivalent
+ * of ``RESOLVE_BENEATH``.
+ *
+ * The test verifies that entering failfs succeeds with ``CAP_SYS_CHROOT`` and
+ * that every absolute path lookup then fails with ``EOPNOTSUPP``. The working
+ * directory, left behind in the real filesystem, is consequently reported
+ * as unreachable by :manpage:`getcwd(2)`.
+ *
+ * The test runs in a forked child so the root of the parent process is
+ * left untouched.
+ */
+
+#define _GNU_SOURCE
+#include <fcntl.h>
+#include <limits.h>
+#include <sys/stat.h>
+#include "tst_test.h"
+#include "lapi/fcntl.h"
+#include "lapi/syscalls.h"
+
+#define UNR_TAG "(unreachable)/"
+
+static void run(void)
+{
+	if (SAFE_FORK())
+		return;
+
+	char buf[PATH_MAX];
+
+	TST_EXP_PASS(tst_syscall(__NR_fchroot, FD_FAILFS_ROOT, 0),
+		"fchroot() with the FD_FAILFS_ROOT sentinel");
+
+	TST_EXP_FAIL2(open("/dev/zero", O_RDONLY), EOPNOTSUPP,
+		"absolute file open");
+
+	TST_EXP_FAIL(mkdir("/foo", 0700), EOPNOTSUPP,
+		"absolute directory creation");
+
+	/*
+	 * The libc getcwd() wrapper rejects the "(unreachable)"
+	 * prefix produced by the kernel, so call the raw syscall.
+	 */
+	TEST(tst_syscall(__NR_getcwd, buf, sizeof(buf)));
+	if (TST_RET > 0)
+		TST_EXP_EQ_STRN(buf, UNR_TAG, sizeof(UNR_TAG) - 1);
+	else
+		tst_res(TFAIL | TTERRNO, "getcwd() failed");
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.forks_child = 1,
+};

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
