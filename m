Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <jstancek@redhat.com>) id 1QEyI0-0004T1-KV
	for ltp-list@lists.sourceforge.net; Wed, 27 Apr 2011 06:31:56 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1QEyHz-0000Gg-Nw
	for ltp-list@lists.sourceforge.net; Wed, 27 Apr 2011 06:31:56 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p3R6Vnf9005033
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 27 Apr 2011 02:31:49 -0400
Received: from laptop.jstancek.net (dustball.brq.redhat.com [10.34.26.57])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id p3R6VmoQ018112
	for <ltp-list@lists.sourceforge.net>; Wed, 27 Apr 2011 02:31:49 -0400
Message-ID: <4DB7B854.8010304@redhat.com>
Date: Wed, 27 Apr 2011 08:31:48 +0200
From: Jan Stancek <jstancek@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050307020607070306080109"
Subject: [LTP] [PATCH] kill05: fix race condition in do_master_child
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
To: ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------050307020607070306080109
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


There is a race condition when starting child. Master child can go
forward before child changes its reuid.
Fix this by waiting until child is ready.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
  testcases/kernel/syscalls/kill/kill05.c |   25 +++++++++++++++++--------
  1 files changed, 17 insertions(+), 8 deletions(-)



--------------050307020607070306080109
Content-Type: text/x-patch;
	name="0001-kill05-fix-race-condition-in-do_master_child.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0001-kill05-fix-race-condition-in-do_master_child.patch"

diff --git a/testcases/kernel/syscalls/kill/kill05.c b/testcases/kernel/syscalls/kill/kill05.c
index e44b690..fe34788 100644
--- a/testcases/kernel/syscalls/kill/kill05.c
+++ b/testcases/kernel/syscalls/kill/kill05.c
@@ -130,6 +130,16 @@ int main(int ac, char **av)
 	tst_exit();
 }
 
+void wait_for_flag(int value)
+{
+	while (1) {
+		if (*flag == value)
+			break;
+		else
+			sleep(1);
+	}
+}
+
 /*
  * do_master_child()
  */
@@ -160,6 +170,7 @@ void do_master_child(char **av)
 			perror("setreuid failed (in child)");
 			exit(1);
 		}
+		*flag = 1;
 #ifdef UCLINUX
 		if (self_exec(av[0], "") < 0) {
 			perror("self_exec failed");
@@ -175,10 +186,13 @@ void do_master_child(char **av)
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
@@ -204,13 +218,8 @@ void do_master_child(char **av)
 
 void do_child()
 {
-
-	while (1) {
-		if (*flag == 1)
-			exit(0);
-		else
-			sleep(1);
-	}
+	wait_for_flag(2);
+	exit(0);
 }
 
 void setup(void)


--------------050307020607070306080109
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
WhatsUp Gold - Download Free Network Management Software
The most intuitive, comprehensive, and cost-effective network 
management toolset available today.  Delivers lowest initial 
acquisition cost and overall TCO of any competing solution.
http://p.sf.net/sfu/whatsupgold-sd
--------------050307020607070306080109
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------050307020607070306080109--

