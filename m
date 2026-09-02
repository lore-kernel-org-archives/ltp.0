Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2C0AC61DD6
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 11:12:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D2A883C6603
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 13:12:22 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 87DF13E93B0
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 13:04:50 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CD21B200C82
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 13:04:49 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2ADD51FACF;
 Wed,  2 Sep 2026 11:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788347084; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BAzQYvWsGWRTlck9El1rvsXpUAsTwE3LZf5Qd1RJVg4=;
 b=eGZeJBX9YENejkAwGLGJLJxZei1WIg5TrHcQ/FTb9D3J0MqiSdEmBGxdG3DeXS/TibSvHh
 hsuP5ETpxtPko0bfuC1E+XKhWacZZ2f2QkZmxRAxEziUNj5LRFW28o0DAnwWlRvlRmDPAu
 Qtt3Qr53oDBlMkJ+R8uzs2+pRVXxubs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788347084;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BAzQYvWsGWRTlck9El1rvsXpUAsTwE3LZf5Qd1RJVg4=;
 b=MzNsZ0efp/Xpc5PMZZdh0Lf3SCZtNup7GM/IV1tvxz9cd4YtVRKK01G5wbvSJRQZBcAk/F
 hAv4YuQFg9EnNtAg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TozVTpZI;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=KtGEtrBM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788347080; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BAzQYvWsGWRTlck9El1rvsXpUAsTwE3LZf5Qd1RJVg4=;
 b=TozVTpZIqc3Q8zISBhW+3PbyaO9rfwaU6fZgi1E5XIWg3YIEBvxrj6cVehIQualrdnN1uo
 Pqh1d8H9toR6dMycBplpMA7P5Zu1oiSbmguWkmTvYeX8pmvpiU6QBO4A1yqYxQSXVzvOhx
 4YFBekkmjlKwL1DcDCb39d7cxw/EwpA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788347080;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BAzQYvWsGWRTlck9El1rvsXpUAsTwE3LZf5Qd1RJVg4=;
 b=KtGEtrBMEadhgipP7WJFrPt5h40xw8bVZ6KhVpuTOVmIzOHXAm4CdzidVT8mBYaACkAZsH
 3Dwster+/FNVIMDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 85CE5139A8;
 Wed,  2 Sep 2026 11:04:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sP71HroCmGpzQwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 02 Sep 2026 11:04:26 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 02 Sep 2026 13:04:43 +0200
MIME-Version: 1.0
Message-Id: <20260902-keyctl_coverage-v1-28-d29dfa2ebcef@suse.com>
References: <20260902-keyctl_coverage-v1-0-d29dfa2ebcef@suse.com>
In-Reply-To: <20260902-keyctl_coverage-v1-0-d29dfa2ebcef@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788347062; l=3272;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=gHr91qQODKoy9V/89tSNgVhlcbiDpHQZYcjlVMgMvn8=;
 b=dw5jMckyDl7WlHsBxr7AU+ELCyelWD35jNh+GQcxM7wRzjsPA/NoUZ+sCXy0KvOierXzcB3pM
 19GhoAZBzayDJsrCCdsbnfmbwxnB1yurg4cd8N2suuHJagqCiT7mPLv
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 2ADD51FACF
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 28/33] keyctl34: Test KEYCTL_CAPABILITIES flag
 retrieval
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

Test keyrings subsystem capabilities retrieval with KEYCTL_CAPABILITIES
and verify standard capability bits (CAPABILITIES, INVALIDATE,
RESTRICT_KEYRING, MOVE, NS_KEYRING_NAME, NS_KEY_TAG).

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/keyctl/.gitignore |  1 +
 testcases/kernel/syscalls/keyctl/keyctl34.c | 62 +++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 7658ac859..08877ff49 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -751,6 +751,7 @@ keyctl30 keyctl30
 keyctl31 keyctl31
 keyctl32 keyctl32
 keyctl33 keyctl33
+keyctl34 keyctl34
 
 kcmp01 kcmp01
 kcmp02 kcmp02
diff --git a/testcases/kernel/syscalls/keyctl/.gitignore b/testcases/kernel/syscalls/keyctl/.gitignore
index 0f209d7e0..f2ce330d7 100644
--- a/testcases/kernel/syscalls/keyctl/.gitignore
+++ b/testcases/kernel/syscalls/keyctl/.gitignore
@@ -31,3 +31,4 @@
 /keyctl31
 /keyctl32
 /keyctl33
+/keyctl34
diff --git a/testcases/kernel/syscalls/keyctl/keyctl34.c b/testcases/kernel/syscalls/keyctl/keyctl34.c
new file mode 100644
index 000000000..bfe15a6ed
--- /dev/null
+++ b/testcases/kernel/syscalls/keyctl/keyctl34.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Test ``KEYCTL_CAPABILITIES`` of :manpage:`keyctl(2)`, added in Linux 5.3.
+ *
+ * ``KEYCTL_CAPABILITIES`` retrieves the bitmask of features and capabilities
+ * supported by the keyrings subsystem in the running kernel.
+ *
+ * [Algorithm]
+ *
+ * - retrieve keyrings subsystem capabilities into a buffer
+ * - verify return value is at least 2 bytes
+ * - verify standard capability bits ``KEYCTL_CAPS0_CAPABILITIES``,
+ *   ``KEYCTL_CAPS0_INVALIDATE``, ``KEYCTL_CAPS0_RESTRICT_KEYRING``,
+ *   ``KEYCTL_CAPS0_MOVE``, ``KEYCTL_CAPS1_NS_KEYRING_NAME``, and
+ *   ``KEYCTL_CAPS1_NS_KEY_TAG`` are set
+ */
+
+#include "keyctl_common.h"
+
+static unsigned char caps[8];
+
+static void run(void)
+{
+	memset(caps, 0, sizeof(caps));
+
+	TEST(keyctl(KEYCTL_CAPABILITIES, (unsigned long)caps, sizeof(caps), 0, 0));
+	if (TST_RET < 0)
+		tst_brk(TBROK | TTERRNO, "KEYCTL_CAPABILITIES failed");
+
+	if (TST_RET < 2) {
+		tst_res(TFAIL, "KEYCTL_CAPABILITIES returned %ld, expected at least 2",
+			TST_RET);
+		return;
+	}
+
+	TST_EXP_EXPR(caps[0] & KEYCTL_CAPS0_CAPABILITIES,
+		     "KEYCTL_CAPS0_CAPABILITIES is set");
+	TST_EXP_EXPR(caps[0] & KEYCTL_CAPS0_INVALIDATE,
+		     "KEYCTL_CAPS0_INVALIDATE is set");
+	TST_EXP_EXPR(caps[0] & KEYCTL_CAPS0_RESTRICT_KEYRING,
+		     "KEYCTL_CAPS0_RESTRICT_KEYRING is set");
+	TST_EXP_EXPR(caps[0] & KEYCTL_CAPS0_MOVE,
+		     "KEYCTL_CAPS0_MOVE is set");
+
+	TST_EXP_EXPR(caps[1] & KEYCTL_CAPS1_NS_KEYRING_NAME,
+		     "KEYCTL_CAPS1_NS_KEYRING_NAME is set");
+	TST_EXP_EXPR(caps[1] & KEYCTL_CAPS1_NS_KEY_TAG,
+		     "KEYCTL_CAPS1_NS_KEY_TAG is set");
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
