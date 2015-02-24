Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <mmarhefk@redhat.com>) id 1YQJex-0004HV-G1
	for ltp-list@lists.sourceforge.net; Tue, 24 Feb 2015 17:52:39 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YQJev-0004Fn-KM
	for ltp-list@lists.sourceforge.net; Tue, 24 Feb 2015 17:52:39 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t1OHqT9C015143
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Tue, 24 Feb 2015 12:52:30 -0500
Received: from cc-vtoe10.lab.eng.brq.redhat.com
	(cc-vtoe10.lab.eng.brq.redhat.com [10.34.89.68])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id t1OHqSQ9016271
	for <ltp-list@lists.sourceforge.net>; Tue, 24 Feb 2015 12:52:28 -0500
From: Matus Marhefka <mmarhefk@redhat.com>
Date: Tue, 24 Feb 2015 18:52:20 +0100
Message-Id: <1424800340-10357-1-git-send-email-mmarhefk@redhat.com>
Subject: [LTP] [PATCH] containers: semctl replaced with semop in
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
 testcases/kernel/containers/sysvipc/sem_comm.c | 57 +++++++++++++++++---------
 1 file changed, 38 insertions(+), 19 deletions(-)

diff --git a/testcases/kernel/containers/sysvipc/sem_comm.c b/testcases/kernel/containers/sysvipc/sem_comm.c
index b44be6d..1ac5394 100644
--- a/testcases/kernel/containers/sysvipc/sem_comm.c
+++ b/testcases/kernel/containers/sysvipc/sem_comm.c
@@ -32,14 +32,19 @@
 #include <sys/wait.h>
 #include <stdio.h>
 #include <errno.h>
+#include "usctest.h"
 #include "test.h"
 #include "safe_macros.h"
 #include "libclone.h"
 #include "ipcns_helper.h"
 
+
 #define TESTKEY 124426L
 char *TCID	= "sem_comm";
 int TST_TOTAL	= 1;
+struct tst_checkpoint checkpoint1;
+struct tst_checkpoint checkpoint2;
+
 
 static void cleanup(void)
 {
@@ -51,7 +56,8 @@ static void setup(void)
 	tst_require_root(NULL);
 	check_newipc();
 	tst_tmpdir();
-	TST_CHECKPOINT_INIT(tst_rmdir);
+	TST_CHECKPOINT_CREATE(&checkpoint1);
+	TST_CHECKPOINT_CREATE(&checkpoint2);
 }
 
 int chld1_sem(void *arg)
@@ -59,32 +65,39 @@ int chld1_sem(void *arg)
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
 
-	/* tell child2 to continue and wait for it to create the semaphore */
-	TST_SAFE_CHECKPOINT_WAKE_AND_WAIT(NULL, 0);
+	/* tell child2 to continue */
+	TST_CHECKPOINT_SIGNAL_CHILD(NULL, &checkpoint1);
+
+	/* wait for child2 to create the semaphore */
+	TST_CHECKPOINT_CHILD_WAIT(&checkpoint2);
 
-	sm.sem_num = 0;
 	sm.sem_op = -1;
-	sm.sem_flg = IPC_NOWAIT;
 	if (semop(id, &sm, 1) == -1) {
 		perror("semop");
 		semctl(id, 0, IPC_RMID);
 		return 2;
 	}
 
-	/* tell child2 to continue and wait for it to lock the semaphore */
-	TST_SAFE_CHECKPOINT_WAKE_AND_WAIT(NULL, 0);
+	/* tell child2 to continue */
+	TST_CHECKPOINT_SIGNAL_CHILD(NULL, &checkpoint1);
+
+	/* wait for child2 to lock the semaphore */
+	TST_CHECKPOINT_CHILD_WAIT(&checkpoint2);
 
 	sm.sem_op = 1;
 	semop(id, &sm, 1);
@@ -99,26 +112,32 @@ int chld2_sem(void *arg)
 	struct sembuf sm;
 
 	/* wait for child1 to create the semaphore */
-	TST_SAFE_CHECKPOINT_WAIT(NULL, 0);
+	TST_CHECKPOINT_CHILD_WAIT(&checkpoint1);
 
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
 
-	/* tell child1 to continue and wait for it to lock the semaphore */
-	TST_SAFE_CHECKPOINT_WAKE_AND_WAIT(NULL, 0);
+	/* tell child1 to continue */
+	TST_CHECKPOINT_SIGNAL_CHILD(NULL, &checkpoint2);
+
+	/* wait for child1 to lock the semaphore */
+	TST_CHECKPOINT_CHILD_WAIT(&checkpoint1);
 
-	sm.sem_num = 0;
 	sm.sem_op = -1;
-	sm.sem_flg = IPC_NOWAIT;
 	if (semop(id, &sm, 1) == -1) {
 		if (errno == EAGAIN) {
 			rval = 1;
@@ -130,7 +149,7 @@ int chld2_sem(void *arg)
 	}
 
 	/* tell child1 to continue */
-	TST_SAFE_CHECKPOINT_WAKE(NULL, 0);
+	TST_CHECKPOINT_SIGNAL_CHILD(NULL, &checkpoint2);
 
 	sm.sem_op = 1;
 	semop(id, &sm, 1);
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
