Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70DF3CA1012
	for <ltp@archiver.kernel.org>; Thu,  4 Sep 2025 10:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1756981600; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=GeUjFzk/ftdLsYz+w4qOiRTn6ETIjdlXc+Bztit20MU=;
 b=dKBfwS9IwhPKhqLXKWmyP87Oz2rXAZpjB5n8y6FV9w1RrzsZWEe4pjd05uzuxWeTpqUIk
 xp4MWOp7b0K4BWLaDi8DWM7dgPFHhU8Nfd6qnysPH1bcUhDf93ZIduJsjk+E5vETvUGQIFN
 aOuP/bg5bXM2LT/iIoan0BSHsB2Q5k4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CF5993CD434
	for <ltp@archiver.kernel.org>; Thu,  4 Sep 2025 12:26:40 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7B60A3CD3F3
 for <ltp@lists.linux.it>; Thu,  4 Sep 2025 12:26:20 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 83FB82005EC
 for <ltp@lists.linux.it>; Thu,  4 Sep 2025 12:26:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756981577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=tl22B191aGPnUAnwvQFjd4slzknZk5HJHXBpd4TYCj8=;
 b=EVDVNjeszUdN8cffXfCw+td0E82HUb2K1FyWS05KDbKEv7lVmt5MGcl9Ko66OsMn8C4HQM
 fRgjIwsEKQqBPgbmHksAUVdSQf4yznEO7fQkum/WuAybWQnPrmGEjHuLN1eQwh/SoE6Dnd
 uLVGi/IVKFQcZEFFHa1J9ITfUZI2Gec=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-252-lm9CRcx-NUCZSEtPWQPW-Q-1; Thu,
 04 Sep 2025 06:26:16 -0400
X-MC-Unique: lm9CRcx-NUCZSEtPWQPW-Q-1
X-Mimecast-MFC-AGG-ID: lm9CRcx-NUCZSEtPWQPW-Q_1756981575
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 21A6319560B2; Thu,  4 Sep 2025 10:26:15 +0000 (UTC)
Received: from fedora-laptop-x1.redhat.com (unknown [10.72.112.183])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A42021800446; Thu,  4 Sep 2025 10:26:12 +0000 (UTC)
To: ltp@lists.linux.it
Date: Thu,  4 Sep 2025 18:26:09 +0800
Message-ID: <20250904102609.133359-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6JH_gaVsnnub30Ra92nEXmfbjhF3Kc4bnwX-WMkvc8s_1756981575
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] sched_football: synchronize with kickoff flag to
 reduce skew
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

Previously, thread synchronization in sched_football only relied on a
thread_barrier. This ensured that all threads were created before the
referee started the game, but did not fully prevent offense threads from
getting a scheduling opportunity before defense threads were migrated,
leading to occasional non-zero final ball positions on kvm or debug kernels.

This patch introduces an explicit `kickoff_flag`:

* All player threads (offense, defense, fans) wait at the barrier and
  then spin until the referee sets `kickoff_flag`. This reduces kernel
  scheduling skew, as threads only proceed once the referee explicitly
  signals the kickoff.

* The referee now:
  - Waits at the barrier.
  - Clears the ball position.
  - Sets `kickoff_flag` to start the ball.

* Game termination is also slightly reordered (by Cyril):
  - Final ball position is read before `game_over` is set,
    avoiding a race where the ball could still move right after
    defense threads stop.

* Only test on RT-kernels.

This makes startup sequencing more deterministic while still allowing
some nondeterminism, which is intentional for testing scheduler
behavior under load.

Signed-off-by: Li Wang <liwang@redhat.com>
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Tested-by: Andrea Cervesato <andrea.cervesato@suse.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---

Notes:
    V1 -> V2:
    	* add usleep(20000) to increase the chances of each player
    	  being active before the kickoff.

 .../func/sched_football/sched_football.c      | 28 +++++++++++++++----
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/testcases/realtime/func/sched_football/sched_football.c b/testcases/realtime/func/sched_football/sched_football.c
index 0617bdb87..4a72874ce 100644
--- a/testcases/realtime/func/sched_football/sched_football.c
+++ b/testcases/realtime/func/sched_football/sched_football.c
@@ -44,6 +44,7 @@
 static tst_atomic_t the_ball;
 static int players_per_team = 0;
 static int game_length = DEF_GAME_LENGTH;
+static tst_atomic_t kickoff_flag;
 static tst_atomic_t game_over;
 
 static char *str_game_length;
@@ -55,6 +56,9 @@ void *thread_fan(void *arg LTP_ATTRIBUTE_UNUSED)
 {
 	prctl(PR_SET_NAME, "crazy_fan", 0, 0, 0);
 	pthread_barrier_wait(&start_barrier);
+	while (!tst_atomic_load(&kickoff_flag))
+		;
+
 	/*occasionally wake up and run across the field */
 	while (!tst_atomic_load(&game_over)) {
 		struct timespec start, stop;
@@ -80,6 +84,9 @@ void *thread_defense(void *arg LTP_ATTRIBUTE_UNUSED)
 {
 	prctl(PR_SET_NAME, "defense", 0, 0, 0);
 	pthread_barrier_wait(&start_barrier);
+	while (!tst_atomic_load(&kickoff_flag))
+		;
+
 	/*keep the ball from being moved */
 	while (!tst_atomic_load(&game_over)) {
 	}
@@ -92,6 +99,9 @@ void *thread_offense(void *arg LTP_ATTRIBUTE_UNUSED)
 {
 	prctl(PR_SET_NAME, "offense", 0, 0, 0);
 	pthread_barrier_wait(&start_barrier);
+	while (!tst_atomic_load(&kickoff_flag))
+		;
+
 	while (!tst_atomic_load(&game_over)) {
 		tst_atomic_add_return(1, &the_ball); /* move the ball ahead one yard */
 	}
@@ -115,9 +125,11 @@ void referee(int game_length)
 	now = start;
 
 	/* Start the game! */
-	tst_atomic_store(0, &the_ball);
-	pthread_barrier_wait(&start_barrier);
 	atrace_marker_write("sched_football", "Game_started!");
+	pthread_barrier_wait(&start_barrier);
+	tst_atomic_store(0, &the_ball);
+	tst_atomic_store(1, &kickoff_flag);
+	usleep(20000);
 
 	/* Watch the game */
 	while ((now.tv_sec - start.tv_sec) < game_length) {
@@ -125,14 +137,14 @@ void referee(int game_length)
 		gettimeofday(&now, NULL);
 	}
 
-	/* Stop the game! */
-	tst_atomic_store(1, &game_over);
-	atrace_marker_write("sched_football", "Game_Over!");
-
 	/* Blow the whistle */
 	final_ball = tst_atomic_load(&the_ball);
 	tst_res(TINFO, "Final ball position: %d", final_ball);
 
+	/* Stop the game! */
+	tst_atomic_store(1, &game_over);
+	atrace_marker_write("sched_football", "Game_Over!");
+
 	TST_EXP_EXPR(final_ball == 0);
 }
 
@@ -154,6 +166,7 @@ static void do_test(void)
 	/* We're the ref, so set our priority right */
 	param.sched_priority = sched_get_priority_min(SCHED_FIFO) + 80;
 	sched_setscheduler(0, SCHED_FIFO, &param);
+	tst_atomic_store(0, &kickoff_flag);
 
 	/*
 	 * Start the offense
@@ -186,6 +199,9 @@ static void do_test(void)
 
 static void do_setup(void)
 {
+	if (!tst_check_preempt_rt())
+		tst_brk(TCONF, "Test requires real-time kernel");
+
 	if (tst_parse_int(str_game_length, &game_length, 1, INT_MAX))
 		tst_brk(TBROK, "Invalid game length '%s'", str_game_length);
 
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
