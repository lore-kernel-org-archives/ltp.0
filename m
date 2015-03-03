Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1YSps2-00030x-44
	for ltp-list@lists.sourceforge.net; Tue, 03 Mar 2015 16:40:34 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YSps0-00052r-51
	for ltp-list@lists.sourceforge.net; Tue, 03 Mar 2015 16:40:34 +0000
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t23GeOwe017021
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Tue, 3 Mar 2015 11:40:25 -0500
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id t23GeNgB020379
	for <ltp-list@lists.sourceforge.net>; Tue, 3 Mar 2015 11:40:24 -0500
From: Jan Stancek <jstancek@redhat.com>
Date: Tue,  3 Mar 2015 17:40:18 +0100
Message-Id: <d3991bc7d1ccd42c00b14efb65dfbd0ae17a2b6b.1425400593.git.jstancek@redhat.com>
Subject: [LTP] [PATCH v2] sched_setparam/9-1: fix hang on -rt kernel
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
 .../conformance/interfaces/sched_setparam/9-1.c    | 53 +++++++++++++++-------
 1 file changed, 37 insertions(+), 16 deletions(-)

Changes in v2:
- refined comment
- replace exit() with pause(), so kill_children() has pid to kill

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/9-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/9-1.c
index ed90cee..48ef1b0 100644
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
@@ -92,20 +95,40 @@ static void child_process(void)
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
+		/* OS-es supporting set_affinity(), like Linux, will
+		 * have only one parent and child process competing
+		 * for same CPU. Since code path in parent does not
+		 * block between fork() and sched_setparam(), child
+		 * should run only after parent boosted its priority.
+		 * Situation on other OS-es is a bit less predictable,
+		 * as these will spawn ncpu-1 children, which run at max
+		 * priority and could (though unlikely) preempt parent.
+		 * Rather than risking deadlock, keep the sched_yield()
+		 * call in loop as it is harmless. */
 		sched_yield();
-	}
+	} while (difftime(t2, t1) <= 2);
+	pause();
 }
 
 static void kill_children(int *child_pid)
@@ -133,6 +156,8 @@ int main(void)
 		nb_cpu = 1;
 	}
 
+	mean_prio = (sched_get_priority_min(SCHED_FIFO) +
+		sched_get_priority_max(SCHED_FIFO)) / 2;
 	child_pid = malloc(nb_cpu * sizeof(int));
 
 	key = ftok("conformance/interfaces/sched_setparam/9-1.c", 1234);
@@ -194,11 +219,7 @@ int main(void)
 		return PTS_UNRESOLVED;
 	}
 
-	sleep(1);
-
-	param.sched_priority = (sched_get_priority_min(SCHED_FIFO) +
-				sched_get_priority_max(SCHED_FIFO)) / 2;
-
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
