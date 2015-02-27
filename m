Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1YRIMd-0004xo-Ff
	for ltp-list@lists.sourceforge.net; Fri, 27 Feb 2015 10:41:47 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YRIMc-0004jB-36
	for ltp-list@lists.sourceforge.net; Fri, 27 Feb 2015 10:41:47 +0000
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t1RAfdxp021679
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Fri, 27 Feb 2015 05:41:39 -0500
From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 27 Feb 2015 11:41:32 +0100
Message-Id: <2370af01ebeb2c4014c6d0c4252818a6138d8e19.1425033440.git.jstancek@redhat.com>
Subject: [LTP] [PATCH 1/2] sched_setparam/9-1: fix hang on -rt kernel
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: jkastner@redhat.com

As mentioned in [1], the testcase hangs on -rt kernel,
because alarm(2) will never fire. The testcase runs with
FIFO scheduling of higher priority than ksoftirqd.

This patch changes testcase in following way:
1. In good case, where child process preempts parent,
   child is able to detect this condition and terminate.
2. In bad case, where preemption fails, testcase doesn't
   rely on softirq (alarm), but hrtimer (time).
3. removes unnecessary sleep

[1] https://lkml.org/lkml/2006/1/10/481

Reported-by: Jiri Kastner <jkastner@redhat.com>
Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../conformance/interfaces/sched_setparam/9-1.c    | 48 ++++++++++++++--------
 1 file changed, 32 insertions(+), 16 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/9-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/9-1.c
index ed90cee..354e03e 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/9-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/9-1.c
@@ -31,14 +31,15 @@
  *      not, the test fail.
  */
 #define _GNU_SOURCE
+#include <errno.h>
 #include <sched.h>
 #include <stdio.h>
 #include <signal.h>
+#include <stdlib.h>
 #include <sys/ipc.h>
 #include <sys/shm.h>
+#include <time.h>
 #include <unistd.h>
-#include <stdlib.h>
-#include <errno.h>
 #include "posixtest.h"
 #include "affinity.h"
 
@@ -55,6 +56,7 @@
 
 static int nb_cpu;
 static int *shmptr;
+static int mean_prio;
 
 static int get_ncpu(void)
 {
@@ -85,6 +87,7 @@ static int get_ncpu(void)
 static void child_process(void)
 {
 	struct sched_param param;
+	time_t t1, t2;
 
 	param.sched_priority = sched_get_priority_max(SCHED_FIFO);
 	if (sched_setparam(getpid(), &param) != 0) {
@@ -92,20 +95,33 @@ static void child_process(void)
 		return;
 	}
 
-	/* to avoid blocking */
-	alarm(2);
-	while (1) ;
+	t1 = time(NULL);
+	do {
+		t2 = time(NULL);
+	} while (difftime(t2, t1) <= 2);
 }
 
 static void test_process(void)
 {
-	/* to avoid blocking */
-	alarm(2);
-
-	while (1) {
-		(*shmptr)++;
+	struct sched_param param;
+	time_t t1, t2;
+
+	t1 = time(NULL);
+	do {
+		sched_getparam(getpid(), &param);
+		(*shmptr) = param.sched_priority;
+		/* if we can see that our priority has changed
+		 * that means we preempted parent, so we are done */
+		if ((*shmptr) == mean_prio)
+			break;
+
+		t2 = time(NULL);
+		/* immediately after parent forks us, we has same
+		 * priority and compete with parent for same CPU,
+		 * give parent chance to run and boost our priority */
 		sched_yield();
-	}
+	} while (difftime(t2, t1) <= 2);
+	exit(0);
 }
 
 static void kill_children(int *child_pid)
@@ -133,6 +149,8 @@ int main(void)
 		nb_cpu = 1;
 	}
 
+	mean_prio = (sched_get_priority_min(SCHED_FIFO) +
+		sched_get_priority_max(SCHED_FIFO)) / 2;
 	child_pid = malloc(nb_cpu * sizeof(int));
 
 	key = ftok("conformance/interfaces/sched_setparam/9-1.c", 1234);
@@ -194,11 +212,9 @@ int main(void)
 		return PTS_UNRESOLVED;
 	}
 
-	sleep(1);
-
-	param.sched_priority = (sched_get_priority_min(SCHED_FIFO) +
-				sched_get_priority_max(SCHED_FIFO)) / 2;
-
+	/* parent runs, which means test_process() gave up cpu,
+	 * boost its priority and check it preempted parent */
+	param.sched_priority = mean_prio;
 	oldcount = *shmptr;
 	if (sched_setparam(child_pid[i], &param) != 0) {
 		perror("An error occurs when calling sched_setparam()");
-- 
1.8.3.1


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
