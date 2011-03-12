Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <penght@cn.fujitsu.com>) id 1PyKgl-0005rB-DY
	for ltp-list@lists.sourceforge.net; Sat, 12 Mar 2011 09:00:43 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1PyKge-0003C5-C5
	for ltp-list@lists.sourceforge.net; Sat, 12 Mar 2011 09:00:43 +0000
Message-ID: <4D7B3610.2000905@cn.fujitsu.com>
Date: Sat, 12 Mar 2011 17:00:00 +0800
From: Peng Haitao <penght@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [ltp] [PATCH] shmctl01.c: fix error of the case need
	sighandler()
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net


The case expect the signal "SIGUSR1" to wake up child process, so should add
sighandler().

Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>
---
 testcases/kernel/syscalls/ipc/shmctl/shmctl01.c |   18 +++++++++++++-----
 1 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c
index 693bf97..f72487b 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c
@@ -138,9 +138,9 @@ int main(int ac, char **av)
 	void check_functionality(void);
 
 	/* parse standard options */
-	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL) {
+	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
-	}
+
 #ifdef UCLINUX
 	argv0 = av[0];
 	maybe_run_child(do_child, "ddd", &stat_i, &stat_time, &shm_id_1);
@@ -231,8 +231,7 @@ void *set_shmat()
 	 * print a message to that effect.
 	 */
 	if (rval == (void *)-1) {
-		tst_resm(TBROK, "shmat() failed - %s", strerror(errno));
-		cleanup();
+		tst_brkm(TBROK, cleanup, "shmat() failed - %s", strerror(errno));
 	}
 
 	return rval;
@@ -485,10 +484,19 @@ void func_rmid()
 	shm_id_1 = -1;
 }
 
+/*
+ * sighandler() - handle signals, in this case SIGUSR1 is the only one expected
+ */
+void sighandler(sig)
+{
+	if (sig != SIGUSR1)
+		tst_resm(TINFO, "received unexpected signal %d", sig);
+}
+
 void setup(void)
 {
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(FORK, sighandler, cleanup);
 
 	TEST_PAUSE;
 
-- 
1.7.1

-- 
Best Regards,
Peng Haitao


------------------------------------------------------------------------------
Colocation vs. Managed Hosting
A question and answer guide to determining the best fit
for your organization - today and in the future.
http://p.sf.net/sfu/internap-sfd2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
