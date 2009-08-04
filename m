Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <kiran@linux.vnet.ibm.com>) id 1MYE6x-0000Tp-Th
	for ltp-list@lists.sourceforge.net; Tue, 04 Aug 2009 07:07:03 +0000
Received: from e31.co.us.ibm.com ([32.97.110.149])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MYE6p-0005rY-Ks
	for ltp-list@lists.sourceforge.net; Tue, 04 Aug 2009 07:07:03 +0000
From: Kiran <kiran@linux.vnet.ibm.com>
In-Reply-To: <1249298453.7460.33.camel@subratamodak.linux.ibm.com>
References: <1249044153.5432.74.camel@kiran-laptop>
	<1249298453.7460.33.camel@subratamodak.linux.ibm.com>
Date: Tue, 04 Aug 2009 12:30:07 +0530
Message-Id: <1249369207.7558.11.camel@kiran-laptop>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH 3/3] libstats: Modify testcases to call the	append
	function
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
To: subrata@linux.vnet.ibm.com
Cc: gowrishankar.m@in.ibm.com, ltp-list <ltp-list@lists.sf.net>

Hi Subrata,

I am resending the patch after checking with the latest CVS version of
LTP.

Signed-off-by: Kiran Prakash <kiran@linux.vnet.ibm.com>
Acked-by: Gowrishankar <gowrishankar.m@in.ibm.com>
Acked-by: Darren Hart <dvhltc@us.ibm.com>
Acked-by: Sripathi Kodi <sripathik@in.ibm.com>

diff -upr ltp-full-20090731_orig/testcases/realtime/func/async_handler/async_handler.c ltp-full-20090731/testcases/realtime/func/async_handler/async_handler.c
--- ltp-full-20090731_orig/testcases/realtime/func/async_handler/async_handler.c	2008-11-28 16:00:13.000000000 +0530
+++ ltp-full-20090731/testcases/realtime/func/async_handler/async_handler.c	2009-08-04 12:09:26.000000000 +0530
@@ -115,6 +115,7 @@ void *signal_thread(void *arg)
 	long delta, max, min;
 	stats_container_t dat;
 	stats_container_t hist;
+	stats_record_t rec;
 
 	stats_container_init(&dat, iterations);
 	stats_container_init(&hist, HIST_BUCKETS);
@@ -139,8 +140,9 @@ void *signal_thread(void *arg)
 		delta = (long)((end - start)/NS_PER_US);
 		if (delta > pass_criteria)
 			ret = 1;
-		dat.records[i].x = i;
-		dat.records[i].y = delta;
+		rec.x = i;
+		rec.y = delta;
+		stats_container_append(&dat, rec);
 		if (i == 0)
 			min = max = delta;
 		else {
diff -upr ltp-full-20090731_orig/testcases/realtime/func/async_handler/async_handler_tsc.c ltp-full-20090731/testcases/realtime/func/async_handler/async_handler_tsc.c
--- ltp-full-20090731_orig/testcases/realtime/func/async_handler/async_handler_tsc.c	2008-11-28 16:00:13.000000000 +0530
+++ ltp-full-20090731/testcases/realtime/func/async_handler/async_handler_tsc.c	2009-08-04 12:09:26.000000000 +0530
@@ -133,6 +133,7 @@ void *signal_thread(void *arg)
 	long delta, max, min;
 	stats_container_t dat;
 	stats_container_t hist;
+	stats_record_t rec;
 
 	stats_container_init(&dat, ITERATIONS);
 	stats_container_init(&hist, HIST_BUCKETS);
@@ -162,8 +163,9 @@ void *signal_thread(void *arg)
 		} else if (delta > 20) {
 			over_20++;
 		}
-		dat.records[i].x = i;
-		dat.records[i].y = delta;
+		rec.x = i;
+		rec.y = delta;
+		stats_container_append(&dat, rec);
 		if (i == 0)
 			min = max = delta;
 		else {
diff -upr ltp-full-20090731_orig/testcases/realtime/func/gtod_latency/gtod_latency.c ltp-full-20090731/testcases/realtime/func/gtod_latency/gtod_latency.c
--- ltp-full-20090731_orig/testcases/realtime/func/gtod_latency/gtod_latency.c	2008-12-11 18:34:35.000000000 +0530
+++ ltp-full-20090731/testcases/realtime/func/gtod_latency/gtod_latency.c	2009-08-04 12:09:26.000000000 +0530
@@ -222,6 +222,7 @@ int main(int argc, char *argv[])
 	stats_container_t dat;
 	stats_container_t hist;
 	stats_quantiles_t quantiles;
+	stats_record_t rec;
 
 	stats_container_init(&dat, ITERATIONS);
 	stats_container_init(&hist, HIST_BUCKETS);
@@ -273,8 +274,9 @@ int main(int argc, char *argv[])
 	}
 	for (i = 0; i < ITERATIONS; i++) {
 		delta = timespec_subtract(&start_data[i], &stop_data[i]);
-		dat.records[i].x = i;
-		dat.records[i].y = delta;
+		rec.x = i;
+		rec.y = delta;
+		stats_container_append(&dat, rec);
 		if (i == 0 || delta < min) min = delta;
 		if (delta > max) max = delta;
 		if (latency_threshold && delta > latency_threshold)
diff -upr ltp-full-20090731_orig/testcases/realtime/func/hrtimer-prio/hrtimer-prio.c ltp-full-20090731/testcases/realtime/func/hrtimer-prio/hrtimer-prio.c
--- ltp-full-20090731_orig/testcases/realtime/func/hrtimer-prio/hrtimer-prio.c	2008-11-28 16:00:13.000000000 +0530
+++ ltp-full-20090731/testcases/realtime/func/hrtimer-prio/hrtimer-prio.c	2009-08-04 12:09:26.000000000 +0530
@@ -58,6 +58,7 @@ static int iterations = DEF_ITERATIONS;
 static int busy_threads;
 
 static stats_container_t dat;
+static stats_record_t rec;
 static atomic_t busy_threads_started;
 static unsigned long min_delta;
 static unsigned long max_delta;
@@ -131,8 +132,9 @@ void *timer_thread(void *thread)
 		rt_nanosleep(DEF_SLEEP_TIME);
 		end = rt_gettime();
 		delta_us = ((unsigned long)(end - start) - DEF_SLEEP_TIME)/NS_PER_US;
-		dat.records[i].x = i;
-		dat.records[i].y = delta_us;
+		rec.x = i;
+		rec.y = delta_us;
+		stats_container_append(&dat, rec);
 		max_delta = MAX(max_delta, delta_us);
 		min_delta = (i == 0) ? delta_us : MIN(min_delta, delta_us);
 	}
diff -upr ltp-full-20090731_orig/testcases/realtime/func/periodic_cpu_load/periodic_cpu_load.c ltp-full-20090731/testcases/realtime/func/periodic_cpu_load/periodic_cpu_load.c
--- ltp-full-20090731_orig/testcases/realtime/func/periodic_cpu_load/periodic_cpu_load.c	2008-11-28 16:00:13.000000000 +0530
+++ ltp-full-20090731/testcases/realtime/func/periodic_cpu_load/periodic_cpu_load.c	2009-08-04 12:09:26.000000000 +0530
@@ -63,6 +63,7 @@
 
 int fail[THREADS_PER_GROUP * NUM_GROUPS];
 stats_container_t dat[THREADS_PER_GROUP * NUM_GROUPS];
+stats_record_t rec;
 stats_quantiles_t quantiles[THREADS_PER_GROUP * NUM_GROUPS];
 static const char groupname[NUM_GROUPS] = "ABC";
 
@@ -139,8 +140,9 @@ void *periodic_thread(void *thread)
 		func(parg->arg);
 		exe_end = rt_gettime();
 		exe_time = exe_end - exe_start;
-		dat[t->id].records[i].x = i;
-		dat[t->id].records[i].y = exe_time/NS_PER_US;
+		rec.x = i;
+		rec.y = exe_time/NS_PER_US;
+		stats_container_append(&dat[t->id], rec);
 
 		i++;
 
diff -upr ltp-full-20090731_orig/testcases/realtime/func/periodic_cpu_load/periodic_cpu_load_single.c ltp-full-20090731/testcases/realtime/func/periodic_cpu_load/periodic_cpu_load_single.c
--- ltp-full-20090731_orig/testcases/realtime/func/periodic_cpu_load/periodic_cpu_load_single.c	2008-11-28 16:00:13.000000000 +0530
+++ ltp-full-20090731/testcases/realtime/func/periodic_cpu_load/periodic_cpu_load_single.c	2009-08-04 12:09:26.000000000 +0530
@@ -86,6 +86,7 @@ int periodic_thread(nsec_t period, int i
 	stats_container_t dat;
 	stats_container_t hist;
 	stats_quantiles_t quantiles;
+	stats_record_t rec;
 
 	int i = 0;
 	int fail = 0;
@@ -119,8 +120,9 @@ int periodic_thread(nsec_t period, int i
 		calc(loops);
 		exe_end = rt_gettime();
 		exe_time = exe_end - exe_start;
-		dat.records[i].x = i;
-		dat.records[i].y = exe_time/NS_PER_US;
+		rec.x = i;
+		rec.y = exe_time/NS_PER_US;
+		stats_container_append(&dat, rec);
 
 		i++;
 
diff -upr ltp-full-20090731_orig/testcases/realtime/func/pi_perf/pi_perf.c ltp-full-20090731/testcases/realtime/func/pi_perf/pi_perf.c
--- ltp-full-20090731_orig/testcases/realtime/func/pi_perf/pi_perf.c	2009-07-07 20:15:28.000000000 +0530
+++ ltp-full-20090731/testcases/realtime/func/pi_perf/pi_perf.c	2009-08-04 12:15:16.000000000 +0530
@@ -78,6 +78,7 @@ nsec_t low_unlock, max_pi_delay;
 stats_container_t low_dat, cpu_delay_dat;
 stats_container_t cpu_delay_hist;
 stats_quantiles_t cpu_delay_quantiles;
+stats_record_t rec;
 
 void usage(void)
 {
@@ -151,8 +152,9 @@ void * low_prio_thread(void *arg)
 
 		pthread_mutex_unlock(&lock);
 
-		low_dat.records[i].x = i;
-		low_dat.records[i].y = low_hold / NS_PER_US;
+		rec.x = i;
+		rec.y = low_hold / NS_PER_US;
+		stats_container_append(&low_dat, rec);
 
 		if (i == iterations-1)
 			end = 1;
@@ -190,8 +192,9 @@ void * high_prio_thread(void *arg)
 		busy_work_ms(high_work_time);
 		pthread_mutex_unlock(&lock);
 
-		cpu_delay_dat.records[i].x = i;
-		cpu_delay_dat.records[i].y = high_get_lock / NS_PER_US;
+		rec.x = i;
+		rec.y = high_get_lock / NS_PER_US;
+		stats_container_append(&cpu_delay_dat, rec);
 
 		/* Wait for all threads to finish this iteration */
 		pthread_barrier_wait(&bar2);
diff -upr ltp-full-20090731_orig/testcases/realtime/func/pthread_kill_latency/pthread_kill_latency.c ltp-full-20090731/testcases/realtime/func/pthread_kill_latency/pthread_kill_latency.c
--- ltp-full-20090731_orig/testcases/realtime/func/pthread_kill_latency/pthread_kill_latency.c	2008-11-28 16:00:13.000000000 +0530
+++ ltp-full-20090731/testcases/realtime/func/pthread_kill_latency/pthread_kill_latency.c	2009-08-04 12:09:26.000000000 +0530
@@ -120,6 +120,7 @@ void *signal_receiving_thread(void *arg)
 	stats_container_t dat;
 	stats_container_t hist;
 	stats_quantiles_t quantiles;
+	stats_record_t rec;
 
 	stats_container_init(&dat, ITERATIONS);
 	stats_container_init(&hist, HIST_BUCKETS);
@@ -160,8 +161,9 @@ void *signal_receiving_thread(void *arg)
 		sigwait(&set, &sig);
 		end = rt_gettime();
 		delta = (end - begin)/NS_PER_US;
-		dat.records[i].x = i;
-		dat.records[i].y = delta;
+		rec.x = i;
+		rec.y = delta;
+		stats_container_append(&dat, rec);
 
 		if (i == 0 || delta < min)
 			min = delta;
diff -upr ltp-full-20090731_orig/testcases/realtime/func/sched_jitter/sched_jitter.c ltp-full-20090731/testcases/realtime/func/sched_jitter/sched_jitter.c
--- ltp-full-20090731_orig/testcases/realtime/func/sched_jitter/sched_jitter.c	2008-11-28 16:00:13.000000000 +0530
+++ ltp-full-20090731/testcases/realtime/func/sched_jitter/sched_jitter.c	2009-08-04 12:09:26.000000000 +0530
@@ -122,6 +122,7 @@ void *thread_worker(void* arg)
 	unsigned long long min=-1, max=0;
 
 	stats_container_t dat;
+	stats_record_t rec;
 
 	stats_container_init(&dat, NUMRUNS);
 
@@ -141,8 +142,9 @@ void *thread_worker(void* arg)
 			min = delta;
 		if (delta> max)
 			max = delta;
-		dat.records[i].x = i;
-		dat.records[i].y = delta;
+		rec.x = i;
+		rec.y = delta;
+		stats_container_append(&dat, rec);
 
 		printf("delta: %llu ns\n", delta);
 		usleep(1); /* let other things happen */
diff -upr ltp-full-20090731_orig/testcases/realtime/func/sched_latency/sched_latency.c ltp-full-20090731/testcases/realtime/func/sched_latency/sched_latency.c
--- ltp-full-20090731_orig/testcases/realtime/func/sched_latency/sched_latency.c	2008-11-28 16:00:13.000000000 +0530
+++ ltp-full-20090731/testcases/realtime/func/sched_latency/sched_latency.c	2009-08-04 12:09:26.000000000 +0530
@@ -73,6 +73,7 @@ static unsigned int load_ms = DEF_LOAD_M
 stats_container_t dat;
 stats_container_t hist;
 stats_quantiles_t quantiles;
+stats_record_t rec;
 
 void usage(void)
 {
@@ -166,8 +167,10 @@ void *periodic_thread(void *arg)
 
 		/* start of period */
 		delay = (now - iter_start - (nsec_t)(i+1)*period)/NS_PER_US;
-		dat.records[i].x = i;
-		dat.records[i].y = delay;
+		rec.x = i;
+		rec.y = delay;
+		stats_container_append(&dat, rec);
+
 		if (delay < min_delay)
 			min_delay = delay;
 		if (delay > max_delay)
diff -upr ltp-full-20090731_orig/testcases/realtime/perf/latency/pthread_cond_many.c ltp-full-20090731/testcases/realtime/perf/latency/pthread_cond_many.c
--- ltp-full-20090731_orig/testcases/realtime/perf/latency/pthread_cond_many.c	2008-04-20 22:50:18.000000000 +0530
+++ ltp-full-20090731/testcases/realtime/perf/latency/pthread_cond_many.c	2009-08-04 12:09:26.000000000 +0530
@@ -192,6 +192,7 @@ test_signal(long iter, long nthreads)
 	unsigned long max = 0;
 	unsigned long min = 0;
 	stats_container_t dat;
+	stats_record_t rec;
 
 	stats_container_init(&dat,iter * nthreads);
 
@@ -207,8 +208,9 @@ test_signal(long iter, long nthreads)
 	for (i = 0; i < (iter - 1) * nthreads; i+=nthreads) {
 		for (j = 0 , k = i; j < nthreads; j++ , k++) {
 			wake_child(j, broadcast_flag);
-			dat.records[k].x = k;
-			dat.records[k].y = latency;
+			rec.x = k;
+			rec.y = latency;
+			stats_container_append(&dat, rec);
 			pthread_mutex_lock(&child_mutex);
 			child_waiting[j] = 0;
 			pthread_mutex_unlock(&child_mutex);



-- 

Thanks,
Kiran


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
