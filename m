Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70047C43458
	for <ltp@archiver.kernel.org>; Mon, 29 Jun 2026 14:03:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D1A4F3E4C34
	for <ltp@archiver.kernel.org>; Mon, 29 Jun 2026 16:03:27 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CC9293C5800
 for <ltp@lists.linux.it>; Mon, 29 Jun 2026 16:03:11 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1E99E1400547
 for <ltp@lists.linux.it>; Mon, 29 Jun 2026 16:03:10 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DDCEE758D9;
 Mon, 29 Jun 2026 14:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1782741789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mCNv0ETgU3LN5bzYVxYccaahPgYcj3+g8yayw75yRIs=;
 b=vb/RVS2gpldbnkHtcB8dvZkk0lcE+BttrC7B2tocz0vOjmjlpCqQ8EUWd3dgicQkqzK/Bx
 BosdT3pvMgnXr4zaMcYljKV2RG09wv3YKoliOWPxLvynMrvC7B3X9YT6OwsEQz39+b/mX/
 AdW6VYP447Z9fqxoVfgg4mpu6jzuxiU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1782741789;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mCNv0ETgU3LN5bzYVxYccaahPgYcj3+g8yayw75yRIs=;
 b=H9ncpeNGORp1Atd8VBpHoT7fKWRQfH79hKKbFC6GCJb091WwrsFfeVC6Juun+lpVm3RRDf
 f0MeckCGs24CcPCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="vb/RVS2g";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=H9ncpeNG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1782741789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mCNv0ETgU3LN5bzYVxYccaahPgYcj3+g8yayw75yRIs=;
 b=vb/RVS2gpldbnkHtcB8dvZkk0lcE+BttrC7B2tocz0vOjmjlpCqQ8EUWd3dgicQkqzK/Bx
 BosdT3pvMgnXr4zaMcYljKV2RG09wv3YKoliOWPxLvynMrvC7B3X9YT6OwsEQz39+b/mX/
 AdW6VYP447Z9fqxoVfgg4mpu6jzuxiU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1782741789;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mCNv0ETgU3LN5bzYVxYccaahPgYcj3+g8yayw75yRIs=;
 b=H9ncpeNGORp1Atd8VBpHoT7fKWRQfH79hKKbFC6GCJb091WwrsFfeVC6Juun+lpVm3RRDf
 f0MeckCGs24CcPCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C2620779A8;
 Mon, 29 Jun 2026 14:03:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id G/iqLR17Qmq7cgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 29 Jun 2026 14:03:09 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 29 Jun 2026 16:03:09 +0200
MIME-Version: 1.0
Message-Id: <20260629-invalid_syscalls-v1-1-6276034a35c5@suse.com>
X-B4-Tracking: v=1; b=H4sIABx7QmoC/x3MQQqAIBBA0avErBNMSqmrRIToVANi4UAU4t2Tl
 m/xfwbGRMgwNRkS3sR0xoqubcAdNu4oyFeDkkpLrUZB8baB/MovOxsCC9kb7QbljZcOanYl3Oj
 5l/NSygemL3OUYgAAAA==
X-Change-ID: 20260629-invalid_syscalls-0476c52d7d0c
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782741789; l=2942;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=iTGnj1sTHc1+Qf5hUPds73TkidTU5t75u3PNByEDEPQ=;
 b=Js+qBv/0DxUTPALbWycv4WUtyS839H8kD/tAiqa7oL4ccFFXIFdmw2fYSdIX+i38INNrb12zA
 MbrWtK9r+GwBFZfnrxcKbJzdvrIfXanLNBU/vMaarLZm65w4BWC3T4I
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: DDCEE758D9
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2]; TO_DN_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscall02: add invalid syscall number test
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

Add a test verifying that syscall() returns ENOSYS when called with
unimplemented syscall numbers. The chosen numbers stay above the syscall
table and below the architecture-specific private ranges, so they are
reliably invalid on every supported architecture.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                              |  1 +
 testcases/kernel/syscalls/syscall/.gitignore  |  1 +
 testcases/kernel/syscalls/syscall/syscall02.c | 47 +++++++++++++++++++++++++++
 3 files changed, 49 insertions(+)

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
index 0000000000000000000000000000000000000000..3bd9fa8cdcca257e03b358749ee7a2b676d8720d
--- /dev/null
+++ b/testcases/kernel/syscalls/syscall/syscall02.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Verify that :manpage:`syscall(2)` fails with ENOSYS when invoked with
+ * invalid syscall numbers.
+ *
+ * The syscall number is dispatched as an unsigned value on Linux. A value is
+ * reliably unimplemented on every supported architecture when it is:
+ *
+ * - above the syscall table
+ * - below the architecture-specific private syscall ranges (e.g. ARM's
+ *   0x0f0000 base)
+ * - without the x32 ABI bit (0x40000000) set
+ *
+ * Such a number is routed to sys_ni_syscall and returns ENOSYS.
+ */
+
+#include <unistd.h>
+#include <sys/syscall.h>
+
+#include "tst_test.h"
+
+#define TC(x) {.scno = (long)(x), .desc = #x}
+
+static struct tcase {
+	long scno;
+	const char *desc;
+} tcases[] = {
+	TC(0x8000),
+	TC(0xf000),
+	TC(0xfffe),
+};
+
+static void verify_syscall(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+
+	TST_EXP_FAIL2(syscall(tc->scno), ENOSYS, "syscall(%s)", tc->desc);
+}
+
+static struct tst_test test = {
+	.test = verify_syscall,
+	.tcnt = ARRAY_SIZE(tcases),
+};

---
base-commit: ad68429b9cfd55b233733e45e600ffafa1458ac5
change-id: 20260629-invalid_syscalls-0476c52d7d0c

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
