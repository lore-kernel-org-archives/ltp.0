Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2888CC2BBCA
	for <ltp@archiver.kernel.org>; Tue, 25 Jun 2024 23:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1719359686; h=date :
 in-reply-to : mime-version : references : message-id : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=axLb19G8WEpPizI/bFzMMHdBV58m26eAGDLixBTAaf0=;
 b=UirETTToOaEz4bG5B8FVGhzZ597QxcO/Muza1ZUNlmLvFGE6xrGB4fnhOhCMRATAuuPJU
 lv4KAor6531BP0eqXTM7UvcTU14SSGfm2+Mt2LLgLJySTxw0RqP4pI4Aqqh/vPXaGiyZC/D
 XEundzXfd1O6vB9roCnOwOku5Wr8D44=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A87223D1167
	for <ltp@archiver.kernel.org>; Wed, 26 Jun 2024 01:54:46 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B9DED3D1133
 for <ltp@lists.linux.it>; Wed, 26 Jun 2024 01:53:00 +0200 (CEST)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com
 [IPv6:2607:f8b0:4864:20::114a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 452AB1400F2B
 for <ltp@lists.linux.it>; Wed, 26 Jun 2024 01:53:00 +0200 (CEST)
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-63bf23f8fbcso138729197b3.0
 for <ltp@lists.linux.it>; Tue, 25 Jun 2024 16:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1719359579; x=1719964379; darn=lists.linux.it;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=2k/yBWjnhOaP62+PYn7fFBYQ+wWWFCSq1Pabtsr3N8Y=;
 b=1X+IM5WY6VkXre0zdh9PMGfB1KnbhFbS9may7HNq1hLqkFLCre8+8DxwuD1YSbme6X
 Dvyt61PEbpzMEjUg9Vhc2VSGGQG7IUPORdyw4vBDQFdl7fp5/yJaFSysmQjUMqVkgxr7
 wOk7f7PWu3magRnK5CQ5wRv1fwTWlPvDxtYRhju4U+jdqjzgCFjIdEvUlPIhWvxtN4b/
 caxaJOI/vRxufnzrc+QGHHh6ALKJIShucion/N1esLtwLjrvOUc1WwKpFUfU9liTCiri
 5VasisTx3zK7aiGUqTpA6Hvh8XCYJsjzrQEgMQIkMGtsRR2sinQ791XVJZ9RTUpmptns
 fz9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719359579; x=1719964379;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2k/yBWjnhOaP62+PYn7fFBYQ+wWWFCSq1Pabtsr3N8Y=;
 b=WjUpUhMK0b/G2vAAcqYbWRrinlPTcr/bMqoaTS72ejlVAfJx5bvZv42urzIDmt8KrF
 8GXCBM49QijBxHffLBbEbJRsxB/kdNiIrqDZ/2SXB7jtQFQVL80nYw+gCbArf1UUxWjw
 uXOl29tV1gQaEBjanHg0w89D4KfzSOksSTLNAr1/fAqME0kgjOeV1kh77ZGUOJ0ucror
 3YJSfku16xowuLQIP3wb73Qc8/Ljcikh5lO8ItBTKpfoy3V64iBS6dNjs8im1wMava0k
 c1V1d1GN80SwcJLiYrMuGhsZDegrXjiliquy9ZAoQ5YfaaVEByjCCy490vhSTdMmfYf4
 jaTg==
X-Gm-Message-State: AOJu0Yx1EbtQ2+4+5s2Q+Lf7UcDDzDlkhfi4xlknWMBbUT4Ad5bcvjBX
 yc0pjewQ19AHDLvcDtc/K51vBJL0HosrggfKHs2Lmp1W+H1DS6944Kgi46F8hWyK71E7KZMkPSD
 q9LEECfV4PworzP0T8Sjryd1pJ3L7odF4P2Qw4WeqK9vZYj2bJ1ws7yOHh2QoMnxQCq4+5p+a9S
 rwVstAtykQHblo317ee6CJ+Tzqa2Gy0OA=
X-Google-Smtp-Source: AGHT+IHRodOs+ePq++yVjVKPXCN9w3DV3aCcSSD5k4QHcIn0GinnySkJnSpLdNYfuVrnMsI4rWaWLcBJ/phg
X-Received: from jstultz-noogler2.c.googlers.com
 ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:6902:2b93:b0:dff:4c99:915 with SMTP id
 3f1490d57ef6-e0303fcf886mr483111276.10.1719359579011; Tue, 25 Jun 2024
 16:52:59 -0700 (PDT)
Date: Tue, 25 Jun 2024 16:52:32 -0700
In-Reply-To: <20240625235245.2106313-1-jstultz@google.com>
Mime-Version: 1.0
References: <20240625235245.2106313-1-jstultz@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240625235245.2106313-4-jstultz@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/6] sched_football: Re-add the crazy fans to
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
Cc: Cyril Hrubis <chrubis@suse.cz>
Cc: Darren Hart <darren@os.amperecomputing.com>
Signed-off-by: John Stultz <jstultz@google.com>
---
v2:
* Remove unused variable
* Drop changelog comment as suggested by Cyril
* Reuse existing ts-to-ns helpers
* Rework to use tst_atomic_* functions as suggested by Cyril
* Rework to use tst_timespec* functions as suggested by Cyril
---
 .../func/sched_football/sched_football.c      | 58 ++++++++++++++++---
 1 file changed, 50 insertions(+), 8 deletions(-)

diff --git a/testcases/realtime/func/sched_football/sched_football.c b/testcases/realtime/func/sched_football/sched_football.c
index 1a1bc5780..37cff515c 100644
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
@@ -52,7 +56,6 @@
  *		bugfixes and cleanups. -- Josh Triplett
  *     2009-06-23 Simplified atomic startup mechanism, avoiding thundering herd
  *		scheduling at the beginning of the game. -- Darren Hart
- *
  *****************************************************************************/
 
 #include <stdio.h>
@@ -68,6 +71,9 @@
 #include <sys/time.h>
 #include <librttest.h>
 #include <tst_atomic.h>
+#define TST_NO_DEFAULT_MAIN
+#include <tst_timer.h>
+
 
 #define DEF_GAME_LENGTH 5
 
@@ -108,6 +114,31 @@ int parse_args(int c, char *v)
 	return handled;
 }
 
+#define SPIN_TIME_NS 200000000ULL
+#define SLEEP_TIME_NS 50000000ULL
+/* These are fans running across the field. They're trying to interrupt/distract everyone */
+void *thread_fan(void *arg)
+{
+	tst_atomic_add_return(1, &players_ready);
+	/*occasionally wake up and run across the field */
+	while (1) {
+		struct timespec start, stop;
+		nsec_t nsec;
+
+		start.tv_sec = 0;
+		start.tv_nsec = SLEEP_TIME_NS;
+		clock_nanosleep(CLOCK_MONOTONIC, 0, &start, NULL);
+		clock_gettime(CLOCK_MONOTONIC, &start);
+		clock_gettime(CLOCK_MONOTONIC, &stop);
+		nsec = tst_timespec_diff_ns(stop, start);
+		while (nsec < SPIN_TIME_NS) {
+			clock_gettime(CLOCK_MONOTONIC, &stop);
+			nsec = tst_timespec_diff_ns(stop, start);
+		}
+	}
+	return NULL;
+}
+
 /* This is the defensive team. They're trying to block the offense */
 void *thread_defense(void *arg)
 {
@@ -200,6 +231,17 @@ int main(int argc, char *argv[])
 	while (tst_atomic_load(&players_ready) < players_per_team * 2)
 		usleep(100);
 
+	/* Start the crazy fans*/
+	priority = 50;
+	printf("Starting %d fan threads at priority %d\n",
+	       players_per_team, priority);
+	for (i = 0; i < players_per_team*2; i++)
+		create_fifo_thread(thread_fan, NULL, priority);
+
+	/* Wait for the crazy fan threads to start */
+	while (tst_atomic_load(&players_ready) < players_per_team * 4)
+		usleep(100);
+
 	/* Ok, everyone is on the field, bring out the ref */
 	printf("Starting referee thread\n");
 	result = referee(game_length);
-- 
2.45.2.741.gdbec12cfda-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
