Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2366C433F5
	for <ltp@archiver.kernel.org>; Tue,  3 May 2022 17:45:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 16B033CA98D
	for <ltp@archiver.kernel.org>; Tue,  3 May 2022 19:45:16 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0E0E53CA949
 for <ltp@lists.linux.it>; Tue,  3 May 2022 19:45:01 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 82CB21000958
 for <ltp@lists.linux.it>; Tue,  3 May 2022 19:45:01 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 269E6210F4;
 Tue,  3 May 2022 17:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1651599901; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l3byiRdZ0U7PqFI8g9i52LJu1T2zjJyOEJ5tDB2PXyA=;
 b=xL7fig5keGrr/VFtV/apQ4X5yLLSb8kjG/P+1iUiPruBcIoth/7DKABcG4hkvNmBoPoK5f
 R3cOjimJVk0NKy6Wm8JUEzzk6n/5rK0BffaKvJZh9/JYcHm3LSzTqU5zS+8kobnLMRFnQe
 8V3BOZ3FmusrNr+yu6WG3Y1iiO3lyPY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1651599901;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l3byiRdZ0U7PqFI8g9i52LJu1T2zjJyOEJ5tDB2PXyA=;
 b=fTNA2G3LznqGjgUWC16CBmTAL4uXZ1irYdgtrde1iiyvF8qWwM3Hxy9OHFnCeRR7NRBSZa
 s/VHR7/fyPox+6AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 06F9713ABE;
 Tue,  3 May 2022 17:45:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id JUZwAB1qcWLTPQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 03 May 2022 17:45:01 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  3 May 2022 19:46:50 +0200
Message-Id: <20220503174718.21205-3-chrubis@suse.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503174718.21205-1-chrubis@suse.cz>
References: <20220503174718.21205-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 02/30] mtest06/mmap1: Convert to runtime
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
 testcases/kernel/mem/mtest06/mmap1.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/testcases/kernel/mem/mtest06/mmap1.c b/testcases/kernel/mem/mtest06/mmap1.c
index 10c47c35c..72506c37b 100644
--- a/testcases/kernel/mem/mtest06/mmap1.c
+++ b/testcases/kernel/mem/mtest06/mmap1.c
@@ -42,10 +42,8 @@
 
 static int file_size = 1024;
 static int num_iter = 5000;
-static float exec_time = 0.05; /* default is 3 min */
 
 static void *distant_area;
-static char *str_exec_time;
 static jmp_buf jmpbuf;
 static volatile unsigned char *map_address;
 static unsigned long page_sz;
@@ -206,17 +204,10 @@ static void setup(void)
 	SAFE_MUNMAP(distant_area, distant_mmap_size);
 	distant_area += distant_mmap_size / 2;
 
-	if (tst_parse_float(str_exec_time, &exec_time, 0, FLT_MAX)) {
-		tst_brk(TBROK, "Invalid number for exec_time '%s'",
-			str_exec_time);
-	}
-
 	sigptr.sa_sigaction = sig_handler;
 	sigemptyset(&sigptr.sa_mask);
 	sigptr.sa_flags = SA_SIGINFO | SA_NODEFER;
 	SAFE_SIGACTION(SIGSEGV, &sigptr, NULL);
-
-	tst_set_timeout((int)(exec_time * 3600));
 }
 
 static void run(void)
@@ -224,8 +215,8 @@ static void run(void)
 	pthread_t thid[2];
 	int start, last_update;
 
-	start = last_update = tst_timeout_remaining();
-	while (tst_timeout_remaining() > STOP_THRESHOLD) {
+	start = last_update = tst_remaining_runtime();
+	while (tst_remaining_runtime()) {
 		int fd = mkfile(file_size);
 
 		tst_atomic_store(0, &mapcnt);
@@ -240,11 +231,11 @@ static void run(void)
 
 		close(fd);
 
-		if (last_update - tst_timeout_remaining() >= PROGRESS_SEC) {
-			last_update = tst_timeout_remaining();
+		if (last_update - tst_remaining_runtime() >= PROGRESS_SEC) {
+			last_update = tst_remaining_runtime();
 			tst_res(TINFO, "[%03d] mapped: %lu, sigsegv hit: %lu, "
 				"threads spawned: %lu",
-				start - tst_timeout_remaining(),
+				start - last_update,
 				map_count, mapped_sigsegv_count,
 				threads_spawned);
 			tst_res(TINFO, "      repeated_reads: %ld, "
@@ -258,9 +249,6 @@ static void run(void)
 static struct tst_test test = {
 	.test_all = run,
 	.setup = setup,
-	.options = (struct tst_option[]) {
-		{"x:", &str_exec_time, "Exec time (hours)"},
-		{}
-	},
+	.max_iteration_runtime = 180,
 	.needs_tmpdir = 1,
 };
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
