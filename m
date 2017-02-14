From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 14 Feb 2017 13:26:39 +0100
Subject: [LTP] [PATCH 4/4] syscalls: Make use of SAFE_MACROS in cleanup
In-Reply-To: <20170214122639.442-1-chrubis@suse.cz>
References: <20170214122639.442-1-chrubis@suse.cz>
Message-ID: <20170214122639.442-4-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Convert newlib tests to use SAFE_MACROS() in cleanup where possible.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/epoll_ctl/epoll_ctl01.c   | 12 ++++++------
 testcases/kernel/syscalls/epoll_ctl/epoll_ctl02.c   | 12 ++++++------
 testcases/kernel/syscalls/fcntl/fcntl02.c           |  4 ++--
 testcases/kernel/syscalls/fcntl/fcntl03.c           |  4 ++--
 testcases/kernel/syscalls/fcntl/fcntl04.c           |  4 ++--
 testcases/kernel/syscalls/flistxattr/flistxattr01.c |  4 ++--
 testcases/kernel/syscalls/flistxattr/flistxattr02.c |  4 ++--
 testcases/kernel/syscalls/flistxattr/flistxattr03.c |  6 ++----
 testcases/kernel/syscalls/ipc/msgget/msgget01.c     |  6 ++----
 testcases/kernel/syscalls/ipc/msgget/msgget02.c     |  6 ++----
 testcases/kernel/syscalls/ipc/msgget/msgget03.c     |  8 +++-----
 testcases/kernel/syscalls/ipc/msgsnd/msgsnd01.c     |  6 ++----
 testcases/kernel/syscalls/ipc/msgsnd/msgsnd02.c     |  6 ++----
 testcases/kernel/syscalls/ipc/msgsnd/msgsnd05.c     |  6 ++----
 testcases/kernel/syscalls/ipc/msgsnd/msgsnd06.c     |  6 ++----
 testcases/kernel/syscalls/kcmp/kcmp01.c             |  4 ++--
 testcases/kernel/syscalls/kcmp/kcmp02.c             |  8 ++++----
 testcases/kernel/syscalls/madvise/madvise01.c       |  7 +++----
 testcases/kernel/syscalls/madvise/madvise02.c       |  4 ++--
 testcases/kernel/syscalls/madvise/madvise06.c       | 11 +++--------
 testcases/kernel/syscalls/madvise/madvise08.c       | 19 ++++++++-----------
 testcases/kernel/syscalls/ppoll/ppoll01.c           |  2 +-
 testcases/kernel/syscalls/preadv/preadv01.c         |  4 ++--
 testcases/kernel/syscalls/preadv/preadv02.c         | 20 ++++++++++----------
 testcases/kernel/syscalls/pwritev/pwritev01.c       |  4 ++--
 testcases/kernel/syscalls/pwritev/pwritev02.c       | 16 ++++++++--------
 testcases/kernel/syscalls/recvmsg/recvmsg02.c       |  8 ++++----
 testcases/kernel/syscalls/sendto/sendto02.c         |  4 ++--
 testcases/kernel/syscalls/socket/socket02.c         |  4 ++--
 testcases/kernel/syscalls/socketpair/socketpair02.c |  8 ++++----
 testcases/kernel/syscalls/umount/umount02.c         |  4 ++--
 31 files changed, 98 insertions(+), 123 deletions(-)

diff --git a/testcases/kernel/syscalls/epoll_ctl/epoll_ctl01.c b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl01.c
index 2ecadf7..5833c38 100644
--- a/testcases/kernel/syscalls/epoll_ctl/epoll_ctl01.c
+++ b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl01.c
@@ -59,14 +59,14 @@ static void setup(void)
 
 static void cleanup(void)
 {
-	if (epfd > 0 && close(epfd))
-		tst_res(TWARN | TERRNO, "failed to close epoll instance");
+	if (epfd > 0)
+		SAFE_CLOSE(epfd);
 
-	if (fd[0] > 0 && close(fd[0]))
-		tst_res(TWARN | TERRNO, "failed to close pipe");
+	if (fd[0] > 0)
+		SAFE_CLOSE(fd[0]);
 
-	if (fd[1] > 0 && close(fd[1]))
-		tst_res(TWARN | TERRNO, "failed to close pipe");
+	if (fd[1] > 0)
+		SAFE_CLOSE(fd[1]);
 }
 
 static int has_event(struct epoll_event *epvs, int len,
diff --git a/testcases/kernel/syscalls/epoll_ctl/epoll_ctl02.c b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl02.c
index ae2465c..360ae47 100644
--- a/testcases/kernel/syscalls/epoll_ctl/epoll_ctl02.c
+++ b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl02.c
@@ -87,14 +87,14 @@ static void setup(void)
 
 static void cleanup(void)
 {
-	if (epfd > 0 && close(epfd))
-		tst_res(TWARN | TERRNO, "failed to close epoll instance");
+	if (epfd)
+		SAFE_CLOSE(epfd);
 
-	if (fd[0] > 0 && close(fd[0]))
-		tst_res(TWARN | TERRNO, "failed to close pipe");
+	if (fd[0])
+		SAFE_CLOSE(fd[0]);
 
-	if (fd[1] > 0 && close(fd[1]))
-		tst_res(TWARN | TERRNO, "failed to close pipe");
+	if (fd[1])
+		SAFE_CLOSE(fd[1]);
 }
 
 static void verify_epoll_ctl(unsigned int n)
diff --git a/testcases/kernel/syscalls/fcntl/fcntl02.c b/testcases/kernel/syscalls/fcntl/fcntl02.c
index f297808..cffa921 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl02.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl02.c
@@ -80,8 +80,8 @@ static void setup(void)
 
 static void cleanup(void)
 {
-	if (fd > 0 && close(fd))
-		tst_res(TWARN | TERRNO, "close(fd) failed");
+	if (fd > 0)
+		SAFE_CLOSE(fd);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/fcntl/fcntl03.c b/testcases/kernel/syscalls/fcntl/fcntl03.c
index 7471267..cf2f8cf 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl03.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl03.c
@@ -69,8 +69,8 @@ static void setup(void)
 
 static void cleanup(void)
 {
-	if (fd > 0 && close(fd))
-		tst_res(TWARN | TERRNO, "close(fd) failed");
+	if (fd > 0)
+		SAFE_CLOSE(fd);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/fcntl/fcntl04.c b/testcases/kernel/syscalls/fcntl/fcntl04.c
index f92f8a0..cddc6c3 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl04.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl04.c
@@ -75,8 +75,8 @@ static void setup(void)
 
 static void cleanup(void)
 {
-	if (fd > 0 && close(fd))
-		tst_res(TWARN | TERRNO, "close(fd) failed");
+	if (fd > 0)
+		SAFE_CLOSE(fd);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/flistxattr/flistxattr01.c b/testcases/kernel/syscalls/flistxattr/flistxattr01.c
index 563b410..5fa4e7f 100644
--- a/testcases/kernel/syscalls/flistxattr/flistxattr01.c
+++ b/testcases/kernel/syscalls/flistxattr/flistxattr01.c
@@ -85,8 +85,8 @@ static void setup(void)
 
 static void cleanup(void)
 {
-	if (fd > 0 && close(fd))
-		tst_res(TWARN | TERRNO, "failed to close file");
+	if (fd > 0)
+		SAFE_CLOSE(fd);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/flistxattr/flistxattr02.c b/testcases/kernel/syscalls/flistxattr/flistxattr02.c
index ee2e43b..876d53a 100644
--- a/testcases/kernel/syscalls/flistxattr/flistxattr02.c
+++ b/testcases/kernel/syscalls/flistxattr/flistxattr02.c
@@ -87,8 +87,8 @@ static void setup(void)
 
 static void cleanup(void)
 {
-	if (fd1 > 0 && close(fd1))
-		tst_res(TWARN | TERRNO, "failed to close file");
+	if (fd1 > 0)
+		SAFE_CLOSE(fd1);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/flistxattr/flistxattr03.c b/testcases/kernel/syscalls/flistxattr/flistxattr03.c
index b9c6b73..0fcf0d8 100644
--- a/testcases/kernel/syscalls/flistxattr/flistxattr03.c
+++ b/testcases/kernel/syscalls/flistxattr/flistxattr03.c
@@ -78,10 +78,8 @@ static void setup(void)
 
 static void cleanup(void)
 {
-	if (fd[1] > 0 && close(fd[1]))
-		tst_res(TWARN | TERRNO, "failed to close file");
-	if (fd[0] > 0 && close(fd[0]))
-		tst_res(TWARN | TERRNO, "failed to close file");
+	SAFE_CLOSE(fd[1]);
+	SAFE_CLOSE(fd[0]);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/ipc/msgget/msgget01.c b/testcases/kernel/syscalls/ipc/msgget/msgget01.c
index 1e9bbeb..8e058c5 100644
--- a/testcases/kernel/syscalls/ipc/msgget/msgget01.c
+++ b/testcases/kernel/syscalls/ipc/msgget/msgget01.c
@@ -66,10 +66,8 @@ static void setup(void)
 
 static void cleanup(void)
 {
-	if (queue_id != -1 && msgctl(queue_id, IPC_RMID, NULL)) {
-		tst_res(TWARN | TERRNO, "failed to delete message queue %i",
-			queue_id);
-	}
+	if (queue_id != -1)
+		SAFE_MSGCTL(queue_id, IPC_RMID, NULL);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/ipc/msgget/msgget02.c b/testcases/kernel/syscalls/ipc/msgget/msgget02.c
index 1886201..9cf1314 100644
--- a/testcases/kernel/syscalls/ipc/msgget/msgget02.c
+++ b/testcases/kernel/syscalls/ipc/msgget/msgget02.c
@@ -104,10 +104,8 @@ static void setup(void)
 
 static void cleanup(void)
 {
-	if (queue_id != -1 && msgctl(queue_id, IPC_RMID, NULL)) {
-		tst_res(TWARN | TERRNO, "failed to delete message queue %i",
-			queue_id);
-	}
+	if (queue_id != -1)
+		SAFE_MSGCTL(queue_id, IPC_RMID, NULL);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/ipc/msgget/msgget03.c b/testcases/kernel/syscalls/ipc/msgget/msgget03.c
index 0b7c66a..97911f9 100644
--- a/testcases/kernel/syscalls/ipc/msgget/msgget03.c
+++ b/testcases/kernel/syscalls/ipc/msgget/msgget03.c
@@ -29,6 +29,7 @@
 #include <stdlib.h>
 
 #include "tst_test.h"
+#include "tst_safe_sysv_ipc.h"
 #include "libnewipc.h"
 
 static int maxmsgs;
@@ -79,11 +80,8 @@ static void cleanup(void)
 		return;
 
 	for (num = 0; num < maxmsgs; num++) {
-		if (queues[num] != -1 && msgctl(queues[num], IPC_RMID, NULL)) {
-			tst_res(TWARN | TERRNO,
-				"failed to delete message queue %i",
-				queues[num]);
-		}
+		if (queues[num] != -1)
+			SAFE_MSGCTL(queues[num], IPC_RMID, NULL);
 	}
 
 	free(queues);
diff --git a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd01.c b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd01.c
index 7101bdb..d605fca 100644
--- a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd01.c
+++ b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd01.c
@@ -65,10 +65,8 @@ static void setup(void)
 
 static void cleanup(void)
 {
-	if (queue_id != -1 && msgctl(queue_id, IPC_RMID, NULL)) {
-		tst_res(TWARN | TERRNO, "failed to delete message queue %i",
-			queue_id);
-	}
+	if (queue_id != -1)
+		SAFE_MSGCTL(queue_id, IPC_RMID, NULL);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd02.c b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd02.c
index 5bdc6c8..5632079 100644
--- a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd02.c
+++ b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd02.c
@@ -117,10 +117,8 @@ static void setup(void)
 
 static void cleanup(void)
 {
-	if (queue_id != -1 && msgctl(queue_id, IPC_RMID, NULL)) {
-		tst_res(TWARN | TERRNO, "failed to delete message queue %i",
-			queue_id);
-	}
+	if (queue_id != -1)
+		SAFE_MSGCTL(queue_id, IPC_RMID, NULL);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd05.c b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd05.c
index 3d13f3e..032c870 100644
--- a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd05.c
+++ b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd05.c
@@ -109,10 +109,8 @@ static void setup(void)
 
 static void cleanup(void)
 {
-	if (queue_id != -1 && msgctl(queue_id, IPC_RMID, NULL)) {
-		tst_res(TWARN | TERRNO, "failed to delete message queue %i",
-			queue_id);
-	}
+	if (queue_id != -1)
+		SAFE_MSGCTL(queue_id, IPC_RMID, NULL);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd06.c b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd06.c
index 787cf97..ce7f046 100644
--- a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd06.c
+++ b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd06.c
@@ -83,10 +83,8 @@ static void setup(void)
 
 static void cleanup(void)
 {
-	if (queue_id != -1 && msgctl(queue_id, IPC_RMID, NULL)) {
-		tst_res(TWARN | TERRNO, "failed to delete message queue %i",
-			queue_id);
-	}
+	if (queue_id != -1)
+		SAFE_MSGCTL(queue_id, IPC_RMID, NULL);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/kcmp/kcmp01.c b/testcases/kernel/syscalls/kcmp/kcmp01.c
index 6e977cb..0aa4da6 100644
--- a/testcases/kernel/syscalls/kcmp/kcmp01.c
+++ b/testcases/kernel/syscalls/kcmp/kcmp01.c
@@ -61,8 +61,8 @@ static void setup(void)
 
 static void cleanup(void)
 {
-	if (fd1 > 0 && close(fd1) < 0)
-		tst_res(TWARN | TERRNO, "close fd1 failed");
+	if (fd1 > 0)
+		SAFE_CLOSE(fd1);
 }
 
 static void do_child(const struct test_case *test)
diff --git a/testcases/kernel/syscalls/kcmp/kcmp02.c b/testcases/kernel/syscalls/kcmp/kcmp02.c
index 2962823..ad0b09d 100644
--- a/testcases/kernel/syscalls/kcmp/kcmp02.c
+++ b/testcases/kernel/syscalls/kcmp/kcmp02.c
@@ -73,11 +73,11 @@ static void setup(void)
 
 static void cleanup(void)
 {
-	if (fd1 > 0 && close(fd1) < 0)
-		tst_res(TWARN | TERRNO, "close fd1 failed");
+	if (fd1 > 0)
+		SAFE_CLOSE(fd1);
 
-	if (fd2 > 0 && close(fd2) < 0)
-		tst_res(TWARN | TERRNO, "close fd2 failed");
+	if (fd2 > 0)
+		SAFE_CLOSE(fd2);
 }
 
 static void verify_kcmp(unsigned int n)
diff --git a/testcases/kernel/syscalls/madvise/madvise01.c b/testcases/kernel/syscalls/madvise/madvise01.c
index 22fb2e6..4ec3ef2 100644
--- a/testcases/kernel/syscalls/madvise/madvise01.c
+++ b/testcases/kernel/syscalls/madvise/madvise01.c
@@ -94,10 +94,9 @@ static void setup(void)
 
 static void cleanup(void)
 {
-	munmap(sfile, st.st_size);
-	munmap(amem, st.st_size);
-	umount(TMP_DIR);
-	rmdir(TMP_DIR);
+	SAFE_MUNMAP(sfile, st.st_size);
+	SAFE_MUNMAP(amem, st.st_size);
+	SAFE_UMOUNT(TMP_DIR);
 }
 
 static void verify_madvise(unsigned int i)
diff --git a/testcases/kernel/syscalls/madvise/madvise02.c b/testcases/kernel/syscalls/madvise/madvise02.c
index 33b1736..592536d 100644
--- a/testcases/kernel/syscalls/madvise/madvise02.c
+++ b/testcases/kernel/syscalls/madvise/madvise02.c
@@ -175,8 +175,8 @@ static void advice_test(unsigned int i)
 static void cleanup(void)
 {
 	free(ptr_addr);
-	munmap(file1, st.st_size);
-	munmap(file2, st.st_size - pagesize);
+	SAFE_MUNMAP(file1, st.st_size);
+	SAFE_MUNMAP(file2, st.st_size - pagesize);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/madvise/madvise06.c b/testcases/kernel/syscalls/madvise/madvise06.c
index e040b6f..7e75f14 100644
--- a/testcases/kernel/syscalls/madvise/madvise06.c
+++ b/testcases/kernel/syscalls/madvise/madvise06.c
@@ -93,14 +93,9 @@ static void setup(void)
 
 static void cleanup(void)
 {
-	FILE *f = fopen(MNT_NAME"/tasks", "w");
-
-	if (f) {
-		fprintf(f, "%d\n", getpid());
-		fclose(f);
-	}
-	rmdir(MNT_NAME"/"GROUP_NAME);
-	umount(MNT_NAME);
+	SAFE_FILE_PRINTF(MNT_NAME"/tasks", "%d\n", getpid());
+	SAFE_RMDIR(MNT_NAME"/"GROUP_NAME);
+	SAFE_UMOUNT(MNT_NAME);
 }
 
 static void dirty_pages(char *ptr, long size)
diff --git a/testcases/kernel/syscalls/madvise/madvise08.c b/testcases/kernel/syscalls/madvise/madvise08.c
index 9541a42..ebda3f2 100644
--- a/testcases/kernel/syscalls/madvise/madvise08.c
+++ b/testcases/kernel/syscalls/madvise/madvise08.c
@@ -108,19 +108,16 @@ static void setup(void)
 
 static void cleanup(void)
 {
-	if (cpattern) {
-		if (FILE_PRINTF(CORE_PATTERN, "%s", cpattern))
-			tst_res(TWARN,
-				"COULD NOT RESTORE " CORE_PATTERN "! It used to be '%s'",
-				cpattern);
-		free(cpattern);
-	}
+	if (cpattern)
+		SAFE_FILE_PRINTF(CORE_PATTERN, "%s", cpattern);
+
+	free(cpattern);
 
-	if (fmem && munmap(fmem, FMEMSIZE))
-		tst_res(TWARN | TERRNO, "munmap(fmem)");
+	if (fmem)
+		SAFE_MUNMAP(fmem, FMEMSIZE);
 
-	if (dfd > 0 && close(dfd))
-		tst_res(TWARN | TERRNO, "close(dfd)");
+	if (dfd > 0)
+		SAFE_CLOSE(dfd);
 }
 
 static int find_sequence(int pid)
diff --git a/testcases/kernel/syscalls/ppoll/ppoll01.c b/testcases/kernel/syscalls/ppoll/ppoll01.c
index 8d6d7e7..2cb336b 100644
--- a/testcases/kernel/syscalls/ppoll/ppoll01.c
+++ b/testcases/kernel/syscalls/ppoll/ppoll01.c
@@ -203,7 +203,7 @@ static void setup(void)
 static void cleanup(void)
 {
 	if (fd1 != -1)
-		close(fd1);
+		SAFE_CLOSE(fd1);
 }
 
 static void do_test(unsigned int i)
diff --git a/testcases/kernel/syscalls/preadv/preadv01.c b/testcases/kernel/syscalls/preadv/preadv01.c
index a51bd44..c2ba09e 100644
--- a/testcases/kernel/syscalls/preadv/preadv01.c
+++ b/testcases/kernel/syscalls/preadv/preadv01.c
@@ -108,8 +108,8 @@ void setup(void)
 
 void cleanup(void)
 {
-	if (fd > 0 && close(fd))
-		tst_res(TWARN | TERRNO, "Failed to close file");
+	if (fd > 0)
+		SAFE_CLOSE(fd);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/preadv/preadv02.c b/testcases/kernel/syscalls/preadv/preadv02.c
index d1863a0..26ebfa3 100644
--- a/testcases/kernel/syscalls/preadv/preadv02.c
+++ b/testcases/kernel/syscalls/preadv/preadv02.c
@@ -113,20 +113,20 @@ static void setup(void)
 
 static void cleanup(void)
 {
-	if (fd1 > 0 && close(fd1))
-		tst_res(TWARN | TERRNO, "failed to close file");
+	if (fd1 > 0)
+		SAFE_CLOSE(fd1);
 
-	if (fd2 > 0 && close(fd2))
-		tst_res(TWARN | TERRNO, "failed to close file");
+	if (fd2 > 0)
+		SAFE_CLOSE(fd2);
 
-	if (fd4 > 0 && close(fd4))
-		tst_res(TWARN | TERRNO, "failed to close file");
+	if (fd4 > 0)
+		SAFE_CLOSE(fd4);
 
-	if (fd5[0] > 0 && close(fd5[0]))
-		tst_res(TWARN | TERRNO, "failed to close file");
+	if (fd5[0] > 0)
+		SAFE_CLOSE(fd5[0]);
 
-	if (fd5[1] > 0 && close(fd5[1]))
-		tst_res(TWARN | TERRNO, "failed to close file");
+	if (fd5[1] > 0)
+		SAFE_CLOSE(fd5[1]);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/pwritev/pwritev01.c b/testcases/kernel/syscalls/pwritev/pwritev01.c
index 75baf25..88a1756 100644
--- a/testcases/kernel/syscalls/pwritev/pwritev01.c
+++ b/testcases/kernel/syscalls/pwritev/pwritev01.c
@@ -104,8 +104,8 @@ static void setup(void)
 
 static void cleanup(void)
 {
-	if (fd > 0 && close(fd))
-		tst_res(TWARN | TERRNO, "failed to close file");
+	if (fd > 0)
+		SAFE_CLOSE(fd);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/pwritev/pwritev02.c b/testcases/kernel/syscalls/pwritev/pwritev02.c
index 63444eb..ec9de20 100644
--- a/testcases/kernel/syscalls/pwritev/pwritev02.c
+++ b/testcases/kernel/syscalls/pwritev/pwritev02.c
@@ -107,17 +107,17 @@ static void setup(void)
 
 static void cleanup(void)
 {
-	if (fd1 > 0 && close(fd1))
-		tst_res(TWARN | TERRNO, "failed to close file");
+	if (fd1 > 0)
+		SAFE_CLOSE(fd1);
 
-	if (fd2 > 0 && close(fd2))
-		tst_res(TWARN | TERRNO, "failed to close file");
+	if (fd2 > 0)
+		SAFE_CLOSE(fd2);
 
-	if (fd4[0] > 0 && close(fd4[0]))
-		tst_res(TWARN | TERRNO, "failed to close file");
+	if (fd4[0] > 0)
+		SAFE_CLOSE(fd4[0]);
 
-	if (fd4[1] > 0 && close(fd4[1]))
-		tst_res(TWARN | TERRNO, "failed to close file");
+	if (fd4[1] > 0)
+		SAFE_CLOSE(fd4[1]);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/recvmsg/recvmsg02.c b/testcases/kernel/syscalls/recvmsg/recvmsg02.c
index fd21092..9ed520b 100644
--- a/testcases/kernel/syscalls/recvmsg/recvmsg02.c
+++ b/testcases/kernel/syscalls/recvmsg/recvmsg02.c
@@ -98,11 +98,11 @@ static void verify_recvmsg(void)
 
 static void cleanup(void)
 {
-	if (sdw > 0 && close(sdw))
-		tst_res(TWARN | TERRNO, "close(sdw) failed");
+	if (sdw > 0)
+		SAFE_CLOSE(sdw);
 
-	if (sdr > 0 && close(sdr))
-		tst_res(TWARN | TERRNO, "close(sdr) failed");
+	if (sdr > 0)
+		SAFE_CLOSE(sdr);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/sendto/sendto02.c b/testcases/kernel/syscalls/sendto/sendto02.c
index 2d5887d..b7b59fc 100644
--- a/testcases/kernel/syscalls/sendto/sendto02.c
+++ b/testcases/kernel/syscalls/sendto/sendto02.c
@@ -61,8 +61,8 @@ static void setup(void)
 
 static void cleanup(void)
 {
-	if (sockfd > 0 && close(sockfd))
-		tst_res(TWARN | TERRNO, "failed to close file");
+	if (sockfd > 0)
+		SAFE_CLOSE(sockfd);
 }
 
 static void verify_sendto(void)
diff --git a/testcases/kernel/syscalls/socket/socket02.c b/testcases/kernel/syscalls/socket/socket02.c
index 38a7cb5..ecc5b01 100644
--- a/testcases/kernel/syscalls/socket/socket02.c
+++ b/testcases/kernel/syscalls/socket/socket02.c
@@ -74,8 +74,8 @@ static void verify_socket(unsigned int n)
 
 static void cleanup(void)
 {
-	if (fd > 0 && close(fd))
-		tst_res(TWARN | TERRNO, "failed to close file");
+	if (fd > 0)
+		SAFE_CLOSE(fd);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/socketpair/socketpair02.c b/testcases/kernel/syscalls/socketpair/socketpair02.c
index 783aea6..6507e31 100644
--- a/testcases/kernel/syscalls/socketpair/socketpair02.c
+++ b/testcases/kernel/syscalls/socketpair/socketpair02.c
@@ -84,11 +84,11 @@ ret:
 
 static void cleanup(void)
 {
-	if (fds[0] > 0 && close(fds[0]))
-		tst_res(TWARN | TERRNO, "failed to close file");
+	if (fds[0] > 0)
+		SAFE_CLOSE(fds[0]);
 
-	if (fds[1] > 0 && close(fds[1]))
-		tst_res(TWARN | TERRNO, "failed to close file");
+	if (fds[1] > 0)
+		SAFE_CLOSE(fds[1]);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/umount/umount02.c b/testcases/kernel/syscalls/umount/umount02.c
index 41f13e4..ecfad1b 100644
--- a/testcases/kernel/syscalls/umount/umount02.c
+++ b/testcases/kernel/syscalls/umount/umount02.c
@@ -86,8 +86,8 @@ static void setup(void)
 
 static void cleanup(void)
 {
-	if (fd > 0 && close(fd))
-		tst_res(TWARN | TERRNO, "Failed to close file");
+	if (fd > 0)
+		SAFE_CLOSE(fd);
 
 	if (mount_flag)
 		tst_umount(MNTPOINT);
-- 
2.10.2

