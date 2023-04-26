Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06661C77B60
	for <ltp@archiver.kernel.org>; Wed, 26 Apr 2023 07:52:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 17E873CBFB1
	for <ltp@archiver.kernel.org>; Wed, 26 Apr 2023 09:52:22 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BE0883C8DAE
 for <ltp@lists.linux.it>; Wed, 26 Apr 2023 09:52:11 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 06ECB60096B
 for <ltp@lists.linux.it>; Wed, 26 Apr 2023 09:52:10 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E960E21A0C;
 Wed, 26 Apr 2023 07:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1682495529; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8fL9TTa1gTBQln3qmWvErjPpVdFlCX4GSGS/lWzfca8=;
 b=VdN7DUpn/SJZbacmt+bCpBp76iFSeI3rQONi7szEtr7eJEKVw+skASsPp1HQN4NoHEeKCx
 jrvP+af2nvrX8VsYwYbo8M3IrezAuQ+SOSmAW9oRaIs/UG2hAmmYzdbBBBa7iCNQM4vDwD
 MEKOGSfFjduPePLDKfbnjXQdHaQlpeE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1682495529;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8fL9TTa1gTBQln3qmWvErjPpVdFlCX4GSGS/lWzfca8=;
 b=Q/GMQv2qswxKDhKMjZov2+ihqdrgDPOXmhYcpuN86UQgH6zTKD4fkXr9vpFbzn7+v2qiNm
 M9gjMkLmHBaEC1DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CB36413421;
 Wed, 26 Apr 2023 07:52:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Y9gFMCnYSGQLBAAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Wed, 26 Apr 2023 07:52:09 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Wed, 26 Apr 2023 09:49:50 +0200
Message-Id: <20230426074950.8807-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Support return value in TST_* macros
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
 include/tst_test_macros.h | 69 +++++++++++++++++++++++++++------------
 1 file changed, 48 insertions(+), 21 deletions(-)

diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
index 231c04951..acc2d1bff 100644
--- a/include/tst_test_macros.h
+++ b/include/tst_test_macros.h
@@ -74,45 +74,60 @@ extern void *TST_RET_PTR;
 	} while (0)
 
 #define TST_EXP_POSITIVE(SCALL, ...)                                           \
-	do {                                                                   \
+	({                                                                     \
 		TST_EXP_POSITIVE_(SCALL, #SCALL, ##__VA_ARGS__);               \
 		                                                               \
 		if (TST_PASS) {                                                \
 			TST_MSGP_(TPASS, " returned %ld",                      \
 			          TST_RET, #SCALL, ##__VA_ARGS__);             \
 		}                                                              \
-	} while (0)
+		                                                               \
+		TST_RET;                                                       \
+	})
 
-#define TST_EXP_FD_SILENT(SCALL, ...)	TST_EXP_POSITIVE_(SCALL, #SCALL, ##__VA_ARGS__)
+#define TST_EXP_FD_SILENT(SCALL, ...)                                          \
+	({                                                                     \
+		TST_EXP_POSITIVE_(SCALL, #SCALL, ##__VA_ARGS__);               \
+		TST_RET;                                                       \
+	})
 
 #define TST_EXP_FD(SCALL, ...)                                                 \
-	do {                                                                   \
+	({                                                                     \
 		TST_EXP_POSITIVE_(SCALL, #SCALL, ##__VA_ARGS__);               \
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
 
-#define TST_EXP_PID_SILENT(SCALL, ...)	TST_EXP_POSITIVE_(SCALL, #SCALL, ##__VA_ARGS__)
+#define TST_EXP_PID_SILENT(SCALL, ...)                                         \
+	({                                                                     \
+		TST_EXP_POSITIVE_(SCALL, #SCALL, ##__VA_ARGS__);               \
+		TST_RET;                                                       \
+	})
 
 #define TST_EXP_PID(SCALL, ...)                                                \
-	do {                                                                   \
+	({                                                                     \
 		TST_EXP_POSITIVE_(SCALL, #SCALL, ##__VA_ARGS__);               \
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
@@ -128,18 +143,20 @@ extern void *TST_RET_PTR;
 		                                                               \
 		TST_PASS = 1;                                                  \
 		                                                               \
+		TST_RET;                                                       \
 	} while (0)
 
 #define TST_EXP_VAL_SILENT(SCALL, VAL, ...) TST_EXP_VAL_SILENT_(SCALL, VAL, #SCALL, ##__VA_ARGS__)
 
 #define TST_EXP_VAL(SCALL, VAL, ...)                                           \
-	do {                                                                   \
+	({                                                                     \
 		TST_EXP_VAL_SILENT_(SCALL, VAL, #SCALL, ##__VA_ARGS__);        \
 		                                                               \
 		if (TST_PASS)                                                  \
 			TST_MSG_(TPASS, " passed", #SCALL, ##__VA_ARGS__);     \
-			                                                       \
-	} while(0)
+		                                                               \
+		TST_RET;                                                       \
+	})
 
 #define TST_EXP_PASS_SILENT_(SCALL, SSCALL, ...)                               \
 	do {                                                                   \
@@ -163,15 +180,21 @@ extern void *TST_RET_PTR;
                                                                                \
 	} while (0)
 
-#define TST_EXP_PASS_SILENT(SCALL, ...) TST_EXP_PASS_SILENT_(SCALL, #SCALL, ##__VA_ARGS__)
+#define TST_EXP_PASS_SILENT(SCALL, ...)                                        \
+	({                                                                     \
+		TST_EXP_PASS_SILENT_(SCALL, #SCALL, ##__VA_ARGS__);            \
+		TST_RET;                                                       \
+	})
 
 #define TST_EXP_PASS(SCALL, ...)                                               \
-	do {                                                                   \
+	({                                                                     \
 		TST_EXP_PASS_SILENT_(SCALL, #SCALL, ##__VA_ARGS__);            \
 		                                                               \
 		if (TST_PASS)                                                  \
 			TST_MSG_(TPASS, " passed", #SCALL, ##__VA_ARGS__);     \
-	} while (0)                                                            \
+		                                                               \
+		TST_RET;                                                       \
+	})
 
 #define TST_EXP_FAIL_SILENT_(PASS_COND, SCALL, SSCALL, ERRNO, ...)             \
 	do {                                                                   \
@@ -200,20 +223,24 @@ extern void *TST_RET_PTR;
 	} while (0)
 
 #define TST_EXP_FAIL(SCALL, ERRNO, ...)                                        \
-	do {                                                                   \
+	({                                                                     \
 		TST_EXP_FAIL_SILENT_(TST_RET == 0, SCALL, #SCALL,              \
 			ERRNO, ##__VA_ARGS__);                                 \
 		if (TST_PASS)                                                  \
 			TST_MSG_(TPASS | TTERRNO, " ", #SCALL, ##__VA_ARGS__); \
-	} while (0)
+		                                                               \
+		TST_RET;                                                       \
+	})
 
 #define TST_EXP_FAIL2(SCALL, ERRNO, ...)                                       \
-	do {                                                                   \
+	({                                                                     \
 		TST_EXP_FAIL_SILENT_(TST_RET >= 0, SCALL, #SCALL,              \
 			ERRNO, ##__VA_ARGS__);                                 \
 		if (TST_PASS)                                                  \
 			TST_MSG_(TPASS | TTERRNO, " ", #SCALL, ##__VA_ARGS__); \
-	} while (0)
+		                                                               \
+		TST_RET;                                                       \
+	})
 
 #define TST_EXP_FAIL_SILENT(SCALL, ERRNO, ...) \
 	TST_EXP_FAIL_SILENT_(TST_RET == 0, SCALL, #SCALL, ERRNO, ##__VA_ARGS__)
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
