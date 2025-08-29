Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24ABCCA0FF7
	for <ltp@archiver.kernel.org>; Fri, 29 Aug 2025 09:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1756461428; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=iEE2kpzKcyP0omqGK5gOIW9RPxGnEF7pyZBfZLsBHkM=;
 b=O/xLRapU2D6MaQ9XKGTOkHwYbua2hv+QpBQmaTZT6dkdB4/JpJyeflMSNVPkHj3VuHuFj
 Ii0qc0RBYlzDEpRje35t/IiKgOpKJoJepeyTf6tEOopvWRZFs3eY13+qRXApLzqCjZ/r/qO
 ZqoMVaGGgsbp483zlGCM6v9c8be3EIc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 45A8D3CD106
	for <ltp@archiver.kernel.org>; Fri, 29 Aug 2025 11:57:08 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4A8D73CCC75
 for <ltp@lists.linux.it>; Fri, 29 Aug 2025 11:56:47 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7F2146008DD
 for <ltp@lists.linux.it>; Fri, 29 Aug 2025 11:56:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756461404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=xblqC/q8a0xQCiCFxK/nRYF8kJ//Vqqm8ojpunbjKls=;
 b=YwcyL5sPdi0ieqrYclVDHon4BQgQcf4CWM3ugFFN7VnsiTGI4Bb2Z2yDy+djBETcR7p02+
 HaZmAwABgbpSnhhFUk9h4OKOzKXNXmdBtnFATrz5p5CeED1e46fkuecmOC03SPVsXtkVdD
 YAEl8WSwgKCYDFzp4v6rAbR3EFhsoFc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-97-f6ph3xpHOeq63oUeDitX_w-1; Fri,
 29 Aug 2025 05:56:40 -0400
X-MC-Unique: f6ph3xpHOeq63oUeDitX_w-1
X-Mimecast-MFC-AGG-ID: f6ph3xpHOeq63oUeDitX_w_1756461399
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8A5B81800347
 for <ltp@lists.linux.it>; Fri, 29 Aug 2025 09:56:39 +0000 (UTC)
Received: from fedora-laptop-x1.redhat.com (unknown [10.72.112.202])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EB11718004A3; Fri, 29 Aug 2025 09:56:37 +0000 (UTC)
To: ltp@lists.linux.it
Date: Fri, 29 Aug 2025 17:56:35 +0800
Message-ID: <20250829095635.193116-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CBe6BWpMn4RtdeduXWtZBfqB7-cgmnzmMVwlwdzPoks_1756461399
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] sched_football: synchronize start with barrier and
 add proper game stop
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The original code synchronized thread startup only with a `players_ready`
counter and busy-wait loops like:

    while (tst_atomic_load(&players_ready) < players_per_team * 4)
        usleep(100);

This ensured only that the right *number* of threads had started, but not
that they all reached the same point before execution. In practice, offense
threads could already move the ball while defense threads were not yet
scheduled, especially on debug/RT kernels. This resulted in unstable test
behavior and spurious failures.

To fix this, introduce a `pthread_barrier` that all players (offense,
defense, fans) and the referee must reach before the game starts. This
provides strict synchronization and removes the fragile busy-wait loops.

Additionally, player threads previously ran infinite loops (`while (1)`),
causing the test process to never terminate after the referee finished,
leading to harness timeouts. A global `game_over` flag is introduced so
threads can exit cleanly when the referee ends the game.

With these changes:
 - Startup is deterministic (barrier-based instead of busy-wait).
 - Threads terminate gracefully after the game (via `game_over`).
 - Test stability and reproducibility are significantly improved.

And to get rid of false postive:
  ==== sched_football ====
  command: sched_football
  tst_test.c:1882: TINFO: LTP version: 20240930
  tst_test.c:1886: TINFO: Tested kernel: 5.14.0-528.5693_1539899881.el9.x86_64+rt-debug
  tst_test.c:1719: TINFO: Timeout per run is 0h 05m 24s
  sched_football.c:147: TINFO: players_per_team: 256 game_length: 5
  sched_football.c:159: TINFO: Starting 256 offense threads at priority 15
  sched_football.c:170: TINFO: Starting 256 defense threads at priority 30
  sched_football.c:181: TINFO: Starting 256 fan threads at priority 50
  sched_football.c:108: TINFO: Starting referee thread
  sched_football.c:111: TINFO: Starting the game (5 sec)
  sched_football.c:131: TINFO: Final ball position: 6977
  sched_football.c:133: TFAIL: Expect: final_ball == 0

Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Chunyu Hu <chuhu@redhat.com>
---
 .../func/sched_football/sched_football.c      | 48 ++++++++-----------
 1 file changed, 20 insertions(+), 28 deletions(-)

diff --git a/testcases/realtime/func/sched_football/sched_football.c b/testcases/realtime/func/sched_football/sched_football.c
index 1d761d43c..0617bdb87 100644
--- a/testcases/realtime/func/sched_football/sched_football.c
+++ b/testcases/realtime/func/sched_football/sched_football.c
@@ -44,18 +44,19 @@
 static tst_atomic_t the_ball;
 static int players_per_team = 0;
 static int game_length = DEF_GAME_LENGTH;
-static tst_atomic_t players_ready;
+static tst_atomic_t game_over;
 
 static char *str_game_length;
 static char *str_players_per_team;
+static pthread_barrier_t start_barrier;
 
 /* These are fans running across the field. They're trying to interrupt/distract everyone */
 void *thread_fan(void *arg LTP_ATTRIBUTE_UNUSED)
 {
 	prctl(PR_SET_NAME, "crazy_fan", 0, 0, 0);
-	tst_atomic_add_return(1, &players_ready);
+	pthread_barrier_wait(&start_barrier);
 	/*occasionally wake up and run across the field */
-	while (1) {
+	while (!tst_atomic_load(&game_over)) {
 		struct timespec start, stop;
 		nsec_t nsec;
 
@@ -78,9 +79,9 @@ void *thread_fan(void *arg LTP_ATTRIBUTE_UNUSED)
 void *thread_defense(void *arg LTP_ATTRIBUTE_UNUSED)
 {
 	prctl(PR_SET_NAME, "defense", 0, 0, 0);
-	tst_atomic_add_return(1, &players_ready);
+	pthread_barrier_wait(&start_barrier);
 	/*keep the ball from being moved */
-	while (1) {
+	while (!tst_atomic_load(&game_over)) {
 	}
 
 	return NULL;
@@ -90,8 +91,8 @@ void *thread_defense(void *arg LTP_ATTRIBUTE_UNUSED)
 void *thread_offense(void *arg LTP_ATTRIBUTE_UNUSED)
 {
 	prctl(PR_SET_NAME, "offense", 0, 0, 0);
-	tst_atomic_add_return(1, &players_ready);
-	while (1) {
+	pthread_barrier_wait(&start_barrier);
+	while (!tst_atomic_load(&game_over)) {
 		tst_atomic_add_return(1, &the_ball); /* move the ball ahead one yard */
 	}
 
@@ -115,6 +116,7 @@ void referee(int game_length)
 
 	/* Start the game! */
 	tst_atomic_store(0, &the_ball);
+	pthread_barrier_wait(&start_barrier);
 	atrace_marker_write("sched_football", "Game_started!");
 
 	/* Watch the game */
@@ -122,10 +124,13 @@ void referee(int game_length)
 		sleep(1);
 		gettimeofday(&now, NULL);
 	}
+
+	/* Stop the game! */
+	tst_atomic_store(1, &game_over);
 	atrace_marker_write("sched_football", "Game_Over!");
-	final_ball = tst_atomic_load(&the_ball);
 
 	/* Blow the whistle */
+	final_ball = tst_atomic_load(&the_ball);
 	tst_res(TINFO, "Final ball position: %d", final_ball);
 
 	TST_EXP_EXPR(final_ball == 0);
@@ -140,11 +145,12 @@ static void do_test(void)
 	if (players_per_team == 0)
 		players_per_team = get_numcpus();
 
-	tst_atomic_store(0, &players_ready);
-
 	tst_res(TINFO, "players_per_team: %d game_length: %d",
 	       players_per_team, game_length);
 
+	/* total = offense + defense + fans + referee */
+	pthread_barrier_init(&start_barrier, NULL, players_per_team * 4 + 1);
+
 	/* We're the ref, so set our priority right */
 	param.sched_priority = sched_get_priority_min(SCHED_FIFO) + 80;
 	sched_setscheduler(0, SCHED_FIFO, &param);
@@ -159,10 +165,6 @@ static void do_test(void)
 	for (i = 0; i < players_per_team; i++)
 		create_fifo_thread(thread_offense, NULL, priority);
 
-	/* Wait for the offense threads to start */
-	while (tst_atomic_load(&players_ready) < players_per_team)
-		usleep(100);
-
 	/* Start the defense */
 	priority = 30;
 	tst_res(TINFO, "Starting %d defense threads at priority %d",
@@ -170,26 +172,16 @@ static void do_test(void)
 	for (i = 0; i < players_per_team; i++)
 		create_fifo_thread(thread_defense, NULL, priority);
 
-	/* Wait for the defense threads to start */
-	while (tst_atomic_load(&players_ready) < players_per_team * 2)
-		usleep(100);
-
 	/* Start the crazy fans*/
 	priority = 50;
-	tst_res(TINFO, "Starting %d fan threads at priority %d",
-	       players_per_team, priority);
+	tst_res(TINFO, "Starting %d crazy-fan threads at priority %d",
+	       players_per_team*2, priority);
 	for (i = 0; i < players_per_team*2; i++)
 		create_fifo_thread(thread_fan, NULL, priority);
 
-	/* Wait for the crazy fan threads to start */
-	while (tst_atomic_load(&players_ready) < players_per_team * 4)
-		usleep(100);
-
-	/* let things get into steady state */
-	sleep(2);
-	/* Ok, everyone is on the field, bring out the ref */
-
 	referee(game_length);
+
+	pthread_barrier_destroy(&start_barrier);
 }
 
 static void do_setup(void)
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
