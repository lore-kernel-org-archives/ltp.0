Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58E0CC4332F
	for <ltp@archiver.kernel.org>; Mon, 19 Dec 2022 16:46:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D93D13CD4AB
	for <ltp@archiver.kernel.org>; Mon, 19 Dec 2022 17:46:52 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 889433CBACC
 for <ltp@lists.linux.it>; Mon, 19 Dec 2022 17:46:42 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BF456600768
 for <ltp@lists.linux.it>; Mon, 19 Dec 2022 17:46:41 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E43C9611D9;
 Mon, 19 Dec 2022 16:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1671468400; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=qZIupsi+sywN7aP48SoBJxA17GbOxbW7LtgvkN1chkw=;
 b=eD+VcjSJm4oWu9gNv/GF1mAiMBju1L3k8FGbftzeiXaI2YDGnhvcs1St9L0vyQm2SGLvIJ
 1TJCz/BDpHN+E497o51nAPxwoJFmmiRGSpZDpL1COYDduD4BLq77LcDSjA2macy1B2NSn9
 at6tW3GQXPPU2c73ACZ8h+jF54DltCE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B239213498;
 Mon, 19 Dec 2022 16:46:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id XNjnKHCVoGPVdQAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Mon, 19 Dec 2022 16:46:40 +0000
To: ltp@lists.linux.it
Date: Mon, 19 Dec 2022 17:44:59 +0100
Message-Id: <20221219164459.3614-1-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Fix aio-stress stucking with multiple threads
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

CPUs that increment threads_starting and threads_ending might have not
flushed the operation into cache. This causes the test to stuck when
variables have not been increased correctly. To avoid this issue we
use pthread_barrier instead of flags.
Removed also no_stonewall flag that is useless for our testing.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/io/ltp-aiodio/aio-stress.c | 47 ++++-----------------
 1 file changed, 8 insertions(+), 39 deletions(-)

diff --git a/testcases/kernel/io/ltp-aiodio/aio-stress.c b/testcases/kernel/io/ltp-aiodio/aio-stress.c
index 39db14d65..2fdbb84e8 100644
--- a/testcases/kernel/io/ltp-aiodio/aio-stress.c
+++ b/testcases/kernel/io/ltp-aiodio/aio-stress.c
@@ -88,7 +88,6 @@ static int shm_id;
 static char *unaligned_buffer;
 static char *aligned_buffer;
 static int padded_reclen;
-static char *no_stonewall;
 static char *verify;
 static char *verify_buf;
 static char *unlink_files;
@@ -227,10 +226,7 @@ struct thread_info {
 };
 
 /* pthread mutexes and other globals for keeping the threads in sync */
-static pthread_cond_t stage_cond = PTHREAD_COND_INITIALIZER;
-static pthread_mutex_t stage_mutex = PTHREAD_MUTEX_INITIALIZER;
-static int threads_ending;
-static int threads_starting;
+static pthread_barrier_t worker_barrier;
 static struct timeval global_stage_start_time;
 static struct thread_info *global_thread_info;
 
@@ -1025,9 +1021,6 @@ static void global_thread_throughput(struct thread_info *t, char *this_stage)
 	if (total_mb) {
 		tst_res(TINFO, "%s throughput (%.2f MB/s)", this_stage, total_mb / runtime);
 		tst_res(TINFO, "%.2f MB in %.2fs", total_mb, runtime);
-
-		if (no_stonewall)
-			tst_res(TINFO, "min transfer %.2fMB", min_trans);
 	}
 }
 
@@ -1053,18 +1046,8 @@ static int *worker(struct thread_info *t)
 
 restart:
 	if (num_threads > 1) {
-		pthread_mutex_lock(&stage_mutex);
-		threads_starting++;
-
-		if (threads_starting == num_threads) {
-			threads_ending = 0;
+		if (pthread_barrier_wait(&worker_barrier))
 			gettimeofday(&global_stage_start_time, NULL);
-			pthread_cond_broadcast(&stage_cond);
-		}
-
-		while (threads_starting != num_threads)
-			pthread_cond_wait(&stage_cond, &stage_mutex);
-		pthread_mutex_unlock(&stage_mutex);
 	}
 
 	if (t->active_opers) {
@@ -1077,14 +1060,7 @@ restart:
 
 	/* first we send everything through aio */
 	while (t->active_opers && cnt < iterations) {
-		if (!no_stonewall && threads_ending) {
-			oper = t->active_opers;
-			oper->stonewalled = 1;
-			oper_list_del(oper, &t->active_opers);
-			oper_list_add(oper, &t->finished_opers);
-		} else {
-			run_active_list(t, io_iter, max_io_submit);
-		}
+		run_active_list(t, io_iter, max_io_submit);
 		cnt++;
 	}
 
@@ -1135,18 +1111,8 @@ restart:
 	}
 
 	if (num_threads > 1) {
-		pthread_mutex_lock(&stage_mutex);
-		threads_ending++;
-
-		if (threads_ending == num_threads) {
-			threads_starting = 0;
-			pthread_cond_broadcast(&stage_cond);
+		if (pthread_barrier_wait(&worker_barrier))
 			global_thread_throughput(t, this_stage);
-		}
-
-		while (threads_ending != num_threads)
-			pthread_cond_wait(&stage_cond, &stage_mutex);
-		pthread_mutex_unlock(&stage_mutex);
 	}
 
 	/* someone got restarted, go back to the beginning */
@@ -1177,6 +1143,8 @@ static int run_workers(struct thread_info *t, int num_threads)
 	int ret = 0;
 	int i;
 
+	pthread_barrier_init(&worker_barrier, NULL, num_threads);
+
 	for (i = 0; i < num_threads; i++)
 		SAFE_PTHREAD_CREATE(&t[i].tid, NULL, (start_routine)worker, t + i);
 
@@ -1185,6 +1153,8 @@ static int run_workers(struct thread_info *t, int num_threads)
 		ret |= (intptr_t)retval;
 	}
 
+	pthread_barrier_destroy(&worker_barrier);
+
 	return ret;
 }
 
@@ -1397,7 +1367,6 @@ static struct tst_test test = {
 		{ "t:", &str_num_threads, "Number of threads to run" },
 		{ "u", &unlink_files, "Unlink files after completion" },
 		{ "v", &verify, "Verification of bytes written" },
-		{ "x", &no_stonewall, "Turn off thread stonewalling" },
 		{},
 	},
 };
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
