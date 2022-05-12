Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2977CC433EF
	for <ltp@archiver.kernel.org>; Thu, 12 May 2022 12:38:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 62FB03CA9D6
	for <ltp@archiver.kernel.org>; Thu, 12 May 2022 14:38:39 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1F58B3CA9DC
 for <ltp@lists.linux.it>; Thu, 12 May 2022 14:36:10 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8889F200A1F
 for <ltp@lists.linux.it>; Thu, 12 May 2022 14:36:09 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 47F3421C73;
 Thu, 12 May 2022 12:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1652358969; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8JYq5q7BsApT/WJCp8sCliar3lozmuD9uaPIxkjl0gQ=;
 b=MSQpiWaesX+EG0Vbb625mE2/DttBC2hBL/91quwIfRDSGMFTCHSnT/lk9bfdhM08T7bXvx
 0QK8gOZWNscXLGWPfOhVhV65qF8tkY/t4a8xnzwXsZFjmE12xwj0XZZi2aynblZi3NKhkJ
 1asul5bi0Cuen1qT3cvh6ra0BvGCriA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1652358969;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8JYq5q7BsApT/WJCp8sCliar3lozmuD9uaPIxkjl0gQ=;
 b=lnS6zKH2zY0PMK6EGixkPrzMJjTxA8FJYinESa4tUkqYLRTNRJMuS1oUfj0e0Lqzffp3VD
 8CM4Yr8vNoRdVdCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3491113ABE;
 Thu, 12 May 2022 12:36:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id DbAaDDn/fGI5GgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 12 May 2022 12:36:09 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 12 May 2022 14:38:00 +0200
Message-Id: <20220512123816.24399-14-chrubis@suse.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220512123816.24399-1-chrubis@suse.cz>
References: <20220512123816.24399-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 13/29] syscalls/perf_event_open03: Convert to
 runtime
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
 .../syscalls/perf_event_open/perf_event_open03.c  | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/perf_event_open/perf_event_open03.c b/testcases/kernel/syscalls/perf_event_open/perf_event_open03.c
index 6dffc8272..999c8aa22 100644
--- a/testcases/kernel/syscalls/perf_event_open/perf_event_open03.c
+++ b/testcases/kernel/syscalls/perf_event_open/perf_event_open03.c
@@ -25,7 +25,7 @@
 
 const int iterations = 12000000;
 static int fd = -1;
-static int timeout;
+static int runtime;
 
 static void setup(void)
 {
@@ -43,12 +43,12 @@ static void setup(void)
 	SAFE_FILE_SCANF(INTEL_PT_PATH, "%d", &ev.type);
 	fd = perf_event_open(&ev, getpid(), -1, -1, 0);
 
-	timeout = tst_timeout_remaining();
+	runtime = tst_remaining_runtime();
 }
 
 /*
  * Check how fast we can do the iterations after 5 seconds of runtime.
- * If the rate is too small to complete for current timeout then
+ * If the rate is too small to complete for current runtime then
  * stop the test.
  */
 static void check_progress(int i)
@@ -67,11 +67,11 @@ static void check_progress(int i)
 	if (elapsed_ms > 5000) {
 		iter_per_ms = (float) i / elapsed_ms;
 		tst_res(TINFO, "rate: %f iters/ms", iter_per_ms);
-		tst_res(TINFO, "needed rate for current test timeout: %f iters/ms",
-			(float) iterations / (timeout * 1000));
+		tst_res(TINFO, "needed rate for current test runtime: %f iters/ms",
+			(float) iterations / (runtime * 1000));
 
-		if (iter_per_ms * 1000 * (timeout - 1) < iterations)
-			tst_brk(TCONF, "System too slow to complete test in specified timeout");
+		if (iter_per_ms * 1000 * (runtime - 1) < iterations)
+			tst_brk(TCONF, "System too slow to complete test in specified runtime");
 	}
 }
 
@@ -108,6 +108,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.needs_root = 1,
+	.max_runtime = 300,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "7bdb157cdebb"},
 		{"CVE", "2020-25704"},
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
