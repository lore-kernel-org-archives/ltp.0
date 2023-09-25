Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 219E0CE7A95
	for <ltp@archiver.kernel.org>; Mon, 25 Sep 2023 15:13:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5CBB63CF2BF
	for <ltp@archiver.kernel.org>; Mon, 25 Sep 2023 17:13:57 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3BB443CE247
 for <ltp@lists.linux.it>; Mon, 25 Sep 2023 17:13:26 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 46F751400F50
 for <ltp@lists.linux.it>; Mon, 25 Sep 2023 17:13:25 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F217021858;
 Mon, 25 Sep 2023 15:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695654804; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aU1WKHfsjZLxi5TDJFegII4GmH1t6GQYcwfPrK4qpLc=;
 b=tN3nHxW2vj0kN7Ol5jtDuDTZPf2cEauMI9Llxmd1rG61VGk25kcyFu1UqiiV/OmmVS2Ebq
 k5vq+T5sUN+Shlrjm/mGYz2W0Il0XAuTBjeVFE0BUE1nKUgvxenv+ZT9vNq6h6p3TLhDnC
 Li9HTfIWWcAHEPq2XPEf/H1JVH6jcAQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695654804;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aU1WKHfsjZLxi5TDJFegII4GmH1t6GQYcwfPrK4qpLc=;
 b=wGxVGMTkSL42PPK8/4Gszo07zC1RDRTu2xmioGKn08iYqTbWMkoxY/ut3z5ocNwX4/ASqL
 qoY6G8ofVwDDGoDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B981A13580;
 Mon, 25 Sep 2023 15:13:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id UHqWK5SjEWXHTgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 25 Sep 2023 15:13:24 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 25 Sep 2023 17:13:19 +0200
Message-Id: <20230925151319.87688-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230925151319.87688-1-pvorel@suse.cz>
References: <20230925151319.87688-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC][PATCH 3/3] lib/tst_test.c: Print failure hints also for
 TBROK
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Some kernel/libc bugs are not causing TFAIL, but also TBROK,
e.g. clone04 failure on musl, which does:
tst_test.c:1632: TBROK: Test killed by SIGSEGV!

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/tst_test.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 179f697b7..0dec00be4 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -880,8 +880,10 @@ static void do_exit(int ret)
 		if (results->warnings)
 			ret |= TWARN;
 
-		if (results->broken)
+		if (results->broken) {
 			ret |= TBROK;
+			print_failure_hints();
+		}
 
 		fprintf(stderr, "\nSummary:\n");
 		fprintf(stderr, "passed   %d\n", results->passed);
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
