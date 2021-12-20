Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC8EC433F5
	for <ltp@archiver.kernel.org>; Mon, 20 Dec 2021 21:28:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CC5BE3C921D
	for <ltp@archiver.kernel.org>; Mon, 20 Dec 2021 22:28:10 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B353D3C90FC
 for <ltp@lists.linux.it>; Mon, 20 Dec 2021 22:28:01 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2751D10005F8
 for <ltp@lists.linux.it>; Mon, 20 Dec 2021 22:28:00 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 41EAD1F3B6;
 Mon, 20 Dec 2021 21:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1640035680; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=CwkjPOG4kgC9u9J7YVqEA91lEGyhyZ5HkLCQprcGuFw=;
 b=ZygT/E55+QR3TNlc3x1Ryv40x+Drs/NlSz07CFefmknOO3R3NsLvl4wiqn/t1BGT3B8oSV
 15FK/cqBlexYcYtruUttwVhacc66PVLGPGfe7M49wFO5576qM2hDMjAy303X6TN31dbp8L
 lxErcNND7a8sCjYvA/Qt5tbRG1lfgGY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1640035680;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=CwkjPOG4kgC9u9J7YVqEA91lEGyhyZ5HkLCQprcGuFw=;
 b=HeJ3eifj4kBFushYiA0oDVGakSID4cnuQomnTa0FggOUYHBkN7YcQZmpIOS/McnvRwdNLh
 daM8mje+R28EqVDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1493313D26;
 Mon, 20 Dec 2021 21:28:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id RbeJA2D1wGGUSQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 20 Dec 2021 21:28:00 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 20 Dec 2021 22:27:56 +0100
Message-Id: <20211220212756.13510-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/1] tst_af_alg: Another fix for disabled weak
 cipher
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

e.g. md5 on enabled FIPS.
Similar fix to 4fa302ef9d. It fixes:

./af_alg01
tst_af_alg.c:84: TBROK: unexpected error binding AF_ALG socket to hash algorithm 'md5': ELIBBAD (80)
become
tst_fips.c:22: TINFO: FIPS: on
tst_af_alg.c:82: TCONF: FIPS enabled => hash algorithm 'md5' disabled
tst_fips.c:22: TINFO: FIPS: on
tst_af_alg.c:82: TCONF: FIPS enabled => hash algorithm 'md5-generic' disabled

./af_alg02
tst_af_alg.c:37: TBROK: unexpected error binding AF_ALG socket to skcipher algorithm 'salsa20': ELIBBAD (80)
become
tst_fips.c:22: TINFO: FIPS: on
tst_af_alg.c:36: TCONF: FIPS enabled => skcipher algorithm 'salsa20' disabled

./af_alg04
tst_af_alg.c:81: TBROK: unexpected error binding AF_ALG socket to hash algorithm 'vmac64(aes)': ELIBBAD (80)
become
tst_fips.c:22: TINFO: FIPS: on
tst_af_alg.c:82: TCONF: FIPS enabled => hash algorithm 'vmac64(aes)' disabled
af_alg04.c:32: TCONF: kernel doesn't have hash algorithm 'vmac(aes)'
af_alg04.c:32: TCONF: kernel doesn't have hash algorithm 'vmac(sm4)'
af_alg04.c:32: TCONF: kernel doesn't have hash algorithm 'vmac(sm4-generic)'

af_alg01.c adjusted not to print TCONF twice.

Tested on Debian stable bullseye and SLES 15-SP4.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

I was wrong, although SUSE has some custom patches for FIPS to disable
ciphers in drivers/crypto, patch is for mainline, because it returns
ELIBBAD for algorithms it considers non-FIPS-approved.

Also, while it's not that easy to run fips=1 on current openSUSE
Tumbleweed or Fedora 34 (there are probably some restricted ciphers
boot (systemd?) depends on), at least Debian stable boots and restrict
ciphers as expected.

NOTE: do we want to optimize repeated fips detection or repeated output?
(didn't see any elegant solution).

Kind regards,
Petr

 include/tst_af_alg.h               |  3 ++-
 lib/tst_af_alg.c                   | 16 +++++++++++++++-
 testcases/kernel/crypto/af_alg01.c |  6 ++++--
 3 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/include/tst_af_alg.h b/include/tst_af_alg.h
index fd2ff06478..264e226a2c 100644
--- a/include/tst_af_alg.h
+++ b/include/tst_af_alg.h
@@ -61,7 +61,8 @@ void tst_alg_bind(int algfd, const char *algtype, const char *algname);
  * @param algname The name of the algorithm, such as "sha256" or "xts(aes)"
  *
  * Return true if the algorithm is available, or false if unavailable.
- * If another error occurs, tst_brk() is called with TBROK.
+ * If another error occurs, tst_brk() is called with TBROK,
+ * unless algorithm enabled due FIPS mode (errno ELIBBAD).
  */
 bool tst_have_alg(const char *algtype, const char *algname);
 
diff --git a/lib/tst_af_alg.c b/lib/tst_af_alg.c
index 05caa63016..9325a98432 100644
--- a/lib/tst_af_alg.c
+++ b/lib/tst_af_alg.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright 2019 Google LLC
+ * Copyright (c) Linux Test Project, 2019-2021
  */
 
 #include <errno.h>
@@ -30,10 +31,18 @@ void tst_alg_bind_addr(int algfd, const struct sockaddr_alg *addr)
 
 	if (ret == 0)
 		return;
+
+	if (errno == ELIBBAD && tst_fips_enabled()) {
+		tst_brk(TCONF,
+			"FIPS enabled => %s algorithm '%s' disabled",
+			addr->salg_type, addr->salg_name);
+	}
+
 	if (errno == ENOENT) {
 		tst_brk(TCONF, "kernel doesn't support %s algorithm '%s'",
 			addr->salg_type, addr->salg_name);
 	}
+
 	tst_brk(TBROK | TERRNO,
 		"unexpected error binding AF_ALG socket to %s algorithm '%s'",
 		addr->salg_type, addr->salg_name);
@@ -77,11 +86,16 @@ bool tst_have_alg(const char *algtype, const char *algname)
 
 	ret = bind(algfd, (const struct sockaddr *)&addr, sizeof(addr));
 	if (ret != 0) {
-		if (errno != ENOENT) {
+		if (errno == ELIBBAD && tst_fips_enabled()) {
+			tst_res(TCONF,
+				"FIPS enabled => %s algorithm '%s' disabled",
+				algtype, algname);
+		} else if (errno != ENOENT) {
 			tst_brk(TBROK | TERRNO,
 				"unexpected error binding AF_ALG socket to %s algorithm '%s'",
 				algtype, algname);
 		}
+
 		have_alg = false;
 	}
 
diff --git a/testcases/kernel/crypto/af_alg01.c b/testcases/kernel/crypto/af_alg01.c
index 47292ee328..e31126fe01 100644
--- a/testcases/kernel/crypto/af_alg01.c
+++ b/testcases/kernel/crypto/af_alg01.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright 2019 Google LLC
+ * Copyright (c) Linux Test Project, 2019-2021
  */
 
 /*
@@ -22,8 +23,9 @@ static void test_with_hash_alg(const char *hash_algname)
 	char key[4096] = { 0 };
 
 	if (!tst_have_alg("hash", hash_algname)) {
-		tst_res(TCONF, "kernel doesn't have hash algorithm '%s'",
-			hash_algname);
+		if (errno != ELIBBAD)
+			tst_res(TCONF, "kernel doesn't have hash algorithm '%s'",
+				hash_algname);
 		return;
 	}
 	sprintf(hmac_algname, "hmac(%s)", hash_algname);
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
