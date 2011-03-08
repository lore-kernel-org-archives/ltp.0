Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <penght@cn.fujitsu.com>) id 1PwpgB-0004yf-Bc
	for ltp-list@lists.sourceforge.net; Tue, 08 Mar 2011 05:41:55 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1Pwpg9-00062s-IJ
	for ltp-list@lists.sourceforge.net; Tue, 08 Mar 2011 05:41:55 +0000
Message-ID: <4D75C1AA.3020302@cn.fujitsu.com>
Date: Tue, 08 Mar 2011 13:42:02 +0800
From: Peng Haitao <penght@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] kill05.c: fix fail due to the same pw_uid of ltpuser1
 and ltpuser2
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

Hi Garrett,

When the macro "SAFE_GETPWNAM" is called twice, the return values are the same.
This may cause the case failure.

Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>
---
 testcases/kernel/syscalls/kill/kill05.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/kill/kill05.c b/testcases/kernel/syscalls/kill/kill05.c
index 0193100..6a80597 100644
--- a/testcases/kernel/syscalls/kill/kill05.c
+++ b/testcases/kernel/syscalls/kill/kill05.c
@@ -143,9 +143,6 @@ void do_master_child(char **av)
 
 	struct passwd *ltpuser1, *ltpuser2;
 
-	ltpuser1 = SAFE_GETPWNAM(NULL, user1name);
-	ltpuser2 = SAFE_GETPWNAM(NULL, user2name);
-
 	TEST_EXP_ENOS(exp_enos);
 
 	Tst_count = 0;
@@ -158,7 +155,7 @@ void do_master_child(char **av)
 		tst_brkm(TBROK|TERRNO, cleanup, "Fork failed");
 
 	if (pid1 == 0) {
-
+		ltpuser1 = SAFE_GETPWNAM(NULL, user1name);
 		if (setreuid(ltpuser1->pw_uid, ltpuser1->pw_uid) == -1) {
 			perror("setreuid failed (in child)");
 			exit(1);
@@ -172,6 +169,7 @@ void do_master_child(char **av)
 		do_child();
 #endif
 	}
+	ltpuser2 = SAFE_GETPWNAM(NULL, user2name);
 	if (setreuid(ltpuser2->pw_uid, ltpuser2->pw_uid) == -1) {
 		perror("seteuid failed");
 		exit(1);
-- 
1.7.1

-- 
Best Regards,
Peng Haitao


------------------------------------------------------------------------------
What You Don't Know About Data Connectivity CAN Hurt You
This paper provides an overview of data connectivity, details
its effect on application quality, and explores various alternative
solutions. http://p.sf.net/sfu/progress-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
