Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1SDcqF-0006Zm-Jm
	for ltp-list@lists.sourceforge.net; Fri, 30 Mar 2012 14:30:15 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SDcqA-0003f0-0b
	for ltp-list@lists.sourceforge.net; Fri, 30 Mar 2012 14:30:15 +0000
From: Zhouping Liu <zliu@redhat.com>
Date: Fri, 30 Mar 2012 22:29:58 +0800
Message-Id: <aef1be3a718b56357b90b2a7f06f583c2a3c240d.1333117443.git.zliu@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.7.6"
Subject: [LTP] [PATCH] mm/tunable: fix unexpected error log in
	min_free_kbytes
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
--------------1.7.7.6
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


when overcommit_memory=0, mmap() will be destroyed in two below scenario:
 1) MAP_FAILED with ENOMEM,
 2) oom_killer kill it.
without the patch, it just catched oom_killer scenario,
the patch fixed it.

Signed-off-by: Zhouping Liu <zliu@redhat.com>
---
 testcases/kernel/mem/tunable/min_free_kbytes.c |   17 +++++++++++++----
 1 files changed, 13 insertions(+), 4 deletions(-)


--------------1.7.7.6
Content-Type: text/x-patch;
	name="0001-mm-tunable-fix-unexpected-error-log-in-min_free_kbyt.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0001-mm-tunable-fix-unexpected-error-log-in-min_free_kbyt.patch"

diff --git a/testcases/kernel/mem/tunable/min_free_kbytes.c b/testcases/kernel/mem/tunable/min_free_kbytes.c
index a69e129..00ead04 100644
--- a/testcases/kernel/mem/tunable/min_free_kbytes.c
+++ b/testcases/kernel/mem/tunable/min_free_kbytes.c
@@ -92,7 +92,6 @@ int main(int argc, char *argv[])
 		exit(0);
 	}
 
-
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		Tst_count = 0;
 
@@ -101,7 +100,6 @@ int main(int argc, char *argv[])
 		test_tune(1);
 	}
 
-
 	if (kill(pid, SIGUSR1) == -1)
 		tst_brkm(TBROK|TERRNO, cleanup, "kill %d", pid);
 	if (waitpid(pid, &status, WUNTRACED|WCONTINUED)  == -1)
@@ -150,10 +148,21 @@ static void test_tune(unsigned long overcommit_policy)
 			if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
 				tst_resm(TFAIL,
 				    "child unexpectedly failed: %d", status);
-		} else {
+		} else if (overcommit_policy == 1) {
 			if (!WIFSIGNALED(status) || WTERMSIG(status) != SIGKILL)
 				tst_resm(TFAIL,
 				    "child unexpectedly failed: %d", status);
+		} else {
+			if (WIFEXITED(status)) {
+				if (WEXITSTATUS(status) != 0) {
+					tst_resm(TFAIL, "child unexpectedly "
+					    "failed: %d", status);
+				}
+			} else if (!WIFSIGNALED(status) ||
+				    WTERMSIG(status) != SIGKILL) {
+				tst_resm(TFAIL,
+				    "child unexpectedly failed: %d", status);
+			}
 		}
 	}
 }
@@ -178,7 +187,7 @@ static int eatup_mem(unsigned long overcommit_policy)
 		addrs[i] = mmap(NULL, MAP_SIZE, PROT_READ|PROT_WRITE,
 		    MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
 		if (addrs[i] == MAP_FAILED) {
-			if (overcommit_policy != 2 || errno != ENOMEM) {
+			if (overcommit_policy != 1 && errno != ENOMEM) {
 				perror("mmap");
 				ret = -1;
 			}

--------------1.7.7.6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
--------------1.7.7.6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.7.6--



