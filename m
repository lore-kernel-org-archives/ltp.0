Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20086C433FE
	for <ltp@archiver.kernel.org>; Mon, 11 Apr 2022 15:16:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A5CF33CA527
	for <ltp@archiver.kernel.org>; Mon, 11 Apr 2022 17:16:56 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7BF3A3CA3CF
 for <ltp@lists.linux.it>; Mon, 11 Apr 2022 17:16:45 +0200 (CEST)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com
 [IPv6:2607:f8b0:4864:20::1149])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B638F14000AA
 for <ltp@lists.linux.it>; Mon, 11 Apr 2022 17:16:44 +0200 (CEST)
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-2eba71ef663so134284147b3.14
 for <ltp@lists.linux.it>; Mon, 11 Apr 2022 08:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=yNMLt2aTE0VyWbNrC00xG57MgVtqqTMaPbPRW5jZZqo=;
 b=tK03kJrPl6NqEPxm4yJ4RIDnhlxA0VzeRnfoOcyAWl9j6p9Z9CwFz8J8YoF6jvDUgC
 p0XcX9cXCV5T8lPXCITwI2jXKEaWfedpfHxJgrrlvleNnlNda7Demdu8i26RHQuJV2ir
 GJ6v2skAecnVKlByg6rp8Gu8nqcijpr9kRJ1+Hz9mhY1cZk9E99YRjZmC9DR42xCclZZ
 niaLnwaZxJs//nOwFBIXDHKemXuVVmn0JJGZkvBtzKS4e40twGKdLz+92N0J/fw8ztot
 8E2UB9af+fVDRbwidJlp74t69p3ZGcobj+Ex5MBJ0QkHQWHwugnKGr+XZjkUAqVX14d4
 I/4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=yNMLt2aTE0VyWbNrC00xG57MgVtqqTMaPbPRW5jZZqo=;
 b=WCLfqT4iCwTrTnR4qd7o8gb4pgTguYeVxFkxoOQXZ2iF8jiUur8vTcz6Q9XFmPo9ir
 gAytVDlmbqKgRS4AlWjTAMoc4RaJP0S1zduAmMxRR81w/PEuOFrXC9FXXBh1P/wbgL7r
 jJWiO6Phqri8ZmqJU1py6iwJcmHPfI8T+LYal5AiT8mc7/C5GWd/Iuw5JinjMSyKBTA0
 0BSmrUk5kB4GfPYoJTMTtpoBx3TgssGQJDNzddJk020A4NyarrmAwYCxLX9EJ2tleyns
 SxZ0SiOQR6rClf34lr3v2PZqcMN10LspafLxx+O4IAOSdy0xDbsGo65w64LhD5cwHvGn
 rDKw==
X-Gm-Message-State: AOAM530xhPo2RJd+ZdycQ8KzzbXpNTKWPAX98GGV36qkhtaOv68ewY1I
 h2/UkTqD254HVP5lb9LVhPSnGuvqnL8/papoD9CwG1oTPlV28lW9GLq/iC33ikKFBrn8AVw5cqY
 mbGJIIl0vn85rtNJOzmCWtxDRknVg4CtKPYHQG71WutaMRpszuvctkqIv
X-Google-Smtp-Source: ABdhPJzrRzUP7F8kztfp8860+LGcSsqNdcMxh0M1f9rHFuXhexwJUpXhOg7JQXS7X8TPSUA+3m+3BzhfhYY=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4be])
 (user=edliaw job=sendgmr) by 2002:a25:4884:0:b0:628:c114:eb34 with
 SMTP id
 v126-20020a254884000000b00628c114eb34mr23928614yba.602.1649690203091; Mon, 11
 Apr 2022 08:16:43 -0700 (PDT)
Date: Mon, 11 Apr 2022 15:16:37 +0000
Message-Id: <20220411151637.1739318-1-edliaw@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] fzsync: break inf loop with flag vs pthread_cancel
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
From: Edward Liaw via ltp <ltp@lists.linux.it>
Reply-To: Edward Liaw <edliaw@google.com>
Cc: kernel-team@android.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi, I'm working to get fzsync working with the Android kernel, which
does not have pthread_cancel available.

In the absence of pthread_cancel, when thread A exits due to a break,
thread B will get stuck in an infinite loop while waiting for thread A
to progress.

Instead of cancelling thread B, we can use the exit flag to break out of
thread B's loop.  This should also remove the need for the wrapper
around the thread.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 include/tst_fuzzy_sync.h            | 74 +++++++++++------------------
 lib/newlib_tests/tst_fuzzy_sync01.c |  7 +--
 lib/newlib_tests/tst_fuzzy_sync02.c |  7 +--
 3 files changed, 30 insertions(+), 58 deletions(-)

diff --git a/include/tst_fuzzy_sync.h b/include/tst_fuzzy_sync.h
index bc3450294..455795ebb 100644
--- a/include/tst_fuzzy_sync.h
+++ b/include/tst_fuzzy_sync.h
@@ -60,7 +60,6 @@
  */
 
 #include <math.h>
-#include <pthread.h>
 #include <stdbool.h>
 #include <stdlib.h>
 #include <sys/time.h>
@@ -234,35 +233,13 @@ static inline void tst_fzsync_pair_cleanup(struct tst_fzsync_pair *pair)
 {
 	if (pair->thread_b) {
 		/* Revoke thread B if parent hits accidental break */
-		if (!pair->exit) {
+		if (!pair->exit)
 			tst_atomic_store(1, &pair->exit);
-			usleep(100000);
-			pthread_cancel(pair->thread_b);
-		}
 		SAFE_PTHREAD_JOIN(pair->thread_b, NULL);
 		pair->thread_b = 0;
 	}
 }
 
-/** To store the run_b pointer and pass to tst_fzsync_thread_wrapper */
-struct tst_fzsync_run_thread {
-	void *(*func)(void *);
-	void *arg;
-};
-
-/**
- * Wrap run_b for tst_fzsync_pair_reset to enable pthread cancel
- * at the start of the thread B.
- */
-static inline void *tst_fzsync_thread_wrapper(void *run_thread)
-{
-       struct tst_fzsync_run_thread t = *(struct tst_fzsync_run_thread *)run_thread;
-
-       pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
-       pthread_setcancelstate(PTHREAD_CANCEL_ENABLE, NULL);
-       return t.func(t.arg);
-}
-
 /**
  * Zero some stat fields
  *
@@ -311,13 +288,8 @@ static inline void tst_fzsync_pair_reset(struct tst_fzsync_pair *pair,
 	pair->a_cntr = 0;
 	pair->b_cntr = 0;
 	pair->exit = 0;
-	if (run_b) {
-		static struct tst_fzsync_run_thread wrap_run_b;
-
-		wrap_run_b.func = run_b;
-		wrap_run_b.arg = NULL;
-		SAFE_PTHREAD_CREATE(&pair->thread_b, 0, tst_fzsync_thread_wrapper, &wrap_run_b);
-	}
+	if (run_b)
+		SAFE_PTHREAD_CREATE(&pair->thread_b, 0, run_b, 0);
 
 	pair->exec_time_start = (float)tst_timeout_remaining();
 }
@@ -554,6 +526,7 @@ static inline void tst_fzsync_pair_update(struct tst_fzsync_pair *pair)
  * @param our_cntr The counter for the thread we are on
  * @param other_cntr The counter for the thread we are synchronising with
  * @param spins A pointer to the spin counter or NULL
+ * @param exit Exit flag when we need to break out of the wait loop
  *
  * Used by tst_fzsync_pair_wait_a(), tst_fzsync_pair_wait_b(),
  * tst_fzsync_start_race_a(), etc. If the calling thread is ahead of the other
@@ -566,6 +539,7 @@ static inline void tst_fzsync_pair_update(struct tst_fzsync_pair *pair)
 static inline void tst_fzsync_pair_wait(int *our_cntr,
 					int *other_cntr,
 					int *spins,
+					int *exit,
 					bool yield_in_wait)
 {
 	if (tst_atomic_inc(other_cntr) == INT_MAX) {
@@ -578,7 +552,8 @@ static inline void tst_fzsync_pair_wait(int *our_cntr,
 		 */
 		if (yield_in_wait) {
 			while (tst_atomic_load(our_cntr) > 0
-			       && tst_atomic_load(our_cntr) < INT_MAX) {
+			       && tst_atomic_load(our_cntr) < INT_MAX
+			       && !tst_atomic_load(exit)) {
 				if (spins)
 					(*spins)++;
 
@@ -586,7 +561,8 @@ static inline void tst_fzsync_pair_wait(int *our_cntr,
 			}
 		} else {
 			while (tst_atomic_load(our_cntr) > 0
-			       && tst_atomic_load(our_cntr) < INT_MAX) {
+			       && tst_atomic_load(our_cntr) < INT_MAX
+			       && !tst_atomic_load(exit)) {
 				if (spins)
 					(*spins)++;
 			}
@@ -599,10 +575,12 @@ static inline void tst_fzsync_pair_wait(int *our_cntr,
 		 * is restored and we can continue.
 		 */
 		if (yield_in_wait) {
-			while (tst_atomic_load(our_cntr) > 1)
+			while (tst_atomic_load(our_cntr) > 1
+			       && !tst_atomic_load(exit))
 				sched_yield();
 		} else {
-			while (tst_atomic_load(our_cntr) > 1)
+			while (tst_atomic_load(our_cntr) > 1
+			       && !tst_atomic_load(exit))
 				;
 		}
 	} else {
@@ -612,14 +590,16 @@ static inline void tst_fzsync_pair_wait(int *our_cntr,
 		 */
 		if (yield_in_wait) {
 			while (tst_atomic_load(our_cntr) <
-			       tst_atomic_load(other_cntr)) {
+			       tst_atomic_load(other_cntr)
+			       && !tst_atomic_load(exit)) {
 				if (spins)
 					(*spins)++;
 				sched_yield();
 			}
 		} else {
 			while (tst_atomic_load(our_cntr) <
-			       tst_atomic_load(other_cntr)) {
+			       tst_atomic_load(other_cntr)
+			       && !tst_atomic_load(exit)) {
 				if (spins)
 					(*spins)++;
 			}
@@ -635,7 +615,8 @@ static inline void tst_fzsync_pair_wait(int *our_cntr,
  */
 static inline void tst_fzsync_wait_a(struct tst_fzsync_pair *pair)
 {
-	tst_fzsync_pair_wait(&pair->a_cntr, &pair->b_cntr, NULL, pair->yield_in_wait);
+	tst_fzsync_pair_wait(&pair->a_cntr, &pair->b_cntr,
+	                     NULL, &pair->exit, pair->yield_in_wait);
 }
 
 /**
@@ -646,7 +627,8 @@ static inline void tst_fzsync_wait_a(struct tst_fzsync_pair *pair)
  */
 static inline void tst_fzsync_wait_b(struct tst_fzsync_pair *pair)
 {
-	tst_fzsync_pair_wait(&pair->b_cntr, &pair->a_cntr, NULL, pair->yield_in_wait);
+	tst_fzsync_pair_wait(&pair->b_cntr, &pair->a_cntr,
+	                     NULL, &pair->exit, pair->yield_in_wait);
 }
 
 /**
@@ -662,7 +644,6 @@ static inline void tst_fzsync_wait_b(struct tst_fzsync_pair *pair)
  */
 static inline int tst_fzsync_run_a(struct tst_fzsync_pair *pair)
 {
-	int exit = 0;
 	float rem_p = 1 - tst_timeout_remaining() / pair->exec_time_start;
 
 	if ((pair->exec_time_p * SAMPLING_SLICE < rem_p)
@@ -677,19 +658,18 @@ static inline int tst_fzsync_run_a(struct tst_fzsync_pair *pair)
 	if (pair->exec_time_p < rem_p) {
 		tst_res(TINFO,
 			"Exceeded execution time, requesting exit");
-		exit = 1;
+		tst_atomic_store(1, &pair->exit);
 	}
 
 	if (++pair->exec_loop > pair->exec_loops) {
 		tst_res(TINFO,
 			"Exceeded execution loops, requesting exit");
-		exit = 1;
+		tst_atomic_store(1, &pair->exit);
 	}
 
-	tst_atomic_store(exit, &pair->exit);
 	tst_fzsync_wait_a(pair);
 
-	if (exit) {
+	if (pair->exit) {
 		tst_fzsync_pair_cleanup(pair);
 		return 0;
 	}
@@ -758,7 +738,8 @@ static inline void tst_fzsync_start_race_a(struct tst_fzsync_pair *pair)
 static inline void tst_fzsync_end_race_a(struct tst_fzsync_pair *pair)
 {
 	tst_fzsync_time(&pair->a_end);
-	tst_fzsync_pair_wait(&pair->a_cntr, &pair->b_cntr, &pair->spins, pair->yield_in_wait);
+	tst_fzsync_pair_wait(&pair->a_cntr, &pair->b_cntr,
+	                     &pair->spins, &pair->exit, pair->yield_in_wait);
 }
 
 /**
@@ -796,7 +777,8 @@ static inline void tst_fzsync_start_race_b(struct tst_fzsync_pair *pair)
 static inline void tst_fzsync_end_race_b(struct tst_fzsync_pair *pair)
 {
 	tst_fzsync_time(&pair->b_end);
-	tst_fzsync_pair_wait(&pair->b_cntr, &pair->a_cntr, &pair->spins, pair->yield_in_wait);
+	tst_fzsync_pair_wait(&pair->b_cntr, &pair->a_cntr,
+	                     &pair->spins, &pair->exit, pair->yield_in_wait);
 }
 
 /**
diff --git a/lib/newlib_tests/tst_fuzzy_sync01.c b/lib/newlib_tests/tst_fuzzy_sync01.c
index ae3ea4e09..5f23a085b 100644
--- a/lib/newlib_tests/tst_fuzzy_sync01.c
+++ b/lib/newlib_tests/tst_fuzzy_sync01.c
@@ -182,15 +182,10 @@ static void *worker(void *v)
 static void run(unsigned int i)
 {
 	const struct window a = races[i].a;
-	struct tst_fzsync_run_thread wrap_run_b = {
-		.func = worker,
-		.arg = &i,
-	};
 	int cs, ct, r, too_early = 0, critical = 0, too_late = 0;
 
 	tst_fzsync_pair_reset(&pair, NULL);
-	SAFE_PTHREAD_CREATE(&pair.thread_b, 0, tst_fzsync_thread_wrapper,
-			    &wrap_run_b);
+	SAFE_PTHREAD_CREATE(&pair.thread_b, 0, worker, &i);
 
 	while (tst_fzsync_run_a(&pair)) {
 
diff --git a/lib/newlib_tests/tst_fuzzy_sync02.c b/lib/newlib_tests/tst_fuzzy_sync02.c
index 51075f3c3..c1c2a5327 100644
--- a/lib/newlib_tests/tst_fuzzy_sync02.c
+++ b/lib/newlib_tests/tst_fuzzy_sync02.c
@@ -125,16 +125,11 @@ static void run(unsigned int i)
 {
 	const struct window a = to_abs(races[i].a);
 	const struct window ad = to_abs(races[i].ad);
-	struct tst_fzsync_run_thread wrap_run_b = {
-		.func = worker,
-		.arg = &i,
-	};
 	int critical = 0;
 	int now, fin;
 
 	tst_fzsync_pair_reset(&pair, NULL);
-	SAFE_PTHREAD_CREATE(&pair.thread_b, 0, tst_fzsync_thread_wrapper,
-			    &wrap_run_b);
+	SAFE_PTHREAD_CREATE(&pair.thread_b, 0, worker, &i);
 
 	while (tst_fzsync_run_a(&pair)) {
 		c = 0;
-- 
2.35.1.1178.g4f1659d476-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
