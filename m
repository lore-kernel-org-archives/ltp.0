Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1Ramew-0004n7-6u
	for ltp-list@lists.sourceforge.net; Wed, 14 Dec 2011 11:06:02 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Rames-0001HN-5R
	for ltp-list@lists.sourceforge.net; Wed, 14 Dec 2011 11:06:02 +0000
Received: from int-mx12.intmail.prod.int.phx2.redhat.com
	(int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id pBEB5qFM029128
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 14 Dec 2011 06:05:52 -0500
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id pBEB5pVn002671
	for <ltp-list@lists.sourceforge.net>; Wed, 14 Dec 2011 06:05:51 -0500
Message-ID: <4EE8830E.6050804@redhat.com>
Date: Wed, 14 Dec 2011 12:05:50 +0100
From: Jan Stancek <jstancek@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020102090902070300000703"
Subject: [LTP] [PATCH] pipeio: prevent race between SIGCHLD and open()
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
--------------020102090902070300000703
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


This test occasionally hangs on some machines. The hang has been
observed on some single CPU ones.

pipeio code is using signal(2), setting by default SA_RESTART
flag, which is also the case for SIGCHLD.

If last child manages to exit while parent is still at open(),
parent gets SIGCHLD and open() is restarted. At this point test
hangs.

Here's strace output from parent point of view:

=== snip ===
brk(0)                                  = 0x11bb000
brk(0x11dd000)                          = 0x11dd000
getpid()                                = 18826
stat("tpipe.18826", 0x7fff89e1d410)     = -1 ENOENT (No such file or
directory)
mknod("tpipe.18826", S_IFIFO|0777)      = 0
rt_sigaction(SIGCHLD, {0x400a54, [CHLD], SA_RESTORER|SA_RESTART,
   0x354aa32a20}, {SIG_DFL, [], 0}, 8) = 0
clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|
   CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x7f53b9ddd9d0) = 18827
fstat(1, {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 3), ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
   = 0x7f53b9de5000
open("tpipe.18826", O_RDONLY
)           = ? ERESTARTSYS (To be restarted)
--- SIGCHLD (Child exited) @ 0 (0) ---
wait4(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0, NULL) = 18827
rt_sigreturn(0xffffffffffffffff)        = 2
open("tpipe.18826", O_RDONLY
=== /snip ===

This patch is introducing semaphore, which prevents children from
exiting until parent completes open(). It also adds timed wait,
so parent waits for children to exit before it deletes pipe and
semaphore.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
  testcases/kernel/ipc/pipeio/pipeio.c |   37 
++++++++++++++++++++++++++++++++-
  1 files changed, 35 insertions(+), 2 deletions(-)



--------------020102090902070300000703
Content-Type: text/x-patch;
	name="0001-pipeio-prevent-race-between-SIGCHLD-and-open.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0001-pipeio-prevent-race-between-SIGCHLD-and-open.patch"

diff --git a/testcases/kernel/ipc/pipeio/pipeio.c b/testcases/kernel/ipc/pipeio/pipeio.c
index 1c28c9b..451c094 100644
--- a/testcases/kernel/ipc/pipeio/pipeio.c
+++ b/testcases/kernel/ipc/pipeio/pipeio.c
@@ -158,6 +158,8 @@ char *av[];
 	  struct semid_ds *buf;
 	  unsigned short int *array;
 	} u;
+	unsigned int uwait_iter = 1000;
+	unsigned int uwait_total = 5000000;
 
 	u.val = 0;
 	format = HEX;
@@ -443,13 +445,17 @@ char *av[];
 
 	writebuf[size-1] = 'A';	/* to detect partial read/write problem */
 
-	if ((sem_id = semget(IPC_PRIVATE, 1, IPC_CREAT|S_IRWXU)) == -1) {
+	if ((sem_id = semget(IPC_PRIVATE, 2, IPC_CREAT|S_IRWXU)) == -1) {
 		tst_brkm(TBROK, NULL, "Couldn't allocate semaphore: %s", strerror(errno));
 	}
 
 	if (semctl(sem_id, 0, SETVAL, u) == -1)
 		tst_brkm(TBROK, NULL, "Couldn't initialize semaphore value: %s", strerror(errno));
 
+	/* semaphore to hold off children from exiting until open() completes */
+	if (semctl(sem_id, 1, SETVAL, u) == -1)
+		tst_brkm(TBROK, NULL, "Couldn't initialize semaphore value: %s", strerror(errno));
+
 	if (background) {
 	    if ((n=fork()) == -1) {
 		tst_resm (TFAIL, "fork() failed: %s", strerror(errno));
@@ -586,6 +592,15 @@ printf("child after fork pid = %d\n", getpid());
 			}
 			fflush(stderr);
 		}
+
+		/* child waits until parent completes open() */
+		sem_op = (struct sembuf) {
+			.sem_num = 1,
+			.sem_op = -1,
+			.sem_flg = 0
+		};
+		if (semop(sem_id, &sem_op, 1) == -1)
+			tst_brkm(TBROK, NULL, "Couldn't lower the semaphore: %s", strerror(errno));
 	}
 	if (c > 0) {	/***** if parent *****/
 
@@ -602,6 +617,15 @@ printf("child after fork pid = %d\n", getpid());
 			close(write_fd);
 		}
 
+		/* raise semaphore so children can exit */
+		sem_op = (struct sembuf) {
+			.sem_num = 1,
+			.sem_op = num_wrters,
+			.sem_flg = 0
+		};
+		if (semop(sem_id, &sem_op, 1) == -1)
+			tst_brkm(TBROK, NULL, "Couldn't raise the semaphore: %s", strerror(errno));
+
 		sem_op = (struct sembuf) {
 			.sem_num = 0,
 			.sem_op = -num_wrters,
@@ -694,6 +718,15 @@ output:
 				tst_resm(TPASS, "1 PASS %d pipe reads complete, read size = %d, %s %s",
 				          count+1,size,pipe_type,blk_type);
 
+		/* wait for all children to finish, timeout after uwait_total
+		   semtimedop might not be available everywhere */
+		for (i=0; i<uwait_total; i+=uwait_iter) {
+			if (semctl(sem_id, 1, GETVAL) == 0) {
+				break;
+			}
+			usleep(uwait_iter);
+		}
+
 		semctl(sem_id, 0, IPC_RMID);
 
 		if (!unpipe)
@@ -884,4 +917,4 @@ sig_handler(int sig)
     fflush(stdout);
     exit(3);
 
-}
\ No newline at end of file
+}


--------------020102090902070300000703
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Cloud Computing - Latest Buzzword or a Glimpse of the Future?
This paper surveys cloud computing today: What are the benefits? 
Why are businesses embracing it? What are its payoffs and pitfalls?
http://www.accelacomm.com/jaw/sdnl/114/51425149/
--------------020102090902070300000703
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------020102090902070300000703--

