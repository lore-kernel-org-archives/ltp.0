Return-Path: <SRS0=uLVz=PN=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D74C433EF
	for <ltp@archiver.kernel.org>; Mon, 25 Oct 2021 16:01:51 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AE0B60EB1
	for <ltp@archiver.kernel.org>; Mon, 25 Oct 2021 16:01:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8AE0B60EB1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 182303C66DA
	for <ltp@archiver.kernel.org>; Mon, 25 Oct 2021 18:01:49 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 551BE3C66F0
 for <ltp@lists.linux.it>; Mon, 25 Oct 2021 18:00:49 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CCE226010BE
 for <ltp@lists.linux.it>; Mon, 25 Oct 2021 18:00:48 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 705541FD65
 for <ltp@lists.linux.it>; Mon, 25 Oct 2021 16:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1635177648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HutqMdWpPF5ZfnRDAJT7ekVvi3VIScKvVEvAKlwKlek=;
 b=Ez69jnkSwr87Nf/s50YdLaU7TNlWw9s4OXal655JQZiMGRGEvRXNR1hypuoJza2h8Wds/U
 w6JPoDcLiA8sZ6xHTJKTIHRKRdhPHgtklUys1VtESopUYOefYa6phWOBejQ74gSMPtpQRx
 Y87tdcQ3WZcjVdrwRIuumii9SwJiA+Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1635177648;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HutqMdWpPF5ZfnRDAJT7ekVvi3VIScKvVEvAKlwKlek=;
 b=6y1J0ClrjFadEanyOf0AogGMWO+4LgdAEHAq8bpkZk03ZK+CIeQjtIvAIgB+Z1IC4+iGIN
 GDQFoemJG0D6vdCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5896A13C39
 for <ltp@lists.linux.it>; Mon, 25 Oct 2021 16:00:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id OQWWE7DUdmGiLAAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 25 Oct 2021 16:00:48 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 25 Oct 2021 18:01:33 +0200
Message-Id: <20211025160134.9283-6-chrubis@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211025160134.9283-1-chrubis@suse.cz>
References: <20211025160134.9283-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 5/6] cve-2015-3290: convert tst_remining_runtime()
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
 testcases/cve/cve-2015-3290.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/testcases/cve/cve-2015-3290.c b/testcases/cve/cve-2015-3290.c
index 6c4fd57ac..9eb7127df 100644
--- a/testcases/cve/cve-2015-3290.c
+++ b/testcases/cve/cve-2015-3290.c
@@ -394,10 +394,6 @@ static void *child_thread(void *arg LTP_ATTRIBUTE_UNUSED)
 	return (void *)niter;
 }
 
-#define TIMEOUT		(180)
-#define TIME_TO_GIVEUP	(TIMEOUT - 5)
-#define TIMER_TYPE	CLOCK_MONOTONIC
-
 static void do_child(void)
 {
 	int i, ncpus;
@@ -414,7 +410,7 @@ static void do_child(void)
 	for (i = 0; i < ncpus; i++)
 		SAFE_PTHREAD_CREATE(&threads[i], NULL, child_thread, NULL);
 
-	sleep(TIME_TO_GIVEUP);
+	sleep(tst_remaining_runtime());
 	running = 0;
 
 	for (i = 0; i < ncpus; i++) {
@@ -467,7 +463,7 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.needs_checkpoints = 1,
 	.setup = setup,
-	.timeout = TIMEOUT,
+	.max_runtime = 180,
 	.test_all = run,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "9b6e6a8334d5"},
-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
