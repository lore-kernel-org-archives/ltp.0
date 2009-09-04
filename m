Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <kiran@linux.vnet.ibm.com>) id 1MjVe8-0006LG-E2
	for ltp-list@lists.sourceforge.net; Fri, 04 Sep 2009 10:03:56 +0000
Received: from e28smtp08.in.ibm.com ([59.145.155.8])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MjVe2-0006B9-6N
	for ltp-list@lists.sourceforge.net; Fri, 04 Sep 2009 10:03:56 +0000
From: Kiran <kiran@linux.vnet.ibm.com>
In-Reply-To: <1251875695.4930.8.camel@subratamodak.linux.ibm.com>
References: <1251794259.3881.6.camel@kiran-laptop>
	<1251875695.4930.8.camel@subratamodak.linux.ibm.com>
Date: Fri, 04 Sep 2009 15:19:06 +0530
Message-Id: <1252057746.4698.6.camel@kiran-laptop>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Patch to change the format of Steve Rostedt's
 rt-migrate-test testcase
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
Cc: ltp-list@lists.sf.net, rostedt <rostedt@goodmis.org>

Hi Subrata,

This patch places the rt-migrate testcase into the
realtime/func/rt-migrate directory.

Signed-off-by: Kiran Prakash <kiran@linux.vnet.ibm.com>

diff -Naur ltp-orig/testcases/realtime/func/Makefile ltp/testcases/realtime/func/Makefile
--- ltp-orig/testcases/realtime/func/Makefile	2009-09-04 12:13:40.000000000 +0530
+++ ltp/testcases/realtime/func/Makefile	2009-09-04 12:51:44.000000000 +0530
@@ -17,7 +17,8 @@
 	sched_football \
 	sched_jitter \
 	sched_latency \
-	thread_clock
+	thread_clock \
+	rt-migrate
 
 all:
 	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i; done
diff -Naur ltp-orig/testcases/realtime/func/rt-migrate/Makefile ltp/testcases/realtime/func/rt-migrate/Makefile
--- ltp-orig/testcases/realtime/func/rt-migrate/Makefile	1970-01-01 05:30:00.000000000 +0530
+++ ltp/testcases/realtime/func/rt-migrate/Makefile	2009-09-04 12:14:11.000000000 +0530
@@ -0,0 +1,21 @@
+
+srcdir := ../..
+include $(srcdir)/config.mk
+
+
+SRCS    = $(wildcard *.c)
+
+ifeq ($(HAVE_PI_MUTEX), yes)
+TARGETS = $(SRCS:%.c=%)
+else
+TARGETS =
+endif
+
+all: $(TARGETS)
+
+install:
+	@set -e; for i in $(TARGETS); do ln -f $$i ../../../bin/$$i; done
+
+clean:
+	rm -f $(TARGETS) *~
+
diff -Naur ltp-orig/testcases/realtime/func/rt-migrate/rt-migrate.c ltp/testcases/realtime/func/rt-migrate/rt-migrate.c
--- ltp-orig/testcases/realtime/func/rt-migrate/rt-migrate.c	1970-01-01 05:30:00.000000000 +0530
+++ ltp/testcases/realtime/func/rt-migrate/rt-migrate.c	2009-09-04 14:42:57.000000000 +0530
@@ -0,0 +1,507 @@
+
+/******************************************************************************
+ *
+ * Copyright (C) 2007-2009 Steven Rostedt <srostedt@redhat.com>
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License (not later!)
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ * NAME
+ *      rt-migrate-test.c
+ *
+ * DESCRIPTION
+ *	This test makes sure that all the high prio tasks that are in the
+ *	running state are actually running on a CPU if it can.
+ ** Steps:
+ *	- Creates N+1 threads with lower real time priorities.
+ *	  Where N is the number of CPUs in the system.
+ *	- If the thread is high priority, and if a CPU is available, the
+ *	  thread runs on that CPU.
+ *	- The thread records the start time and the number of ticks in the run
+ *	  interval.
+ *	- The output indicates if lower prio task is quicker than higher
+ *	  priority task.
+ *
+ * USAGE:
+ *	Use run_auto.sh in the current directory to build and run the test.
+ *
+ * AUTHOR
+ *      Steven Rostedt <srostedt@redhat.com>
+ *
+ * HISTORY
+ *      30 July, 2009: Initial version by Steven Rostedt
+ *      11 Aug, 2009: Converted the coding style to the one used by the realtime
+ *                    testcases by Kiran Prakash
+ *
+ */
+#define _GNU_SOURCE
+#include <stdio.h>
+#ifndef __USE_XOPEN2K
+# define __USE_XOPEN2K
+#endif
+#include <stdlib.h>
+#include <string.h>
+#include <getopt.h>
+#include <stdarg.h>
+#include <unistd.h>
+#include <ctype.h>
+#include <time.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <signal.h>
+#include <sys/time.h>
+#include <linux/unistd.h>
+#include <sys/syscall.h>
+#include <errno.h>
+#include <sched.h>
+#include <pthread.h>
+#include <librttest.h>
+#include <libstats.h>
+
+#define gettid() syscall(__NR_gettid)
+
+#define VERSION_STRING "V 0.4LTP"
+
+int nr_tasks;
+int lfd;
+
+int numcpus;
+static int mark_fd = -1;
+static __thread char buff[BUFSIZ+1];
+
+static void setup_ftrace_marker(void)
+{
+	struct stat st;
+	char *files[] = {
+		"/sys/kernel/debug/tracing/trace_marker",
+		"/debug/tracing/trace_marker",
+		"/debugfs/tracing/trace_marker",
+	};
+	int ret;
+	int i;
+
+	for (i = 0; i < (sizeof(files) / sizeof(char *)); i++) {
+		ret = stat(files[i], &st);
+		if (ret >= 0)
+			goto found;
+	}
+	/* todo, check mounts system */
+	return;
+found:
+	mark_fd = open(files[i], O_WRONLY);
+}
+
+static void ftrace_write(const char *fmt, ...)
+{
+	va_list ap;
+	int n;
+
+	if (mark_fd < 0)
+		return;
+
+	va_start(ap, fmt);
+	n = vsnprintf(buff, BUFSIZ, fmt, ap);
+	va_end(ap);
+
+	write(mark_fd, buff, n);
+}
+
+#define INTERVAL 100ULL * NS_PER_MS
+#define RUN_INTERVAL 20ULL * NS_PER_MS
+#define NR_RUNS 50
+#define PRIO_START 2
+/* 1 millisec off */
+#define MAX_ERR  1000 * NS_PER_US
+
+#define PROGRESS_CHARS 70
+
+static unsigned long long interval = INTERVAL;
+static unsigned long long run_interval = RUN_INTERVAL;
+static unsigned long long max_err = MAX_ERR;
+static int nr_runs = NR_RUNS;
+static int prio_start = PRIO_START;
+static int check = 1;
+static int stop;
+
+static unsigned long long now;
+
+static int done;
+static int loop;
+
+static pthread_barrier_t start_barrier;
+static pthread_barrier_t end_barrier;
+stats_container_t *intervals;
+stats_container_t *intervals_length;
+stats_container_t *intervals_loops;
+static long *thread_pids;
+
+static void print_progress_bar(int percent)
+{
+	int i;
+	int p;
+
+	if (percent > 100)
+		percent = 100;
+
+	/* Use stderr, so we don't capture it */
+	putc('\r', stderr);
+	putc('|', stderr);
+	for (i = 0; i < PROGRESS_CHARS; i++)
+		putc(' ', stderr);
+	putc('|', stderr);
+	putc('\r', stderr);
+	putc('|', stderr);
+
+	p = PROGRESS_CHARS * percent / 100;
+
+	for (i = 0; i < p; i++)
+		putc('-', stderr);
+
+	fflush(stderr);
+}
+
+static void usage()
+{
+	rt_help();
+	printf("Usage:\n"
+	       "-a priority Priority of the threads"
+	       "-r time     Run time (ms) to busy loop the threads (20)\n"
+	       "-t time     Sleep time (ms) between intervals (100)\n"
+	       "-e time     Max allowed error (microsecs)\n"
+	       "-l loops    Number of iterations to run (50)\n"
+	      );
+}
+
+static void parse_args(int c, char *v)
+{
+		switch (c) {
+		case 'a': prio_start = atoi(v); break;
+		case 'r':
+			run_interval = atoi(v);
+			break;
+		case 't': interval = atoi(v); break;
+		case 'l': nr_runs = atoi(v); break;
+		case 'e': max_err = atoi(v) * NS_PER_US; break;
+		case '?':
+		case 'h':
+			usage();
+			exit(0);
+		}
+}
+
+static void record_time(int id, unsigned long long time, unsigned long l)
+{
+	unsigned long long ltime;
+	stats_record_t rec;
+	if (loop >= nr_runs)
+		return;
+	time -= now;
+	ltime = rt_gettime() / NS_PER_US;
+	ltime -= now;
+	rec.x = loop;
+	rec.y = time;
+	stats_container_append(&intervals[id], rec);
+	rec.x = loop;
+	rec.y = ltime;
+	stats_container_append(&intervals_length[id], rec);
+	rec.x = loop;
+	rec.y = l;
+	stats_container_append(&intervals_loops[id], rec);
+}
+
+static void print_results(void)
+{
+	int i;
+	int t;
+	unsigned long long tasks_max[nr_tasks];
+	unsigned long long tasks_min[nr_tasks];
+	unsigned long long tasks_avg[nr_tasks];
+
+	memset(tasks_max, 0, sizeof(tasks_max[0])*nr_tasks);
+	memset(tasks_min, 0xff, sizeof(tasks_min[0])*nr_tasks);
+	memset(tasks_avg, 0, sizeof(tasks_avg[0])*nr_tasks);
+
+	printf("Iter: ");
+	for (t = 0; t < nr_tasks; t++)
+		printf("%6d  ", t);
+	printf("\n");
+
+	for (t = 0; t < nr_tasks; t++) {
+		tasks_max[t] = stats_max(&intervals[t]);
+		tasks_min[t] = stats_min(&intervals[t]);
+		tasks_avg[t] = stats_avg(&intervals[t]);
+	}
+	for (i = 0; i < nr_runs; i++) {
+		printf("%4d:   ", i);
+		for (t = 0; t < nr_tasks; t++)
+			printf("%6lld  ", intervals[t].records[i].y);
+
+		printf("\n");
+		printf(" len:   ");
+		for (t = 0; t < nr_tasks; t++)
+			printf("%6lld  ", intervals_length[t].records[i].y);
+
+		printf("\n");
+		printf(" loops: ");
+		for (t = 0; t < nr_tasks; t++)
+			printf("%6ld  ", intervals_loops[t].records[i].y);
+
+		printf("\n");
+		printf("\n");
+	}
+
+	printf("Parent pid: %d\n", getpid());
+
+	for (t = 0; t < nr_tasks; t++) {
+		printf(" Task %d (prio %d) (pid %ld):\n", t, t + prio_start,
+			thread_pids[t]);
+		printf("   Max: %lld us\n", tasks_max[t]);
+		printf("   Min: %lld us\n", tasks_min[t]);
+		printf("   Tot: %lld us\n", tasks_avg[t] * nr_runs);
+		printf("   Avg: %lld us\n", tasks_avg[t]);
+		printf("\n");
+	}
+
+	printf(" Result: %s\n", (check < 0) ? "FAIL" : "PASS");
+}
+
+static unsigned long busy_loop(unsigned long long start_time)
+{
+	unsigned long long time;
+	unsigned long l = 0;
+
+	do {
+		l++;
+		time = rt_gettime();
+	} while ((time - start_time) < RUN_INTERVAL);
+
+	return l;
+}
+
+void *start_task(void *data)
+{
+	struct thread *thr = (struct thread *)data;
+	long id = (long) thr->arg;
+	thread_pids[id] = gettid();
+	unsigned long long start_time;
+	int ret;
+	int high = 0;
+	cpu_set_t cpumask;
+	cpu_set_t save_cpumask;
+	int cpu = 0;
+	unsigned long l;
+	long pid;
+
+	ret = sched_getaffinity(0, sizeof(save_cpumask), &save_cpumask);
+	if (ret < 0)
+		debug(DBG_ERR, "sched_getaffinity failed: %s\n", strerror(ret));
+
+	pid = gettid();
+
+	/* Check if we are the highest prio task */
+	if (id == nr_tasks-1)
+		high = 1;
+
+	while (!done) {
+		if (high) {
+			/* rotate around the CPUS */
+			if (!CPU_ISSET(cpu, &save_cpumask))
+				cpu = 0;
+			CPU_ZERO(&cpumask);
+			CPU_SET(cpu, &cpumask); cpu++;
+			sched_setaffinity(0, sizeof(cpumask), &cpumask);
+		}
+		pthread_barrier_wait(&start_barrier);
+		start_time = rt_gettime();
+		ftrace_write("Thread %d: started %lld diff %lld\n",
+			     pid, start_time, start_time - now);
+		l = busy_loop(start_time);
+		record_time(id, start_time / NS_PER_US, l);
+		pthread_barrier_wait(&end_barrier);
+	}
+
+	return (void *)pid;
+}
+
+static int check_times(int l)
+{
+	int i;
+	unsigned long long last;
+	unsigned long long last_loops;
+	unsigned long long last_length;
+
+	for (i = 0; i < nr_tasks; i++) {
+		if (i && last < intervals[i].records[l].y &&
+		    ((intervals[i].records[l].y - last) > max_err)) {
+			/*
+			 * May be a false positive.
+			 * Make sure that we did more loops
+			 * our start is before the end
+			 * and the end should be tested.
+			 */
+			if (intervals_loops[i].records[l].y < last_loops ||
+			    intervals[i].records[l].y > last_length ||
+			    (intervals_length[i].records[l].y > last_length &&
+			     intervals_length[i].records[l].y - last_length >
+			     max_err)) {
+				check = -1;
+				return 1;
+			}
+		}
+		last = intervals[i].records[l].y;
+		last_loops = intervals_loops[i].records[l].y;
+		last_length = intervals_length[i].records[l].y;
+	}
+	return 0;
+}
+
+static void stop_log(int sig)
+{
+	stop = 1;
+}
+
+int main(int argc, char **argv)
+{
+	pthread_t *threads;
+	long i;
+	int ret;
+	struct timespec intv;
+	struct sched_param param;
+
+	rt_init("a:r:t:e:l:h:", parse_args, argc, argv);
+	signal(SIGINT, stop_log);
+
+	if (argc >= (optind + 1))
+		nr_tasks = atoi(argv[optind]);
+	else {
+		numcpus = sysconf(_SC_NPROCESSORS_ONLN);
+		nr_tasks = numcpus + 1;
+	}
+
+	intervals = malloc(sizeof(stats_container_t) * nr_tasks);
+	if (!intervals)
+		debug(DBG_ERR, "malloc failed\n");
+	memset(intervals, 0, sizeof(stats_container_t) * nr_tasks);
+
+	intervals_length = malloc(sizeof(stats_container_t) * nr_tasks);
+	if (!intervals_length)
+		debug(DBG_ERR, "malloc failed\n");
+	memset(intervals_length, 0, sizeof(stats_container_t) * nr_tasks);
+
+	if (!intervals_loops)
+		debug(DBG_ERR, "malloc failed\n");
+	intervals_loops = malloc(sizeof(stats_container_t) * nr_tasks);
+	memset(intervals_loops, 0, sizeof(stats_container_t) * nr_tasks);
+
+	threads = malloc(sizeof(*threads) * nr_tasks);
+	if (!threads)
+		debug(DBG_ERR, "malloc failed\n");
+	memset(threads, 0, sizeof(*threads) * nr_tasks);
+
+	ret = pthread_barrier_init(&start_barrier, NULL, nr_tasks + 1);
+	ret = pthread_barrier_init(&end_barrier, NULL, nr_tasks + 1);
+	if (ret < 0)
+		debug(DBG_ERR, "pthread_barrier_init failed: %s\n",
+				strerror(ret));
+
+
+	for (i = 0; i < nr_tasks; i++) {
+		stats_container_init(&intervals[i], nr_runs);
+		stats_container_init(&intervals_length[i], nr_runs);
+		stats_container_init(&intervals_loops[i], nr_runs);
+	}
+
+	thread_pids = malloc(sizeof(long) * nr_tasks);
+	if (!thread_pids)
+		debug(DBG_ERR, "malloc thread_pids failed\n");
+
+	for (i = 0; i < nr_tasks; i++) {
+		threads[i] = create_fifo_thread(start_task, (void *)i,
+						prio_start + i);
+	}
+
+	/*
+	 * Progress bar uses stderr to let users see it when
+	 * redirecting output. So we convert stderr to use line
+	 * buffering so the progress bar doesn't flicker.
+	 */
+	setlinebuf(stderr);
+
+	/* up our prio above all tasks */
+	memset(&param, 0, sizeof(param));
+	param.sched_priority = nr_tasks + prio_start;
+	if (sched_setscheduler(0, SCHED_FIFO, &param))
+		debug(DBG_WARN, "Warning, can't set priority of"
+				"main thread !\n");
+	intv.tv_sec = INTERVAL / NS_PER_SEC;
+	intv.tv_nsec = INTERVAL % (1 * NS_PER_SEC);
+
+	print_progress_bar(0);
+
+	setup_ftrace_marker();
+
+	for (loop = 0; loop < nr_runs; loop++) {
+		unsigned long long end;
+
+		now = rt_gettime() / NS_PER_US;
+
+		ftrace_write("Loop %d now=%lld\n", loop, now);
+
+		pthread_barrier_wait(&start_barrier);
+
+		ftrace_write("All running!!!\n");
+
+		rt_nanosleep(intv.tv_nsec);
+		print_progress_bar((loop * 100) / nr_runs);
+
+		end = rt_gettime() / NS_PER_US;
+		ftrace_write("Loop %d end now=%lld diff=%lld\n",
+				loop, end, end - now);
+		ret = pthread_barrier_wait(&end_barrier);
+
+		if (stop || (check && check_times(loop))) {
+			loop++;
+			nr_runs = loop;
+			break;
+		}
+	}
+	putc('\n', stderr);
+
+	pthread_barrier_wait(&start_barrier);
+	done = 1;
+	pthread_barrier_wait(&end_barrier);
+
+	join_threads();
+	print_results();
+
+	if (stop) {
+		/*
+		 * We use this test in bash while loops
+		 * So if we hit Ctrl-C then let the while
+		 * loop know to break.
+		 */
+		if (check < 0)
+			exit(-1);
+		else
+			exit(1);
+	}
+	if (check < 0)
+		exit(-1);
+	else
+		exit(0);
+
+	return 0;
+}
diff -Naur ltp-orig/testcases/realtime/func/rt-migrate/run_auto.sh ltp/testcases/realtime/func/rt-migrate/run_auto.sh
--- ltp-orig/testcases/realtime/func/rt-migrate/run_auto.sh	1970-01-01 05:30:00.000000000 +0530
+++ ltp/testcases/realtime/func/rt-migrate/run_auto.sh	2009-09-04 12:37:45.000000000 +0530
@@ -0,0 +1,12 @@
+#! /bin/bash
+
+profile=${1:-default}
+
+cd $(dirname $0) # Move to test directory
+if [ ! $SCRIPTS_DIR ]; then
+        # assume we're running standalone
+        export SCRIPTS_DIR=../../scripts/
+fi
+source $SCRIPTS_DIR/setenv.sh
+# Warning: tests args are now set in profiles
+$SCRIPTS_DIR/run_c_files.sh $profile rt-migrate
diff -Naur ltp-orig/testcases/realtime/profiles/default ltp/testcases/realtime/profiles/default
--- ltp-orig/testcases/realtime/profiles/default	2009-09-04 12:13:40.000000000 +0530
+++ ltp/testcases/realtime/profiles/default	2009-09-04 13:13:24.000000000 +0530
@@ -60,4 +60,4 @@
 func/pi-tests			testpi-5
 func/pi-tests			testpi-6
 func/pi-tests			sbrk_mutex
-
+func/rt-migrate                 rt-migrate


On Wed, 2009-09-02 at 12:44 +0530, Subrata Modak wrote:
> Hey,
> 
> You did not mention where it should actually go (which directory ?), and
> how you are integrating the run into the RT tests ?
> 
> Regards--
> Subrata 
> 
> On Tue, 2009-09-01 at 14:07 +0530, Kiran wrote:
> > Hi,
> > 
> > This patch converts the testcase rt-migrate-test.c to the coding format
> > used by the other realtime testcases in LTP, by making use of the
> > librttest and libstats infrastructure.
> > 
> > Signed-off-by: Kiran Prakash <kiran@linux.vnet.ibm.com>
> > Acked-by: Darren Hart <dvhltc@us.ibm.com>
> > Acked-by: Sripathi Kodi <sripathik@in.ibm.com>
> > 
> > --- rt-migrate-test_orig.c	2009-08-11 16:36:21.000000000 +0530
> > +++ rt-migrate-test.c	2009-08-17 17:20:45.000000000 +0530
> > @@ -1,5 +1,5 @@
> > -/*
> > - * rt-migrate-test.c
> > +
> > +/******************************************************************************
> >   *
> >   * Copyright (C) 2007-2009 Steven Rostedt <srostedt@redhat.com>
> >   *
> > @@ -18,7 +18,33 @@
> >   * along with this program; if not, write to the Free Software
> >   * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> >   *
> > - * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > + * NAME
> > + *      rt-migrate-test.c
> > + *
> > + * DESCRIPTION
> > + *	This test makes sure that all the high prio tasks that are in the
> > + *	running state are actually running on a CPU if it can.
> > + ** Steps:
> > + *	- Creates N+1 threads with lower real time priorities.
> > + *	  Where N is the number of CPUs in the system.
> > + *	- If the thread is high priority, and if a CPU is available, the
> > + *	  thread runs on that CPU.
> > + *	- The thread records the start time and the number of ticks in the run
> > + *	  interval.
> > + *	- The output indicates if lower prio task is quicker than higher
> > + *	  priority task.
> > + *
> > + * USAGE:
> > + *	Use run_auto.sh in the current directory to build and run the test.
> > + *
> > + * AUTHOR
> > + *      Steven Rostedt <srostedt@redhat.com>
> > + *
> > + * HISTORY
> > + *      30 July, 2009: Initial version by Steven Rostedt
> > + *      11 Aug, 2009: Converted the coding style to the one used by the realtime
> > + *                    testcases by Kiran Prakash
> > + *
> >   */
> >  #define _GNU_SOURCE
> >  #include <stdio.h>
> > @@ -42,14 +68,17 @@
> >  #include <errno.h>
> >  #include <sched.h>
> >  #include <pthread.h>
> > +#include <librttest.h>
> > +#include <libstats.h>
> > 
> >  #define gettid() syscall(__NR_gettid)
> > 
> > -#define VERSION_STRING "V 0.3"
> > +#define VERSION_STRING "V 0.4LTP"
> > 
> >  int nr_tasks;
> >  int lfd;
> > 
> > +int numcpus;
> >  static int mark_fd = -1;
> >  static __thread char buff[BUFSIZ+1];
> > 
> > @@ -90,18 +119,12 @@ static void ftrace_write(const char *fmt
> >  	write(mark_fd, buff, n);
> >  }
> > 
> > -#define nano2sec(nan) (nan / 1000000000ULL)
> > -#define nano2ms(nan) (nan / 1000000ULL)
> > -#define nano2usec(nan) (nan / 1000ULL)
> > -#define usec2nano(sec) (sec * 1000ULL)
> > -#define ms2nano(ms) (ms * 1000000ULL)
> > -#define sec2nano(sec) (sec * 1000000000ULL)
> > -#define INTERVAL ms2nano(100ULL)
> > -#define RUN_INTERVAL ms2nano(20ULL)
> > +#define INTERVAL 100ULL * NS_PER_MS
> > +#define RUN_INTERVAL 20ULL * NS_PER_MS
> >  #define NR_RUNS 50
> >  #define PRIO_START 2
> >  /* 1 millisec off */
> > -#define MAX_ERR  usec2nano(1000)
> > +#define MAX_ERR  1000 * NS_PER_US
> > 
> >  #define PROGRESS_CHARS 70
> > 
> > @@ -110,7 +133,7 @@ static unsigned long long run_interval =
> >  static unsigned long long max_err = MAX_ERR;
> >  static int nr_runs = NR_RUNS;
> >  static int prio_start = PRIO_START;
> > -static int check;
> > +static int check = 1;
> >  static int stop;
> > 
> >  static unsigned long long now;
> > @@ -120,26 +143,11 @@ static int loop;
> > 
> >  static pthread_barrier_t start_barrier;
> >  static pthread_barrier_t end_barrier;
> > -static unsigned long long **intervals;
> > -static unsigned long long **intervals_length;
> > -static unsigned long **intervals_loops;
> > +stats_container_t *intervals;
> > +stats_container_t *intervals_length;
> > +stats_container_t *intervals_loops;
> >  static long *thread_pids;
> > 
> > -static char buffer[BUFSIZ];
> > -
> > -static void perr(char *fmt, ...)
> > -{
> > -	va_list ap;
> > -
> > -	va_start(ap, fmt);
> > -	vsnprintf(buffer, BUFSIZ, fmt, ap);
> > -	va_end(ap);
> > -
> > -	perror(buffer);
> > -	fflush(stderr);
> > -	exit(-1);
> > -}
> > -
> >  static void print_progress_bar(int percent)
> >  {
> >  	int i;
> > @@ -151,7 +159,7 @@ static void print_progress_bar(int perce
> >  	/* Use stderr, so we don't capture it */
> >  	putc('\r', stderr);
> >  	putc('|', stderr);
> > -	for (i=0; i < PROGRESS_CHARS; i++)
> > +	for (i = 0; i < PROGRESS_CHARS; i++)
> >  		putc(' ', stderr);
> >  	putc('|', stderr);
> >  	putc('\r', stderr);
> > @@ -159,97 +167,59 @@ static void print_progress_bar(int perce
> > 
> >  	p = PROGRESS_CHARS * percent / 100;
> > 
> > -	for (i=0; i < p; i++)
> > +	for (i = 0; i < p; i++)
> >  		putc('-', stderr);
> > 
> >  	fflush(stderr);
> >  }
> > 
> > -static void usage(char **argv)
> > +static void usage()
> >  {
> > -	char *arg = argv[0];
> > -	char *p = arg+strlen(arg);
> > -
> > -	while (p >= arg && *p != '/')
> > -		p--;
> > -	p++;
> > -
> > -	printf("%s %s\n", p, VERSION_STRING);
> > +	rt_help();
> >  	printf("Usage:\n"
> > -	       "%s <options> nr_tasks\n\n"
> > -	       "-p prio --prio  prio        base priority to start RT tasks with (2) \n"
> > -	       "-r time --run-time time     Run time (ms) to busy loop the threads (20)\n"
> > -	       "-s time --sleep-time time   Sleep time (ms) between intervals (100)\n"
> > -	       "-m time --maxerr time       Max allowed error (microsecs)\n"
> > -	       "-l loops --loops loops      Number of iterations to run (50)\n"
> > -	       "-c    --check               Stop if lower prio task is quick than higher (off)\n"
> > -	       "  () above are defaults \n",
> > -		p);
> > -	exit(0);
> > -}
> > -
> > -static void parse_options (int argc, char *argv[])
> > -{
> > -	for (;;) {
> > -		int option_index = 0;
> > -		/** Options for getopt */
> > -		static struct option long_options[] = {
> > -			{"prio", required_argument, NULL, 'p'},
> > -			{"run-time", required_argument, NULL, 'r'},
> > -			{"sleep-time", required_argument, NULL, 's'},
> > -			{"maxerr", required_argument, NULL, 'm'},
> > -			{"loops", required_argument, NULL, 'l'},
> > -			{"check", no_argument, NULL, 'c'},
> > -			{"help", no_argument, NULL, '?'},
> > -			{NULL, 0, NULL, 0}
> > -		};
> > -		int c = getopt_long (argc, argv, "p:r:s:m:l:ch",
> > -			long_options, &option_index);
> > -		if (c == -1)
> > -			break;
> > +	       "-a priority Priority of the threads"
> > +	       "-r time     Run time (ms) to busy loop the threads (20)\n"
> > +	       "-t time     Sleep time (ms) between intervals (100)\n"
> > +	       "-e time     Max allowed error (microsecs)\n"
> > +	       "-l loops    Number of iterations to run (50)\n"
> > +	      );
> > +}
> > +
> > +static void parse_args(int c, char *v)
> > +{
> >  		switch (c) {
> > -		case 'p': prio_start = atoi(optarg); break;
> > +		case 'a': prio_start = atoi(v); break;
> >  		case 'r':
> > -			run_interval = atoi(optarg);
> > +			run_interval = atoi(v);
> >  			break;
> > -		case 's': interval = atoi(optarg); break;
> > -		case 'l': nr_runs = atoi(optarg); break;
> > -		case 'm': max_err = usec2nano(atoi(optarg)); break;
> > -		case 'c': check = 1; break;
> > +		case 't': interval = atoi(v); break;
> > +		case 'l': nr_runs = atoi(v); break;
> > +		case 'e': max_err = atoi(v) * NS_PER_US; break;
> >  		case '?':
> >  		case 'h':
> > -			usage(argv);
> > -			break;
> > +			usage();
> > +			exit(0);
> >  		}
> > -	}
> > -
> > -}
> > -
> > -static unsigned long long get_time(void)
> > -{
> > -	struct timeval tv;
> > -	unsigned long long time;
> > -
> > -	gettimeofday(&tv, NULL);
> > -
> > -	time = sec2nano(tv.tv_sec);
> > -	time += usec2nano(tv.tv_usec);
> > -
> > -	return time;
> >  }
> > 
> >  static void record_time(int id, unsigned long long time, unsigned long l)
> >  {
> >  	unsigned long long ltime;
> > -
> > +	stats_record_t rec;
> >  	if (loop >= nr_runs)
> >  		return;
> >  	time -= now;
> > -	ltime = get_time();
> > +	ltime = rt_gettime() / NS_PER_US;
> >  	ltime -= now;
> > -	intervals[loop][id] = time;
> > -	intervals_length[loop][id] = ltime;
> > -	intervals_loops[loop][id] = l;
> > +	rec.x = loop;
> > +	rec.y = time;
> > +	stats_container_append(&intervals[id], rec);
> > +	rec.x = loop;
> > +	rec.y = ltime;
> > +	stats_container_append(&intervals_length[id], rec);
> > +	rec.x = loop;
> > +	rec.y = l;
> > +	stats_container_append(&intervals_loops[id], rec);
> >  }
> > 
> >  static void print_results(void)
> > @@ -269,32 +239,26 @@ static void print_results(void)
> >  		printf("%6d  ", t);
> >  	printf("\n");
> > 
> > -	for (i=0; i < nr_runs; i++) {
> > +	for (t = 0; t < nr_tasks; t++) {
> > +		tasks_max[t] = stats_max(&intervals[t]);
> > +		tasks_min[t] = stats_min(&intervals[t]);
> > +		tasks_avg[t] = stats_avg(&intervals[t]);
> > +	}
> > +	for (i = 0; i < nr_runs; i++) {
> >  		printf("%4d:   ", i);
> > -		for (t=0; t < nr_tasks; t++) {
> > -			unsigned long long itv = intervals[i][t];
> > +		for (t = 0; t < nr_tasks; t++)
> > +			printf("%6lld  ", intervals[t].records[i].y);
> > 
> > -			if (tasks_max[t] < itv)
> > -				tasks_max[t] = itv;
> > -			if (tasks_min[t] > itv)
> > -				tasks_min[t] = itv;
> > -			tasks_avg[t] += itv;
> > -			printf("%6lld  ", nano2usec(itv));
> > -		}
> >  		printf("\n");
> >  		printf(" len:   ");
> > -		for (t=0; t < nr_tasks; t++) {
> > -			unsigned long long len = intervals_length[i][t];
> > +		for (t = 0; t < nr_tasks; t++)
> > +			printf("%6lld  ", intervals_length[t].records[i].y);
> > 
> > -			printf("%6lld  ", nano2usec(len));
> > -		}
> >  		printf("\n");
> >  		printf(" loops: ");
> > -		for (t=0; t < nr_tasks; t++) {
> > -			unsigned long loops = intervals_loops[i][t];
> > +		for (t = 0; t < nr_tasks; t++)
> > +			printf("%6ld  ", intervals_loops[t].records[i].y);
> > 
> > -			printf("%6ld  ", loops);
> > -		}
> >  		printf("\n");
> >  		printf("\n");
> >  	}
> > @@ -304,19 +268,14 @@ static void print_results(void)
> >  	for (t=0; t < nr_tasks; t++) {
> >  		printf(" Task %d (prio %d) (pid %ld):\n", t, t + prio_start,
> >  			thread_pids[t]);
> > -		printf("   Max: %lld us\n", nano2usec(tasks_max[t]));
> > -		printf("   Min: %lld us\n", nano2usec(tasks_min[t]));
> > -		printf("   Tot: %lld us\n", nano2usec(tasks_avg[t]));
> > -		printf("   Avg: %lld us\n", nano2usec(tasks_avg[t] / nr_runs));
> > +		printf("   Max: %lld us\n", tasks_max[t]);
> > +		printf("   Min: %lld us\n", tasks_min[t]);
> > +		printf("   Tot: %lld us\n", tasks_avg[t] * nr_runs);
> > +		printf("   Avg: %lld us\n", tasks_avg[t]);
> >  		printf("\n");
> >  	}
> > 
> > -	if (check) {
> > -		if (check < 0)
> > -			printf(" Failed!\n");
> > -		else
> > -			printf(" Passed!\n");
> > -	}
> > +	printf(" Result: %s\n", (check < 0) ? "FAIL" : "PASS");
> >  }
> > 
> >  static unsigned long busy_loop(unsigned long long start_time)
> > @@ -326,7 +285,7 @@ static unsigned long busy_loop(unsigned 
> > 
> >  	do {
> >  		l++;
> > -		time = get_time();
> > +		time = rt_gettime();
> >  	} while ((time - start_time) < RUN_INTERVAL);
> > 
> >  	return l;
> > @@ -334,11 +293,10 @@ static unsigned long busy_loop(unsigned 
> > 
> >  void *start_task(void *data)
> >  {
> > -	long id = (long)data;
> > +	struct thread *thr = (struct thread *)data;
> > +	long id = (long) thr->arg;
> > +	thread_pids[id] = gettid();
> >  	unsigned long long start_time;
> > -	struct sched_param param = {
> > -		.sched_priority = id + prio_start,
> > -	};
> >  	int ret;
> >  	int high = 0;
> >  	cpu_set_t cpumask;
> > @@ -349,7 +307,7 @@ void *start_task(void *data)
> > 
> >  	ret = sched_getaffinity(0, sizeof(save_cpumask), &save_cpumask);
> >  	if (ret < 0)
> > -		perr("getting affinity");
> > +		debug(DBG_ERR, "sched_getaffinity failed: %s\n", strerror(ret));
> > 
> >  	pid = gettid();
> > 
> > @@ -357,10 +315,6 @@ void *start_task(void *data)
> >  	if (id == nr_tasks-1)
> >  		high = 1;
> > 
> > -	ret = sched_setscheduler(0, SCHED_FIFO, &param);
> > -	if (ret < 0 && !id)
> > -		fprintf(stderr, "Warning, can't set priorities\n");
> > -
> >  	while (!done) {
> >  		if (high) {
> >  			/* rotate around the CPUS */
> > @@ -371,11 +325,11 @@ void *start_task(void *data)
> >  			sched_setaffinity(0, sizeof(cpumask), &cpumask);
> >  		}
> >  		pthread_barrier_wait(&start_barrier);
> > -		start_time = get_time();
> > +		start_time = rt_gettime();
> >  		ftrace_write("Thread %d: started %lld diff %lld\n",
> >  			     pid, start_time, start_time - now);
> >  		l = busy_loop(start_time);
> > -		record_time(id, start_time, l);
> > +		record_time(id, start_time / NS_PER_US, l);
> >  		pthread_barrier_wait(&end_barrier);
> >  	}
> > 
> > @@ -389,26 +343,27 @@ static int check_times(int l)
> >  	unsigned long long last_loops;
> >  	unsigned long long last_length;
> > 
> > -	for (i=0; i < nr_tasks; i++) {
> > -		if (i && last < intervals[l][i] &&
> > -		    ((intervals[l][i] - last) > max_err)) {
> > +	for (i = 0; i < nr_tasks; i++) {
> > +		if (i && last < intervals[i].records[l].y &&
> > +		    ((intervals[i].records[l].y - last) > max_err)) {
> >  			/*
> >  			 * May be a false positive.
> >  			 * Make sure that we did more loops
> >  			 * our start is before the end
> >  			 * and the end should be tested.
> >  			 */
> > -			if (intervals_loops[l][i] < last_loops ||
> > -			    intervals[l][i] > last_length ||
> > -			    (intervals_length[l][i] > last_length &&
> > -			     intervals_length[l][i] - last_length > max_err)) {
> > +			if (intervals_loops[i].records[l].y < last_loops ||
> > +			    intervals[i].records[l].y > last_length ||
> > +			    (intervals_length[i].records[l].y > last_length &&
> > +			     intervals_length[i].records[l].y - last_length >
> > +			     max_err)) {
> >  				check = -1;
> >  				return 1;
> >  			}
> >  		}
> > -		last = intervals[l][i];
> > -		last_loops = intervals_loops[l][i];
> > -		last_length = intervals_length[l][i];
> > +		last = intervals[i].records[l].y;
> > +		last_loops = intervals_loops[i].records[l].y;
> > +		last_length = intervals_length[i].records[l].y;
> >  	}
> >  	return 0;
> >  }
> > @@ -418,39 +373,6 @@ static void stop_log(int sig)
> >  	stop = 1;
> >  }
> > 
> > -static int count_cpus(void)
> > -{
> > -	FILE *fp;
> > -	char buf[1024];
> > -	int cpus = 0;
> > -	char *pbuf;
> > -	size_t *pn;
> > -	size_t n;
> > -	int r;
> > -
> > -	n = 1024;
> > -	pn = &n;
> > -	pbuf = buf;
> > -
> > -	fp = fopen("/proc/cpuinfo", "r");
> > -	if (!fp)
> > -		perr("Can not read cpuinfo");
> > -
> > -	while ((r = getline(&pbuf, pn, fp)) >= 0) {
> > -		char *p;
> > -
> > -		if (strncmp(buf, "processor", 9) != 0)
> > -			continue;
> > -		for (p = buf+9; isspace(*p); p++)
> > -			;
> > -		if (*p == ':')
> > -			cpus++;
> > -	}
> > -	fclose(fp);
> > -
> > -	return cpus;
> > -}
> > -
> >  int main (int argc, char **argv)
> >  {
> >  	pthread_t *threads;
> > @@ -459,62 +381,56 @@ int main (int argc, char **argv)
> >  	struct timespec intv;
> >  	struct sched_param param;
> > 
> > -	parse_options(argc, argv);
> > -
> > +	rt_init("a:r:t:e:l:h:", parse_args, argc, argv);
> >  	signal(SIGINT, stop_log);
> > 
> >  	if (argc >= (optind + 1))
> >  		nr_tasks = atoi(argv[optind]);
> > -	else
> > -		nr_tasks = count_cpus() + 1;
> > +	else {
> > +		numcpus = sysconf(_SC_NPROCESSORS_ONLN);
> > +		nr_tasks = numcpus + 1;
> > +	}
> > +
> > +	intervals = malloc(sizeof(stats_container_t) * nr_tasks);
> > +	if (!intervals)
> > +		debug(DBG_ERR, "malloc failed\n");
> > +	memset(intervals, 0, sizeof(stats_container_t) * nr_tasks);
> > +
> > +	intervals_length = malloc(sizeof(stats_container_t) * nr_tasks);
> > +	if (!intervals_length)
> > +		debug(DBG_ERR, "malloc failed\n");
> > +	memset(intervals_length, 0, sizeof(stats_container_t) * nr_tasks);
> > +
> > +	if (!intervals_loops)
> > +		debug(DBG_ERR, "malloc failed\n");
> > +	intervals_loops = malloc(sizeof(stats_container_t) * nr_tasks);
> > +	memset(intervals_loops, 0, sizeof(stats_container_t) * nr_tasks);
> > 
> >  	threads = malloc(sizeof(*threads) * nr_tasks);
> >  	if (!threads)
> > -		perr("malloc");
> > +		debug(DBG_ERR, "malloc failed\n");
> >  	memset(threads, 0, sizeof(*threads) * nr_tasks);
> > 
> >  	ret = pthread_barrier_init(&start_barrier, NULL, nr_tasks + 1);
> >  	ret = pthread_barrier_init(&end_barrier, NULL, nr_tasks + 1);
> >  	if (ret < 0)
> > -		perr("pthread_barrier_init");
> > +		debug(DBG_ERR, "pthread_barrier_init failed: %s\n",
> > +				strerror(ret));
> > 
> > -	intervals = malloc(sizeof(void*) * nr_runs);
> > -	if (!intervals)
> > -		perr("malloc intervals array");
> > -
> > -	intervals_length = malloc(sizeof(void*) * nr_runs);
> > -	if (!intervals_length)
> > -		perr("malloc intervals length array");
> > 
> > -	intervals_loops = malloc(sizeof(void*) * nr_runs);
> > -	if (!intervals_loops)
> > -		perr("malloc intervals loops array");
> > +	for (i = 0; i < nr_tasks; i++) {
> > +		stats_container_init(&intervals[i], nr_runs);
> > +		stats_container_init(&intervals_length[i], nr_runs);
> > +		stats_container_init(&intervals_loops[i], nr_runs);
> > +	}
> > 
> >  	thread_pids = malloc(sizeof(long) * nr_tasks);
> >  	if (!thread_pids)
> > -		perr("malloc thread_pids");
> > -
> > -	for (i=0; i < nr_runs; i++) {
> > -		intervals[i] = malloc(sizeof(unsigned long long)*nr_tasks);
> > -		if (!intervals[i])
> > -			perr("malloc intervals");
> > -		memset(intervals[i], 0, sizeof(unsigned long long)*nr_tasks);
> > -
> > -		intervals_length[i] = malloc(sizeof(unsigned long long)*nr_tasks);
> > -		if (!intervals_length[i])
> > -			perr("malloc length intervals");
> > -		memset(intervals_length[i], 0, sizeof(unsigned long long)*nr_tasks);
> > -
> > -		intervals_loops[i] = malloc(sizeof(unsigned long)*nr_tasks);
> > -		if (!intervals_loops[i])
> > -			perr("malloc loops intervals");
> > -		memset(intervals_loops[i], 0, sizeof(unsigned long)*nr_tasks);
> > -	}
> > -
> > -	for (i=0; i < nr_tasks; i++) {
> > -		if (pthread_create(&threads[i], NULL, start_task, (void *)i))
> > -			perr("pthread_create");
> > +		debug(DBG_ERR, "malloc thread_pids failed\n");
> > 
> > +	for (i = 0; i < nr_tasks; i++) {
> > +		threads[i] = create_fifo_thread(start_task, (void *)i,
> > +						prio_start + i);
> >  	}
> > 
> >  	/*
> > @@ -528,12 +444,10 @@ int main (int argc, char **argv)
> >  	memset(&param, 0, sizeof(param));
> >  	param.sched_priority = nr_tasks + prio_start;
> >  	if (sched_setscheduler(0, SCHED_FIFO, &param))
> > -		fprintf(stderr, "Warning, can't set priority of main thread!\n");
> > -		
> > -
> > -
> > -	intv.tv_sec = nano2sec(INTERVAL);
> > -	intv.tv_nsec = INTERVAL % sec2nano(1);
> > +		debug(DBG_WARN, "Warning, can't set priority of"
> > +				"main thread !\n");
> > +	intv.tv_sec = INTERVAL / NS_PER_SEC;
> > +	intv.tv_nsec = INTERVAL % (1 * NS_PER_SEC);
> > 
> >  	print_progress_bar(0);
> > 
> > @@ -542,7 +456,7 @@ int main (int argc, char **argv)
> >  	for (loop=0; loop < nr_runs; loop++) {
> >  		unsigned long long end;
> > 
> > -		now = get_time();
> > +		now = rt_gettime() / NS_PER_US;
> > 
> >  		ftrace_write("Loop %d now=%lld\n", loop, now);
> > 
> > @@ -550,14 +464,12 @@ int main (int argc, char **argv)
> > 
> >  		ftrace_write("All running!!!\n");
> > 
> > -		nanosleep(&intv, NULL);
> > -
> > +		rt_nanosleep(intv.tv_nsec);
> >  		print_progress_bar((loop * 100)/ nr_runs);
> > 
> > -		end = get_time();
> > +		end = rt_gettime() / NS_PER_US;
> >  		ftrace_write("Loop %d end now=%lld diff=%lld\n", loop, end, end - now);
> > -
> > -		pthread_barrier_wait(&end_barrier);
> > +		ret = pthread_barrier_wait(&end_barrier);
> > 
> >  		if (stop || (check && check_times(loop))) {
> >  			loop++;
> > @@ -571,9 +483,7 @@ int main (int argc, char **argv)
> >  	done = 1;
> >  	pthread_barrier_wait(&end_barrier);
> > 
> > -	for (i=0; i < nr_tasks; i++)
> > -		pthread_join(threads[i], (void*)&thread_pids[i]);
> > -
> > +	join_threads();
> >  	print_results();
> > 
> >  	if (stop) {
> > 
> > 
> > 
> > ------------------------------------------------------------------------------
> > Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
> > trial. Simplify your report design, integration and deployment - and focus on 
> > what you do best, core application coding. Discover what's new with 
> > Crystal Reports now.  http://p.sf.net/sfu/bobj-july
> > _______________________________________________
> > Ltp-list mailing list
> > Ltp-list@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/ltp-list
> 


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
