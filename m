Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3469AC433F5
	for <ltp@archiver.kernel.org>; Thu, 17 Feb 2022 14:25:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 47DAC3CA0B4
	for <ltp@archiver.kernel.org>; Thu, 17 Feb 2022 15:25:35 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9B0D43C3206
 for <ltp@lists.linux.it>; Thu, 17 Feb 2022 15:25:24 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 579601A006EF
 for <ltp@lists.linux.it>; Thu, 17 Feb 2022 15:25:23 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0E4852198B
 for <ltp@lists.linux.it>; Thu, 17 Feb 2022 14:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1645107923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Sj3VsFV1qKhbXr614T8K+u7+3AeCIMsyGkjqvfM4/TE=;
 b=j1wXglAHesdVN3Kv1w6PKVq1aRWakyo2gHhxbO7tgmnQR54jlK1KNDtmaSDfFJWgyqrLtC
 i1fsJCYkd8HKINEdYKnDNH+UTvwL9WiwU+HIxwcWNgiX/fWf+ZxqtOEXcFwBVSW/hUHx9I
 1fxORjW6ztiiquTwcUBiZVIbXO0AG6o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1645107923;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Sj3VsFV1qKhbXr614T8K+u7+3AeCIMsyGkjqvfM4/TE=;
 b=w1S1LoQDF6fMpcMTgw5uJRPvgpyToUYYaKZzhcBlSghv/bYD/HQGwu8OXPpuJGuHnX9vaB
 Ed1X6gl0AukN2hCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ECFEB13C14
 for <ltp@lists.linux.it>; Thu, 17 Feb 2022 14:25:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id oKcWONJaDmL0OgAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 17 Feb 2022 14:25:22 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 17 Feb 2022 15:27:30 +0100
Message-Id: <20220217142730.19726-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] test_macros: TST_EXP_EXPR() add auto stringification
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

This unifies the behavior with the rest of the TST_EXP_*() macros that
auto-stringify their parameters in case that no format string is
supplied.

It's actually useful in cases where there is clear from the variables
what has been asserted such as:

static void run(void)
{
	siginfo_t infop;

	...

	TST_EXP_EXPR(infop.si_pid == child_pid);

	...
}

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/tst_test_macros.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
index 8893dbf0e..3b3b1b17e 100644
--- a/include/tst_test_macros.h
+++ b/include/tst_test_macros.h
@@ -211,7 +211,10 @@ extern void *TST_RET_PTR;
 #define TST_EXP_FAIL2_SILENT(SCALL, ERRNO, ...) \
 	TST_EXP_FAIL_SILENT_(TST_RET >= 0, SCALL, #SCALL, ERRNO, ##__VA_ARGS__)
 
-#define TST_EXP_EXPR(EXPR, FMT, ...)						\
-	tst_res_(__FILE__, __LINE__, (EXPR) ? TPASS : TFAIL, "Expect: " FMT, ##__VA_ARGS__);
+#define TST_EXP_EXPR_(EXPR, SEXPR, ...) \
+	tst_res_(__FILE__, __LINE__, (EXPR) ? TPASS : TFAIL, \
+		TST_FMT_("Expect: " TST_2_(dummy, ##__VA_ARGS__, SEXPR), __VA_ARGS__))
+
+#define TST_EXP_EXPR(EXPR, ...) TST_EXP_EXPR_(EXPR, #EXPR, ##__VA_ARGS__)
 
 #endif	/* TST_TEST_MACROS_H__ */
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
