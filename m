Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2656C433EF
	for <ltp@archiver.kernel.org>; Tue,  3 May 2022 17:46:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 635963CAA3A
	for <ltp@archiver.kernel.org>; Tue,  3 May 2022 19:46:03 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3DCAD3CA94A
 for <ltp@lists.linux.it>; Tue,  3 May 2022 19:45:03 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D4F95600700
 for <ltp@lists.linux.it>; Tue,  3 May 2022 19:45:02 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 92DF821872;
 Tue,  3 May 2022 17:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1651599902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SmMlMt9FuzVniuKZ4bMUYl5uGry3oCLmPOjzocf6Yck=;
 b=nBiTBKM7sxB3uCWulbLGds9jVyemqY1NPw4beEKV1mXrOtk3k7YOp6Kx39a2YTg/4WfROK
 U8k8/FImzC3xN2VN8VBG5f3A+HjPBWOPojWNSF9mp07RXBOeVHPANUqSMxZWHFkoRP6Fm2
 E9Yd4/BgWaKNCcSpl+xInGpmEC3SsGU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1651599902;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SmMlMt9FuzVniuKZ4bMUYl5uGry3oCLmPOjzocf6Yck=;
 b=Q5gzenTdwSpLd1QvetV3EmaDqvIv9YfhyGzYvJkd9Sd8ZmvaHa2A5WG0FH0hzv0RSHNV55
 l/zDh8fk2EDnooCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7550213ABE;
 Tue,  3 May 2022 17:45:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 27k3Fx5qcWLrPQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 03 May 2022 17:45:02 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  3 May 2022 19:46:52 +0200
Message-Id: <20220503174718.21205-5-chrubis@suse.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503174718.21205-1-chrubis@suse.cz>
References: <20220503174718.21205-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 04/30] mtest01/mtest01: Convert to runtime
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
 testcases/kernel/mem/mtest01/mtest01.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/mem/mtest01/mtest01.c b/testcases/kernel/mem/mtest01/mtest01.c
index 20cb95191..2991d3d2e 100644
--- a/testcases/kernel/mem/mtest01/mtest01.c
+++ b/testcases/kernel/mem/mtest01/mtest01.c
@@ -41,8 +41,6 @@
 #define ALLOC_THRESHOLD		(6*FIVE_HUNDRED_MB)
 #endif
 
-#define STOP_THRESHOLD 15	/* seconds remaining before reaching timeout */
-
 static pid_t *pid_list;
 static sig_atomic_t children_done;
 static int max_pids;
@@ -137,6 +135,7 @@ static void child_loop_alloc(unsigned long long alloc_bytes)
 {
 	unsigned long bytecount = 0;
 	char *mem;
+	int runtime_rem;
 
 	tst_res(TINFO, "... child %d starting", getpid());
 
@@ -153,12 +152,15 @@ static void child_loop_alloc(unsigned long long alloc_bytes)
 		if (bytecount >= alloc_bytes)
 			break;
 	}
+
+	runtime_rem = tst_remaining_runtime();
+
 	if (dowrite)
 		tst_res(TINFO, "... [t=%d] %lu bytes allocated and used in child %d",
-				tst_timeout_remaining(), bytecount, getpid());
+				runtime_rem, bytecount, getpid());
 	else
 		tst_res(TINFO, "... [t=%d] %lu bytes allocated only in child %d",
-				tst_timeout_remaining(), bytecount, getpid());
+				runtime_rem, bytecount, getpid());
 
 	kill(getppid(), SIGRTMIN);
 	raise(SIGSTOP);
@@ -195,10 +197,9 @@ static void mem_test(void)
 
 	/* wait in the loop for all children finish allocating */
 	while (children_done < pid_cntr) {
-		if (tst_timeout_remaining() < STOP_THRESHOLD) {
+		if (!tst_remaining_runtime()) {
 			tst_res(TWARN,
 				"the remaininig time is not enough for testing");
-
 			break;
 		}
 
@@ -234,6 +235,7 @@ static struct tst_test test = {
 		{"v",  &verbose,     	"Verbose"},
 		{}
 	},
+	.max_iteration_runtime = 300,
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = mem_test,
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
