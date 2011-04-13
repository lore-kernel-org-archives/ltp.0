Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <jstancek@redhat.com>) id 1Q9vHs-0007KG-Dm
	for ltp-list@lists.sourceforge.net; Wed, 13 Apr 2011 08:18:56 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1Q9vHm-0006FK-T8
	for ltp-list@lists.sourceforge.net; Wed, 13 Apr 2011 08:18:56 +0000
Date: Wed, 13 Apr 2011 04:18:45 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <987671813.49949.1302682725050.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <22027122.49784.1302682072069.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] kill05: fix sporadic failures
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
Cc: Jeffrey Burke <jburke@redhat.com>

Test failed sporadically, because of:

1. misusage of getpwnam causes ltpuser1 and ltpuser2 to point
to same passwd structure, from getpwnam(3):
"The return value may point to a static area, and may be overwritten by
subsequent calls to getpwent(3)."
Fix this by copying the results from returned pointer.

2. race condition between parent and child
The test actually worked when child didn't have time to set its euid.
Fix this by waiting for child to set its euid.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/kill/kill05.c |   47 ++++++++++++++++++++++--------
 1 files changed, 34 insertions(+), 13 deletions(-)

diff --git a/testcases/kernel/syscalls/kill/kill05.c b/testcases/kernel/syscalls/kill/kill05.c
index 0193100..1593932 100644
--- a/testcases/kernel/syscalls/kill/kill05.c
+++ b/testcases/kernel/syscalls/kill/kill05.c
@@ -61,6 +61,13 @@
  *      - Fix deletion of IPC memory segment. Segment was not correctly
  *        deleted due to the change of uid during the test.
  *
+ *      13/04/2001 Jan Stancek (jstancek@redhat.com)
+ *      - Fix misusage of getpwnam
+ *        "The return value may point to a static area, and may be
+ *        overwritten by subsequent calls to getpwent(3)"
+ *      - Fix race condition between parent and child
+ *        Wait for child to set its euid before attempting to kill it
+ *
  * RESTRICTIONS
  *	This test must be run as root.
  *	Looping with the -i option does not work correctly.
@@ -130,6 +137,16 @@ int main(int ac, char **av)
 	tst_exit();
 }
 
+void wait_for_flag(int value)
+{
+	while (1) {
+		if (*flag == value)
+			exit(0);
+		else
+			sleep(1);
+	}
+}
+
 /*
  * do_master_child()
  */
@@ -141,10 +158,16 @@ void do_master_child(char **av)
 	char user1name[] = "nobody";
 	char user2name[] = "bin";
 
-	struct passwd *ltpuser1, *ltpuser2;
+	struct passwd *user;
+	unsigned int uid1, uid2, gid1, gid2;
 
-	ltpuser1 = SAFE_GETPWNAM(NULL, user1name);
-	ltpuser2 = SAFE_GETPWNAM(NULL, user2name);
+	user = SAFE_GETPWNAM(NULL, user1name);
+	uid1 = user->pw_uid;
+	gid1 = user->pw_gid;
+
+	user = SAFE_GETPWNAM(NULL, user2name);
+	uid2 = user->pw_uid;
+	gid2 = user->pw_gid;
 
 	TEST_EXP_ENOS(exp_enos);
 
@@ -158,11 +181,11 @@ void do_master_child(char **av)
 		tst_brkm(TBROK|TERRNO, cleanup, "Fork failed");
 
 	if (pid1 == 0) {
-
-		if (setreuid(ltpuser1->pw_uid, ltpuser1->pw_uid) == -1) {
+		if (setreuid(uid1, gid1) == -1) {
 			perror("setreuid failed (in child)");
 			exit(1);
 		}
+		*flag = 1;
 #ifdef UCLINUX
 		if (self_exec(av[0], "") < 0) {
 			perror("self_exec failed");
@@ -172,15 +195,18 @@ void do_master_child(char **av)
 		do_child();
 #endif
 	}
-	if (setreuid(ltpuser2->pw_uid, ltpuser2->pw_uid) == -1) {
+	if (setreuid(uid2, gid2) == -1) {
 		perror("seteuid failed");
 		exit(1);
 	}
 
+	/* wait until child sets its euid */
+	wait_for_flag(1);
+
 	TEST(kill(pid1, TEST_SIG));
 
 	/* signal the child that we're done */
-	*flag = 1;
+	*flag = 2;
 
 	if (waitpid(pid1, &status, 0) == -1) {
 		perror("waitpid failed");
@@ -209,12 +235,7 @@ void do_child()
 	pid_t my_pid;
 
 	my_pid = getpid();
-	while (1) {
-		if (*flag == 1)
-			exit(0);
-		else
-			sleep(1);
-	}
+	wait_for_flag(2);
 }
 
 void setup(void)
-- 
1.7.1

------------------------------------------------------------------------------
Forrester Wave Report - Recovery time is now measured in hours and minutes
not days. Key insights are discussed in the 2010 Forrester Wave Report as
part of an in-depth evaluation of disaster recovery service providers.
Forrester found the best-in-class provider in terms of services and vision.
Read this report now!  http://p.sf.net/sfu/ibm-webcastpromo
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
