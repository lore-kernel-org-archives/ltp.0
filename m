From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Jul 2016 11:24:10 +0100
Subject: [LTP] [PATCH] syscalls/read02: Don't pass invalid buffer to read
	when testing for bad fds
Message-ID: <1468578250-26463-1-git-send-email-peter.maydell@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The read02 testcases 1 and 2 are intended to check the handling
of the read syscall with an invalid fd (should fail EBADF) and
an fd which is a directory (should fail EISDIR). However a bug
in the test code meant that it also passed a NULL pointer as
the buffer argument, and so the test only succeeded because of
the implementation detail that the kernel happens to check for
the EBADF and EISDIR errors before it checks the buffer pointer
validity for an EFAULT error.

The 'buf' field in the test_case_t structure is supposed to be
a pointer to the address of the buffer, but it was being
initialised with the address of the buffer itself; fix this by
adding the extra indirection via a new 'bufaddr' variable, so
that the test is checking the condition it intends to and nothing
more.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 testcases/kernel/syscalls/read/read02.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/read/read02.c b/testcases/kernel/syscalls/read/read02.c
index 1e0f83a..587b2ae 100644
--- a/testcases/kernel/syscalls/read/read02.c
+++ b/testcases/kernel/syscalls/read/read02.c
@@ -54,6 +54,7 @@ char *TCID = "read02";
 static int badfd = -1;
 static int fd2, fd3, fd4 = -1;
 static char buf[BUFSIZ];
+static void *bufaddr = buf;
 static void *outside_buf = (void *)-1;
 static void *addr4;
 static void *addr5;
@@ -66,8 +67,8 @@ static struct test_case_t {
 	size_t count;
 	int exp_error;
 } TC[] = {
-	{&badfd, (void **)&buf, 1, EBADF},
-	{&fd2, (void **)&buf, 1, EISDIR},
+	{&badfd, &bufaddr, 1, EBADF},
+	{&fd2, &bufaddr, 1, EISDIR},
 #ifndef UCLINUX
 	{&fd3, &outside_buf, 1, EFAULT},
 #endif
-- 
1.9.1

