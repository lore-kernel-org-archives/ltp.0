Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1Rb7ir-000701-Di
	for ltp-list@lists.sourceforge.net; Thu, 15 Dec 2011 09:35:29 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Rb7in-000617-Ea
	for ltp-list@lists.sourceforge.net; Thu, 15 Dec 2011 09:35:29 +0000
Received: from int-mx01.intmail.prod.int.phx2.redhat.com
	(int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id pBF9ZJGB026226
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 15 Dec 2011 04:35:19 -0500
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with
	ESMTP id pBF9ZI1n022501
	for <ltp-list@lists.sourceforge.net>; Thu, 15 Dec 2011 04:35:18 -0500
Message-ID: <4EE9BF56.3030603@redhat.com>
Date: Thu, 15 Dec 2011 10:35:18 +0100
From: Jan Stancek <jstancek@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040204080703010707080802"
Subject: [LTP] [PATCH v2 1/2] pipeio: convert strerror(errno) to TERRNO
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
--------------040204080703010707080802
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
  testcases/kernel/ipc/pipeio/pipeio.c |   32 
++++++++++++++++----------------
  1 files changed, 16 insertions(+), 16 deletions(-)



--------------040204080703010707080802
Content-Type: text/x-patch;
	name="0001-pipeio-convert-strerror-errno-to-TERRNO.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0001-pipeio-convert-strerror-errno-to-TERRNO.patch"

diff --git a/testcases/kernel/ipc/pipeio/pipeio.c b/testcases/kernel/ipc/pipeio/pipeio.c
index 1c28c9b..22ab3a7 100644
--- a/testcases/kernel/ipc/pipeio/pipeio.c
+++ b/testcases/kernel/ipc/pipeio/pipeio.c
@@ -433,7 +433,7 @@ char *av[];
 
 	if ((writebuf = (char *) malloc(size)) == NULL ||
 	    (readbuf = (char *) malloc(size)) == NULL) {
-		tst_resm (TFAIL, "malloc() failed: %s", strerror(errno));
+		tst_resm (TFAIL|TERRNO, "malloc() failed");
   		SAFE_FREE(writebuf);
 		SAFE_FREE(readbuf);
 		exit(1);
@@ -444,15 +444,15 @@ char *av[];
 	writebuf[size-1] = 'A';	/* to detect partial read/write problem */
 
 	if ((sem_id = semget(IPC_PRIVATE, 1, IPC_CREAT|S_IRWXU)) == -1) {
-		tst_brkm(TBROK, NULL, "Couldn't allocate semaphore: %s", strerror(errno));
+		tst_brkm(TBROK|TERRNO, NULL, "Couldn't allocate semaphore");
 	}
 
 	if (semctl(sem_id, 0, SETVAL, u) == -1)
-		tst_brkm(TBROK, NULL, "Couldn't initialize semaphore value: %s", strerror(errno));
+		tst_brkm(TBROK|TERRNO, NULL, "Couldn't initialize semaphore value");
 
 	if (background) {
 	    if ((n=fork()) == -1) {
-		tst_resm (TFAIL, "fork() failed: %s", strerror(errno));
+		tst_resm (TFAIL|TERRNO, "fork() failed");
 		exit(1);
 	    }
 	    else if (n != 0) /* parent */
@@ -461,7 +461,7 @@ char *av[];
 
 	if (unpipe) {
 		if (pipe(fds) == -1) {
-			tst_resm (TFAIL, "pipe() failed to create un-named pipe: %s", strerror(errno));
+			tst_resm (TFAIL|TERRNO, "pipe() failed to create un-named pipe");
 			exit(1);
 		}
 		read_fd = fds[0];
@@ -470,14 +470,14 @@ char *av[];
 		blk_type = UNNAMED_IO;
 	} else {
 		if (strlen(dir) && chdir(dir) == -1) {
-			tst_resm (TFAIL, "chdir(%s) failed: %s", dir, strerror(errno));
+			tst_resm (TFAIL|TERRNO, "chdir(%s) failed", dir);
 			exit(1);
 		}
 
 		if (stat(pname, &stbuf) == -1) {
 
 		    if (mkfifo(pname,0777) == -1) {
-			tst_resm (TFAIL, "mkfifo(%s,0777) failed: %s", pname, strerror(errno));
+			tst_resm (TFAIL|TERRNO, "mkfifo(%s,0777) failed", pname);
 			exit(1);
 		    }
 		}
@@ -510,7 +510,7 @@ printf("num_wrters = %d\n", num_wrters);
 
 	for (i=num_wrters; i > 0; --i) {
 		if ((c=fork()) < 0) {
-			tst_resm (TFAIL, "fork() failed: %s", strerror(errno));
+			tst_resm (TFAIL|TERRNO, "fork() failed");
 			exit(1);
 		}
 		if (c == 0) break;	/* stop child from forking */
@@ -521,11 +521,11 @@ printf("child after fork pid = %d\n", getpid());
 #endif
 		if (! unpipe) {
 			if ((write_fd = open(pname,O_WRONLY)) == -1) {
-				tst_resm (TFAIL, "child pipe open(%s, %#o) failed: %s", pname, O_WRONLY|ndelay, strerror(errno));
+				tst_resm (TFAIL|TERRNO, "child pipe open(%s, %#o) failed", pname, O_WRONLY|ndelay);
 				exit(1);
 			}
 			if (ndelay && fcntl(write_fd, F_SETFL, O_NONBLOCK) == -1) {
-				tst_brkm(TBROK, NULL, "Failed setting the pipe to nonblocking mode: %s", strerror(errno));
+				tst_brkm(TBROK|TERRNO, NULL, "Failed setting the pipe to nonblocking mode");
 			}
 		}
 		else {
@@ -539,7 +539,7 @@ printf("child after fork pid = %d\n", getpid());
 		};
 
 		if (semop(sem_id, &sem_op, 1) == -1)
-			tst_brkm(TBROK, NULL, "Couldn't raise the semaphore: %s", strerror(errno));
+			tst_brkm(TBROK|TERRNO, NULL, "Couldn't raise the semaphore");
 
 		pid_word = (int *)&writebuf[0];
 		count_word = (int *)&writebuf[NBPW];
@@ -567,7 +567,7 @@ printf("child after fork pid = %d\n", getpid());
 			 * If lio_write_buffer returns a negative number,
 			 * the return will be -errno.
 			 */
-													tst_resm (TFAIL, "pass %d: lio_write_buffer(%s) failed; it returned %d: %s", j, cp, nb, strerror(-nb));
+				tst_resm (TFAIL, "pass %d: lio_write_buffer(%s) failed; it returned %d: %s", j, cp, nb, strerror(-nb));
 				exit(1);
 			}
 			else if (nb != size) {
@@ -591,11 +591,11 @@ printf("child after fork pid = %d\n", getpid());
 
 		if (! unpipe) {
 			if ((read_fd = open(pname,O_RDONLY)) == -1) {
-				tst_resm (TFAIL, "parent pipe open(%s, %#o) failed: %s", pname, O_RDONLY, strerror(errno));
+				tst_resm (TFAIL|TERRNO, "parent pipe open(%s, %#o) failed", pname, O_RDONLY);
 				exit(1);
 			}
 			if (ndelay && fcntl(read_fd, F_SETFL, O_NONBLOCK) == -1) {
-				tst_brkm(TBROK, NULL, "Failed setting the pipe to nonblocking mode: %s", strerror(errno));
+				tst_brkm(TBROK|TERRNO, NULL, "Failed setting the pipe to nonblocking mode");
 			}
 		}
 		else {
@@ -612,7 +612,7 @@ printf("child after fork pid = %d\n", getpid());
 			if (errno == EINTR) {
 				continue;
 			}
-			tst_brkm(TBROK, NULL, "Couldn't wait on semaphore: %s", strerror(errno));
+			tst_brkm(TBROK|TERRNO, NULL, "Couldn't wait on semaphore");
 		}
 
 		for (i=num_wrters*num_writes; i > 0 || loop; --i) {
@@ -884,4 +884,4 @@ sig_handler(int sig)
     fflush(stdout);
     exit(3);
 
-}
\ No newline at end of file
+}


--------------040204080703010707080802
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
10 Tips for Better Server Consolidation
Server virtualization is being driven by many needs.  
But none more important than the need to reduce IT complexity 
while improving strategic productivity.  Learn More! 
http://www.accelacomm.com/jaw/sdnl/114/51507609/
--------------040204080703010707080802
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------040204080703010707080802--

