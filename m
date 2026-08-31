Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED42C624A5
	for <ltp@archiver.kernel.org>; Mon, 31 Aug 2026 08:02:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B22F23E9478
	for <ltp@archiver.kernel.org>; Mon, 31 Aug 2026 10:02:52 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ED7403E5ABF
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 10:00:23 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7F61D600939
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 10:00:23 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DC59922455;
 Mon, 31 Aug 2026 08:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788163219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0ok5b0jVAlKN2Dj/ZzzomjEVJijiV6K49NeyajdorGU=;
 b=x6sS/A+5u8jjHBE+t44Qp3efWnWvRXeRAzmy74CNKM8fbR2YClLPSB3pJM6631/CkEiwlZ
 ZEsmpzxCbXAbWD3RsoVcon4Rg0PPj9yd80ZtFg2ZWdQBOb+MiThbnvZS0Khf6ZGOO+HaUi
 4S3WQkxruwOUSUCURGFGOpYbMOdzgcY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788163219;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0ok5b0jVAlKN2Dj/ZzzomjEVJijiV6K49NeyajdorGU=;
 b=FLFKLs3Qi9SvssDI0u0Y/zvwmOmcDbJIJCnuHp5yiMk+0HWsPg/V6GFxqGUDtNLnGRuMYw
 Fc7IMr2ANpJ66NCQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=NLydkKDC;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Wz40aElU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788163214; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0ok5b0jVAlKN2Dj/ZzzomjEVJijiV6K49NeyajdorGU=;
 b=NLydkKDCW7PwiITNefqvtfFT5MrvUoNcLt4GDg9T4N9/Dgxwc0Jpa1UR9IGXEqUWjrMuJd
 5FpP2Mgko9yBPIH/Z2jrMMxD8G7/DUOedB4K1zqhy1+ucIqLIYPTmzmtEG29RzTETLfZ1G
 R2QU1j4oVG8H/Hw2B9EzwXHWPn/B+dk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788163214;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0ok5b0jVAlKN2Dj/ZzzomjEVJijiV6K49NeyajdorGU=;
 b=Wz40aElULMOnHqPYhWlzgxe+VX0ZXaxumcLgqY79zmfblKVl3eScE15VuCbcI/OoucwmcW
 yFdJnN6dUHEpI2Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5FFD11373A;
 Mon, 31 Aug 2026 08:00:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2G3MFYc0lWo9dQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 31 Aug 2026 08:00:07 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 31 Aug 2026 10:00:11 +0200
MIME-Version: 1.0
Message-Id: <20260831-fchroot-v4-10-57cceb68f927@suse.com>
References: <20260831-fchroot-v4-0-57cceb68f927@suse.com>
In-Reply-To: <20260831-fchroot-v4-0-57cceb68f927@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788163205; l=3477;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=Ih7lLFEUshd4kTYi/ok0vBrafXxg9i8tPsqJExodNY0=;
 b=0FZdpCdSTorlaC9gEFdrw5ZSfUVEcVNTnir2WWVrjGpyE8AV0N+DA0bv05N1KapwhGHhH30Ey
 IbkPvjJTuF9At7LHUA+lRhyiYPfP15F4zDXTLPppraRglirZUarLgYv
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Queue-Id: DC59922455
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH STAGING v4 10/16] fchroot07: test execve blocked by
 failfs root
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

Verify that after fchroot() moved the root into failfs, loading a
binary by absolute path fails with EOPNOTSUPP. The exec runs in a
grandchild so a wrongly successful exec is still detected through
the exit code.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/staging                                    |  1 +
 testcases/kernel/syscalls/fchroot/.gitignore       |  2 +
 testcases/kernel/syscalls/fchroot/fchroot07.c      | 59 ++++++++++++++++++++++
 .../kernel/syscalls/fchroot/fchroot07_child.c      | 16 ++++++
 4 files changed, 78 insertions(+)

diff --git a/runtest/staging b/runtest/staging
index 8b6b1ecd9..b8954bb5a 100644
--- a/runtest/staging
+++ b/runtest/staging
@@ -6,3 +6,4 @@ fchroot03 fchroot03
 fchroot04 fchroot04
 fchroot05 fchroot05
 fchroot06 fchroot06
+fchroot07 fchroot07
diff --git a/testcases/kernel/syscalls/fchroot/.gitignore b/testcases/kernel/syscalls/fchroot/.gitignore
index 12151270a..bfa2a8ce1 100644
--- a/testcases/kernel/syscalls/fchroot/.gitignore
+++ b/testcases/kernel/syscalls/fchroot/.gitignore
@@ -4,3 +4,5 @@ fchroot03
 fchroot04
 fchroot05
 fchroot06
+fchroot07
+fchroot07_child
diff --git a/testcases/kernel/syscalls/fchroot/fchroot07.c b/testcases/kernel/syscalls/fchroot/fchroot07.c
new file mode 100644
index 000000000..420e5a37f
--- /dev/null
+++ b/testcases/kernel/syscalls/fchroot/fchroot07.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Test that :manpage:`execve(2)` is blocked under the failfs root.
+ *
+ * After :manpage:`fchroot(2)` moved the process root into failfs, loading
+ * a binary by absolute path fails with ``EOPNOTSUPP``.
+ *
+ * Root is required because entering failfs with the ``FD_FAILFS_ROOT``
+ * sentinel requires ``CAP_SYS_CHROOT``.
+ *
+ * The test runs in a forked child so the root of the parent process is
+ * left untouched.
+ */
+
+#define _GNU_SOURCE
+#include <unistd.h>
+#include "tst_test.h"
+#include "lapi/fcntl.h"
+#include "lapi/syscalls.h"
+
+#define CHILD_EXEC "fchroot07_child"
+
+static char child_path[PATH_MAX];
+
+static void run(void)
+{
+	if (SAFE_FORK())
+		return;
+
+	TST_EXP_PASS(tst_syscall(__NR_fchroot, FD_FAILFS_ROOT, 0),
+		"fchroot() with the FD_FAILFS_ROOT sentinel");
+
+	if (!SAFE_FORK()) {
+		TST_EXP_FAIL(execl(child_path, CHILD_EXEC, NULL), EOPNOTSUPP,
+			"absolute exec blocked by the failfs root");
+		exit(0);
+	}
+
+	SAFE_WAIT(NULL);
+	exit(0);
+}
+
+static void setup(void)
+{
+	if (tst_get_path(CHILD_EXEC, child_path, sizeof(child_path)))
+		tst_brk(TCONF, "Couldn't find %s in $PATH", CHILD_EXEC);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.needs_root = 1,
+	.forks_child = 1,
+	.child_needs_reinit = 1,
+};
diff --git a/testcases/kernel/syscalls/fchroot/fchroot07_child.c b/testcases/kernel/syscalls/fchroot/fchroot07_child.c
new file mode 100644
index 000000000..3d731781c
--- /dev/null
+++ b/testcases/kernel/syscalls/fchroot/fchroot07_child.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+#define TST_NO_DEFAULT_MAIN
+#include "tst_test.h"
+
+int main(void)
+{
+	tst_reinit();
+
+	tst_res(TFAIL, "child executed");
+
+	return 0;
+}

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
