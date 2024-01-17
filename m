Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1968C47DA7
	for <ltp@archiver.kernel.org>; Wed, 17 Jan 2024 10:18:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 052673CCCE5
	for <ltp@archiver.kernel.org>; Wed, 17 Jan 2024 11:18:09 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C87913CB05E
 for <ltp@lists.linux.it>; Wed, 17 Jan 2024 11:17:54 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 28123601A38
 for <ltp@lists.linux.it>; Wed, 17 Jan 2024 11:17:53 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 291E522255
 for <ltp@lists.linux.it>; Wed, 17 Jan 2024 10:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705486673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=rpZfknjo1D2pfAVVkQCC87usznkVdLhTmLMtoGmR/Vg=;
 b=cSBKjMF9GQUCFIlqTwB0igQ0Dt4I7HYUyS7dsewB7qeAuQl8bFKvXDTLMnmPycFfKDpSRa
 cexKsjkqpFQU7hELnhGI/17tL9f4/3rgyHsX4NerZyYPablLaLv7uJaV6sDctUvwITEyGZ
 +gFL4iGaWn2K7UvqluHE1McnRqyfUwE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705486673;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=rpZfknjo1D2pfAVVkQCC87usznkVdLhTmLMtoGmR/Vg=;
 b=tvu0RFJJNdG1vjPP1bpJSwg72mceQUvPKpYhDio26mS0YLPsnrUKNzXR/gYX3V259wYcKE
 ++5Cr8F9H/q+2mDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705486673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=rpZfknjo1D2pfAVVkQCC87usznkVdLhTmLMtoGmR/Vg=;
 b=cSBKjMF9GQUCFIlqTwB0igQ0Dt4I7HYUyS7dsewB7qeAuQl8bFKvXDTLMnmPycFfKDpSRa
 cexKsjkqpFQU7hELnhGI/17tL9f4/3rgyHsX4NerZyYPablLaLv7uJaV6sDctUvwITEyGZ
 +gFL4iGaWn2K7UvqluHE1McnRqyfUwE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705486673;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=rpZfknjo1D2pfAVVkQCC87usznkVdLhTmLMtoGmR/Vg=;
 b=tvu0RFJJNdG1vjPP1bpJSwg72mceQUvPKpYhDio26mS0YLPsnrUKNzXR/gYX3V259wYcKE
 ++5Cr8F9H/q+2mDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1673F13751
 for <ltp@lists.linux.it>; Wed, 17 Jan 2024 10:17:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iSSfBFGpp2XPLAAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 17 Jan 2024 10:17:53 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 17 Jan 2024 11:18:01 +0100
Message-ID: <20240117101801.12536-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [4.90 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 BROKEN_CONTENT_TYPE(1.50)[]; RCPT_COUNT_ONE(0.00)[1];
 RCVD_COUNT_THREE(0.00)[3]; TO_DN_NONE(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.00)[20.57%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] lib: TST_EXP_FAIL: Fix the *_ARR_() macros
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

This is basically the same fix as:
d7e5e102364b (tst_test_macros.h: fix "too many arguments")

The point is that the SCALL parameter has to be stringified in the first
pass otherwise it ends up expandend and as long as it contains coma the
number of parameters will increase breaking the printf() formatting
again.

Fixes: #1120

Fixes: 1cfe61428982 ("lib: TST_EXP_FAIL: Add array variants")
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/tst_test_macros.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
index 24fd324bf..d2e50a219 100644
--- a/include/tst_test_macros.h
+++ b/include/tst_test_macros.h
@@ -227,41 +227,41 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
 		}                                                              \
 	} while (0)
 
-#define TST_EXP_FAIL_ARR_(SCALL, EXP_ERRS, EXP_ERRS_CNT, ...)                  \
+#define TST_EXP_FAIL_ARR_(SCALL, SSCALL, EXP_ERRS, EXP_ERRS_CNT, ...)          \
 	do {                                                                   \
-		TST_EXP_FAIL_SILENT_(TST_RET == 0, SCALL, #SCALL,              \
+		TST_EXP_FAIL_SILENT_(TST_RET == 0, SCALL, SSCALL,              \
 			EXP_ERRS, EXP_ERRS_CNT, ##__VA_ARGS__);                \
 		if (TST_PASS)                                                  \
-			TST_MSG_(TPASS | TTERRNO, " ", #SCALL, ##__VA_ARGS__); \
+			TST_MSG_(TPASS | TTERRNO, " ", SSCALL, ##__VA_ARGS__); \
 	} while (0)
 
 #define TST_EXP_FAIL(SCALL, EXP_ERR, ...)                                      \
 	do {                                                                   \
 		int tst_exp_err__ = EXP_ERR;                                   \
-		TST_EXP_FAIL_ARR_(SCALL, &tst_exp_err__, 1,                    \
+		TST_EXP_FAIL_ARR_(SCALL, #SCALL, &tst_exp_err__, 1,            \
                                   ##__VA_ARGS__);                              \
 	} while (0)
 
 #define TST_EXP_FAIL_ARR(SCALL, EXP_ERRS, ...)                                 \
-		TST_EXP_FAIL_ARR_(SCALL, EXP_ERRS, ARRAY_SIZE(EXP_ERRS),       \
-                                  ##__VA_ARGS__);                              \
+		TST_EXP_FAIL_ARR_(SCALL, #SCALL, EXP_ERRS,                     \
+				  ARRAY_SIZE(EXP_ERRS), ##__VA_ARGS__);
 
-#define TST_EXP_FAIL2_ARR_(SCALL, EXP_ERRS, EXP_ERRS_CNT, ...)                 \
+#define TST_EXP_FAIL2_ARR_(SCALL, SSCALL, EXP_ERRS, EXP_ERRS_CNT, ...)         \
 	do {                                                                   \
-		TST_EXP_FAIL_SILENT_(TST_RET >= 0, SCALL, #SCALL,              \
+		TST_EXP_FAIL_SILENT_(TST_RET >= 0, SCALL, SSCALL,              \
 			EXP_ERRS, EXP_ERRS_CNT, ##__VA_ARGS__);                \
 		if (TST_PASS)                                                  \
-			TST_MSG_(TPASS | TTERRNO, " ", #SCALL, ##__VA_ARGS__); \
+			TST_MSG_(TPASS | TTERRNO, " ", SSCALL, ##__VA_ARGS__); \
 	} while (0)
 
 #define TST_EXP_FAIL2_ARR(SCALL, EXP_ERRS, ...)                                \
-		TST_EXP_FAIL2_ARR_(SCALL, EXP_ERRS, ARRAY_SIZE(EXP_ERRS),      \
-                                  ##__VA_ARGS__);                              \
+		TST_EXP_FAIL2_ARR_(SCALL, #SCALL, EXP_ERRS,                    \
+		                  ARRAY_SIZE(EXP_ERRS), ##__VA_ARGS__);
 
 #define TST_EXP_FAIL2(SCALL, EXP_ERR, ...)                                     \
 	do {                                                                   \
 		int tst_exp_err__ = EXP_ERR;                                   \
-		TST_EXP_FAIL2_ARR_(SCALL, &tst_exp_err__, 1,                   \
+		TST_EXP_FAIL2_ARR_(SCALL, #SCALL, &tst_exp_err__, 1,           \
                                   ##__VA_ARGS__);                              \
 	} while (0)
 
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
