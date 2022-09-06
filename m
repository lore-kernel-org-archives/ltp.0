Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BBB4C38145
	for <ltp@archiver.kernel.org>; Tue,  6 Sep 2022 09:26:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6D4D23CA68B
	for <ltp@archiver.kernel.org>; Tue,  6 Sep 2022 11:26:31 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1B34F3C93EF
 for <ltp@lists.linux.it>; Tue,  6 Sep 2022 11:26:21 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 115FE1001169
 for <ltp@lists.linux.it>; Tue,  6 Sep 2022 11:26:20 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 689331F9B7;
 Tue,  6 Sep 2022 09:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1662456380; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rH8KUEbLq3ibqMYMQQJxjZ/H5aA+IpDVRf58vriGRXQ=;
 b=D5k5HYvZDpLJ2Fwu8EN1xdNYE6cfVBtM/u7/8pxksv78hmmMnrAWSW74/vZq3QTuCPNBlA
 9jtxBb8q1rKP7amVb97UdX5N1wPiYTM20wTvbt0dn3kSU/kSDzSergSppHWeun9dvKBvwp
 xyzNgKEdtLBJhSd1F4iMqQmkIFJotcc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1662456380;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rH8KUEbLq3ibqMYMQQJxjZ/H5aA+IpDVRf58vriGRXQ=;
 b=PXThTQ3+z4//M6JSBh3V0xhRq8/IeuaxhJGKXtPUbXaqq0O55C1we/uRaWP8ZcUo2T9XBW
 Tc38qCC4D4XHURBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3486513A93;
 Tue,  6 Sep 2022 09:26:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id eJ5HCzwSF2NTawAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 06 Sep 2022 09:26:20 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  6 Sep 2022 11:26:13 +0200
Message-Id: <20220906092615.15116-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220906092615.15116-1-pvorel@suse.cz>
References: <20220906092615.15116-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] tst_test_macros: Add TST_EXP_FD_ERRNO
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
Cc: Jan Kara <jack@suse.cz>, Matthew Bobrowski <repnop@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Combine TST_EXP_FD() and TST_EXP_FAIL().

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/tst_test_macros.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
index 2e7b7871c..a2dfaac13 100644
--- a/include/tst_test_macros.h
+++ b/include/tst_test_macros.h
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2015-2020 Cyril Hrubis <chrubis@suse.cz>
+ * Copyright (c) Linux Test Project, 2021-2022
  */
 
 #ifndef TST_TEST_MACROS_H__
@@ -93,6 +94,15 @@ extern void *TST_RET_PTR;
 				#SCALL, ##__VA_ARGS__);                        \
 	} while (0)
 
+#define TST_EXP_FD_ERRNO(SCALL, ERRNO, ...)                                    \
+	do {                                                                   \
+		if (ERRNO)                                                     \
+			TST_EXP_FAIL(SCALL, ERRNO, ##__VA_ARGS__);             \
+		else                                                           \
+			TST_EXP_FD(SCALL, ##__VA_ARGS__);                      \
+		                                                               \
+	} while (0)
+
 #define TST_EXP_PID_SILENT(SCALL, ...)	TST_EXP_POSITIVE_(SCALL, #SCALL, ##__VA_ARGS__)
 
 #define TST_EXP_PID(SCALL, ...)                                                \
-- 
2.37.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
