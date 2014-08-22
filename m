Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1XKoVe-0003r9-Of
	for ltp-list@lists.sourceforge.net; Fri, 22 Aug 2014 13:04:02 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XKoVd-0006fu-FO
	for ltp-list@lists.sourceforge.net; Fri, 22 Aug 2014 13:04:02 +0000
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s7MD3s6D008414
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 22 Aug 2014 09:03:54 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id s7MD3qBt015761
	for <ltp-list@lists.sourceforge.net>; Fri, 22 Aug 2014 09:03:53 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 22 Aug 2014 15:03:52 +0200
Message-Id: <f8ac54907cad048b8c762d0394f5e86c0ccaa5da.1408712259.git.jstancek@redhat.com>
Subject: [LTP] [PATCH] sendmsg02: fix parameter passed to semctl(SETVAL)
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

The fourth has the type union semun.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/sendmsg/sendmsg02.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/sendmsg/sendmsg02.c b/testcases/kernel/syscalls/sendmsg/sendmsg02.c
index 669af20..d96e10c 100644
--- a/testcases/kernel/syscalls/sendmsg/sendmsg02.c
+++ b/testcases/kernel/syscalls/sendmsg/sendmsg02.c
@@ -46,6 +46,12 @@
 #include "usctest.h"
 #include "safe_macros.h"
 
+union semun {
+	int val;
+	struct semid_ds *buf;
+	unsigned short int *array;
+};
+
 char *TCID = "sendmsg02";
 
 static int sem_id;
@@ -126,10 +132,12 @@ static void reproduce(int seconds)
 	int child_count = 0;
 	int *child_pids;
 	int child_pid;
+	union semun u;
 
 	child_pids = SAFE_MALLOC(cleanup, sizeof(int) * child_pairs * 2);
 
-	if (semctl(sem_id, 0, SETVAL, 1) == -1)
+	u.val = 1;
+	if (semctl(sem_id, 0, SETVAL, u) == -1)
 		tst_brkm(TBROK | TERRNO, cleanup, "couldn't set semval to 1");
 
 	/* fork child for each client/server pair */
@@ -168,7 +176,8 @@ static void reproduce(int seconds)
 	if (child_count == child_pairs*2)
 		sleep(seconds);
 
-	if (semctl(sem_id, 0, SETVAL, 0) == -1) {
+	u.val = 0;
+	if (semctl(sem_id, 0, SETVAL, u) == -1) {
 		/* kill children if setting semval failed */
 		for (i = 0; i < child_count; i++)
 			kill(child_pids[i], SIGKILL);
-- 
1.7.1


------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
