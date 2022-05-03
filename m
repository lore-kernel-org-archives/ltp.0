Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F1B3C433F5
	for <ltp@archiver.kernel.org>; Tue,  3 May 2022 17:46:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A411D3CAA5C
	for <ltp@archiver.kernel.org>; Tue,  3 May 2022 19:46:16 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0E4693CA94E
 for <ltp@lists.linux.it>; Tue,  3 May 2022 19:45:04 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9B3831000955
 for <ltp@lists.linux.it>; Tue,  3 May 2022 19:45:03 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4D06421875;
 Tue,  3 May 2022 17:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1651599903; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oVXepiHFa6P1201cZDt51HfQtjTvBX4in+bdW9iieGU=;
 b=rtbemKUmH4YfT6VMZI++OQjW9merzpnx1QqSg3y24UEsDp7jixBmYwH+Xv/3vn34DILcgR
 +iRf004t6SqLYkdV1wCmWa+MPWMbPsL+5NlaZA7mTCYUGaERIalkSoePJx9KN9TAmIqQ8t
 U/A+Dxjj0LclHsPLtH0yPJt2Huiecpk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1651599903;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oVXepiHFa6P1201cZDt51HfQtjTvBX4in+bdW9iieGU=;
 b=a9hV5Qw6McYPCNzFqAv+tSMGtPUVq5GYZf5P1GqHQ1iPKRJu6Wdu6v0UPL1AVuyM4bKMD+
 q1ifC8bUVaQ1JNAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3CB2F13ABE;
 Tue,  3 May 2022 17:45:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id KG6eDR9qcWLuPQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 03 May 2022 17:45:03 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  3 May 2022 19:46:53 +0200
Message-Id: <20220503174718.21205-6-chrubis@suse.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503174718.21205-1-chrubis@suse.cz>
References: <20220503174718.21205-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 05/30] cve/cve-2015-3290: Convert to runtime
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
index fd1abe136..91fe813eb 100644
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
+	.max_iteration_runtime = 180,
 	.test_all = run,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "9b6e6a8334d5"},
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
