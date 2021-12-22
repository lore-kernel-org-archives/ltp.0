Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68ADDC433EF
	for <ltp@archiver.kernel.org>; Wed, 22 Dec 2021 19:26:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 76C4F3C925E
	for <ltp@archiver.kernel.org>; Wed, 22 Dec 2021 20:26:31 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0773D3C08F2
 for <ltp@lists.linux.it>; Wed, 22 Dec 2021 20:26:10 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 23C8C140145A
 for <ltp@lists.linux.it>; Wed, 22 Dec 2021 20:26:09 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 68A271F389;
 Wed, 22 Dec 2021 19:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1640201169; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=CjGaDA9B4fzPIY0jsU1Js4npD0arMfP3qP9qFtB1C54=;
 b=yDjvg+E2e4sOovtBhcNzQcWqN54byiDUWhwNbjGU5bLd+KYboHVLjWDsbHnCLyvZRxj0IM
 iPNmQ2Smk9tX8f5bSxPfKrmGve9NGzbv8tfwws9dKj5ut8TjxaJmpFBsQy7CUA8A3YnI/1
 iMFkNqE3QcOlvFwxFjfWCzVxG21vejo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1640201169;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=CjGaDA9B4fzPIY0jsU1Js4npD0arMfP3qP9qFtB1C54=;
 b=DYCkzqaP0e7v5MtvU5rnqDJq0qscapUtk4oSRf/ZGVooQujaQsrSGi4gnJ+c/sWXeG0F9k
 dQCk++f38rHSC3CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CEE3413D75;
 Wed, 22 Dec 2021 19:26:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id BpnJL9B7w2FZXQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 22 Dec 2021 19:26:08 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 22 Dec 2021 20:26:03 +0100
Message-Id: <20211222192604.16839-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/2] tst_af_alg: Moving tst_res(TCONF) to
 tst_have_alg()
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
Cc: Eric Biggers <ebiggers@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

+ introduce tst_try_alg() for cases where tst_res(TCONF) cannot be used.

It reduces duplicity for tst_have_alg() use.

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
New in v3.

 include/tst_af_alg.h               | 16 ++++++++++--
 lib/tst_af_alg.c                   | 41 ++++++++++++++++++++++--------
 testcases/kernel/crypto/af_alg01.c | 14 ++++------
 testcases/kernel/crypto/af_alg03.c |  3 ++-
 testcases/kernel/crypto/af_alg04.c |  6 ++---
 5 files changed, 53 insertions(+), 27 deletions(-)

diff --git a/include/tst_af_alg.h b/include/tst_af_alg.h
index fd2ff06478..93ff5715b7 100644
--- a/include/tst_af_alg.h
+++ b/include/tst_af_alg.h
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright 2019 Google LLC
+ * Copyright (c) Linux Test Project, 2021
  */
 /**
  * @file tst_af_alg.h
@@ -60,8 +61,19 @@ void tst_alg_bind(int algfd, const char *algtype, const char *algname);
  * @param algtype The type of algorithm, such as "hash" or "skcipher"
  * @param algname The name of the algorithm, such as "sha256" or "xts(aes)"
  *
- * Return true if the algorithm is available, or false if unavailable.
- * If another error occurs, tst_brk() is called with TBROK.
+ * Return 0 if the algorithm is available, or errno if unavailable.
+ */
+int tst_try_alg(const char *algtype, const char *algname);
+
+/**
+ * Check for the availability of an algorithm.
+ *
+ * @param algtype The type of algorithm, such as "hash" or "skcipher"
+ * @param algname The name of the algorithm, such as "sha256" or "xts(aes)"
+ *
+ * Return true if the algorithm is available, or false if unavailable
+ * and call tst_res() with TCONF. If another error occurs, tst_brk() is called
+ * with TBROK.
  */
 bool tst_have_alg(const char *algtype, const char *algname);
 
diff --git a/lib/tst_af_alg.c b/lib/tst_af_alg.c
index 05caa63016..d99a9ee2ef 100644
--- a/lib/tst_af_alg.c
+++ b/lib/tst_af_alg.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright 2019 Google LLC
+ * Copyright (c) Linux Test Project, 2019-2021
  */
 
 #include <errno.h>
@@ -64,29 +65,47 @@ void tst_alg_bind(int algfd, const char *algtype, const char *algname)
 	tst_alg_bind_addr(algfd, &addr);
 }
 
-bool tst_have_alg(const char *algtype, const char *algname)
+int tst_try_alg(const char *algtype, const char *algname)
 {
 	long ret;
+	int retval = 0;
 	int algfd;
 	struct sockaddr_alg addr;
-	bool have_alg = true;
 
 	algfd = tst_alg_create();
 
 	init_sockaddr_alg(&addr, algtype, algname);
 
 	ret = bind(algfd, (const struct sockaddr *)&addr, sizeof(addr));
-	if (ret != 0) {
-		if (errno != ENOENT) {
-			tst_brk(TBROK | TERRNO,
-				"unexpected error binding AF_ALG socket to %s algorithm '%s'",
-				algtype, algname);
-		}
-		have_alg = false;
-	}
+
+	if (ret != 0)
+		retval = errno;
 
 	close(algfd);
-	return have_alg;
+	return retval;
+}
+
+bool tst_have_alg(const char *algtype, const char *algname)
+{
+	int ret;
+
+	ret = tst_try_alg(algtype, algname);
+
+	switch (ret) {
+	case 0:
+		return true;
+	case ENOENT:
+		tst_res(TCONF, "kernel doesn't have %s algorithm '%s'",
+			algtype, algname);
+		return false;
+	default:
+		errno = ret;
+		tst_brk(TBROK | TERRNO,
+			"unexpected error binding AF_ALG socket to %s algorithm '%s'",
+			algtype, algname);
+		return false;
+	break;
+	}
 }
 
 void tst_require_alg(const char *algtype, const char *algname)
diff --git a/testcases/kernel/crypto/af_alg01.c b/testcases/kernel/crypto/af_alg01.c
index 47292ee328..7cefe59461 100644
--- a/testcases/kernel/crypto/af_alg01.c
+++ b/testcases/kernel/crypto/af_alg01.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright 2019 Google LLC
+ * Copyright (c) Linux Test Project, 2019-2021
  */
 
 /*
@@ -21,20 +22,15 @@ static void test_with_hash_alg(const char *hash_algname)
 	char hmac_algname[64];
 	char key[4096] = { 0 };
 
-	if (!tst_have_alg("hash", hash_algname)) {
-		tst_res(TCONF, "kernel doesn't have hash algorithm '%s'",
-			hash_algname);
+	if (!tst_have_alg("hash", hash_algname))
 		return;
-	}
+
 	sprintf(hmac_algname, "hmac(%s)", hash_algname);
-	if (!tst_have_alg("hash", hmac_algname)) {
-		tst_res(TCONF, "kernel doesn't have hash algorithm '%s'",
-			hmac_algname);
+	if (!tst_have_alg("hash", hmac_algname))
 		return;
-	}
 
 	sprintf(hmac_algname, "hmac(hmac(%s))", hash_algname);
-	if (tst_have_alg("hash", hmac_algname)) {
+	if (tst_try_alg("hash", hmac_algname) != ENOENT) {
 		int algfd;
 
 		tst_res(TFAIL, "instantiated nested hmac algorithm ('%s')!",
diff --git a/testcases/kernel/crypto/af_alg03.c b/testcases/kernel/crypto/af_alg03.c
index 5f214e48ba..bb8d480e28 100644
--- a/testcases/kernel/crypto/af_alg03.c
+++ b/testcases/kernel/crypto/af_alg03.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright 2019 Google LLC
+ * Copyright (c) Linux Test Project, 2019-2021
  */
 
 /*
@@ -17,7 +18,7 @@ static void run(void)
 	tst_require_alg("aead", "rfc7539(chacha20,poly1305)");
 	tst_require_alg("hash", "sha256");
 
-	if (tst_have_alg("aead", "rfc7539(chacha20,sha256)")) {
+	if (tst_try_alg("aead", "rfc7539(chacha20,sha256)") != ENOENT) {
 		tst_res(TFAIL,
 			"instantiated rfc7539 template with wrong digest size");
 	} else {
diff --git a/testcases/kernel/crypto/af_alg04.c b/testcases/kernel/crypto/af_alg04.c
index 112afcd527..7b665f89a3 100644
--- a/testcases/kernel/crypto/af_alg04.c
+++ b/testcases/kernel/crypto/af_alg04.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright 2019 Google LLC
+ * Copyright (c) Linux Test Project, 2019-2021
  */
 
 /*
@@ -28,11 +29,8 @@ static void test_with_symm_enc_algs(const char *symm_enc_algname)
 	sprintf(vmac_algname, "vmac64(%s)", symm_enc_algname);
 	if (!tst_have_alg("hash", vmac_algname)) {
 		sprintf(vmac_algname, "vmac(%s)", symm_enc_algname);
-		if (!tst_have_alg("hash", vmac_algname)) {
-			tst_res(TCONF, "kernel doesn't have hash algorithm '%s'",
-				vmac_algname);
+		if (!tst_have_alg("hash", vmac_algname))
 			return;
-		}
 	}
 	algfd = tst_alg_setup("hash", vmac_algname, NULL, 16);
 
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
