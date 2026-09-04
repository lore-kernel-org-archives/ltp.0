Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF18AC624DE
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 12:16:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4DB103E1D87
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 14:16:40 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D9DBA3E9762
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 14:09:19 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 29B141A010E2
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 14:09:19 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 047C822B30;
 Fri,  4 Sep 2026 12:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788523754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FnQni2+x+fLvFbroFrHwSG/VmrjEZimCe81UQRZNo2M=;
 b=SazZD3DvhC9Y4QLq0upRlX6Rv/Byf6NvmJzhi1O+ySrLs2SHj9snkCuaY9uyAbwLeCgihC
 8V2T9qg+mRVK2Jhc87AvK2SjZRFo+mPBXJgztOLyA5GvZVGw0KxdzikVihOpcPHAjxE4xR
 Oyx1sFNItFOcFcDJPCw6XIt/2953UMg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788523754;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FnQni2+x+fLvFbroFrHwSG/VmrjEZimCe81UQRZNo2M=;
 b=8Ph/6WnyyEsSRLFKPdja/44V1RXNMYs8lkcSvO8B1g9X7j8f+fXcjS25e/ObYDcq2VRKbm
 tl7UJXyH5UmFmHBg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=U+Q+HkT7;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=wKkRBnCC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788523750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FnQni2+x+fLvFbroFrHwSG/VmrjEZimCe81UQRZNo2M=;
 b=U+Q+HkT7Jsu3iaLrbJu1OJn6lVKvYf6r/doNoZi9PNC78j6uu1YLsqDdiXi6hBs/H/CZIv
 4MChEspoM/3qwh3k/Pjh128vG3zKNP1VVzMT7LDbP46Kxhc0qsDezykZYSZgbEqLQng4LF
 F+0bFFv3Ys9Mby36ITo+gDTDTEg8tus=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788523750;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FnQni2+x+fLvFbroFrHwSG/VmrjEZimCe81UQRZNo2M=;
 b=wKkRBnCCpt1df64z5Zz2l1IWJSKtTwDXi44OyZ0GhRoFBIFcikIsByElrGotGAz81cJjYX
 9vg6qhLR0jhzjWAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 87DBF139F2;
 Fri,  4 Sep 2026 12:08:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6HGHHtq0mmpENgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 04 Sep 2026 12:08:58 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 04 Sep 2026 14:09:18 +0200
MIME-Version: 1.0
Message-Id: <20260904-keyctl_coverage-v2-29-43b78b15ef9f@suse.com>
References: <20260904-keyctl_coverage-v2-0-43b78b15ef9f@suse.com>
In-Reply-To: <20260904-keyctl_coverage-v2-0-43b78b15ef9f@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788523731; l=2551;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=20uCEkfCaCyTI9nJBF1FQyXwrM4xPFPzmULvsbvS3QQ=;
 b=3u9x93nZcqrq8CJ1FDFTuxg2mU+ceFPRl+XMaHqrq4lsaROoC74pcqegLS7DlWZMiRgXKrML1
 4tPK3czy70ID3uoWDjjAzcEuglyMJHUUjDDoGjScCHLgXMAYmlPaCYl
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 047C822B30
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 URIBL_BLOCKED(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 29/33] keyctl35: Test KEYCTL_CAPABILITIES size query
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

Test that calling KEYCTL_CAPABILITIES with a NULL buffer and
buflen of 0 returns the total size in bytes of the keyrings
subsystem capability array without faulting.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/keyctl/.gitignore |  1 +
 testcases/kernel/syscalls/keyctl/keyctl35.c | 49 +++++++++++++++++++++++++++++
 3 files changed, 51 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 08877ff49..67d626c22 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -752,6 +752,7 @@ keyctl31 keyctl31
 keyctl32 keyctl32
 keyctl33 keyctl33
 keyctl34 keyctl34
+keyctl35 keyctl35
 
 kcmp01 kcmp01
 kcmp02 kcmp02
diff --git a/testcases/kernel/syscalls/keyctl/.gitignore b/testcases/kernel/syscalls/keyctl/.gitignore
index f2ce330d7..58ebb452f 100644
--- a/testcases/kernel/syscalls/keyctl/.gitignore
+++ b/testcases/kernel/syscalls/keyctl/.gitignore
@@ -32,3 +32,4 @@
 /keyctl32
 /keyctl33
 /keyctl34
+/keyctl35
diff --git a/testcases/kernel/syscalls/keyctl/keyctl35.c b/testcases/kernel/syscalls/keyctl/keyctl35.c
new file mode 100644
index 000000000..43a8e2c7b
--- /dev/null
+++ b/testcases/kernel/syscalls/keyctl/keyctl35.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Test ``KEYCTL_CAPABILITIES`` size query of :manpage:`keyctl(2)`, added in Linux 5.3.
+ *
+ * [Algorithm]
+ *
+ * - call ``KEYCTL_CAPABILITIES`` with NULL buffer and ``buflen = 0``
+ * - verify the return value is at least 2 bytes
+ * - verify calling ``KEYCTL_CAPABILITIES`` with a valid buffer returns the
+ *   same size
+ */
+
+#include "keyctl_common.h"
+
+static unsigned char buf[8];
+
+static void run(void)
+{
+	long size;
+
+	TEST(keyctl(KEYCTL_CAPABILITIES, (unsigned long)NULL, 0, 0, 0));
+	if (TST_RET < 0)
+		tst_brk(TBROK | TTERRNO, "KEYCTL_CAPABILITIES size query failed");
+
+	size = TST_RET;
+	if (size < 2) {
+		tst_res(TFAIL, "KEYCTL_CAPABILITIES size query returned %ld, expected >= 2",
+			size);
+		return;
+	}
+
+	tst_res(TPASS, "KEYCTL_CAPABILITIES size query returned %ld", size);
+
+	TST_EXP_VAL(keyctl(KEYCTL_CAPABILITIES, (unsigned long)buf, sizeof(buf), 0, 0),
+		    size);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.min_kver = "5.3",
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_KEYS=y",
+		NULL
+	},
+};

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
