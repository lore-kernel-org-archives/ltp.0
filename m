Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66765C19F2A
	for <ltp@archiver.kernel.org>; Thu, 11 Aug 2022 13:57:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 87DAC3C95ED
	for <ltp@archiver.kernel.org>; Thu, 11 Aug 2022 15:57:47 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9C21A3C925A
 for <ltp@lists.linux.it>; Thu, 11 Aug 2022 15:57:38 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CD8B11400DAD
 for <ltp@lists.linux.it>; Thu, 11 Aug 2022 15:57:37 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D591138C04;
 Thu, 11 Aug 2022 13:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1660226256; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GhXkyNzRBCq0HtZmPTF9rtsvBfxHGas3ro+ti1QagME=;
 b=2x0Rv3uN74nl9Z4YZJ1aq7kj5sUbN4zEvmAONh+9/qON3ZdRy31xBp3JIWbV42QYJfDhnc
 LrV80AAATsBVnkVCYInhGhMwCagi3DOqRMyT/rDf1MR82/MjLvjE1I3AczCDnYZfIBTkx4
 xkciSpVFLL1et5hmDQhzbPqjqLf1NXI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1660226256;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GhXkyNzRBCq0HtZmPTF9rtsvBfxHGas3ro+ti1QagME=;
 b=lg9JubnRPa+KSUhH0PoZBxApDY9zEDxDrtA6wp1+mQM/j1Dg0ZNQncVIDKVWGMLhKLqwfe
 A+8v2rCJ2rggrCCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 920CE1342A;
 Thu, 11 Aug 2022 13:57:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id CNpNINAK9WKmcwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 11 Aug 2022 13:57:36 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 11 Aug 2022 15:57:30 +0200
Message-Id: <20220811135731.2228-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220811135731.2228-1-pvorel@suse.cz>
References: <20220811135731.2228-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/2] tst_test_macros.h: Add TST_EXP_EQ_STR
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

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
new in v3

 include/tst_test_macros.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
index c8f7825c4..8cc959243 100644
--- a/include/tst_test_macros.h
+++ b/include/tst_test_macros.h
@@ -242,4 +242,14 @@ extern void *TST_RET_PTR;
 #define TST_EXP_EQ_SSZ(VAL_A, VAL_B) \
 		TST_EXP_EQ_(VAL_A, #VAL_A, VAL_B, #VAL_B, ssize_t, "%zi")
 
+#define TST_EXP_EQ_STR(STR_A, STR_B) do {\
+	if (strcmp(STR_A, STR_B)) { \
+		tst_res_(__FILE__, __LINE__, TFAIL, \
+			"'%s' != '%s'", STR_A, STR_B); \
+	} else { \
+		tst_res_(__FILE__, __LINE__, TPASS, \
+			"'%s' == '%s'", STR_A, STR_B); \
+	} \
+} while (0)
+
 #endif	/* TST_TEST_MACROS_H__ */
-- 
2.37.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
