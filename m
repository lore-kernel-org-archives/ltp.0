Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EADDFC4345F
	for <ltp@archiver.kernel.org>; Wed, 24 Apr 2024 12:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1713961392; h=date :
 in-reply-to : mime-version : references : message-id : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=1Nwjb3P1i6dYvQcWTWteVqLlVcHRYaXzJ8e3Va+HAQg=;
 b=AhQz55loYTPwqHP9EnJmou3npCpdjrfY0T9riCCt0r5Z/mzWSx2wauFrima0qW82ZXMZd
 jfkCdDZJQkC0exNQoYB/UEtN4OoOfJJZqLG5e9yP+t1g+HQoVACgKd52bjpcSp3ntUzlmRc
 /WAs/7NcuHpNz3wRhGjFeD/b77hoz98=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 786E03D0045
	for <ltp@archiver.kernel.org>; Wed, 24 Apr 2024 14:23:12 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E43493CFA6F
 for <ltp@lists.linux.it>; Wed, 24 Apr 2024 00:58:33 +0200 (CEST)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com
 [IPv6:2607:f8b0:4864:20::1149])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6D6336006D7
 for <ltp@lists.linux.it>; Wed, 24 Apr 2024 00:58:33 +0200 (CEST)
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-6183c4a6d18so111828947b3.3
 for <ltp@lists.linux.it>; Tue, 23 Apr 2024 15:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1713913112; x=1714517912; darn=lists.linux.it;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=dtfJ/TZVDMnkUSVO20F4VJ8UFP1PC5iiWFEtOZAX0Lo=;
 b=yzRKPWaJA7IkEr3FdRVa9/zmq8yLa4IxI3/4wNO14FJFPQlAEIUlz/DtTPC4cg6kKe
 hWHiHBvtM/1MOj0ghm8YEnzgs4QRuX6JEvqpW5D3J1fhRs/pU9TAVUhlx0FqPyAdHz7X
 HJwmCk/IIxrOdlkWwks7Wj4u/JPHXTG75435XcQmMB9tD240mhx2w1RNQlr9sWW3/Mff
 TT4TB2o0YRLps5LTxZ/4vbkxK6JG4cDNcocbnBpcBoB19VsS+nyKFGhPNMUaVAV0nUeK
 51r8D03U0pNwo22RwlJKdo/iFZGtRO3hCD6AUPmWAM8L3ZXUyJiz8bMF3w6Q/mXATFgR
 CEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713913112; x=1714517912;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dtfJ/TZVDMnkUSVO20F4VJ8UFP1PC5iiWFEtOZAX0Lo=;
 b=hPs618NFZdR/rOpcYfixnHSa1ykkKpuCju1VljhA6ZgnnzsCdG8lsCMImFahh40nWL
 +SFCR4zd2b4xVyOUdBDN+rVB4yP8t9VESWQjKiIRoxrKrOaNxsD62TEsv1zRfyi7f/w9
 EpgNL1XIHYxQk2xo/kOJNspP2vqty2lT+q1fPbjsS4X0Sa5gwU0rRuHt+Ui1x874eVu4
 U8V0DotOqgK5ajUrqmuqqOxD9O2b13b2mmisbigUnjADL02VW27Yr4TvNDt8piVTCJjn
 BJqlqP/l4pBJldPUKRHrX1wVWYfP1lMHgR7GBKfQ4ffvPDmWLRdRu+UTkmctOF+6Q8QM
 XZDg==
X-Gm-Message-State: AOJu0YxaSMXYsVUMAOoj0O+aLNx1Cl9JH3cI9assHZUkpOyU9k4g/zFN
 hx+BzJuqeCRU5vFRveFsp+Eqf2r1zHPNNa5wbqvkwgutNQ6oKbrOGYYBqFQ5jasVqGreIB2pfJt
 URicLdunvz+jPWAjrmaf9RLBbDMBPSN17LJ1Icd8x4CIoB5MeIzNHnOHjUVXEJvLAmvfKXROTZS
 chj7pIHDGw9UE9akoftwXwOxxQ4Wv8Tjg=
X-Google-Smtp-Source: AGHT+IH61ROjBRBmLfZi8mKtjBeCwXYkZPpq02ehfASymKzE8TROxdDMCxRF7hY8ZNw5orct9kErswJcmPeS
X-Received: from jstultz-noogler2.c.googlers.com
 ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a81:8382:0:b0:618:91c3:c8e2 with SMTP id
 t124-20020a818382000000b0061891c3c8e2mr191415ywf.1.1713913111599; Tue, 23 Apr
 2024 15:58:31 -0700 (PDT)
Date: Tue, 23 Apr 2024 15:58:00 -0700
In-Reply-To: <20240423225821.4003538-1-jstultz@google.com>
Mime-Version: 1.0
References: <20240423225821.4003538-1-jstultz@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240423225821.4003538-4-jstultz@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 24 Apr 2024 14:22:03 +0200
Subject: [LTP] [PATCH 3/6] sched_football: Re-add the crazy fans to
 interrupt everyone
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
From: John Stultz via ltp <ltp@lists.linux.it>
Reply-To: John Stultz <jstultz@google.com>
Cc: kernel-team@android.com, John Stultz <jstultz@google.com>,
 Darren Hart <darren@os.amperecomputing.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

An idea that I had included long ago in this test case, but was
later dropped was the "crazy fans", which added extra disruption
to the scheduling behavior.

In my recent work, I've found that including them uncovers some
unexpected behavior with current Linux kernels.

So re-add the high priroity tasks that wake up and run to disrupt
the scheduling of defense threads. We run 2*NR_CPU "fan" threads
and they spin for awhile, to force migrations.

Cc: kernel-team@android.com
Cc: Darren Hart <darren@os.amperecomputing.com>
Signed-off-by: John Stultz <jstultz@google.com>
---
 .../func/sched_football/sched_football.c      | 63 ++++++++++++++++---
 1 file changed, 55 insertions(+), 8 deletions(-)

diff --git a/testcases/realtime/func/sched_football/sched_football.c b/testcases/realtime/func/sched_football/sched_football.c
index 359c96703..ed3c5cadf 100644
--- a/testcases/realtime/func/sched_football/sched_football.c
+++ b/testcases/realtime/func/sched_football/sched_football.c
@@ -22,19 +22,23 @@
  * DESCRIPTION
  *      This is a scheduler test that uses a football analogy.
  *      The premise is that we want to make sure that lower priority threads
- *      (defensive team). The offense is trying to increment the balls position,
- *      while the defense is trying to block that from happening.
+ *      don't run while we have runnable higher priority threads.
+ *      The offense is trying to increment the balls position, while the
+ *      defense is trying to block that from happening.
  *      And the ref (highest priority thread) will blow the wistle if the
  *      ball moves. Finally, we have crazy fans (higer prority) that try to
  *      distract the defense by occasionally running onto the field.
  *
  *      Steps:
- *       - Create a fixed number of offense threads (lower priority)
+ *       - Create NR_CPU offense threads (lower priority)
+ *       - Create NR_CPU defense threads (mid priority)
+ *       - Create 2*NR_CPU fan threads (high priority)
  *       - Create a referee thread (highest priority)
- *       - Once everyone is on the field, the offense thread increments the
- *         value of 'the_ball'. The defense thread tries to block
- *         the ball by never letting the offense players get the CPU (it just
- *         spins).
+ *       - Once everyone is on the field, the offense thread spins incrementing
+ *         the value of 'the_ball'. The defense thread tries to block the ball
+ *         by never letting the offense players get the CPU (it just spins).
+ *         The crazy fans sleep a bit, then jump the rail and run across the
+ *         field, disrupting the players on the field.
  *       - The refree threads wakes up regularly to check if the game is over :)
  *       - In the end, if the value of 'the_ball' is >0, the test is considered
  *         to have failed.
@@ -52,7 +56,7 @@
  *		bugfixes and cleanups. -- Josh Triplett
  *     2009-06-23 Simplified atomic startup mechanism, avoiding thundering herd
  *		scheduling at the beginning of the game. -- Darren Hart
- *
+ *     2024-04-23 Re-add crazy fans! Along with minor cleanups -- John Stultz
  *****************************************************************************/
 
 #include <stdio.h>
@@ -107,6 +111,38 @@ int parse_args(int c, char *v)
 	return handled;
 }
 
+#define NSEC_PER_SEC 1000000000ULL
+unsigned long long ts_delta(struct timespec *start, struct timespec *stop)
+{
+	unsigned long long a, b;
+
+	a = start->tv_sec * NSEC_PER_SEC + start->tv_nsec;
+	b = stop->tv_sec * NSEC_PER_SEC + stop->tv_nsec;
+	return b - a;
+}
+
+#define SPIN_TIME_NS 200000000
+#define SLEEP_TIME_NS 50000000
+/* These are fans running across the field. They're trying to interrupt/distract everyone */
+void *thread_fan(void *arg)
+{
+	atomic_inc(&players_ready);
+	/*occasionally wake up and run across the field */
+	while (1) {
+		int i;
+		struct timespec start, stop;
+
+		start.tv_sec = 0;
+		start.tv_nsec = SLEEP_TIME_NS;
+		clock_nanosleep(CLOCK_MONOTONIC, 0, &start, NULL);
+		clock_gettime(CLOCK_MONOTONIC, &start);
+		clock_gettime(CLOCK_MONOTONIC, &stop);
+		while (ts_delta(&start, &stop) < SPIN_TIME_NS)
+			clock_gettime(CLOCK_MONOTONIC, &stop);
+	}
+	return NULL;
+}
+
 /* This is the defensive team. They're trying to block the offense */
 void *thread_defense(void *arg)
 {
@@ -199,6 +235,17 @@ int main(int argc, char *argv[])
 	while (atomic_get(&players_ready) < players_per_team * 2)
 		usleep(100);
 
+	/* Start the crazy fans*/
+	priority = 50;
+	printf("Starting %d fan threads at priority %d\n",
+	       players_per_team, priority);
+	for (i = 0; i < players_per_team*2; i++)
+		create_fifo_thread(thread_fan, NULL, priority);
+
+	/* Wait for the crazy fan threads to start */
+	while (atomic_get(&players_ready) < players_per_team * 4)
+		usleep(100);
+
 	/* Ok, everyone is on the field, bring out the ref */
 	printf("Starting referee thread\n");
 	result = referee(game_length);
-- 
2.44.0.769.g3c40516874-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
