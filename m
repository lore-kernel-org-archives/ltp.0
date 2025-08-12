Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75A5DCA0EC4
	for <ltp@archiver.kernel.org>; Tue, 12 Aug 2025 12:01:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DA5FD3CB1C4
	for <ltp@archiver.kernel.org>; Tue, 12 Aug 2025 14:01:57 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8120D3C052E
 for <ltp@lists.linux.it>; Tue, 12 Aug 2025 14:01:40 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 56F5E6000BE
 for <ltp@lists.linux.it>; Tue, 12 Aug 2025 14:01:38 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C180421B35;
 Tue, 12 Aug 2025 12:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1755000098; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=F3DJ2g1jdOgY6jijkJAtHmMa+iru+Y4ASBOia4q5w1I=;
 b=RR25jo2RVd823VRMisrpS1K11DCMLoNxZ0OxC5idjafLqnehD2GYNXhSlCv9RQwCIzlz9l
 AObH5+EZrJAgfzQM1VfD+XH88iQihZaxGqTXOdQJYMjDR+xbUBTkmRmQT4BCRDyc3hnalo
 q452GvQQHlDZVf9Andn6rlsvvQjVeYk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1755000098;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=F3DJ2g1jdOgY6jijkJAtHmMa+iru+Y4ASBOia4q5w1I=;
 b=puoQQlCVY6JJsvmSLPBy+T0j/fcHjRloetYIu7K7GpcGJNsX31c/GDuAWWnOZ0+/Zd/4XS
 MjbB+tssy4/9riDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=KgttaV18;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=zEsk3N33
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1755000094; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=F3DJ2g1jdOgY6jijkJAtHmMa+iru+Y4ASBOia4q5w1I=;
 b=KgttaV18j3kSPAuJ7lQO0XTefUBHhN5Ioq5UXWFwJzapE9I/Y/JE4cZUDI0UZNWQ1bHDsJ
 NJm0BIfRK7+zUQXbnamvxDnhfQLox9kDKwsrduZ67PDEXIo6+IYIAjBag1uvYH4pGIu28P
 TRu7BM65Teyqt8+NxY3TIg387p5IZQU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1755000094;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=F3DJ2g1jdOgY6jijkJAtHmMa+iru+Y4ASBOia4q5w1I=;
 b=zEsk3N33qeQy7rlijne4Y38xmz9kMdqg1V7EAmGNpd8IUT27RusZn5Frsi49NErFdjhzE9
 hOLsOMoJGo0HYWAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 84341136C7;
 Tue, 12 Aug 2025 12:01:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 9KwEGh0tm2iBJAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 12 Aug 2025 12:01:33 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 12 Aug 2025 14:01:32 +0200
MIME-Version: 1.0
Message-Id: <20250812-cve_2025_38236-v2-1-76abeeaeaee6@suse.com>
X-B4-Tracking: v=1; b=H4sIABstm2gC/3XMSw7CIBSF4a00dyyGh6XVkfswTUMvF8vAYkCJp
 mHv0s4dfic5/wqJoqcEl2aFSNknH5YKeWgAZ7PciXlbDZLLlvdCMsw0bhhVL5VmHU4c7cnZybV
 QT89Izn/24G2onn16hfjd+1ls699UFkwwUlp0xhp9Rn1N70RHDA8YSik/Z+7c+qsAAAA=
X-Change-ID: 20250812-cve_2025_38236-7cb0cd4fdbf5
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755000093; l=4995;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=wnu0F0WnFNd7rv97r5AKzTvsp24Gc4bgLtUzZatVvfQ=;
 b=I0TBiDY6NSr/B75dSc2LNiPCPUjeQPYXCEvim0IP/P4k7J0A2vDxQUkvTwp5tKuKHOaEgGkJP
 6cYkcywren0DRjHB2Uwsc52beP/KWJqg/5AokL5K1g3MfonW7l0QBTO
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,chromium.org:url,suse.de:dkim];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: C180421B35
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] cve: add CVE-2025-38236 test
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
Changes in v2:
- use MSG_DONTWAIT
- add reference in the description
- reduce if/else nesting
- use different data for send()
- Link to v1: https://lore.kernel.org/r/20250812-cve_2025_38236-v1-1-e3617ada69c6@suse.com
---
 runtest/cve                    |   1 +
 testcases/cve/.gitignore       |   1 +
 testcases/cve/cve-2025-38236.c | 101 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 103 insertions(+)

diff --git a/runtest/cve b/runtest/cve
index 1d1d875974f0ce545005faedb78125d33ec7c989..6d575aa2165bcd46e5ca36a07db33f69a91bd94a 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -91,3 +91,4 @@ cve-2023-31248 nft02
 cve-2020-25704 perf_event_open03
 cve-2022-0185 fsconfig03
 cve-2022-4378 cve-2022-4378
+cve-2025-38236 cve-2025-38236
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
index 0000000000000000000000000000000000000000..a34e5e8f530dcd244a7e40fbf66293e469b167be
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
+ *
+ * Reproducer is based on:
+ * https://project-zero.issues.chromium.org/issues/423023990
+ */
+
+#include "tst_test.h"
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
+	SAFE_SEND(0, sock[1], "B", 1, MSG_OOB);
+	SAFE_RECV(0, sock[0], &dummy, 1, MSG_OOB);
+
+	tst_res(TINFO, "Send out-of-band data");
+	SAFE_SEND(0, sock[1], "C", 1, MSG_OOB);
+
+	tst_res(TINFO, "Receive data from normal stream");
+
+	ret = recv(sock[0], &dummy, 1, MSG_DONTWAIT);
+	if (ret == -1) {
+		if (errno == EWOULDBLOCK) {
+			tst_res(TPASS, "Can't read out-of-band data from normal stream");
+			return;
+		}
+
+		tst_brk(TBROK | TERRNO, "recv error");
+		return;
+	}
+
+	const char *msg = "We are able to read out-of-band data from normal stream";
+
+	if (dummy == 'C') {
+		tst_res(TFAIL, "%s", msg);
+	} else {
+		tst_res(TFAIL, "%s, but data doesn't match: '%c' != 'A'",
+			msg, dummy);
+	}
+
+	SAFE_RECV(0, sock[0], &dummy, 1, MSG_OOB);
+
+	tst_res(TFAIL, "We are able to access data from skb queue (use-after-free)");
+}
+
+static void setup(void)
+{
+	SAFE_SOCKETPAIR(AF_UNIX, SOCK_STREAM, 0, sock);
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
