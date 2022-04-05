Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3E64C433F5
	for <ltp@archiver.kernel.org>; Tue,  5 Apr 2022 17:06:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 58F8B3CA47A
	for <ltp@archiver.kernel.org>; Tue,  5 Apr 2022 19:06:27 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A5CA73C0D04
 for <ltp@lists.linux.it>; Tue,  5 Apr 2022 19:06:15 +0200 (CEST)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com
 [IPv6:2607:f8b0:4864:20::b4a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B94871400F52
 for <ltp@lists.linux.it>; Tue,  5 Apr 2022 19:06:14 +0200 (CEST)
Received: by mail-yb1-xb4a.google.com with SMTP id
 b11-20020a5b008b000000b00624ea481d55so10810891ybp.19
 for <ltp@lists.linux.it>; Tue, 05 Apr 2022 10:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=XyVhWC89juhD+sLiu7kzi8MQlP2gVi68/dGfWhZR2BE=;
 b=EKUGv8s19ebBz/ud+5VvdhY1B36DEZvdqGuRSLyK7qKe7w/9gTxXg7c5gVR6tr+Dbt
 XHO8VK7vYmThMD53zy8r96hSgTooPxhRBubGrp9uldDJuz5svB5+KlA/tcpUjXZ3eaQB
 piPHSV0mMpdekQe3hfIs/cOeXjZv9GAMr+3Q8Lrq7/EIyvVGpZdVBLoYgZL3lMHApD3o
 F80/LtoG8+mtlfAHquKYt1cDjznmFSesQFq7GGsITjMZHqDJDvxZNd0Z1kjd//zAjeJK
 GcOfL24JSPwZRM0pbBAkqPGqKHNuCi8xyXywPfApYbNpXbkhyjtkl6sR6UUv3oTLSX3T
 0rKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=XyVhWC89juhD+sLiu7kzi8MQlP2gVi68/dGfWhZR2BE=;
 b=7we7xde3IwQ3iY/VQIRbwE1WRB3BQ17ngFjtpzD1cCI9k6aLZUEcIlnV2MryTGzBSl
 zTkOrkrn63lbCejp82iymniHW2TLOtMsyPXvmkx05sDpQakVjaDO1b9jiZGwOHKj1phX
 2Dc74ogvRVEq0eh4OlMLuubchu6eDThywXXWDPH668GRPadU1vtJ0oLL55lAyfidYAXo
 qFilBE9h/5oI4m8BTQ4kzg3Qoppn8HKQUxFmFHS8nlOLvTCVnMlXu0wKAjMKB7kwWnPE
 aUGGyQg72ECjoLP0nnMmAgV8k/NHN02jJhcTfI+QPWlOrnHoUINPubEOFXkyo7vvWQo/
 TCIg==
X-Gm-Message-State: AOAM532L21gq9W5WGtfMTIyfW+xFElyiT5z7oduCMRXoaPFzMixX53/A
 DvnbafBXPNzC8ZLl7KkuXy1T2tWnWa9mFHgYo1k7grZKN4cRvCfMn4xB1Pb227HHT27dwkvEQK5
 xBP5QIzfUeCajhE6wxlaH/FcJKd1xss9l4kTcYqvAOnvSumPpN1L168VG
X-Google-Smtp-Source: ABdhPJxtPnbPxBIXSZ7d0Yq8u2a9fkyGdUAPaAK8YktDNvjPxu3Rfnwj2gTyxS1OImnjqG3NR6wDd0iRvuY=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4be])
 (user=edliaw job=sendgmr) by 2002:a25:4197:0:b0:633:c373:8198 with
 SMTP id
 o145-20020a254197000000b00633c3738198mr3310933yba.519.1649178373446; Tue, 05
 Apr 2022 10:06:13 -0700 (PDT)
Date: Tue,  5 Apr 2022 17:06:07 +0000
Message-Id: <20220405170607.3596657-1-edliaw@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1094.g7c7d902a7c-goog
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] fzsync: break inf loop with flag vs pthread_cancel
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
 include/tst_fuzzy_sync.h            | 68 +++++++++++------------------
 lib/newlib_tests/tst_fuzzy_sync01.c |  7 +--
 lib/newlib_tests/tst_fuzzy_sync02.c |  7 +--
 3 files changed, 27 insertions(+), 55 deletions(-)

diff --git a/include/tst_fuzzy_sync.h b/include/tst_fuzzy_sync.h
index bc3450294..2c120f077 100644
--- a/include/tst_fuzzy_sync.h
+++ b/include/tst_fuzzy_sync.h
@@ -60,7 +60,6 @@
  */
 
 #include <math.h>
-#include <pthread.h>
 #include <stdbool.h>
 #include <stdlib.h>
 #include <sys/time.h>
@@ -233,36 +232,12 @@ static inline void tst_fzsync_pair_init(struct tst_fzsync_pair *pair)
 static inline void tst_fzsync_pair_cleanup(struct tst_fzsync_pair *pair)
 {
 	if (pair->thread_b) {
-		/* Revoke thread B if parent hits accidental break */
-		if (!pair->exit) {
-			tst_atomic_store(1, &pair->exit);
-			usleep(100000);
-			pthread_cancel(pair->thread_b);
-		}
+		tst_atomic_store(1, &pair->exit);
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
@@ -311,13 +286,8 @@ static inline void tst_fzsync_pair_reset(struct tst_fzsync_pair *pair,
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
@@ -554,6 +524,7 @@ static inline void tst_fzsync_pair_update(struct tst_fzsync_pair *pair)
  * @param our_cntr The counter for the thread we are on
  * @param other_cntr The counter for the thread we are synchronising with
  * @param spins A pointer to the spin counter or NULL
+ * @param exit Exit flag when we need to break out of the wait loop
  *
  * Used by tst_fzsync_pair_wait_a(), tst_fzsync_pair_wait_b(),
  * tst_fzsync_start_race_a(), etc. If the calling thread is ahead of the other
@@ -566,6 +537,7 @@ static inline void tst_fzsync_pair_update(struct tst_fzsync_pair *pair)
 static inline void tst_fzsync_pair_wait(int *our_cntr,
 					int *other_cntr,
 					int *spins,
+					int *exit,
 					bool yield_in_wait)
 {
 	if (tst_atomic_inc(other_cntr) == INT_MAX) {
@@ -578,7 +550,8 @@ static inline void tst_fzsync_pair_wait(int *our_cntr,
 		 */
 		if (yield_in_wait) {
 			while (tst_atomic_load(our_cntr) > 0
-			       && tst_atomic_load(our_cntr) < INT_MAX) {
+			       && tst_atomic_load(our_cntr) < INT_MAX
+			       && !tst_atomic_load(exit)) {
 				if (spins)
 					(*spins)++;
 
@@ -586,7 +559,8 @@ static inline void tst_fzsync_pair_wait(int *our_cntr,
 			}
 		} else {
 			while (tst_atomic_load(our_cntr) > 0
-			       && tst_atomic_load(our_cntr) < INT_MAX) {
+			       && tst_atomic_load(our_cntr) < INT_MAX
+			       && !tst_atomic_load(exit)) {
 				if (spins)
 					(*spins)++;
 			}
@@ -599,10 +573,12 @@ static inline void tst_fzsync_pair_wait(int *our_cntr,
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
@@ -612,14 +588,16 @@ static inline void tst_fzsync_pair_wait(int *our_cntr,
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
@@ -635,7 +613,8 @@ static inline void tst_fzsync_pair_wait(int *our_cntr,
  */
 static inline void tst_fzsync_wait_a(struct tst_fzsync_pair *pair)
 {
-	tst_fzsync_pair_wait(&pair->a_cntr, &pair->b_cntr, NULL, pair->yield_in_wait);
+	tst_fzsync_pair_wait(&pair->a_cntr, &pair->b_cntr,
+	                     NULL, &pair->exit, pair->yield_in_wait);
 }
 
 /**
@@ -646,7 +625,8 @@ static inline void tst_fzsync_wait_a(struct tst_fzsync_pair *pair)
  */
 static inline void tst_fzsync_wait_b(struct tst_fzsync_pair *pair)
 {
-	tst_fzsync_pair_wait(&pair->b_cntr, &pair->a_cntr, NULL, pair->yield_in_wait);
+	tst_fzsync_pair_wait(&pair->b_cntr, &pair->a_cntr,
+	                     NULL, &pair->exit, pair->yield_in_wait);
 }
 
 /**
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
2.35.1.1094.g7c7d902a7c-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
