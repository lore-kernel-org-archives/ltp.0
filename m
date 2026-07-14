Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 979ABC43458
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 10:56:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 274C53E574B
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 12:56:28 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6C9073E2F07
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 12:56:12 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 94B041A008BC
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 12:56:10 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B8F3077D6D;
 Tue, 14 Jul 2026 10:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784026564; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=euTX2tJjxgDMzeGDmsz0s3xk+4fh86rnr2ShzKtncJ8=;
 b=AE5A20qtd8tKe3CJdVOfJiP6UsMvaH69EPfaMUxuZaCnxQKeWYZ1y6YtrBXORWYQsjqlH6
 H48Wwjk43omO+3thlkrlvyy1CP99x1EI0JBjExLXgtwRvxPN5Eb9qSdcdPNKeUfXLZq5cm
 fz/aBsK9nxfRiTfDs1dwIOWdyb30vUU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784026564;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=euTX2tJjxgDMzeGDmsz0s3xk+4fh86rnr2ShzKtncJ8=;
 b=5zJHTaxi2gkeIho0FhY9npRRrgY61zp4nwkRLuU3n6ujlPEjHkRRvO2fGOTqAc7jbBYbTJ
 ha22AA/dZuie9nBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784026564; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=euTX2tJjxgDMzeGDmsz0s3xk+4fh86rnr2ShzKtncJ8=;
 b=AE5A20qtd8tKe3CJdVOfJiP6UsMvaH69EPfaMUxuZaCnxQKeWYZ1y6YtrBXORWYQsjqlH6
 H48Wwjk43omO+3thlkrlvyy1CP99x1EI0JBjExLXgtwRvxPN5Eb9qSdcdPNKeUfXLZq5cm
 fz/aBsK9nxfRiTfDs1dwIOWdyb30vUU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784026564;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=euTX2tJjxgDMzeGDmsz0s3xk+4fh86rnr2ShzKtncJ8=;
 b=5zJHTaxi2gkeIho0FhY9npRRrgY61zp4nwkRLuU3n6ujlPEjHkRRvO2fGOTqAc7jbBYbTJ
 ha22AA/dZuie9nBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 92A93779AE;
 Tue, 14 Jul 2026 10:56:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oUwwIcQVVmqaQgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 14 Jul 2026 10:56:04 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 14 Jul 2026 12:56:04 +0200
MIME-Version: 1.0
Message-Id: <20260714-syscall_invalid_nr-v2-1-b94a8f60f112@suse.com>
X-B4-Tracking: v=1; b=H4sIAMMVVmoC/32NQQrCMBBFr1JmbaSJIRFX3kNKSdOJHaipZDRYS
 u5u7AFcvgf//Q0YEyHDpdkgYSamJVZQhwb85OIdBY2VQbXKtFZqwSt7N889xexmGvuYhA9GBqO
 DslpCHT4TBvrs0VtXeSJ+LWndP7L82b+5LIUU43kwQeMJvR2u/GY8+uUBXSnlC7TSmTqzAAAA
X-Change-ID: 20260714-syscall_invalid_nr-cf61f64f2741
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784026564; l=2624;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=YKU7UbHzX2NinTELTv45jVGSCgumDhjwXLFAz5B5Vio=;
 b=+8aNLUiSoLAchlVGi0NOxszV29SYINNS2aG6PYAmweiIR6Sl/RKFU2Hu9pSo5Z3ML81KInVM/
 RZ6MM8S0P9nDBU3IgND7s84Zu3LincHji0j5NmuygujUdU/JE1IXJCs
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.com:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] syscall02: test invalid syscall number -1
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

Add a test verifying that a raw syscall() with the reserved number -1
fails with ENOSYS. The behavior is architecture specific, so the test is
limited to the architectures where it was checked against kernel code.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v2:
- update imports and description
- Link to v1: https://lore.kernel.org/20260714-syscall_invalid_nr-v1-1-d8b6f4e3ec7b@suse.com
---
 runtest/syscalls                              |  1 +
 testcases/kernel/syscalls/syscall/.gitignore  |  1 +
 testcases/kernel/syscalls/syscall/syscall02.c | 31 +++++++++++++++++++++++++++
 3 files changed, 33 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index a021c79da49d4157c33187caed2dd3f0483759e0..8a777e61da1af59ba694e0bc5b5d92bb1d63754a 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1678,6 +1678,7 @@ sync_file_range01 sync_file_range01
 sync_file_range02 sync_file_range02
 
 syscall01 syscall01
+syscall02 syscall02
 
 sysconf01 sysconf01
 
diff --git a/testcases/kernel/syscalls/syscall/.gitignore b/testcases/kernel/syscalls/syscall/.gitignore
index 74a081e40cb564e874e0f81478d3d1a0e95b6df4..fed1d81079450a7442023447285cd112924f7a10 100644
--- a/testcases/kernel/syscalls/syscall/.gitignore
+++ b/testcases/kernel/syscalls/syscall/.gitignore
@@ -1 +1,2 @@
 /syscall01
+/syscall02
diff --git a/testcases/kernel/syscalls/syscall/syscall02.c b/testcases/kernel/syscalls/syscall/syscall02.c
new file mode 100644
index 0000000000000000000000000000000000000000..2fefcb17c763813653a6644759c2a035bee2c604
--- /dev/null
+++ b/testcases/kernel/syscalls/syscall/syscall02.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Verify that a raw :manpage:`syscall(2)` with the invalid system call
+ * number -1 fails with ENOSYS.
+ *
+ * The behavior of number -1 is architecture specific, so the test only runs on
+ * the architectures where it has been verified against the kernel entry code.
+ */
+
+#define _GNU_SOURCE
+#include <unistd.h>
+
+#include "tst_test.h"
+
+static void run(void)
+{
+	TST_EXP_FAIL2(syscall(-1), ENOSYS, "invalid syscall number -1");
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.supported_archs = (const char *const []) {
+		"x86_64",
+		"aarch64",
+		NULL
+	},
+};

---
base-commit: 7ca5dc366a558f3666223e6abe579edd90bafd38
change-id: 20260714-syscall_invalid_nr-cf61f64f2741

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
