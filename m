Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <weijg.fnst@cn.fujitsu.com>) id 1YzMYq-0005a7-Ak
	for ltp-list@lists.sourceforge.net; Mon, 01 Jun 2015 10:03:12 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YzMYm-0004ua-MN
	for ltp-list@lists.sourceforge.net; Mon, 01 Jun 2015 10:03:12 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t51A1VBb021377
	for <ltp-list@lists.sourceforge.net>; Mon, 1 Jun 2015 18:01:31 +0800
From: "Wei,Jiangang" <weijg.fnst@cn.fujitsu.com>
Date: Mon, 1 Jun 2015 18:02:23 +0800
Message-ID: <1433152944-759-1-git-send-email-weijg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 1/2] sched_setparam/9-1: cleanup code and fix memory
	leak
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
To: ltp-list@lists.sourceforge.net

1) add a parameter for kill_children() and replace
   the for-loop(s) of kill() with it.

2) free the memory after killing children process.

Signed-off-by: Wei,Jiangang <weijg.fnst@cn.fujitsu.com>
---
 .../conformance/interfaces/sched_setparam/9-1.c       | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/9-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/9-1.c
index 48ef1b0..24fe761 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/9-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/9-1.c
@@ -131,12 +131,13 @@ static void test_process(void)
 	pause();
 }
 
-static void kill_children(int *child_pid)
+static void kill_children(int *child_pid, int count)
 {
 	int i;
 
-	for (i = 0; i < nb_cpu; i++)
+	for (i = 0; i < count; i++)
 		kill(child_pid[i], SIGTERM);
+	free(child_pid);
 }
 
 int main(void)
@@ -191,9 +192,7 @@ int main(void)
 		child_pid[i] = fork();
 		if (child_pid[i] == -1) {
 			perror("An error occurs when calling fork()");
-			for (j = 0; j < i; j++)
-				kill(child_pid[j], SIGTERM);
-
+			kill_children(child_pid, i)
 			return PTS_UNRESOLVED;
 		} else if (child_pid[i] == 0) {
 
@@ -207,9 +206,7 @@ int main(void)
 	child_pid[i] = fork();
 	if (child_pid[i] == -1) {
 		perror("An error occurs when calling fork()");
-		for (j = 0; j < i; j++)
-			kill(child_pid[j], SIGTERM);
-
+		kill_children(child_pid, i);
 		return PTS_UNRESOLVED;
 	} else if (child_pid[i] == 0) {
 
@@ -223,7 +220,7 @@ int main(void)
 	oldcount = *shmptr;
 	if (sched_setparam(child_pid[i], &param) != 0) {
 		perror("An error occurs when calling sched_setparam()");
-		kill_children(child_pid);
+		kill_children(child_pid, nb_cpu);
 		return PTS_UNRESOLVED;
 	}
 	newcount = *shmptr;
@@ -231,11 +228,11 @@ int main(void)
 	if (newcount == oldcount) {
 		printf("The target process does not preempt"
 		       " the calling process\n");
-		kill_children(child_pid);
+		kill_children(child_pid, nb_cpu);
 		return PTS_FAIL;
 	}
 
 	printf("Test PASSED\n");
-	kill_children(child_pid);
+	kill_children(child_pid, nb_cpu);
 	return PTS_PASS;
 }
-- 
1.9.3


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
