Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02B02C5DF81
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 07:46:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 546233CE442
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 09:46:28 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A71E53CE4B9
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 09:45:01 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 36BD0600157
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 09:45:01 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 849793ED2;
 Thu, 20 Aug 2026 07:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787211896; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jhEQbDueT4qse5+D8y+rozm6nJRk5fEWHxGLU69uEZ0=;
 b=xo+H4l0Q0VpUVlkBvfFG8jS6d7mCZ0Pm7D20LQu0RktJ84bmdcFsAVEgRJW7gYbBRYQhFY
 o3qNOEWAFxg9Zo8HbPfkSPrr3rg3aCpjFUNPwUr5juzlBdJjvwWipB0oEvtvQGyXh+SaWY
 03MrXScpR2Y1+O/AeMG32Z89DNmWlt4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787211896;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jhEQbDueT4qse5+D8y+rozm6nJRk5fEWHxGLU69uEZ0=;
 b=1Kfa1vgFyWMqMxQ7uejeVOjo1IRESD7PeDrlMPwgLG+AM4SdXiLVJ0+ZrvGTAfbQaJ+YlB
 WiylUVH0SnVppvBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787211892; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jhEQbDueT4qse5+D8y+rozm6nJRk5fEWHxGLU69uEZ0=;
 b=msvINUN9XX86q1CuR/rtCRB1EI4LmYAzIHJoGW8ZX69r0PTN7IdbParp4oq+xb1a52zOyK
 q8Ix3UUHlrWOjyVtevDWN1N2xJEiUWBGYGBN/cxFm8uo7orZcqBh4RQ45Xdw6cT21In9K6
 3X2MXx8+xGYBud0z2cePU3f5u4Mic9c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787211892;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jhEQbDueT4qse5+D8y+rozm6nJRk5fEWHxGLU69uEZ0=;
 b=TCc3s1vAMX2IXV4G1QLEDKywA6mNuaYmlxI00niVoLq26GTYfuhNFuq16L4pwZqP7K5ib9
 JaqASB35kT/0YeCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 89F2C367E;
 Thu, 20 Aug 2026 07:44:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6GSeHm2whmr3YgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 20 Aug 2026 07:44:45 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 20 Aug 2026 09:44:47 +0200
MIME-Version: 1.0
Message-Id: <20260820-fchroot-v2-7-062ed20957a0@suse.com>
References: <20260820-fchroot-v2-0-062ed20957a0@suse.com>
In-Reply-To: <20260820-fchroot-v2-0-062ed20957a0@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787211883; l=3444;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=dmVgTaX7i+zVszn1islcDAofHd7mx+qNX3LuTbaDSDI=;
 b=v1tjuLf+nKYgtgCiiX/FiRQe8Exnsie5Eplh1CoiOxj5joAI7CnY7TOAK2BkIAQ48mAtn6qc1
 xuxpTmVbdg8C7dELIiP2FWuQomBph0dwm6lAsMkGk8M2GZdM2TVZJ2I
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH STAGING v2 07/16] fchroot04: test fchroot() into
 failfs as root
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

Verify that entering failfs with the FD_FAILFS_ROOT sentinel succeeds
with CAP_SYS_CHROOT and that every absolute path lookup then fails
with EOPNOTSUPP, while the working directory is reported as
unreachable by getcwd().

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/staging                               |  1 +
 testcases/kernel/syscalls/fchroot/.gitignore  |  1 +
 testcases/kernel/syscalls/fchroot/fchroot04.c | 70 +++++++++++++++++++++++++++
 3 files changed, 72 insertions(+)

diff --git a/runtest/staging b/runtest/staging
index 13635037b..91dfdba08 100644
--- a/runtest/staging
+++ b/runtest/staging
@@ -3,3 +3,4 @@
 fchroot01 fchroot01
 fchroot02 fchroot02
 fchroot03 fchroot03
+fchroot04 fchroot04
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
index 000000000..33097d8fd
--- /dev/null
+++ b/testcases/kernel/syscalls/fchroot/fchroot04.c
@@ -0,0 +1,70 @@
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
+ * The syscall runs in a forked child because leaving failfs requires a
+ * mount namespace file descriptor and the parent needs its root for the
+ * test framework cleanup.
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
+	TST_EXP_FAIL2(open("/etc/passwd", O_RDONLY), EOPNOTSUPP,
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
+
+	exit(0);
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
