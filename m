Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5198C433EF
	for <ltp@archiver.kernel.org>; Thu, 12 May 2022 12:41:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 53FE33CA9E5
	for <ltp@archiver.kernel.org>; Thu, 12 May 2022 14:41:21 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3BA7F3CA9C5
 for <ltp@lists.linux.it>; Thu, 12 May 2022 14:36:17 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CE5A31000A09
 for <ltp@lists.linux.it>; Thu, 12 May 2022 14:36:16 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8DD2B1F460;
 Thu, 12 May 2022 12:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1652358976; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8+qKFPWiYWFF5BOwL+GLIoUmBuSXGTi/8+BYCK49/d4=;
 b=c2dB1G8IsYidRUpsil5PPvPpa/M2AMcY/6M+3qmgbLhfRGdWo5+ugzLU7B0zQBIjA4vv9Y
 XIeuVjpZ0x3pgXwhOJNjPy8ap3fHm8LpRwP6N1wVSKx84I0fz+Swo/O3dWTURubla3UUmR
 1WqHzarkazzUXpg3n7g0nOhB2ji6Pxg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1652358976;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8+qKFPWiYWFF5BOwL+GLIoUmBuSXGTi/8+BYCK49/d4=;
 b=yY26KJres5wQzJnl3kn+gRZPk8zD6ta68Gl8JOX4n7QLj4lp7jBd7i12pRCjnfctxikOi3
 HY7ORpxC8zcdwvCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7B02713ABE;
 Thu, 12 May 2022 12:36:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id AeQfHUD/fGJkGgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 12 May 2022 12:36:16 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 12 May 2022 14:38:14 +0200
Message-Id: <20220512123816.24399-28-chrubis@suse.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220512123816.24399-1-chrubis@suse.cz>
References: <20220512123816.24399-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 27/29] timer_test: Convert to runtime
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
Cc: automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/tst_timer_test.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/lib/tst_timer_test.c b/lib/tst_timer_test.c
index 32fa55c7c..ef9b24d11 100644
--- a/lib/tst_timer_test.c
+++ b/lib/tst_timer_test.c
@@ -420,6 +420,9 @@ static struct tst_option options[] = {
 
 static void parse_timer_opts(void)
 {
+	size_t i;
+	long long runtime_us = 0;
+
 	if (str_sleep_time) {
 		if (tst_parse_int(str_sleep_time, &sleep_time, 0, INT_MAX)) {
 			tst_brk(TBROK,
@@ -441,14 +444,17 @@ static void parse_timer_opts(void)
 		if (!sample_cnt)
 			sample_cnt = 500;
 
-		long long timeout = sleep_time * sample_cnt / 1000000;
-
-		tst_set_timeout(timeout + timeout/10);
+		runtime_us = sleep_time * sample_cnt;
 
 		test->test_all = single_timer_test;
 		test->test = NULL;
 		test->tcnt = 0;
+	} else {
+		for (i = 0; i < ARRAY_SIZE(tcases); i++)
+			runtime_us += tcases[i].usec * tcases[i].samples;
 	}
+
+	tst_set_max_runtime((runtime_us + runtime_us/10)/1000000);
 }
 
 struct tst_test *tst_timer_test_setup(struct tst_test *timer_test)
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
