Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE756C433EF
	for <ltp@archiver.kernel.org>; Tue,  3 May 2022 17:45:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 240C33CAA15
	for <ltp@archiver.kernel.org>; Tue,  3 May 2022 19:45:52 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 34BE13CA949
 for <ltp@lists.linux.it>; Tue,  3 May 2022 19:45:02 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2312160068E
 for <ltp@lists.linux.it>; Tue,  3 May 2022 19:45:02 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id ABD3A1F74D;
 Tue,  3 May 2022 17:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1651599901; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=na0FPhT9EPCmlE/WNsOPSdIb7yTQI0w3LASWMLEYwnk=;
 b=ABBWfCgpBvKIlDwhCwYyZAvDHXGijr0kyXFNJkB6SIJzQ0UEHyH3Su4nNVxjh6HFwlAvbR
 gfw5LZSv2hdbsczFln8baLy1xmrTk2Q1mjOUwdi38r7m8Zy15TCINfsvCSmmSlZKMluQ6C
 W5b8A6YalvAo/+1ZfdHMmsMxo06Td9M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1651599901;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=na0FPhT9EPCmlE/WNsOPSdIb7yTQI0w3LASWMLEYwnk=;
 b=rNeo3cu1EN+afV1lHO3GSxtSdksR4RQIS+59WH+g7wFYiHrd6GC0zlgdeh4IQOKzwtuMsh
 fo6j+tgEkWxsAWAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 966DC13ABE;
 Tue,  3 May 2022 17:45:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id x4VgIx1qcWLWPQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 03 May 2022 17:45:01 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  3 May 2022 19:46:51 +0200
Message-Id: <20220503174718.21205-4-chrubis@suse.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503174718.21205-1-chrubis@suse.cz>
References: <20220503174718.21205-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 03/30] mtest06/mmap3: Convert to runtime
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
 testcases/kernel/mem/mtest06/mmap3.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/mem/mtest06/mmap3.c b/testcases/kernel/mem/mtest06/mmap3.c
index 23609752f..461131e15 100644
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
@@ -184,11 +176,11 @@ static struct tst_test test = {
 		{"l:", &str_loops, "Number of map-write-unmap loops"},
 		{"n:", &str_threads, "Number of worker threads"},
 		{"p", &map_private, "Turns on MAP_PRIVATE (default MAP_SHARED)"},
-		{"x:", &str_exec_time, "float Execution time in hours (default 24H)"},
 		{}
 	},
 	.needs_tmpdir = 1,
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = test_mmap,
+	.max_iteration_runtime = 86400,
 };
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
