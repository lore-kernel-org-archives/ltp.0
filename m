Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D581C7618E
	for <ltp@archiver.kernel.org>; Wed, 26 Apr 2023 09:10:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 238DA3CBB92
	for <ltp@archiver.kernel.org>; Wed, 26 Apr 2023 11:10:34 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7AB303C9ADC
 for <ltp@lists.linux.it>; Wed, 26 Apr 2023 11:10:24 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9D28F600662
 for <ltp@lists.linux.it>; Wed, 26 Apr 2023 11:10:22 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7D3D01FDCD;
 Wed, 26 Apr 2023 09:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1682500222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=5UAK014ma4ZkmQirhug5p0Irn2aJSJ/M5PRZmHdJG+Y=;
 b=wE0SHxQ3a431HmIuBpDk4CWzLD56JqV0yp0qI+Vlo8ykwXjFUC3k3tmhkSAOwXdNsjC+c9
 V21md7pjceFF25MdmUHgmiloYRPOIjT0NXx6XvmYA7fyOGg74HAvYE0F11Al7/KeZ6h2/p
 /hLj4exjWaO9U+3sBBg7pCEZHYqI4pk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1682500222;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=5UAK014ma4ZkmQirhug5p0Irn2aJSJ/M5PRZmHdJG+Y=;
 b=DfB/ZHm41WzmhxOETSs7zSISCm4xDQVOAhzWhQ6vtN/J8v8BgP6eydirrotxNCx/obkTZS
 zsjUIHgXb+qnV3CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5AA1B138F0;
 Wed, 26 Apr 2023 09:10:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id DuV4FH7qSGS4MAAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Wed, 26 Apr 2023 09:10:22 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Wed, 26 Apr 2023 11:08:03 +0200
Message-Id: <20230426090803.2928-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] Support return value in TST_* macros
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Removed return value from TST_EXP_PASS_* and TST_EXP_FAIL_*
Add TST_EXP_POSITIVE__

 include/tst_test_macros.h | 39 ++++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
index 231c04951..bd0c491c1 100644
--- a/include/tst_test_macros.h
+++ b/include/tst_test_macros.h
@@ -51,7 +51,7 @@ extern void *TST_RET_PTR;
 	tst_res_(__FILE__, __LINE__, RES, \
 		TST_FMT_(TST_2_(dummy, ##__VA_ARGS__, SCALL) FMT, __VA_ARGS__), PAR, PAR2)
 
-#define TST_EXP_POSITIVE_(SCALL, SSCALL, ...)                                  \
+#define TST_EXP_POSITIVE__(SCALL, SSCALL, ...)                                 \
 	do {                                                                   \
 		TEST(SCALL);                                                   \
 		                                                               \
@@ -73,46 +73,59 @@ extern void *TST_RET_PTR;
                                                                                \
 	} while (0)
 
+#define TST_EXP_POSITIVE_(SCALL, ...)                                          \
+	({                                                                     \
+		TST_EXP_POSITIVE__(SCALL, #SCALL, ##__VA_ARGS__);              \
+		TST_RET;                                                       \
+	})
+
 #define TST_EXP_POSITIVE(SCALL, ...)                                           \
-	do {                                                                   \
-		TST_EXP_POSITIVE_(SCALL, #SCALL, ##__VA_ARGS__);               \
+	({                                                                     \
+		TST_EXP_POSITIVE__(SCALL, #SCALL, ##__VA_ARGS__);              \
 		                                                               \
 		if (TST_PASS) {                                                \
 			TST_MSGP_(TPASS, " returned %ld",                      \
 			          TST_RET, #SCALL, ##__VA_ARGS__);             \
 		}                                                              \
-	} while (0)
+		                                                               \
+		TST_RET;                                                       \
+	})
 
 #define TST_EXP_FD_SILENT(SCALL, ...)	TST_EXP_POSITIVE_(SCALL, #SCALL, ##__VA_ARGS__)
 
 #define TST_EXP_FD(SCALL, ...)                                                 \
-	do {                                                                   \
-		TST_EXP_POSITIVE_(SCALL, #SCALL, ##__VA_ARGS__);               \
+	({                                                                     \
+		TST_EXP_POSITIVE__(SCALL, #SCALL, ##__VA_ARGS__);              \
 		                                                               \
 		if (TST_PASS)                                                  \
 			TST_MSGP_(TPASS, " returned fd %ld", TST_RET,          \
 				#SCALL, ##__VA_ARGS__);                        \
-	} while (0)
+		                                                               \
+		TST_RET;                                                       \
+	})
 
-#define TST_EXP_FD_OR_FAIL(SCALL, ERRNO, ...)                                    \
-	do {                                                                   \
+#define TST_EXP_FD_OR_FAIL(SCALL, ERRNO, ...)                                  \
+	({                                                                     \
 		if (ERRNO)                                                     \
 			TST_EXP_FAIL(SCALL, ERRNO, ##__VA_ARGS__);             \
 		else                                                           \
 			TST_EXP_FD(SCALL, ##__VA_ARGS__);                      \
 		                                                               \
-	} while (0)
+		TST_RET;                                                       \
+	})
 
 #define TST_EXP_PID_SILENT(SCALL, ...)	TST_EXP_POSITIVE_(SCALL, #SCALL, ##__VA_ARGS__)
 
 #define TST_EXP_PID(SCALL, ...)                                                \
-	do {                                                                   \
-		TST_EXP_POSITIVE_(SCALL, #SCALL, ##__VA_ARGS__);               \
+	({                                                                     \
+		TST_EXP_POSITIVE__(SCALL, #SCALL, ##__VA_ARGS__);              \
 									       \
 		if (TST_PASS)                                                  \
 			TST_MSGP_(TPASS, " returned pid %ld", TST_RET,         \
 				#SCALL, ##__VA_ARGS__);                        \
-	} while (0)
+		                                                               \
+		TST_RET;                                                       \
+	})
 
 #define TST_EXP_VAL_SILENT_(SCALL, VAL, SSCALL, ...)                           \
 	do {                                                                   \
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
