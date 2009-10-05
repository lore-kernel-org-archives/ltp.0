Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1N0d47-0004nF-8h
	for ltp-list@lists.sourceforge.net; Wed, 21 Oct 2009 15:25:31 +0000
Received: from fmmailgate01.web.de ([217.72.192.221])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N0d41-0001V1-65
	for ltp-list@lists.sourceforge.net; Wed, 21 Oct 2009 15:25:31 +0000
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate01.web.de (Postfix) with ESMTP id A97F213087FBE
	for <ltp-list@lists.sourceforge.net>;
	Wed, 21 Oct 2009 17:25:18 +0200 (CEST)
Received: from [83.208.36.163] (helo=debian)
	by smtp07.web.de with asmtp (WEB.DE 4.110 #314) id 1N0d3u-0001Qh-00
	for ltp-list@lists.sourceforge.net; Wed, 21 Oct 2009 17:25:18 +0200
Date: Tue, 06 Oct 2009 01:57:43 +0200
From: "Jiri Palecek" <jpalecek@web.de>
MIME-Version: 1.0
Resent-To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>
Resent-Message-ID: <op.u15o5f0ccfnueu@debian>
Subject: [LTP] [PATCH] Change errno reporting mechanism to TERRNO/TTERRNO in
 msgctl tests
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
Sender: ltp-list-bounces@lists.sourceforge.net
Errors-To: ltp-list-bounces@lists.sourceforge.net
Cc: ltp-list@lists.sourceforge.net
Message-ID: <20091005235743.gzi66n99iUFprSZ0NYJWhZlFR-1c4iX5LgxEt2jFY_I@z>

Hello,

 The TERRNO/TTERRNO flags offer more information than the manual errno
 output used previously in the tests. This patch changes the
 tst_resm(XXX, ..., errno) and similar statements to
 tst_resm(XXX|TERRNO, ...).

Regards
   Jiri Palecek

Signed-off-by: Jiri Palecek <jpalecek@web.de>
---
 testcases/kernel/syscalls/ipc/msgctl/msgctl01.c |    4 +--
 testcases/kernel/syscalls/ipc/msgctl/msgctl02.c |    4 +--
 testcases/kernel/syscalls/ipc/msgctl/msgctl03.c |    3 +-
 testcases/kernel/syscalls/ipc/msgctl/msgctl04.c |   13 ++-----
 testcases/kernel/syscalls/ipc/msgctl/msgctl05.c |    4 +--
 testcases/kernel/syscalls/ipc/msgctl/msgctl06.c |    8 ++---
 testcases/kernel/syscalls/ipc/msgctl/msgctl07.c |   22 ++++++------
 testcases/kernel/syscalls/ipc/msgctl/msgctl08.c |   22 +++++-------
 testcases/kernel/syscalls/ipc/msgctl/msgctl09.c |   41 +++++++++++------------
 testcases/kernel/syscalls/ipc/msgctl/msgctl10.c |   24 ++++++-------
 testcases/kernel/syscalls/ipc/msgctl/msgctl11.c |   41 +++++++++++------------
 11 files changed, 83 insertions(+), 103 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl01.c b/testcases/kernel/syscalls/ipc/msgctl/msgctl01.c
index 44011b4..f644b9d 100644
--- a/testcases/kernel/syscalls/ipc/msgctl/msgctl01.c
+++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl01.c
@@ -94,9 +94,7 @@ int main(int ac, char **av)
 		TEST(msgctl(msg_q_1, IPC_STAT, &qs_buf));
 
 		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL, "%s call failed - errno = %d"
-				 " : %s", TCID, TEST_ERRNO,
-				 strerror(TEST_ERRNO));
+			tst_resm(TFAIL|TTERRNO, "msgctl() call failed");
 		} else {
 			if (STD_FUNCTIONAL_TEST) {
 				if (qs_buf.msg_qbytes > 0) {
diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl02.c b/testcases/kernel/syscalls/ipc/msgctl/msgctl02.c
index acbca78..702a2cf 100644
--- a/testcases/kernel/syscalls/ipc/msgctl/msgctl02.c
+++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl02.c
@@ -96,9 +96,7 @@ int main(int ac, char **av)
 		TEST(msgctl(msg_q_1, IPC_SET, &qs_buf));
 
 		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL, "%s call failed - errno = %d"
-				 " : %s", TCID, TEST_ERRNO,
-				 strerror(TEST_ERRNO));
+			tst_resm(TFAIL|TTERRNO, "msgctl() call failed");
 		} else {
 			if (STD_FUNCTIONAL_TEST) {
 
diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl03.c b/testcases/kernel/syscalls/ipc/msgctl/msgctl03.c
index 9949b0a..8c9792c 100644
--- a/testcases/kernel/syscalls/ipc/msgctl/msgctl03.c
+++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl03.c
@@ -86,8 +86,7 @@ int main(int ac, char **av)
 	TEST(msgctl(msg_q_1, IPC_RMID, NULL));
 
 	if (TEST_RETURN == -1) {
-		tst_brkm(TFAIL, cleanup, "%s call failed - errno = %d"
-			 " : %s", TCID, TEST_ERRNO, strerror(TEST_ERRNO));
+		tst_brkm(TFAIL|TTERRNO, cleanup, "msgctl() call failed");
 	} else {
 		if (STD_FUNCTIONAL_TEST) {
 			/*
diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl04.c b/testcases/kernel/syscalls/ipc/msgctl/msgctl04.c
index bb0c245..245cea7 100644
--- a/testcases/kernel/syscalls/ipc/msgctl/msgctl04.c
+++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl04.c
@@ -137,12 +137,9 @@ int main(int ac, char **av)
 			TEST_ERROR_LOG(TEST_ERRNO);
 
 			if (TEST_ERRNO == TC[i].error) {
-				tst_resm(TPASS, "expected failure - "
-					 "errno = %d : %s", TEST_ERRNO,
-					 strerror(TEST_ERRNO));
+				tst_resm(TPASS|TTERRNO, "expected failure");
 			} else {
-				tst_resm(TFAIL, "unexpected error - %d : %s -",
-					 TEST_ERRNO, strerror(TEST_ERRNO));
+				tst_resm(TFAIL|TTERRNO, "unexpected error");
 				tst_resm(TINFO, "expected error is - %d : %s",
 					 TC[i].error, strerror(TC[i].error));
 			}
@@ -192,15 +189,13 @@ void setup(void)
 
 	/* now we have a key, so let's create a message queue */
 	if ((msg_q_1 = msgget(msgkey, IPC_CREAT | IPC_EXCL)) == -1) {
-		tst_brkm(TBROK, cleanup, "Can't create message queue #1: %s",
-			 strerror(errno));
+		tst_brkm(TBROK|TERRNO, cleanup, "Can't create message queue #1");
 	}
 
 	/* now let's create another message queue with read & write access */
 	if ((msg_q_2 =
 	     msgget(msgkey2, IPC_CREAT | IPC_EXCL | MSG_RD | MSG_WR)) == -1) {
-		tst_brkm(TBROK, cleanup, "Can't create message queue #2: %s",
-			 strerror(errno));
+		tst_brkm(TBROK|TERRNO, cleanup, "Can't create message queue #2");
 	}
 }
 
diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl05.c b/testcases/kernel/syscalls/ipc/msgctl/msgctl05.c
index 4012223..a22cf7f 100644
--- a/testcases/kernel/syscalls/ipc/msgctl/msgctl05.c
+++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl05.c
@@ -101,9 +101,7 @@ int main(int ac, char **av)
 		do_child();
 	} else {		/* parent */
 		if (waitpid(pid, NULL, 0) == -1) {
-			tst_resm(TBROK, "waitpid() failed");
-			tst_resm(TINFO, "waitpid() error = %d : %s", errno,
-				 strerror(errno));
+			tst_resm(TBROK|TERRNO, "waitpid() failed");
 		}
 
 		/* if it exists, remove the message queue */
diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl06.c b/testcases/kernel/syscalls/ipc/msgctl/msgctl06.c
index f6d0573..029b601 100644
--- a/testcases/kernel/syscalls/ipc/msgctl/msgctl06.c
+++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl06.c
@@ -39,7 +39,6 @@
 #include <sys/ipc.h>		/* needed for test              */
 #include <sys/msg.h>		/* needed for test              */
 #include <stdio.h>		/* needed by testhead.h         */
-#include <errno.h>		/* definitions needed for errno */
 #include "test.h"
 #include "usctest.h"
 #include "ipcmsg.h"
@@ -80,16 +79,15 @@ int main(int argc, char *argv[])
 	TEST(msgget(key, IPC_CREAT | IPC_EXCL));
 	msqid = TEST_RETURN;
 	if (TEST_RETURN == -1) {
-		tst_resm(TFAIL, "msgget() failed errno = %d", errno);
+		tst_resm(TFAIL|TTERRNO, "msgget() failed");
 		tst_exit();
 	}
 
 	TEST(msgctl(msqid, IPC_STAT, &buf));
 	status = TEST_RETURN;
 	if (TEST_RETURN == -1) {
-		tst_resm(TFAIL,
-			 "msgctl(msqid, IPC_STAT, &buf) failed errno = %d",
-			 errno);
+		tst_resm(TFAIL|TTERRNO,
+			 "msgctl(msqid, IPC_STAT, &buf) failed");
 		(void)msgctl(msqid, IPC_RMID, (struct msqid_ds *)NULL);
 		tst_exit();
 	}
diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl07.c b/testcases/kernel/syscalls/ipc/msgctl/msgctl07.c
index e5d7866..5cf12b8 100644
--- a/testcases/kernel/syscalls/ipc/msgctl/msgctl07.c
+++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl07.c
@@ -101,7 +101,7 @@ int main(int argc, char *argv[])
 
 	key = getipckey();
 	if ((msqid = msgget(key, IPC_CREAT | IPC_EXCL)) == -1) {
-		tst_resm(TFAIL, "msgget() failed errno = %d", errno);
+		tst_resm(TFAIL|TERRNO, "msgget() failed");
 		tst_exit();
 
 	}
@@ -128,7 +128,7 @@ int main(int argc, char *argv[])
 		sigemptyset(&act.sa_mask);
 		sigaddset(&act.sa_mask, SIGALRM);
 		if ((sigaction(SIGALRM, &act, NULL)) < 0) {
-			tst_resm(TFAIL, "signal failed. errno = %d", errno);
+			tst_resm(TFAIL|TERRNO, "signal failed");
 			kill(pid, SIGKILL);
 			(void)msgctl(msqid, IPC_RMID, (struct msqid_ds *)NULL);
 			tst_exit();
@@ -141,7 +141,7 @@ int main(int argc, char *argv[])
 			p1_msgp.text[i] = 'i';
 		p1_msgp.type = 1;
 		if (msgsnd(msqid, &p1_msgp, BYTES, 0) == -1) {
-			tst_resm(TFAIL, "msgsnd() failed. errno = %d", errno);
+			tst_resm(TFAIL|TERRNO, "msgsnd() failed");
 			kill(pid, SIGKILL);
 			(void)msgctl(msqid, IPC_RMID, (struct msqid_ds *)NULL);
 			tst_exit();
@@ -176,7 +176,7 @@ int main(int argc, char *argv[])
 		sigemptyset(&act.sa_mask);
 		sigaddset(&act.sa_mask, SIGALRM);
 		if ((sigaction(SIGALRM, &act, NULL)) < 0) {
-			tst_resm(TFAIL, "signal failed. errno = %d", errno);
+			tst_resm(TFAIL|TERRNO, "signal failed");
 			kill(pid, SIGKILL);
 			(void)msgctl(msqid, IPC_RMID, (struct msqid_ds *)NULL);
 			tst_exit();
@@ -189,7 +189,7 @@ int main(int argc, char *argv[])
 			p1_msgp.text[i] = 'i';
 		p1_msgp.type = 1;
 		if (msgsnd(msqid, &p1_msgp, BYTES, 0) == -1) {
-			tst_resm(TFAIL, "msgsnd() failed. errno = %d", errno);
+			tst_resm(TFAIL|TERRNO, "msgsnd() failed");
 			kill(pid, SIGKILL);
 			(void)msgctl(msqid, IPC_RMID, (struct msqid_ds *)NULL);
 			tst_exit();
@@ -198,7 +198,7 @@ int main(int argc, char *argv[])
 			p2_msgp.text[j] = 'j';
 		p2_msgp.type = 2;
 		if (msgsnd(msqid, &p2_msgp, BYTES, 0) == -1) {
-			tst_resm(TFAIL, "msgsnd() failed. errno = %d", errno);
+			tst_resm(TFAIL|TERRNO, "msgsnd() failed");
 			kill(pid, SIGKILL);
 			(void)msgctl(msqid, IPC_RMID, (struct msqid_ds *)NULL);
 			tst_exit();
@@ -207,7 +207,7 @@ int main(int argc, char *argv[])
 			p3_msgp.text[k] = 'k';
 		p3_msgp.type = 3;
 		if (msgsnd(msqid, &p3_msgp, BYTES, 0) == -1) {
-			tst_resm(TFAIL, "msgsnd() failed. errno = %d", errno);
+			tst_resm(TFAIL|TERRNO, "msgsnd() failed");
 			kill(pid, SIGKILL);
 			(void)msgctl(msqid, IPC_RMID, (struct msqid_ds *)NULL);
 			tst_exit();
@@ -257,7 +257,7 @@ void do_child_1()
 	int size;
 
 	if ((size = msgrcv(msqid, &c1_msgp, BYTES, 0, 0)) == -1) {
-		tst_resm(TFAIL, "msgrcv() failed errno = %d", errno);
+		tst_resm(TFAIL|TERRNO, "msgrcv() failed");
 		tst_exit();
 	}
 	if (size != BYTES) {
@@ -279,7 +279,7 @@ void do_child_2()
 	int size;
 
 	if ((size = msgrcv(msqid, &c3_msgp, BYTES, 3, 0)) == -1) {
-		tst_resm(TFAIL, "msgrcv() failed errno = %d", errno);
+		tst_resm(TFAIL|TERRNO, "msgrcv() failed");
 		tst_exit();
 	}
 	if (size != BYTES) {
@@ -293,7 +293,7 @@ void do_child_2()
 			tst_exit();
 		}
 	if ((size = msgrcv(msqid, &c2_msgp, BYTES, 2, 0)) == -1) {
-		tst_resm(TFAIL, "msgrcv() failed errno = %d", errno);
+		tst_resm(TFAIL|TERRNO, "msgrcv() failed");
 		tst_exit();
 	}
 	if (size != BYTES) {
@@ -307,7 +307,7 @@ void do_child_2()
 			tst_exit();
 		}
 	if ((size = msgrcv(msqid, &c1_msgp, BYTES, 1, 0)) == -1) {
-		tst_resm(TFAIL, "msgrcv() failed errno = %d", errno);
+		tst_resm(TFAIL|TERRNO, "msgrcv() failed");
 		tst_exit();
 	}
 	if (size != BYTES) {
diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl08.c b/testcases/kernel/syscalls/ipc/msgctl/msgctl08.c
index 01505d0..4c36e17 100644
--- a/testcases/kernel/syscalls/ipc/msgctl/msgctl08.c
+++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl08.c
@@ -282,8 +282,8 @@ int child_process;
 	sighold(SIGTERM);
 	TEST(msgget(key, IPC_CREAT | S_IRUSR | S_IWUSR));
 	if (TEST_RETURN < 0) {
-		tst_resm(TFAIL, "Msgget error in child %d, errno = %d",
-			 child_process, TEST_ERRNO);
+		tst_resm(TFAIL|TTERRNO, "Msgget error in child %d",
+			 child_process);
 		tst_exit();
 	}
 	tid = id = TEST_RETURN;
@@ -294,8 +294,7 @@ int child_process;
 		tst_resm(TWARN, "\tFork failed (may be OK if under stress)");
 		TEST(msgctl(tid, IPC_RMID, 0));
 		if (TEST_RETURN < 0) {
-			tst_resm(TFAIL, "Msgctl error in cleanup, errno = %d",
-				 errno);
+			tst_resm(TFAIL|TTERRNO, "Msgctl error in cleanup");
 		}
 		tst_exit();
 	}
@@ -306,8 +305,7 @@ int child_process;
 			tst_resm(TWARN, "self_exec failed");
 			TEST(msgctl(tid, IPC_RMID, 0));
 			if (TEST_RETURN < 0) {
-				tst_resm(TFAIL, "\tMsgctl error in cleanup, "
-					 "errno = %d\n", errno);
+				tst_resm(TFAIL|TTERRNO, "Msgctl error in cleanup");
 			}
 			tst_exit();
 		}
@@ -336,9 +334,9 @@ long key;
 
 	for (i = 0; i < nreps; i++) {
 		if ((size = msgrcv(id, &buffer, 100, 0, 0)) < 0) {
-			tst_brkm(TBROK, cleanup,
-				 "Msgrcv error in child %d, read # = %d, errno = %d",
-				 (i + 1), child, errno);
+			tst_brkm(TBROK|TERRNO, cleanup,
+				 "Msgrcv error in child %d, read # = %d",
+				 (i + 1), child);
 			tst_exit();
 		}
 		if (buffer.data.len + 1 != size) {
@@ -375,9 +373,9 @@ long key;
 		buffer.type = 1;
 		TEST(msgsnd(id, &buffer, size + 1, 0));
 		if (TEST_RETURN < 0) {
-			tst_brkm(TBROK, cleanup,
-				 "Msgsnd error in child %d, key =   %lx errno  = %d",
-				 child, key, TEST_ERRNO);
+			tst_brkm(TBROK|TTERRNO, cleanup,
+				 "Msgsnd error in child %d, key =   %lx",
+				 child, key);
 		}
 		key++;
 	}
diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl09.c b/testcases/kernel/syscalls/ipc/msgctl/msgctl09.c
index c598077..fef1673 100644
--- a/testcases/kernel/syscalls/ipc/msgctl/msgctl09.c
+++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl09.c
@@ -311,7 +311,7 @@ void cleanup_msgqueue(int i, int tid)
 	}
 
 	if (msgctl(tid, IPC_RMID, 0) < 0) {
-		tst_resm(TFAIL, "Msgctl error in cleanup, errno = %d", errno);
+		tst_resm(TFAIL|TERRNO, "Msgctl error in cleanup");
 		tst_exit();
 	}
 }
@@ -325,8 +325,8 @@ int child_process;
 
 	sighold(SIGTERM);
 	if ((id = msgget(key, IPC_CREAT | S_IRUSR | S_IWUSR)) < 0) {
-		tst_resm(TFAIL, "Msgget error in child %d, errno = %d",
-			 child_process, errno);
+		tst_resm(TFAIL|TERRNO, "Msgget error in child %d",
+			 child_process);
 		tst_exit();
 	}
 	tid = id;
@@ -406,9 +406,8 @@ int child_process;
 					kill(wkidarray[i], SIGTERM);
 				}
 				if (msgctl(tid, IPC_RMID, 0) < 0) {
-					tst_resm(TFAIL,
-						 "Msgctl error, errno = %d",
-						 errno);
+					tst_resm(TFAIL|TERRNO,
+						 "Msgctl error");
 				}
 				tst_exit();
 			}
@@ -425,13 +424,13 @@ int child_process;
 			 "Wrong number of children exited in child group %d, Saw %d Expected %d",
 			 child_process, count, (nkids * 2));
 		if (msgctl(tid, IPC_RMID, 0) < 0) {
-			tst_resm(TFAIL, "Msgctl error, errno = %d", errno);
+			tst_resm(TFAIL|TERRNO, "Msgctl error");
 		}
 		tst_exit();
 	}
 	if (msgctl(id, IPC_RMID, 0) < 0) {
-		tst_resm(TFAIL, "Msgctl failure in child group %d, errno %d",
-			 child_process, errno);
+		tst_resm(TFAIL|TERRNO, "Msgctl failure in child group %d",
+			 child_process);
 		tst_exit();
 	}
 	exit(exit_status);
@@ -445,9 +444,9 @@ long key;
 	int id;
 
 	if ((id = msgget(key, 0)) < 0) {
-		tst_resm(TFAIL,
-			 "Msgget error in reader of child group %d, errno = %d",
-			 child, errno);
+		tst_resm(TFAIL|TERRNO,
+			 "Msgget error in reader of child group %d",
+			 child);
 		tst_exit();
 	}
 	if (id != tid) {
@@ -458,9 +457,9 @@ long key;
 	}
 	for (i = 0; i < nreps; i++) {
 		if ((size = msgrcv(id, &buffer, 100, type, 0)) < 0) {
-			tst_resm(TFAIL,
-				 "Msgrcv error in child %d, read # = %d, errno = %d",
-				 (i + 1), child, errno);
+			tst_resm(TFAIL|TERRNO,
+				 "Msgrcv error in child %d, read # = %d",
+				 (i + 1), child);
 			tst_exit();
 		}
 		if (buffer.type != type) {
@@ -496,9 +495,9 @@ long key;
 	int id;
 
 	if ((id = msgget(key, 0)) < 0) {
-		tst_resm(TFAIL,
-			 "Msgget error in writer of child group %d, errno = %d",
-			 child, errno);
+		tst_resm(TFAIL|TERRNO,
+			 "Msgget error in writer of child group %d",
+			 child);
 		tst_exit();
 	}
 	if (id != tid) {
@@ -518,9 +517,9 @@ long key;
 		buffer.data.len = size;
 		buffer.type = type;
 		if (msgsnd(id, &buffer, size + 1, 0) < 0) {
-			tst_resm(TFAIL,
-				 "Msgsnd error in child %d, key =   %lx errno  = %d",
-				 child, key, errno);
+			tst_resm(TFAIL|TERRNO,
+				 "Msgsnd error in child %d, key =   %lx",
+				 child, key);
 			tst_exit();
 		}
 		key++;
diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl10.c b/testcases/kernel/syscalls/ipc/msgctl/msgctl10.c
index cf85d47..90c9c99 100644
--- a/testcases/kernel/syscalls/ipc/msgctl/msgctl10.c
+++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl10.c
@@ -283,8 +283,8 @@ int child_process;
 	sighold(SIGTERM);
 	TEST(msgget(key, IPC_CREAT | S_IRUSR | S_IWUSR));
 	if (TEST_RETURN < 0) {
-		tst_resm(TFAIL, "Msgget error in child %d, errno = %d",
-			 child_process, TEST_ERRNO);
+		tst_resm(TFAIL|TTERRNO, "Msgget error in child %d",
+			 child_process);
 		tst_exit();
 	}
 	tid = id = TEST_RETURN;
@@ -295,8 +295,7 @@ int child_process;
 		tst_resm(TWARN, "\tFork failed (may be OK if under stress)");
 		TEST(msgctl(tid, IPC_RMID, 0));
 		if (TEST_RETURN < 0) {
-			tst_resm(TFAIL, "Msgctl error in cleanup, errno = %d",
-				 errno);
+			tst_resm(TFAIL|TTERRNO, "Msgctl error in cleanup");
 		}
 		tst_exit();
 	}
@@ -307,8 +306,7 @@ int child_process;
 			tst_resm(TWARN, "self_exec failed");
 			TEST(msgctl(tid, IPC_RMID, 0));
 			if (TEST_RETURN < 0) {
-				tst_resm(TFAIL, "\tMsgctl error in cleanup, "
-					 "errno = %d\n", errno);
+				tst_resm(TFAIL|TTERRNO, "Msgctl error in cleanup");
 			}
 			tst_exit();
 		}
@@ -323,7 +321,7 @@ int child_process;
 	wait(0);
 	TEST(msgctl(id, IPC_RMID, 0));
 	if (TEST_RETURN < 0) {
-		tst_resm(TFAIL, "msgctl errno %d", TEST_ERRNO);
+		tst_resm(TFAIL|TTERRNO, "msgctl failed");
 		tst_exit();
 	}
 	exit(PASS);
@@ -337,9 +335,9 @@ long key;
 
 	for (i = 0; i < nreps; i++) {
 		if ((size = msgrcv(id, &buffer, 100, 0, 0)) < 0) {
-			tst_brkm(TBROK, cleanup,
-				 "Msgrcv error in child %d, read # = %d, errno = %d",
-				 (i + 1), child, errno);
+			tst_brkm(TBROK|TERRNO, cleanup,
+				 "Msgrcv error in child %d, read # = %d",
+				 (i + 1), child);
 			tst_exit();
 		}
 		if (buffer.data.len + 1 != size) {
@@ -376,9 +374,9 @@ long key;
 		buffer.type = 1;
 		TEST(msgsnd(id, &buffer, size + 1, 0));
 		if (TEST_RETURN < 0) {
-			tst_brkm(TBROK, cleanup,
-				 "Msgsnd error in child %d, key =   %lx errno  = %d",
-				 child, key, TEST_ERRNO);
+			tst_brkm(TBROK|TTERRNO, cleanup,
+				 "Msgsnd error in child %d, key =   %lx",
+				 child, key);
 		}
 		key++;
 	}
diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl11.c b/testcases/kernel/syscalls/ipc/msgctl/msgctl11.c
index 13e6c66..fa69de4 100644
--- a/testcases/kernel/syscalls/ipc/msgctl/msgctl11.c
+++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl11.c
@@ -314,7 +314,7 @@ void cleanup_msgqueue(int i, int tid)
 	}
 
 	if (msgctl(tid, IPC_RMID, 0) < 0) {
-		tst_resm(TFAIL, "Msgctl error in cleanup, errno = %d", errno);
+		tst_resm(TFAIL|TERRNO, "Msgctl error in cleanup");
 		tst_exit();
 	}
 }
@@ -328,8 +328,8 @@ int child_process;
 
 	sighold(SIGTERM);
 	if ((id = msgget(key, IPC_CREAT | S_IRUSR | S_IWUSR)) < 0) {
-		tst_resm(TFAIL, "Msgget error in child %d, errno = %d",
-			 child_process, errno);
+		tst_resm(TFAIL|TERRNO, "Msgget error in child %d",
+			 child_process);
 		tst_exit();
 	}
 	tid = id;
@@ -409,9 +409,8 @@ int child_process;
 					kill(wkidarray[i], SIGTERM);
 				}
 				if (msgctl(tid, IPC_RMID, 0) < 0) {
-					tst_resm(TFAIL,
-						 "Msgctl error, errno = %d",
-						 errno);
+					tst_resm(TFAIL|TERRNO,
+						 "Msgctl error");
 				}
 				tst_exit();
 			}
@@ -428,13 +427,13 @@ int child_process;
 			 "Wrong number of children exited in child group %d, Saw %d Expected %d",
 			 child_process, count, (nkids * 2));
 		if (msgctl(tid, IPC_RMID, 0) < 0) {
-			tst_resm(TFAIL, "Msgctl error, errno = %d", errno);
+			tst_resm(TFAIL|TERRNO, "Msgctl error");
 		}
 		tst_exit();
 	}
 	if (msgctl(id, IPC_RMID, 0) < 0) {
-		tst_resm(TFAIL, "Msgctl failure in child group %d, errno %d",
-			 child_process, errno);
+		tst_resm(TFAIL|TERRNO, "Msgctl failure in child group %d",
+			 child_process);
 		tst_exit();
 	}
 	exit(exit_status);
@@ -448,9 +447,9 @@ long key;
 	int id;
 
 	if ((id = msgget(key, 0)) < 0) {
-		tst_resm(TFAIL,
-			 "Msgget error in reader of child group %d, errno = %d",
-			 child, errno);
+		tst_resm(TFAIL|TERRNO,
+			 "Msgget error in reader of child group %d",
+			 child);
 		tst_exit();
 	}
 	if (id != tid) {
@@ -461,9 +460,9 @@ long key;
 	}
 	for (i = 0; i < nreps; i++) {
 		if ((size = msgrcv(id, &buffer, 100, type, 0)) < 0) {
-			tst_resm(TFAIL,
-				 "Msgrcv error in child %d, read # = %d, errno = %d",
-				 (i + 1), child, errno);
+			tst_resm(TFAIL|TERRNO,
+				 "Msgrcv error in child %d, read # = %d",
+				 (i + 1), child);
 			tst_exit();
 		}
 		if (buffer.type != type) {
@@ -499,9 +498,9 @@ long key;
 	int id;
 
 	if ((id = msgget(key, 0)) < 0) {
-		tst_resm(TFAIL,
-			 "Msgget error in writer of child group %d, errno = %d",
-			 child, errno);
+		tst_resm(TFAIL|TERRNO,
+			 "Msgget error in writer of child group %d",
+			 child);
 		tst_exit();
 	}
 	if (id != tid) {
@@ -521,9 +520,9 @@ long key;
 		buffer.data.len = size;
 		buffer.type = type;
 		if (msgsnd(id, &buffer, size + 1, 0) < 0) {
-			tst_resm(TFAIL,
-				 "Msgsnd error in child %d, key =   %lx errno  = %d",
-				 child, key, errno);
+			tst_resm(TFAIL|TERRNO,
+				 "Msgsnd error in child %d, key =   %lx",
+				 child, key);
 			tst_exit();
 		}
 		key++;
-- 
1.6.4.3



------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
