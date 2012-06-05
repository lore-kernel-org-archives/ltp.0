Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1SbrxP-0005cG-2A
	for ltp-list@lists.sourceforge.net; Tue, 05 Jun 2012 11:29:51 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SbrxJ-0007e7-Dh
	for ltp-list@lists.sourceforge.net; Tue, 05 Jun 2012 11:29:51 +0000
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q55BTdLo027926
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 5 Jun 2012 07:29:39 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id q55BTc6g022349
	for <ltp-list@lists.sourceforge.net>; Tue, 5 Jun 2012 07:29:38 -0400
Message-ID: <4FCDEDA1.8090709@redhat.com>
Date: Tue, 05 Jun 2012 13:29:37 +0200
From: Jan Stancek <jstancek@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020906010901060403010208"
Subject: [LTP] [PATCH] dio_sparse: prevent race between kill and signal
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
--------------020906010901060403010208
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


If child gets killed before it completes signal(SIGTERM, SIG_DFL),
then kill(childpid, SIGTERM) causes testcase to fail, because
it is caught by LTP def_handler.

For example:
dio_sparse    0  TINFO  :  Dirtying free blocks
dio_sparse    0  TINFO  :  Starting I/O tests
dio_sparse    1  TBROK  :  unexpected signal 15 received (pid = 10319).
dio_sparse    2  TBROK  :  Remaining cases broken
...

Fix this by adding semaphore to wait until all children complete
signal() before killing them.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/io/ltp-aiodio/dio_sparse.c |   43 +++++++++++++++++++++++++-
 1 files changed, 41 insertions(+), 2 deletions(-)



--------------020906010901060403010208
Content-Type: text/x-patch;
	name="0001-dio_sparse-prevent-race-between-kill-and-signal.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-dio_sparse-prevent-race-between-kill-and-signal.patch"

diff --git a/testcases/kernel/io/ltp-aiodio/dio_sparse.c b/testcases/kernel/io/ltp-aiodio/dio_sparse.c
index e93dcd9..376da33 100644
--- a/testcases/kernel/io/ltp-aiodio/dio_sparse.c
+++ b/testcases/kernel/io/ltp-aiodio/dio_sparse.c
@@ -30,7 +30,10 @@
 #include <stdio.h>
 #include <unistd.h>
 #include <memory.h>
+#include <sys/ipc.h>
 #include <sys/mman.h>
+#include <sys/sem.h>
+#include <sys/types.h>
 #include <sys/wait.h>
 #include <limits.h>
 #include <getopt.h>
@@ -110,6 +113,13 @@ int main(int argc, char **argv)
 	int c;
 	int children_errors = 0;
 	int ret;
+	int sem_id;
+	struct sembuf sem_op;
+	union semun {
+		int val;
+		struct semid_ds *buf;
+		unsigned short int *array;
+	} u;
 
 	while ((c = getopt(argc, argv, "dw:n:a:s:")) != -1) {
 		char *endp;
@@ -145,6 +155,15 @@ int main(int argc, char **argv)
 	}
 
 	setup();
+
+	if ((sem_id = semget(IPC_PRIVATE, 1, IPC_CREAT|S_IRWXU)) == -1)
+		tst_brkm(TBROK|TERRNO, NULL, "allocate semaphore");
+
+	/* semaphore to hold off killing children */
+	u.val = 0;
+	if (semctl(sem_id, 0, SETVAL, u) == -1)
+		tst_brkm(TBROK|TERRNO, NULL, "init semaphore");
+
 	tst_resm(TINFO, "Dirtying free blocks");
 	dirty_freeblocks(filesize);
 
@@ -153,7 +172,15 @@ int main(int argc, char **argv)
 		switch (pid[i] = fork()) {
 		case 0:
 			signal(SIGTERM, SIG_DFL);
+			sem_op = (struct sembuf) {
+				.sem_num = 0,
+				.sem_op = 1,
+				.sem_flg = 0
+			};
+			if (semop(sem_id, &sem_op, 1) == -1)
+				tst_brkm(TBROK|TERRNO, NULL, "raise semaphore");
 			read_sparse(filename, filesize);
+			/* shouldn't be reached, read_sparse calls exit() */
 		break;
 		case -1:
 			while (i-- > 0)
@@ -168,7 +195,16 @@ int main(int argc, char **argv)
 	ret = dio_sparse(filename, alignment, writesize, filesize);
 
 	tst_resm(TINFO, "Killing childrens(s)");
-	
+
+	/* parent waits until all children complete signal() */
+	sem_op = (struct sembuf) {
+		.sem_num = 0,
+		.sem_op = -num_children,
+		.sem_flg = 0
+	};
+	if (semop(sem_id, &sem_op, 1) == -1)
+		tst_brkm(TBROK|TERRNO, NULL, "lower semaphore");
+
 	for (i = 0; i < num_children; i++)
 		kill(pid[i], SIGTERM);
 
@@ -191,7 +227,10 @@ int main(int argc, char **argv)
 		
 	if (!children_errors && !ret)
 		tst_resm(TPASS, "Test passed");
-	
+
+	if (semctl(sem_id, 0, IPC_RMID) == -1)
+		tst_brkm(TBROK|TERRNO, NULL, "remove semaphore");
+
 	cleanup();
 	tst_exit();
 }


--------------020906010901060403010208
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
--------------020906010901060403010208
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------020906010901060403010208--

