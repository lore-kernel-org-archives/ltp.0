Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1S5sOG-0000og-Ea
	for ltp-list@lists.sourceforge.net; Fri, 09 Mar 2012 05:29:20 +0000
Received: from mail-tul01m020-f175.google.com ([209.85.214.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1S5sOF-00065v-QO
	for ltp-list@lists.sourceforge.net; Fri, 09 Mar 2012 05:29:20 +0000
Received: by obqv19 with SMTP id v19so2243583obq.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 08 Mar 2012 21:29:14 -0800 (PST)
From: Caspar Zhang <caspar@casparzhang.com>
Date: Fri,  9 Mar 2012 13:28:06 +0800
Message-Id: <1331270886-22153-1-git-send-email-caspar@casparzhang.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.8.4"
Subject: [LTP] [PATCH] sched_getaffinity: fix possible fail in negative case
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: LTP List <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------1.7.8.4
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


in negative case:

    QUICK_TEST(sched_getaffinity(getpid()+1, len, mask));

sometimes getpid()+1 will exist if there're other processes running.
This patch uses a different way to make sure the required pid doesn't
exist by forking a child and terminating it. The pid of the terminated
child will not be used for a short time and it's enough for the test to
continue.

Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
---
 .../sched_getaffinity/sched_getaffinity01.c        |   18 ++++++++++++++++--
 1 files changed, 16 insertions(+), 2 deletions(-)


--------------1.7.8.4
Content-Type: text/x-patch;
	name="0001-sched_getaffinity-fix-possible-fail-in-negative-case.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0001-sched_getaffinity-fix-possible-fail-in-negative-case.patch"

diff --git a/testcases/kernel/syscalls/sched_getaffinity/sched_getaffinity01.c b/testcases/kernel/syscalls/sched_getaffinity/sched_getaffinity01.c
index 97cf90f..80dea9a 100644
--- a/testcases/kernel/syscalls/sched_getaffinity/sched_getaffinity01.c
+++ b/testcases/kernel/syscalls/sched_getaffinity/sched_getaffinity01.c
@@ -94,7 +94,7 @@ int main(int ac, char **av)
 
 static void do_test(void)
 {
-	int i;
+	int i, status;
 	cpu_set_t *mask;
 	int nrcpus = 1024;
 	pid_t pid;
@@ -153,10 +153,24 @@ realloc:
 #else
 	CPU_ZERO(mask);
 #endif
+
 	/* negative tests */
+
 	QUICK_TEST(sched_getaffinity(0, len, (cpu_set_t *)-1));
+
 	QUICK_TEST(sched_getaffinity(0, 0, mask));
-	QUICK_TEST(sched_getaffinity(getpid() + 1, len, mask));
+
+	switch (pid = fork()) {
+	case -1:
+		tst_brkm(TBROK|TERRNO, cleanup, "fork");
+	case 0:
+		exit(0);
+	default:
+		if (waitpid(pid, &status, WUNTRACED|WCONTINUED) == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "waitpid");
+	}
+	QUICK_TEST(sched_getaffinity(pid, len, mask));
+
 	/*
 	 * pid_t -> int -- the actual kernel limit is lower
 	 * though, but this is a negative test, not a positive

--------------1.7.8.4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
--------------1.7.8.4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.8.4--



