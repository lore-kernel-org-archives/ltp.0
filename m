Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 995E3E6F062
	for <ltp@archiver.kernel.org>; Fri,  1 Nov 2024 14:38:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E030B3CD79A
	for <ltp@archiver.kernel.org>; Fri,  1 Nov 2024 15:38:09 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3A0573CD537
 for <ltp@lists.linux.it>; Fri,  1 Nov 2024 15:37:38 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9BC276068CE
 for <ltp@lists.linux.it>; Fri,  1 Nov 2024 15:37:36 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F2E3F21C5B;
 Fri,  1 Nov 2024 14:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730471856; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=kgQnsygS2WZdQQfVxbZvwRKERagfjDRkXQjp6aZIpKs=;
 b=mTCVXdiXX1bOYLoHnFrvOUdItpPNyiYEhOXCSqEU/8KYG/aSt+zcdrQryNsOkMXajzdib7
 zXEVB6TZjVtr1/HZC0daFsIrIH1l/aBNh6Vr0wcp9xBH5ZZTNorKl+rKtmBZtz4GFORvhK
 0is5/18b0FrRNHpAR4IHPLXWrNQ6/NQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730471856;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=kgQnsygS2WZdQQfVxbZvwRKERagfjDRkXQjp6aZIpKs=;
 b=1e8g5RvLk4gdjILop5Hva2J6D5mXf+h9XbQxlHmwus3Qwj0F+XSSVMzxv4gX4XKMVpFcxr
 /qdCbsX2Bq690qBQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=mTCVXdiX;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=1e8g5RvL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730471856; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=kgQnsygS2WZdQQfVxbZvwRKERagfjDRkXQjp6aZIpKs=;
 b=mTCVXdiXX1bOYLoHnFrvOUdItpPNyiYEhOXCSqEU/8KYG/aSt+zcdrQryNsOkMXajzdib7
 zXEVB6TZjVtr1/HZC0daFsIrIH1l/aBNh6Vr0wcp9xBH5ZZTNorKl+rKtmBZtz4GFORvhK
 0is5/18b0FrRNHpAR4IHPLXWrNQ6/NQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730471856;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=kgQnsygS2WZdQQfVxbZvwRKERagfjDRkXQjp6aZIpKs=;
 b=1e8g5RvLk4gdjILop5Hva2J6D5mXf+h9XbQxlHmwus3Qwj0F+XSSVMzxv4gX4XKMVpFcxr
 /qdCbsX2Bq690qBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CC11613722;
 Fri,  1 Nov 2024 14:37:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Hi6IMK/nJGeICwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 01 Nov 2024 14:37:35 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  1 Nov 2024 15:37:25 +0100
Message-ID: <20241101143726.1278291-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
X-Rspamd-Queue-Id: F2E3F21C5B
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_COUNT_TWO(0.00)[2];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU]; ARC_NA(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] ima_boot_aggregate: Fix openssl 3.0 deprecation
 warnings
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
Cc: linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From the docs:
https://docs.openssl.org/3.0/man7/migration_guide/#deprecated-low-level-digest-functions

    Use of low-level digest functions such as SHA1_Init(3) have been
    informally discouraged from use for a long time. Applications should
    instead use the high level EVP APIs EVP_DigestInit_ex(3),
    EVP_DigestUpdate(3) and EVP_DigestFinal_ex(3), or the quick one-shot
    EVP_Q_digest(3).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../integrity/ima/src/ima_boot_aggregate.c    | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c b/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
index 62468e0d19..68d12fc3c2 100644
--- a/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
+++ b/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
@@ -24,6 +24,7 @@
 
 #if HAVE_LIBCRYPTO
 #include <openssl/sha.h>
+#include <openssl/evp.h>
 
 #define MAX_EVENT_SIZE (1024*1024)
 #define EVENT_HEADER_SIZE 32
@@ -61,7 +62,11 @@ static void display_sha1_digest(unsigned char *pcr)
 static void do_test(void)
 {
 	FILE *fp;
+#if OPENSSL_VERSION_NUMBER > 0x030000000L
+	EVP_MD_CTX *c = NULL;
+#else
 	SHA_CTX c;
+#endif
 	int i;
 
 	if (!file)
@@ -85,12 +90,24 @@ static void do_test(void)
 		}
 
 		if (event.header.pcr < NUM_PCRS) {
+#if OPENSSL_VERSION_NUMBER > 0x030000000L
+			if ((c = EVP_MD_CTX_new()) == NULL)
+				tst_brk(TBROK, "can't get new context");
+
+			EVP_DigestInit_ex(c, EVP_sha1(), NULL);
+			EVP_DigestUpdate(c, pcr[event.header.pcr].digest,
+					 SHA_DIGEST_LENGTH);
+			EVP_DigestUpdate(c, event.header.digest, SHA_DIGEST_LENGTH);
+			EVP_DigestFinal_ex(c, pcr[event.header.pcr].digest, NULL);
+			EVP_MD_CTX_free(c);
+#else
 			SHA1_Init(&c);
 			SHA1_Update(&c, pcr[event.header.pcr].digest,
 				    SHA_DIGEST_LENGTH);
 			SHA1_Update(&c, event.header.digest,
 				    SHA_DIGEST_LENGTH);
 			SHA1_Final(pcr[event.header.pcr].digest, &c);
+#endif
 		}
 
 #if MAX_EVENT_DATA_SIZE < USHRT_MAX
@@ -107,15 +124,30 @@ static void do_test(void)
 
 	/* Extend the boot aggregate with the pseudo PCR digest values */
 	memset(&boot_aggregate, 0, SHA_DIGEST_LENGTH);
+
+#if OPENSSL_VERSION_NUMBER > 0x030000000L
+	EVP_DigestInit_ex(c, EVP_sha1(), NULL);
+#else
 	SHA1_Init(&c);
+#endif
+
 	for (i = 0; i < NUM_PCRS; i++) {
 		if (debug) {
 			printf("PCR-%2.2x: ", i);
 			display_sha1_digest(pcr[i].digest);
 		}
+#if OPENSSL_VERSION_NUMBER > 0x030000000L
+		EVP_DigestUpdate(c, pcr[i].digest, SHA_DIGEST_LENGTH);
+#else
 		SHA1_Update(&c, pcr[i].digest, SHA_DIGEST_LENGTH);
+#endif
 	}
+
+#if OPENSSL_VERSION_NUMBER > 0x030000000L
+	EVP_MD_CTX_free(c);
+#else
 	SHA1_Final(boot_aggregate, &c);
+#endif
 
 	printf("sha1:");
 	display_sha1_digest(boot_aggregate);
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
