Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF1D1C624DE
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 12:09:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2E5A83E975D
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 14:09:51 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C35A33E5A9A
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 14:09:02 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2F21514000B8
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 14:09:01 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B0A9022B33;
 Fri,  4 Sep 2026 12:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788523736; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dv9qDc/syw4EBV0wuH4F6yveT8DEWbhCbBLV2Mff734=;
 b=QaCbLY/qDWi518MakMbPJcIjoW2LRdUQYjV2DsjcHYMxDshMUURJ7baf58Eb0O3A4gYhlf
 GEfpULWI9Y1V11Bn8+5jkW8ip0T9OY16bv/DdTGR0qmd/QQXRiLE8yHh3+4wEOUv38WbrD
 JSPwsf8cBNiKDNrQ4mtU9g6tofrAYNM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788523736;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dv9qDc/syw4EBV0wuH4F6yveT8DEWbhCbBLV2Mff734=;
 b=bUTLguw2abrC1+kdKix6xbGeVcbXRq7mxP5zRRmdBxQnd29eHnibTbqWC7dty7YpdjYyMw
 koY/hIVbNuSBbnDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788523732; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dv9qDc/syw4EBV0wuH4F6yveT8DEWbhCbBLV2Mff734=;
 b=qvm7rw4tLDAvGYOsfUMvEF8Euh+KXe6IEqlln/FC4Ue9rt7IL4QHvyLvaPmn68Wm8SXfRS
 UuGsLBFiKP5IXcFvJ1/Z4DuwXHjiNuB0ujcGFdreJc/46CwTJPBvv4B7mzanSW/zhx21Y0
 mZ2tU5y71d617Ef2EpK1mtMAYKdDidI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788523732;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dv9qDc/syw4EBV0wuH4F6yveT8DEWbhCbBLV2Mff734=;
 b=eYOrQkkH7hJEjj9O+dyijM4gD/1CY7P0ayCYC+JmmCa3aWzmdLJNliYgC3dwcEkysJl60t
 MP1DZvS4WFnDetAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7347513887;
 Fri,  4 Sep 2026 12:08:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yE90GdS0mmpENgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 04 Sep 2026 12:08:52 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 04 Sep 2026 14:08:52 +0200
MIME-Version: 1.0
Message-Id: <20260904-keyctl_coverage-v2-3-43b78b15ef9f@suse.com>
References: <20260904-keyctl_coverage-v2-0-43b78b15ef9f@suse.com>
In-Reply-To: <20260904-keyctl_coverage-v2-0-43b78b15ef9f@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788523731; l=2796;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=Hjlffi1pK+WfQsn3J4k8Rp+BQ4M9BehXb2Obt8tGWN8=;
 b=9nsVsHMkoVx5tHGB/+KL2//wROIuk9rBn3OosbUl7bhcup5ejzd8Ftt+HZeTFVlXfgFySCl8w
 7Msmk5EiyftDFWoM29O9bpojauBVwPctrlmzKgpwIAf9zmSnEAxppyC
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid, suse.com:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 03/33] keyctl11: Test KEYCTL_DESCRIBE with exact
 buffer size
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

Test KEYCTL_DESCRIBE when called with a buffer sized exactly to the
full description length: verify the string is copied completely
including the terminating NUL byte.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/keyctl/.gitignore |  1 +
 testcases/kernel/syscalls/keyctl/keyctl11.c | 62 +++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index bf4c0d46e..7c9042471 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -728,6 +728,7 @@ keyctl07 keyctl07
 keyctl08 keyctl08
 keyctl09 keyctl09
 keyctl10 keyctl10
+keyctl11 keyctl11
 
 kcmp01 kcmp01
 kcmp02 kcmp02
diff --git a/testcases/kernel/syscalls/keyctl/.gitignore b/testcases/kernel/syscalls/keyctl/.gitignore
index 08b2d101d..4974fe48d 100644
--- a/testcases/kernel/syscalls/keyctl/.gitignore
+++ b/testcases/kernel/syscalls/keyctl/.gitignore
@@ -8,3 +8,4 @@
 /keyctl08
 /keyctl09
 /keyctl10
+/keyctl11
diff --git a/testcases/kernel/syscalls/keyctl/keyctl11.c b/testcases/kernel/syscalls/keyctl/keyctl11.c
new file mode 100644
index 000000000..4dd0be7ca
--- /dev/null
+++ b/testcases/kernel/syscalls/keyctl/keyctl11.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Test ``KEYCTL_DESCRIBE`` of :manpage:`keyctl(2)` with exact buffer size.
+ *
+ * [Algorithm]
+ *
+ * - describe a key into a buffer sized exactly to the full string length,
+ *   verify full string copy including terminating NUL byte
+ */
+
+#include "keyctl_common.h"
+
+static key_serial_t key;
+static long desc_len;
+static char *buf;
+
+static void setup(void)
+{
+	SAFE_KEYCTL(KEYCTL_JOIN_SESSION_KEYRING, 0, 0, 0, 0);
+
+	key = new_user_key("k", "payload", 7, KEY_SPEC_PROCESS_KEYRING);
+	SAFE_KEYCTL(KEYCTL_SETPERM, key, KEY_PERM_SET, 0, 0);
+
+	TEST(keyctl(KEYCTL_DESCRIBE, key, (unsigned long)NULL, 0, 0));
+	if (TST_RET < 0)
+		tst_brk(TBROK | TTERRNO, "KEYCTL_DESCRIBE failed");
+
+	desc_len = TST_RET;
+	buf = SAFE_MALLOC(desc_len);
+}
+
+static void cleanup(void)
+{
+	free(buf);
+}
+
+static void run(void)
+{
+	memset(buf, 0, desc_len);
+	TST_EXP_EQ_LI_SILENT(keyctl(KEYCTL_DESCRIBE, key, (unsigned long)buf,
+				    desc_len, 0), desc_len);
+	if (!TST_PASS)
+		return;
+
+	if (buf[desc_len - 1] != '\0') {
+		tst_res(TFAIL, "description is not NUL terminated");
+		return;
+	}
+
+	tst_res(TPASS, "full description including NUL fits exact %ld byte buffer",
+		desc_len);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run,
+};

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
