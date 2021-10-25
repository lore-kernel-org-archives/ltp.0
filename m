Return-Path: <SRS0=uLVz=PN=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFE8C433F5
	for <ltp@archiver.kernel.org>; Mon, 25 Oct 2021 16:01:20 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57CF560C49
	for <ltp@archiver.kernel.org>; Mon, 25 Oct 2021 16:01:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 57CF560C49
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 192293C65E7
	for <ltp@archiver.kernel.org>; Mon, 25 Oct 2021 18:01:18 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 720103C65EF
 for <ltp@lists.linux.it>; Mon, 25 Oct 2021 18:00:48 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 04200601AC5
 for <ltp@lists.linux.it>; Mon, 25 Oct 2021 18:00:47 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 50E8B21940
 for <ltp@lists.linux.it>; Mon, 25 Oct 2021 16:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1635177647; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ogqpj/hcPQ8Xsd1GB0Ljlg9NtIWWmznVKFqR/iuE7W8=;
 b=J3TvkBRTegX1eEahhf+ZFEF/iNQql2Oq2SvWy9eC8fS2jxReN4S8qn9fktKXxmODt4yVnm
 oOu7UUykeKcC3s4Xmr3nWltLYI1ZjDnLptSa34IxQr/e10HYSvfszbBg2vpOfHbeQcZMIA
 +zv+d7xlwgHDVuSQJAyt4TpY6F++tQM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1635177647;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ogqpj/hcPQ8Xsd1GB0Ljlg9NtIWWmznVKFqR/iuE7W8=;
 b=kv0b27WhX+Za5rRtfu88YUKlZAXTZ5OhyNyBzcdpviLqhv21HVqJ5O6ZJudhhpWcVuA04x
 yJjeznpa+kZAqZAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3A33313C39
 for <ltp@lists.linux.it>; Mon, 25 Oct 2021 16:00:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id LyMaDq/UdmGbLAAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 25 Oct 2021 16:00:47 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 25 Oct 2021 18:01:31 +0200
Message-Id: <20211025160134.9283-4-chrubis@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211025160134.9283-1-chrubis@suse.cz>
References: <20211025160134.9283-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/6] mtest06/mmap3: Convert to tst_remaining_runtime()
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
 runtest/mm                           |  2 +-
 testcases/kernel/mem/mtest06/mmap3.c | 12 ++----------
 2 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/runtest/mm b/runtest/mm
index 6537666a9..4ecb61f24 100644
--- a/runtest/mm
+++ b/runtest/mm
@@ -16,7 +16,7 @@ mtest01w mtest01 -p80 -w
 mtest05   mmstress
 mtest06   mmap1
 mtest06_2 mmap2 -x 0.002 -a -p
-mtest06_3 mmap3 -x 0.002 -p
+mtest06_3 mmap3 -p
 # Remains diabled till the infinite loop problem is solved
 #mtest-6_4 shmat1 -x 0.00005
 
diff --git a/testcases/kernel/mem/mtest06/mmap3.c b/testcases/kernel/mem/mtest06/mmap3.c
index c18bd2f56..c6d853f98 100644
--- a/testcases/kernel/mem/mtest06/mmap3.c
+++ b/testcases/kernel/mem/mtest06/mmap3.c
@@ -23,11 +23,9 @@
 static char *str_loops;
 static char *str_threads;
 static char *map_private;
-static char *str_exec_time;
 
 static int loops = 1000;
 static int threads = 40;
-static float exec_time = 24;
 
 static volatile int sig_caught;
 static int threads_running;
@@ -109,7 +107,7 @@ static void test_mmap(void)
 	long i;
 	pthread_t thids[threads];
 
-	alarm(exec_time * 3600);
+	alarm(tst_remaining_runtime());
 
 	while (!sig_caught) {
 		for (i = 0; i < threads; i++) {
@@ -138,11 +136,6 @@ static void setup(void)
 	if (tst_parse_int(str_threads, &threads, 1, INT_MAX))
 		tst_brk(TBROK, "Invalid number of threads '%s'", str_threads);
 
-	if (tst_parse_float(str_exec_time, &exec_time, 0.0005, 9000))
-		tst_brk(TBROK, "Invalid execution time '%s'", str_exec_time);
-
-	tst_set_timeout(exec_time * 3600 + 300);
-
 	SAFE_SIGNAL(SIGALRM, sig_handler);
 	SAFE_SIGNAL(SIGBUS, sig_handler);
 	SAFE_SIGNAL(SIGSEGV, sig_handler);
@@ -155,7 +148,6 @@ static void setup(void)
 	tst_res(TINFO, "Number of loops %i", loops);
 	tst_res(TINFO, "Number of threads %i", threads);
 	tst_res(TINFO, "MAP_PRIVATE = %i", map_private ? 1 : 0);
-	tst_res(TINFO, "Execution time %fH", exec_time);
 }
 
 static void cleanup(void)
@@ -184,10 +176,10 @@ static struct tst_test test = {
 		{"l:", &str_loops, "-l uint  Number of map-write-unmap loops"},
 		{"n:", &str_threads, "-n uint  Number of worker threads"},
 		{"p", &map_private, "-p       Turns on MAP_PRIVATE (default MAP_SHARED)"},
-		{"x:", &str_exec_time, "-x float Execution time in hours (default 24H)"},
 		{}
 	},
 	.needs_tmpdir = 1,
+	.max_runtime = 10,
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = test_mmap,
-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
