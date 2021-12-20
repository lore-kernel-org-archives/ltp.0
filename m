Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E92CC433F5
	for <ltp@archiver.kernel.org>; Mon, 20 Dec 2021 19:51:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 91F0A3C9221
	for <ltp@archiver.kernel.org>; Mon, 20 Dec 2021 20:51:25 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B89A83C918D
 for <ltp@lists.linux.it>; Mon, 20 Dec 2021 20:51:16 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 006406005C7
 for <ltp@lists.linux.it>; Mon, 20 Dec 2021 20:51:15 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5F2321F3B3;
 Mon, 20 Dec 2021 19:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1640029875; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=cheVSH8Cn6IkqkJ8KwCqBxK/rsewCOrew7zWYyFEN+M=;
 b=vVgGdi9oEAWyiwIKRjiBLg1G6iD97zpc54MNjKuWK/yinaUKP33GncyomsuQpYLLTqBOmY
 kxf9FE15aoJ8rTVexv9PG3rYM3PIy7MFWdfAeUsicq+uclaGUY76YjpDYM5ddrC6CDUv7A
 0d9Q9eE6gd20dNEqDCquKR4oDqhmTVk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1640029875;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=cheVSH8Cn6IkqkJ8KwCqBxK/rsewCOrew7zWYyFEN+M=;
 b=iLt13IaAqU07Q6bfpxdI97I5pyS99+93yL6JSTPPx9Js0cjot3NuvtCnE1zT90N9J2kHLg
 9GBkPDFDXNRRWECg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 29C0C13DBD;
 Mon, 20 Dec 2021 19:51:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id PkeACLPewGH4JAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 20 Dec 2021 19:51:15 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 20 Dec 2021 20:51:11 +0100
Message-Id: <20211220195111.24580-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] tst_test_macros.h: Print also returned value
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

in TST_EXP_VAL*() macros.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
NOTE: tst_test_macros.h would also deserve documentation of "public"
macros (to save people read all nested definitions.

Kind regards,
Petr

 include/tst_test_macros.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
index 4a023b700a..dd959cad63 100644
--- a/include/tst_test_macros.h
+++ b/include/tst_test_macros.h
@@ -46,6 +46,10 @@ extern void *TST_RET_PTR;
 	tst_res_(__FILE__, __LINE__, RES, \
 		TST_FMT_(TST_2_(dummy, ##__VA_ARGS__, SCALL) FMT, __VA_ARGS__), PAR)
 
+#define TST_MSGP2_(RES, FMT, PAR, PAR2, SCALL, ...) \
+	tst_res_(__FILE__, __LINE__, RES, \
+		TST_FMT_(TST_2_(dummy, ##__VA_ARGS__, SCALL) FMT, __VA_ARGS__), PAR, PAR2)
+
 #define TST_EXP_POSITIVE_(SCALL, SSCALL, ...)                                  \
 	do {                                                                   \
 		TEST(SCALL);                                                   \
@@ -107,8 +111,8 @@ extern void *TST_RET_PTR;
 		TST_PASS = 0;                                                  \
 		                                                               \
 		if (TST_RET != VAL) {                                          \
-			TST_MSGP_(TFAIL | TTERRNO, " retval not %ld",          \
-			          (long )VAL, SSCALL, ##__VA_ARGS__);          \
+			TST_MSGP2_(TFAIL | TTERRNO, " retval not %ld (%ld)",          \
+			          (long)VAL, TST_RET, SSCALL, ##__VA_ARGS__);          \
 			break;                                                 \
 		}                                                              \
 		                                                               \
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
