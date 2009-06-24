Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <dvhltc@us.ibm.com>) id 1MJXau-0006f1-Kv
	for ltp-list@lists.sourceforge.net; Wed, 24 Jun 2009 18:53:16 +0000
Received: from e6.ny.us.ibm.com ([32.97.182.146])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MJXap-0005V8-Ne
	for ltp-list@lists.sourceforge.net; Wed, 24 Jun 2009 18:53:16 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5OIuASS002154
	for <ltp-list@lists.sourceforge.net>; Wed, 24 Jun 2009 14:56:10 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5OIr9QB254178
	for <ltp-list@lists.sourceforge.net>; Wed, 24 Jun 2009 14:53:09 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5OIoll4001740
	for <ltp-list@lists.sourceforge.net>; Wed, 24 Jun 2009 14:50:47 -0400
Message-ID: <4A427613.80206@us.ibm.com>
Date: Wed, 24 Jun 2009 11:53:07 -0700
From: Darren Hart <dvhltc@us.ibm.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH][real-time] sched_footbal atomic start
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list <ltp-list@lists.sourceforge.net>
Cc: gowrishankar <gowrishankar.m@linux.vnet.ibm.com>

The current barrier implementation results in the lowest priority thread
actually starting the game (they are the last to be scheduled to call
pthread_barrier_wait).  This thread likely gets a priority boost as it holds
the hb->lock for the futex associated with the barrier.  This might lead to it
running ahead of the defense threads. 

In fact, any sort of barrier or cond var implementation (short of a pi aware
cond broadcast, which is not yet readily available) will result in a thundering
herd situation when the FUTEX_WAKE_ALL syscall is issued, which can result in
a short run of one or more offense threads while all the threads get to the
RUNNABLE state.

This patch removes the complex starting mechansims and replaces them with a
simple atomic counter.  All player threads are started and once the
players_ready count reaches the total player count, the referee starts the game
by setting the ball position to zero.

Tested on two platforms (both x86_64, 4 and 8-way) for a combined total of
13,000 iterations with 0 failures.

Signed-off-by: Darren Hart <dvhltc@us.ibm.com>


Index: ltp/testcases/realtime/func/sched_football/sched_football.c
===================================================================
--- ltp.orig/testcases/realtime/func/sched_football/sched_football.c	2009-06-24 11:49:16.000000000 -0700
+++ ltp/testcases/realtime/func/sched_football/sched_football.c	2009-06-24 11:48:44.000000000 -0700
@@ -47,9 +47,11 @@
  *
  * HISTORY
  *     2006-03-16 Reduced verbosity, non binary failure reporting, removal of
- *     crazy_fans thread, added game_length argument by Darren Hart.
- *      2007-08-01 Remove all thread cleanup in favor of simply exiting.Various
- *      bugfixes and cleanups. -- Josh Triplett
+ *                crazy_fans thread, added game_length argument by Darren Hart.
+ *     2007-08-01 Remove all thread cleanup in favor of simply exiting.Various
+ *                bugfixes and cleanups. -- Josh Triplett
+ *     2009-06-23 Simplified atomic startup mechanism, avoiding thundering herd
+ *                scheduling at the beginning of the game. -- Darren Hart
  *
  *****************************************************************************/
 
@@ -71,11 +73,9 @@
 /* Here's the position of the ball */
 volatile int the_ball;
 
-/* pthread_barrier for synchronization */
-pthread_barrier_t barrier;
-
 static int players_per_team = 0;
 static int game_length = DEF_GAME_LENGTH;
+static atomic_t players_ready;
 
 void usage(void)
 {
@@ -110,8 +110,7 @@
 /* This is the defensive team. They're trying to block the offense */
 void *thread_defense(void* arg)
 {
-	pthread_barrier_wait(&barrier);
-
+	atomic_inc(&players_ready);
 	/*keep the ball from being moved */
 	while (1) {
 		sched_yield(); /* let other defenders run */
@@ -123,8 +122,7 @@
 /* This is the offensive team. They're trying to move the ball */
 void *thread_offense(void* arg)
 {
-	pthread_barrier_wait(&barrier);
-
+	atomic_inc(&players_ready);
 	while (1) {
 		the_ball++; /* move the ball ahead one yard */
 		sched_yield(); /* let other offensive players run */
@@ -141,9 +139,9 @@
 
 	gettimeofday(&start, NULL);
 	now = start;
-	the_ball = 0;
 
-	pthread_barrier_wait(&barrier);
+	/* Start the game! */
+	the_ball = 0;
 
 	/* Watch the game */
 	while ((now.tv_sec - start.tv_sec) < game_length) {
@@ -169,10 +167,7 @@
 	if (players_per_team == 0)
 		players_per_team = sysconf(_SC_NPROCESSORS_ONLN);
 
-	if ((i = pthread_barrier_init(&barrier, NULL, players_per_team*2 + 1))) {
-		printf("pthread_barrier_init failed: %s\n", strerror(i));
-		exit(i);
-	}
+	atomic_set(0, &players_ready);
 
 	printf("Running with: players_per_team=%d game_length=%d\n",
 	       players_per_team, game_length);
@@ -181,13 +176,20 @@
 	param.sched_priority = sched_get_priority_min(SCHED_FIFO) + 80;
 	sched_setscheduler(0, SCHED_FIFO, &param);
 
-	/* Start the offense */
+	/*
+	 * Start the offense
+	 * They are lower priority than defense, so they must be started first.
+	 */
 	priority = 15;
 	printf("Starting %d offense threads at priority %d\n",
 			players_per_team, priority);
 	for (i = 0; i < players_per_team; i++)
 		create_fifo_thread(thread_offense, NULL, priority);
 
+	/* Wait for the offense threads to start */
+	while (atomic_get(&players_ready) < players_per_team)
+		usleep(100);
+
 	/* Start the defense */
 	priority = 30;
 	printf("Starting %d defense threads at priority %d\n",
@@ -195,6 +197,10 @@
 	for (i = 0; i < players_per_team; i++)
 		create_fifo_thread(thread_defense, NULL, priority);
 
+	/* Wait for the defense threads to start */
+	while (atomic_get(&players_ready) < players_per_team * 2)
+		usleep(100);
+
 	/* Ok, everyone is on the field, bring out the ref */
 	printf("Starting referee thread\n");
 	return referee(game_length);
-- 
Darren Hart
IBM Linux Technology Center
Real-Time Linux Team

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
