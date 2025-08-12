Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 653BDCA0EC4
	for <ltp@archiver.kernel.org>; Tue, 12 Aug 2025 08:46:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BE9ED3CB2A2
	for <ltp@archiver.kernel.org>; Tue, 12 Aug 2025 10:46:21 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 99DD83C0639
 for <ltp@lists.linux.it>; Tue, 12 Aug 2025 10:46:04 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B53841A006E9
 for <ltp@lists.linux.it>; Tue, 12 Aug 2025 10:46:03 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DD6E81F80E;
 Tue, 12 Aug 2025 08:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1754988362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=DHMB5Cr7BEFYuIjCAkxYwD7cM7+0SjoZ3ULMXMViT7g=;
 b=GUMmS/Q5CHPuivvhjfpF+vBFaAGqzlOpkWkLnLG2QH6+FnoT5LjWYaPmyTufN85lKz/hSl
 8su24U+SIPTpnJk15MendEF0CeoXPAdZyyGrqEBrrCw8LxX+ZjQEusimisOx1lTCg8YlLb
 XeoD4iHkmRGjTTTl2V6AZNbIjCDmlc4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1754988362;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=DHMB5Cr7BEFYuIjCAkxYwD7cM7+0SjoZ3ULMXMViT7g=;
 b=/KX9CGnH4WuVlSIrVZSErnN2cegCcpsn2i0LyPgBtev+b7liiP8qdhU79ljbeLDXRIKCjm
 nx2fN7/m2KLSTNAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1754988362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=DHMB5Cr7BEFYuIjCAkxYwD7cM7+0SjoZ3ULMXMViT7g=;
 b=GUMmS/Q5CHPuivvhjfpF+vBFaAGqzlOpkWkLnLG2QH6+FnoT5LjWYaPmyTufN85lKz/hSl
 8su24U+SIPTpnJk15MendEF0CeoXPAdZyyGrqEBrrCw8LxX+ZjQEusimisOx1lTCg8YlLb
 XeoD4iHkmRGjTTTl2V6AZNbIjCDmlc4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1754988362;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=DHMB5Cr7BEFYuIjCAkxYwD7cM7+0SjoZ3ULMXMViT7g=;
 b=/KX9CGnH4WuVlSIrVZSErnN2cegCcpsn2i0LyPgBtev+b7liiP8qdhU79ljbeLDXRIKCjm
 nx2fN7/m2KLSTNAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B623813AAA;
 Tue, 12 Aug 2025 08:46:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id fWDLKUr/mmh0agAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 12 Aug 2025 08:46:02 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 12 Aug 2025 10:45:59 +0200
MIME-Version: 1.0
Message-Id: <20250812-cve_2025_38236-v1-1-e3617ada69c6@suse.com>
X-B4-Tracking: v=1; b=H4sIAEb/mmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDC0Mj3eSy1HgQJ97YwsjYTNc8OckgOcUkLSUpzVQJqKmgKDUtswJsYHR
 sbS0ABUZOFWAAAAA=
X-Change-ID: 20250812-cve_2025_38236-7cb0cd4fdbf5
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754988362; l=4440;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=RkwXf4sG/2EmDEmPFsoxXfqsuy6jgKrCDLP8/jV8UxE=;
 b=htUAGZRJmm4xV1pJGWKe9nheRmPiXQNdeV8UdkXrHKR9Fw4urPa3C12/kW9y43Hnuj7kvkJMU
 xgtwxRKT/2RAKzzgjDY3CPeeBQQrl5bgH9OiACzNCEh2swupZDqJd6m
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo]; 
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid, suse.com:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] cve: add CVE-2025-38236 test
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

Test for CVE-2025-38236 fixed in kernel v6.16-rc4:
af_unix: Don't leave consecutive consumed OOB skbs.

The bug is triggered by sending multiple out-of-band data to a socket and
reading it back from it. According to the MSG_OOB implementation, this
shouldn't be possible. When system is affected by CVE-2025-38236, instead,
skb queue holds MSG_OOB data, breaking recv() and causing a use-after-free
condition.

Even if MSG_OOB is mostly used inside Oracle's product, it is enabled by
default in linux kernel via CONFIG_AF_UNIX_OOB. This is accessible via
Chrome's renderer sandbox, which might cause an attacker to escalate and to
obtain privileges in the system.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/cve/.gitignore       |   1 +
 testcases/cve/cve-2025-38236.c | 101 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 102 insertions(+)

diff --git a/testcases/cve/.gitignore b/testcases/cve/.gitignore
index 3a2b2bed619c99a592f51afe50b7196c593f1f45..8eb17ce56b01070e47917f9bb44cf146c0c5b338 100644
--- a/testcases/cve/.gitignore
+++ b/testcases/cve/.gitignore
@@ -13,3 +13,4 @@ cve-2017-17053
 cve-2022-4378
 icmp_rate_limit01
 tcindex01
+cve-2025-38236
diff --git a/testcases/cve/cve-2025-38236.c b/testcases/cve/cve-2025-38236.c
new file mode 100644
index 0000000000000000000000000000000000000000..68cb3d3ee2b624df2a6de2ce07da1d1e3efc8bb8
--- /dev/null
+++ b/testcases/cve/cve-2025-38236.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2025 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Test for CVE-2025-38236 fixed in kernel v6.16-rc4:
+ * af_unix: Don't leave consecutive consumed OOB skbs.
+ *
+ * The bug is triggered by sending multiple out-of-band data to a socket and
+ * reading it back from it. According to the MSG_OOB implementation, this
+ * shouldn't be possible. When system is affected by CVE-2025-38236, instead,
+ * skb queue holds MSG_OOB data, breaking recv() and causing a use-after-free
+ * condition.
+ *
+ * Even if MSG_OOB is mostly used inside Oracle's product, it is enabled by
+ * default in linux kernel via CONFIG_AF_UNIX_OOB. This is accessible via
+ * Chrome's renderer sandbox, which might cause an attacker to escalate and to
+ * obtain privileges in the system.
+ */
+
+#include "tst_test.h"
+
+static const struct timeval sock_timeout = {
+	.tv_sec = 1,
+};
+
+static char dummy;
+static int sock[2];
+
+static void run(void)
+{
+	int ret;
+
+	dummy = '\0';
+
+	tst_res(TINFO, "#1 send and receive out-of-band data");
+	SAFE_SEND(0, sock[1], "A", 1, MSG_OOB);
+	SAFE_RECV(0, sock[0], &dummy, 1, MSG_OOB);
+
+	tst_res(TINFO, "#2 send and receive out-of-band data");
+	SAFE_SEND(0, sock[1], "A", 1, MSG_OOB);
+	SAFE_RECV(0, sock[0], &dummy, 1, MSG_OOB);
+
+	tst_res(TINFO, "Send out-of-band data");
+	SAFE_SEND(0, sock[1], "A", 1, MSG_OOB);
+
+	tst_res(TINFO, "Receive data from normal stream");
+
+	ret = recv(sock[0], &dummy, 1, 0);
+	if (ret == -1) {
+		if (errno == EWOULDBLOCK)
+			tst_res(TPASS, "Can't read out-of-band data from normal stream");
+		else
+			tst_brk(TBROK | TERRNO, "recv error");
+	} else {
+		const char *msg = "We are able to read out-of-band data from normal stream";
+
+		if (dummy == 'A') {
+			tst_res(TFAIL, "%s", msg);
+		} else {
+			tst_res(TFAIL, "%s, but data doesn't match: '%c' != 'A'",
+				msg, dummy);
+		}
+
+		SAFE_RECV(0, sock[0], &dummy, 1, MSG_OOB);
+
+		tst_res(TFAIL, "We are able to access data from skb queue (use-after-free)");
+	}
+}
+
+static void setup(void)
+{
+	SAFE_SOCKETPAIR(AF_UNIX, SOCK_STREAM, 0, sock);
+	SAFE_SETSOCKOPT(sock[0], SOL_SOCKET, SO_RCVTIMEO,
+		 &sock_timeout, sizeof(struct timeval));
+}
+
+static void cleanup(void)
+{
+	if (sock[0] != -1)
+		SAFE_CLOSE(sock[0]);
+
+	if (sock[1] != -1)
+		SAFE_CLOSE(sock[1]);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_AF_UNIX_OOB=y",
+		NULL
+	},
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "32ca245464e1"},
+		{"CVE", "2025-38236"},
+		{}
+	}
+};

---
base-commit: e2c58cfcb82be0b376098a67c8f45264282be67a
change-id: 20250812-cve_2025_38236-7cb0cd4fdbf5

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
