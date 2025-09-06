Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C16C4CA0FED
	for <ltp@archiver.kernel.org>; Sat,  6 Sep 2025 00:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1757119267; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=OsIrVWqNLjLBllrx29xgo7f6DAo3ABziVmoItic35jk=;
 b=HkV0WATCCZeRRUsQ4Z5ifySnGboINGC4149NpURcInt2/2RZHsqjsdtKcjuXYYY0lo2/N
 ca/ORQNjpsk2/FTpDtLMzI+82hHEjs3yS5EbmlzutC57sLDLk9WMloEz7cvfUR4XK6nnekb
 9xDpE8ctsi93jcimQLSUiYjMvpOQpOE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8EBDC3CD532
	for <ltp@archiver.kernel.org>; Sat,  6 Sep 2025 02:41:07 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 73A923C7F94
 for <ltp@lists.linux.it>; Sat,  6 Sep 2025 02:40:45 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A8A20600A16
 for <ltp@lists.linux.it>; Sat,  6 Sep 2025 02:40:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757119242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=UqaYXA09O9vxj47vBWC6npMzN58NQyZ1eiakdjWpeJI=;
 b=HAd4d/eAMcQRrUKsoMxzrMvTXVuOXjrEeVOOdGvLcj1bnsQ39IxV2qtSurbr2wje8mEiMb
 yqMSA4TrgTQWBwGn4296KYYkkoy1hjMWG8GE6zy+gf95C+37rtFpWXGini7YnsCXoFrCTX
 BizgOJH9jLIJ9GwT/Fy/Baf2xOEXNKI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-250-hgs1bkyUNCGFG_wwuvXBBQ-1; Fri,
 05 Sep 2025 20:40:38 -0400
X-MC-Unique: hgs1bkyUNCGFG_wwuvXBBQ-1
X-Mimecast-MFC-AGG-ID: hgs1bkyUNCGFG_wwuvXBBQ_1757119237
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B6AF719560B5; Sat,  6 Sep 2025 00:40:36 +0000 (UTC)
Received: from fedora-laptop-x1.redhat.com (unknown [10.72.112.17])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 650B93002D2A; Sat,  6 Sep 2025 00:40:33 +0000 (UTC)
To: ltp@lists.linux.it
Date: Sat,  6 Sep 2025 08:40:31 +0800
Message-ID: <20250906004031.33513-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qMfomubPnjTV98v_JzXpM5pI7iPh00KLALUXQqVEgLg_1757119237
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] sched_football: synchronize with kickoff flag to
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
  - Adds a short sleep (longer on non-RT kernels) to stabilize startup.

* Game termination is also slightly reordered (by Cyril):
  - Final ball position is read before `game_over` is set,
    avoiding a race where the ball could still move right after
    defense threads stop.

* Add a short usleep() before the referee sets the kickoff_flag so
  that the system has more time to shuffle processes.

* Wait more times on non-RT kernels.

This makes startup sequencing more deterministic while still allowing
some nondeterminism, which is intentional for testing scheduler
behavior under load.

Signed-off-by: Li Wang <liwang@redhat.com>
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Tested-by: Andrea Cervesato <andrea.cervesato@suse.com>
Tested-by: Petr Vorel <pvorel@suse.cz>
---

Notes:
    v2 -> v3:
        * Removed the busy-wait loop from the fan threads
          (This change makes fan threads less aggressive in consuming CPU resources before game kickoff)
        * Added a 200ms delay (`usleep(200000)`) after the barrier synchronization
        * Added conditional delay after setting the kickoff flag
          (To make the system has more time to shuffle processes)
    
    By now, I run sched_football v3 passed on all CentOS/RHEL stock/RT kernels
    and mainline latest v6.17-rc4 non-RT kernel.
    
    Test systems:
        Bare metal: AMD EPYC 9124 32 CPUs, kernel-6.12.0-124.el10
                                           kernel-rt-6.12.0-124.el10
                                           kernel-6.17-rc4.liwang
        Kvm: Intel(R) Core(TM) Ultra 7 165U 14CPUs, kernel-6.12.0-122.el10

 .../func/sched_football/sched_football.c      | 27 ++++++++++++++-----
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/testcases/realtime/func/sched_football/sched_football.c b/testcases/realtime/func/sched_football/sched_football.c
index 0617bdb87..4465bdde8 100644
--- a/testcases/realtime/func/sched_football/sched_football.c
+++ b/testcases/realtime/func/sched_football/sched_football.c
@@ -44,6 +44,7 @@
 static tst_atomic_t the_ball;
 static int players_per_team = 0;
 static int game_length = DEF_GAME_LENGTH;
+static tst_atomic_t kickoff_flag;
 static tst_atomic_t game_over;
 
 static char *str_game_length;
@@ -80,6 +81,9 @@ void *thread_defense(void *arg LTP_ATTRIBUTE_UNUSED)
 {
 	prctl(PR_SET_NAME, "defense", 0, 0, 0);
 	pthread_barrier_wait(&start_barrier);
+	while (!tst_atomic_load(&kickoff_flag))
+		;
+
 	/*keep the ball from being moved */
 	while (!tst_atomic_load(&game_over)) {
 	}
@@ -92,6 +96,9 @@ void *thread_offense(void *arg LTP_ATTRIBUTE_UNUSED)
 {
 	prctl(PR_SET_NAME, "offense", 0, 0, 0);
 	pthread_barrier_wait(&start_barrier);
+	while (!tst_atomic_load(&kickoff_flag))
+		sched_yield();
+
 	while (!tst_atomic_load(&game_over)) {
 		tst_atomic_add_return(1, &the_ball); /* move the ball ahead one yard */
 	}
@@ -115,9 +122,16 @@ void referee(int game_length)
 	now = start;
 
 	/* Start the game! */
-	tst_atomic_store(0, &the_ball);
-	pthread_barrier_wait(&start_barrier);
 	atrace_marker_write("sched_football", "Game_started!");
+	pthread_barrier_wait(&start_barrier);
+	usleep(200000);
+
+	tst_atomic_store(0, &the_ball);
+	tst_atomic_store(1, &kickoff_flag);
+	if (tst_check_preempt_rt())
+		usleep(20000);
+	else
+		usleep(2000000);
 
 	/* Watch the game */
 	while ((now.tv_sec - start.tv_sec) < game_length) {
@@ -125,14 +139,14 @@ void referee(int game_length)
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
 
@@ -154,6 +168,7 @@ static void do_test(void)
 	/* We're the ref, so set our priority right */
 	param.sched_priority = sched_get_priority_min(SCHED_FIFO) + 80;
 	sched_setscheduler(0, SCHED_FIFO, &param);
+	tst_atomic_store(0, &kickoff_flag);
 
 	/*
 	 * Start the offense
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
