Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C7F1C433F5
	for <ltp@archiver.kernel.org>; Thu,  3 Mar 2022 14:49:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7B6503CA336
	for <ltp@archiver.kernel.org>; Thu,  3 Mar 2022 15:49:18 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 23FEB3CA32A
 for <ltp@lists.linux.it>; Thu,  3 Mar 2022 15:48:16 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A13D52001D9
 for <ltp@lists.linux.it>; Thu,  3 Mar 2022 15:48:15 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3F44D218A9
 for <ltp@lists.linux.it>; Thu,  3 Mar 2022 14:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1646318895; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tn3X5M987hJm+Fe0DCF8nlHgc44ZcG7vvlLwnlJgjIM=;
 b=IcGSgZrCpFTIUUDVb8sbiJRVyw/QTxc7SLN73tvoBYislkwf2mZ2aaX2l36gkMii4bhZri
 00tiiSOJ45PvQlZxzWbbVDDURZBeLVgmlKmgPSOWXnmAqACkePnHIuzFBMBw4XYfTjnSAX
 dUQyFXj2S4LOfPGiSmS01aPB5Nha85c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1646318895;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tn3X5M987hJm+Fe0DCF8nlHgc44ZcG7vvlLwnlJgjIM=;
 b=7VAifuAi+6oGSMWpN91qTvRSyuiPRP9zkhso6XL/relhbvBh8Uar8XWLjo+SpOg6m0hXf2
 A4wyBH/OlW4ZXVAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2D1BA13AD9
 for <ltp@lists.linux.it>; Thu,  3 Mar 2022 14:48:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 2ARcCS/VIGIAAwAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 03 Mar 2022 14:48:15 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  3 Mar 2022 15:50:30 +0100
Message-Id: <20220303145032.21493-6-chrubis@suse.cz>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220303145032.21493-1-chrubis@suse.cz>
References: <20220303145032.21493-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 5/7] mem/ksm06: Move ksm restoration into the tst_test
 struct
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

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/mem/ksm/ksm06.c | 28 +++-------------------------
 1 file changed, 3 insertions(+), 25 deletions(-)

diff --git a/testcases/kernel/mem/ksm/ksm06.c b/testcases/kernel/mem/ksm/ksm06.c
index 61507b2aa..f5f7319d7 100644
--- a/testcases/kernel/mem/ksm/ksm06.c
+++ b/testcases/kernel/mem/ksm/ksm06.c
@@ -39,9 +39,6 @@
 #ifdef HAVE_NUMA_V2
 #include <numaif.h>
 
-static int run = -1;
-static int sleep_millisecs = -1;
-static int merge_across_nodes = -1;
 static unsigned long nr_pages = 100;
 
 static char *n_opt;
@@ -141,27 +138,6 @@ static void setup(void)
 
 	if (n_opt)
 		nr_pages = SAFE_STRTOUL(n_opt, 0, ULONG_MAX);
-
-	/* save the current value */
-	SAFE_FILE_SCANF(PATH_KSM "run", "%d", &run);
-	SAFE_FILE_SCANF(PATH_KSM "merge_across_nodes",
-			"%d", &merge_across_nodes);
-	SAFE_FILE_SCANF(PATH_KSM "sleep_millisecs",
-			"%d", &sleep_millisecs);
-}
-
-static void cleanup(void)
-{
-	if (merge_across_nodes != -1) {
-		FILE_PRINTF(PATH_KSM "merge_across_nodes",
-			    "%d", merge_across_nodes);
-	}
-
-	if (sleep_millisecs != -1)
-		FILE_PRINTF(PATH_KSM "sleep_millisecs", "%d", sleep_millisecs);
-
-	if (run != -1)
-		FILE_PRINTF(PATH_KSM "run", "%d", run);
 }
 
 static struct tst_test test = {
@@ -171,9 +147,11 @@ static struct tst_test test = {
 		{}
 	},
 	.setup = setup,
-	.cleanup = cleanup,
 	.save_restore = (const char * const[]) {
 		"?/sys/kernel/mm/ksm/max_page_sharing",
+		"?/sys/kernel/mm/ksm/run",
+		"?/sys/kernel/mm/ksm/merge_across_nodes",
+		"?/sys/kernel/mm/ksm/sleep_millisecs",
 		NULL,
 	},
 	.test_all = test_ksm,
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
