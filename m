Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E6C7ECAAD1
	for <ltp@archiver.kernel.org>; Wed, 31 Aug 2022 09:21:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AE4113CA6CE
	for <ltp@archiver.kernel.org>; Wed, 31 Aug 2022 11:21:03 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BB67B3CA0B0
 for <ltp@lists.linux.it>; Wed, 31 Aug 2022 11:20:42 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B8B1E60091A
 for <ltp@lists.linux.it>; Wed, 31 Aug 2022 11:20:41 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8E0CB1FD62;
 Wed, 31 Aug 2022 09:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1661937640; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=QouJ21AA3tS7DzhWtAqpZKuYUVYnLD7fT+SQ4aqUYmQ=;
 b=a+T+LW4olIUxP6COupNMWiPJB2S44bmdeR9P1sBkrSIZNMYMLRT2prY+OtFx9udclYXzq3
 sJ3rgSuBl/XlT+KtmjANDAhffx0EbAbVrbdk8EMuHPTUOClz5xgqxjwWA3EJArPXltw+FA
 MRNZfnblJ2Kccq2JzPLCJTVPGVfvYrU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1661937640;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=QouJ21AA3tS7DzhWtAqpZKuYUVYnLD7fT+SQ4aqUYmQ=;
 b=GomYHpL1aXzjATrW5MkqIq/RhhH5L09U052JCrMNoTX3v7Mxb8nGxp01PrSA2dDDdJgp8O
 DJK+GARVz8T06gAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 566E81332D;
 Wed, 31 Aug 2022 09:20:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id fcWnE+gnD2ONQgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 31 Aug 2022 09:20:40 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 31 Aug 2022 11:20:35 +0200
Message-Id: <20220831092036.20779-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] include: Move stringification macros to
 tst_common.h
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

tst_common.h contains useful macros not directly related to test macros.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/tst_common.h      | 4 ++++
 include/tst_test_macros.h | 3 ---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/tst_common.h b/include/tst_common.h
index fd7a900d4..520cca72c 100644
--- a/include/tst_common.h
+++ b/include/tst_common.h
@@ -83,4 +83,8 @@
 #define TST_RES_SUPPORTS_TCONF_TFAIL_TINFO_TPASS_TWARN(condition) \
 	TST_BUILD_BUG_ON(condition)
 
+/* stringification */
+#define TST_TO_STR_(s) #s
+#define TST_TO_STR(s) TST_TO_STR_(s)
+
 #endif /* TST_COMMON_H__ */
diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
index c8f7825c4..2e7b7871c 100644
--- a/include/tst_test_macros.h
+++ b/include/tst_test_macros.h
@@ -36,9 +36,6 @@ extern void *TST_RET_PTR;
 
 #define TST_2_(_1, _2, ...) _2
 
-#define TST_TO_STR_(s) #s
-#define TST_TO_STR(s) TST_TO_STR_(s)
-
 #define TST_FMT_(FMT, _1, ...) FMT, ##__VA_ARGS__
 
 #define TST_MSG_(RES, FMT, SCALL, ...) \
-- 
2.37.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
