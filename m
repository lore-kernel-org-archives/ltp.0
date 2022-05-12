Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 922B3C433EF
	for <ltp@archiver.kernel.org>; Thu, 12 May 2022 12:37:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F203C3CA9C5
	for <ltp@archiver.kernel.org>; Thu, 12 May 2022 14:37:15 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 082FF3C053F
 for <ltp@lists.linux.it>; Thu, 12 May 2022 14:36:06 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9A5661400759
 for <ltp@lists.linux.it>; Thu, 12 May 2022 14:36:05 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4ED041F897;
 Thu, 12 May 2022 12:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1652358965; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oBYaZ0/YuZB4LerHT2CzO5rxa/VLakq7AQNQ675Q7Ck=;
 b=EUa6jRNNMw6Hhmvzh9EMofvsTJKAyA6FkykpGK1Nd1EjnzDQdSd/R0VR3RjQYCFCWUmevH
 NOLVBUbmeBZjOeH/EgvQJm608Hu5BqEDuHgOAzA5APNbLVma3HEcWxNL+Q5cx33qtDzmgW
 9AHf4rv5cRaboQXFxoZSebjewA5TF4I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1652358965;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oBYaZ0/YuZB4LerHT2CzO5rxa/VLakq7AQNQ675Q7Ck=;
 b=fZV37i+hspUNhqbM4oYAB8l39tkPZHKlG44IOdxGMXaQ9BERYAXJh9N9u1+7ZaeEO5dxfA
 bY43H9lqLFSsEyAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3A0D513ABE;
 Thu, 12 May 2022 12:36:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id SHI+DTX/fGIXGgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 12 May 2022 12:36:05 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 12 May 2022 14:37:52 +0200
Message-Id: <20220512123816.24399-6-chrubis@suse.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220512123816.24399-1-chrubis@suse.cz>
References: <20220512123816.24399-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 05/29] cve/cve-2015-3290: Convert to runtime
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
 testcases/cve/cve-2015-3290.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/testcases/cve/cve-2015-3290.c b/testcases/cve/cve-2015-3290.c
index fd1abe136..f61d2809b 100644
--- a/testcases/cve/cve-2015-3290.c
+++ b/testcases/cve/cve-2015-3290.c
@@ -395,10 +395,6 @@ static void *child_thread(void *arg LTP_ATTRIBUTE_UNUSED)
 	return (void *)niter;
 }
 
-#define TIMEOUT		(180)
-#define TIME_TO_GIVEUP	(TIMEOUT - 5)
-#define TIMER_TYPE	CLOCK_MONOTONIC
-
 static void do_child(void)
 {
 	int i, ncpus;
@@ -415,7 +411,7 @@ static void do_child(void)
 	for (i = 0; i < ncpus; i++)
 		SAFE_PTHREAD_CREATE(&threads[i], NULL, child_thread, NULL);
 
-	sleep(TIME_TO_GIVEUP);
+	sleep(tst_remaining_runtime());
 	running = 0;
 
 	for (i = 0; i < ncpus; i++) {
@@ -468,7 +464,7 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.needs_checkpoints = 1,
 	.setup = setup,
-	.timeout = TIMEOUT,
+	.max_runtime = 180,
 	.test_all = run,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "9b6e6a8334d5"},
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
