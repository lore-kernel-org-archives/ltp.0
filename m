From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 19 Apr 2016 20:17:27 +0300
Subject: [LTP] [PATCH] syscall/fcntl33.c: fix test on FUSE fs
Message-ID: <1461086247-23235-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Even though a child process is waiting for a parent to be in 'S'
state before triggering SIGIO, the signal might come earlier than
sigtimedwait() being invoked in the parent process. As a result the
parent waited for the event that had already happened.

I can only think about that the parent process may be in a sleep state
somehow while executing open() syscall on which it might sleep while
running it on FUSE FS:
vfs -> fuse kernel driver -> userspace implementation.

It can be fixed if we move open() before fork.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/kernel/syscalls/fcntl/fcntl33.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/syscalls/fcntl/fcntl33.c b/testcases/kernel/syscalls/fcntl/fcntl33.c
index 2d69866..13616c6 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl33.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl33.c
@@ -146,16 +146,17 @@ static void setup(void)
 
 static void do_test(int i)
 {
-	pid_t cpid;
+	fd = SAFE_OPEN(cleanup, "file", O_RDONLY);
+
+	pid_t cpid = tst_fork();
 
-	cpid = tst_fork();
 	if (cpid < 0)
 		tst_brkm(TBROK | TERRNO, cleanup, "fork() failed");
 
-	if (cpid == 0)
+	if (cpid == 0) {
+		SAFE_CLOSE(NULL, fd);
 		do_child(i);
-
-	fd = SAFE_OPEN(cleanup, "file", O_RDONLY);
+	}
 
 	TEST(fcntl(fd, F_SETLEASE, test_cases[i].lease_type));
 	if (TEST_RETURN == -1) {
-- 
1.7.1

