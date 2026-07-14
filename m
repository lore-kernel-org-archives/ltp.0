Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33771C44508
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 12:51:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C10953E56A8
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 14:51:35 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 18FEF3C00C7
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 14:51:21 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 88EB71000403
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 14:51:20 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F10DB7619F;
 Tue, 14 Jul 2026 12:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784033480; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=UYuwHxic92f8YsvQp/aYBYkEE1rEXmTYM9MBh2IeZnQ=;
 b=u6kr7+8siYY6/FIv5Z/6xEloqz7TpIH33WR/tQyJoFWoLukwOnec50ARkiVB2T1JJlOAut
 r3zAM3nv/gpaWTBp7ovsQG5cK6p7738apntFbhYEwWmDYBcwav1c01ewWNjIdRul6se6zy
 CL8CagoukBvxMEVLDnzb1E3SPS/dv1A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784033480;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=UYuwHxic92f8YsvQp/aYBYkEE1rEXmTYM9MBh2IeZnQ=;
 b=J9GapQNJLAcw2Z4gHPp0sctXAuRpkO80pQxu8X5gCppSWFViCXYWAlPx9no31ixiK6mItS
 tw4pAYQGOFts1sCg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qsaWejH5;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=oqdf0ZyN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784033478; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=UYuwHxic92f8YsvQp/aYBYkEE1rEXmTYM9MBh2IeZnQ=;
 b=qsaWejH5QBP6GPsSWAF5wIO0pj7+FBWKRfPbJDNE97mFMh7WReDo4H693wJVyFKVtPNYtE
 3N8hgvjGnKa57MY2/xx/t9CUF09rPHjQIcs+fAF48mgzCU6en8L9vfioM4BX86qUo68e2a
 XE/n8epRkUNbaKVJ2lv8z5hqV1sAQaQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784033478;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=UYuwHxic92f8YsvQp/aYBYkEE1rEXmTYM9MBh2IeZnQ=;
 b=oqdf0ZyNN9/XNyN003x0QRptGaadlu+3WpG3Ar1AJHkuNXBIiPwGfM9WsNobJGgkBZQFRq
 BDNebNxxkD72OSAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C950A779AE;
 Tue, 14 Jul 2026 12:51:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 08RTLsYwVmr6NwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 14 Jul 2026 12:51:18 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 14 Jul 2026 14:51:16 +0200
MIME-Version: 1.0
Message-Id: <20260714-syscall_invalid_nr-v3-1-af082728847c@suse.com>
X-B4-Tracking: v=1; b=H4sIAMMwVmoC/4XNQQ6CMBCF4auYrq1hSlPQlfcwhpQylUmwmI42E
 sLdLaxc6fJ/yXwzC8ZIyOK0m0XERExjyFHud8L1NtxQUpdbqEKZogIteWJnh6GhkOxAXROidN6
 AN9qrSoPIh4+Int4bernm7omfY5y2HwnW9SeXQILs6tZ4jSW6qj3zi/HgxrtYtaT+CyoL7VHb2
 pvCA6gvYVmWD7BeQ9H1AAAA
X-Change-ID: 20260714-syscall_invalid_nr-cf61f64f2741
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784033478; l=2368;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=8R6FflP74Ny9assU8Kvv/PZPDEyLJA7qOmSqM31nY2Y=;
 b=UmAyKPblo8m5MdDGPN5OQ7U/spyf2f23PQgSiotJTm0HqNibbtdYAfRrYFIe0AR4XIh3c4G3c
 641T0/jft1QByNNlbd557D/oSZvGqlxqa2f0lWhfzMtEQD673sdiPa+
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.com:email,suse.com:mid];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: F10DB7619F
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] syscall02: test invalid syscall number -1
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
fails with ENOSYS.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v3:
- enable all arches
- Link to v2: https://lore.kernel.org/20260714-syscall_invalid_nr-v2-1-b94a8f60f112@suse.com

Changes in v2:
- update imports and description
- Link to v1: https://lore.kernel.org/20260714-syscall_invalid_nr-v1-1-d8b6f4e3ec7b@suse.com
---
 runtest/syscalls                              |  1 +
 testcases/kernel/syscalls/syscall/.gitignore  |  1 +
 testcases/kernel/syscalls/syscall/syscall02.c | 23 +++++++++++++++++++++++
 3 files changed, 25 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 789d1550d890e547b1014c39b103ec32f00e7c5b..2be7012a6cd4728b799421a865aae9b0cf5cf72c 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1688,6 +1688,7 @@ sync_file_range01 sync_file_range01
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
index 0000000000000000000000000000000000000000..be79ffbc0663468ec1eb95d26cc10a80b34216f5
--- /dev/null
+++ b/testcases/kernel/syscalls/syscall/syscall02.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Verify that a raw :manpage:`syscall(2)` with the invalid system call
+ * number -1 fails with ENOSYS.
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
+};

---
base-commit: 23177659f273cd792298067a676c3590493cc76d
change-id: 20260714-syscall_invalid_nr-cf61f64f2741

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
