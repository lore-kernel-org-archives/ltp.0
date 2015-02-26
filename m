Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <mmarhefk@redhat.com>) id 1YQy10-00084P-Jh
	for ltp-list@lists.sourceforge.net; Thu, 26 Feb 2015 12:58:06 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YQy0y-0005EQ-RQ
	for ltp-list@lists.sourceforge.net; Thu, 26 Feb 2015 12:58:06 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t1QCvwto025282
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Thu, 26 Feb 2015 07:57:58 -0500
Received: from cc-vtoe10.lab.eng.brq.redhat.com
	(cc-vtoe10.lab.eng.brq.redhat.com [10.34.89.68])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id t1QCvv1I010997
	for <ltp-list@lists.sourceforge.net>; Thu, 26 Feb 2015 07:57:57 -0500
From: Matus Marhefka <mmarhefk@redhat.com>
Date: Thu, 26 Feb 2015 13:57:41 +0100
Message-Id: <1424955461-21111-1-git-send-email-mmarhefk@redhat.com>
In-Reply-To: <1424800340-10357-1-git-send-email-mmarhefk@redhat.com>
References: <1424800340-10357-1-git-send-email-mmarhefk@redhat.com>
Subject: [LTP] [PATCH v2] containers: semctl replaced with semop in
	sysvipc/sem_comm.c
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

semctl call replaced with semop call for setting up semaphores initial
values because semctl needs non-standard type (not in sys/sem.h).

Signed-off-by: Matus Marhefka <mmarhefk@redhat.com>
---
 testcases/kernel/containers/sysvipc/sem_comm.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/containers/sysvipc/sem_comm.c b/testcases/kernel/containers/sysvipc/sem_comm.c
index b44be6d..fba6767 100644
--- a/testcases/kernel/containers/sysvipc/sem_comm.c
+++ b/testcases/kernel/containers/sysvipc/sem_comm.c
@@ -59,14 +59,17 @@ int chld1_sem(void *arg)
 	int id;
 	struct sembuf sm;
 
-	id = semget(TESTKEY, 1, IPC_CREAT);
+	id = semget(TESTKEY, 1, IPC_CREAT|S_IRUSR|S_IWUSR|IPC_EXCL);
 	if (id == -1) {
 		perror("semget");
 		return 2;
 	}
 
-	if (semctl(id, 0, SETVAL, 1) == -1) {
-		perror("semctl");
+	sm.sem_num = 0;
+	sm.sem_op = 1;
+	sm.sem_flg = IPC_NOWAIT;
+	if (semop(id, &sm, 1) == -1) {
+		perror("semop");
 		semctl(id, 0, IPC_RMID);
 		return 2;
 	}
@@ -74,9 +77,7 @@ int chld1_sem(void *arg)
 	/* tell child2 to continue and wait for it to create the semaphore */
 	TST_SAFE_CHECKPOINT_WAKE_AND_WAIT(NULL, 0);
 
-	sm.sem_num = 0;
 	sm.sem_op = -1;
-	sm.sem_flg = IPC_NOWAIT;
 	if (semop(id, &sm, 1) == -1) {
 		perror("semop");
 		semctl(id, 0, IPC_RMID);
@@ -101,14 +102,19 @@ int chld2_sem(void *arg)
 	/* wait for child1 to create the semaphore */
 	TST_SAFE_CHECKPOINT_WAIT(NULL, 0);
 
-	id = semget(TESTKEY, 1, IPC_CREAT);
+	/* IPC_EXCL is excluded because we do not want semget call to fail
+	 * if namespaces logic doesn't work correctly */
+	id = semget(TESTKEY, 1, IPC_CREAT|S_IRUSR|S_IWUSR);
 	if (id == -1) {
 		perror("semget");
 		return 2;
 	}
 
-	if (semctl(id, 0, SETVAL, 1) == -1) {
-		perror("semctl");
+	sm.sem_num = 0;
+	sm.sem_op = 1;
+	sm.sem_flg = IPC_NOWAIT;
+	if (semop(id, &sm, 1) == -1) {
+		perror("semop");
 		semctl(id, 0, IPC_RMID);
 		return 2;
 	}
@@ -116,9 +122,7 @@ int chld2_sem(void *arg)
 	/* tell child1 to continue and wait for it to lock the semaphore */
 	TST_SAFE_CHECKPOINT_WAKE_AND_WAIT(NULL, 0);
 
-	sm.sem_num = 0;
 	sm.sem_op = -1;
-	sm.sem_flg = IPC_NOWAIT;
 	if (semop(id, &sm, 1) == -1) {
 		if (errno == EAGAIN) {
 			rval = 1;
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
