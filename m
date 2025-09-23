Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92396CAC5A7
	for <ltp@archiver.kernel.org>; Tue, 23 Sep 2025 08:41:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1C3D33CDE98
	for <ltp@archiver.kernel.org>; Tue, 23 Sep 2025 10:41:55 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 949723CDE94
 for <ltp@lists.linux.it>; Tue, 23 Sep 2025 10:41:11 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id F0AF26001FB
 for <ltp@lists.linux.it>; Tue, 23 Sep 2025 10:41:10 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EE8402265D;
 Tue, 23 Sep 2025 08:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1758616864; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S7PecYHLINqIN3YtHOw+B0hmWu9iY9ycP9cTBgmpGm8=;
 b=I7ZJmmxg8iYBswLcv4AMiafFkr5rUakUp+OHO93/ReW43oqa3mpWDyajwpcyqcwIKV+qqB
 gjTVOkbta8wCKkmDbkBdVpYLoOvQ+mIhF+VUCevJNrJE44GpnRaY5EodFozFXo2mDZJo75
 mtNt6JodElagJlKNzw2kfcVlm/orLQU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1758616864;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S7PecYHLINqIN3YtHOw+B0hmWu9iY9ycP9cTBgmpGm8=;
 b=FiGAUGDznbsY6VX4ArnkyP+ePDJMSUfyMG6inoPGgP2S2+5evDCRW7JUgSSJghCY2ihcaM
 euU0s3zoh7vKA5Cw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=MlkphTzl;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4UrnMdEy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1758616862; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S7PecYHLINqIN3YtHOw+B0hmWu9iY9ycP9cTBgmpGm8=;
 b=MlkphTzlLuQpHFv/A+ghb3OO9JUPufrj0WdS4lz5sPG0gC/ShlxUwAGHwZAG6FwLNNBr6o
 x16rdKmaWMvovv6QXVvXJNbfqQcPF/4Ll1VWr/4gTsVSwdaTu3Vu8EJEiwW/I0RQgRdljy
 6DrJRK5OPYFS2Hm6dsfs2gEas219aZ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1758616862;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S7PecYHLINqIN3YtHOw+B0hmWu9iY9ycP9cTBgmpGm8=;
 b=4UrnMdEyApaSrB8wy1VE355+2y3r8G7foFjB1yoiwB485x4/yheCP1gNtFxK4xCjco+Su/
 3QucFDFcGN4xWfDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D05CA13AB1;
 Tue, 23 Sep 2025 08:41:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UBgvMR1d0mgWRgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 23 Sep 2025 08:41:01 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 23 Sep 2025 10:41:00 +0200
MIME-Version: 1.0
Message-Id: <20250923-cve-2025-21756-v2-2-3bb1a6363123@suse.com>
References: <20250923-cve-2025-21756-v2-0-3bb1a6363123@suse.com>
In-Reply-To: <20250923-cve-2025-21756-v2-0-3bb1a6363123@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758616861; l=3868;
 i=andrea.cervesato@suse.com; s=20250922; h=from:subject:message-id;
 bh=FuqhjKLxlgSkgIuRXSg8UWof8MLDNLlSK7K4ZtQc82U=;
 b=sjVxs98NHqNzqtTY0szkx8W2swYd8RwyQiKJ6mpGd53/k3nO16Mnz0P69IPHYK98wtCXIKidh
 NftxDWxUTEoC0u0JqjlijKIscQrdZ8WxssiGVDtJ0OkPMQsq+eaKg9o
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=+8M3XgViLdcdNBM+Jdd90m3pV4jCw2tNsGCy5Rd+qHk=
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: EE8402265D
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] cve: add test reproducer for cve-2025-21756
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
 testcases/cve/cve-2025-21756.c | 95 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 97 insertions(+)

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
index 0000000000000000000000000000000000000000..80fb84c473207fb2497f6ca6bb53166f0b1734cc
--- /dev/null
+++ b/testcases/cve/cve-2025-21756.c
@@ -0,0 +1,95 @@
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
+
+	if (bind(sock, (struct sockaddr *)&sa, sizeof(sa)) == -1) {
+		if (errno == EINVAL)
+			tst_brk(TCONF, "VM socket is not supported");
+
+		tst_brk(TBROK | TERRNO, "bind() error");
+	}
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
+	if (tst_taint_check())
+		tst_res(TFAIL, "Kernel is vulnerable");
+	else
+		tst_res(TPASS, "Kernel survived after socket unbinding");
+
+	while (sock_count--)
+		SAFE_CLOSE(sockets[sock_count]);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.taint_check = TST_TAINT_W | TST_TAINT_D,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "fcdd2242c023"},
+		{"CVE", "2025-21756"},
+		{}
+	},
+};

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
