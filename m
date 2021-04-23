From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 23 Apr 2021 15:03:25 +0200
Subject: [LTP] [PATCH 1/2] syscalls/sendfile: Convert sendfile04 to the
 new API
In-Reply-To: <20210423095944.118255-2-xieziyao@huawei.com>
References: <20210423095944.118255-1-xieziyao@huawei.com>
 <20210423095944.118255-2-xieziyao@huawei.com>
Message-ID: <YILFnTZv5k23bM/Q@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've simplified the code even a bit more and pushed, thanks.

I've did a minor adjustenment such as:

- there is no need to reopen the in_fd since we do not actually read
  from it

- no need to define OFF_T to off_t

- no need for the SOCKETPAIR, the in_fd and out_fd can be any fds as
  long as in is opened for reading and out opened for writing

full diff:

diff --git a/testcases/kernel/syscalls/sendfile/sendfile04.c b/testcases/kernel/syscalls/sendfile/sendfile04.c
index 42600a8ac..4cbc48edc 100644
--- a/testcases/kernel/syscalls/sendfile/sendfile04.c
+++ b/testcases/kernel/syscalls/sendfile/sendfile04.c
@@ -9,7 +9,7 @@
  * [Description]
  *
  * Testcase to test that sendfile(2) system call returns EFAULT when passing
- * wrong buffer.
+ * wrong offset pointer.
  *
  * [Algorithm]
  *
@@ -31,16 +31,8 @@
 
 #include "tst_test.h"
 
-#ifndef OFF_T
-#define OFF_T off_t
-#endif
-
-#define IN_FILE "sendfile04_infile"
-
-int in_fd;
-int out_fd;
-int out[2];
-static char buf[] = "abcdefghijklmnopqrstuvwxyz";
+static int in_fd;
+static int out_fd;
 
 struct test_case_t {
 	int protection;
@@ -56,40 +48,33 @@ struct test_case_t {
 
 static void setup(void)
 {
-	in_fd = SAFE_CREAT(IN_FILE, 00700);
-	SAFE_WRITE(1, in_fd, buf, strlen(buf));
-	SAFE_CLOSE(in_fd);
-
-	SAFE_SOCKETPAIR(AF_UNIX, SOCK_DGRAM, 0, out);
-	out_fd = out[0];
+	in_fd = SAFE_CREAT("in_file", O_RDONLY);
+	out_fd = SAFE_CREAT("out_file", O_WRONLY);
+	SAFE_WRITE(1, in_fd, "a", 1);
 }
 
 static void cleanup(void)
 {
-	SAFE_CLOSE(out[0]);
-	SAFE_CLOSE(out[1]);
+	SAFE_CLOSE(in_fd);
+	SAFE_CLOSE(out_fd);
 }
 
 static void run(unsigned int i)
 {
-	OFF_T *protected_buffer;
+	off_t *protected_buffer;
 	protected_buffer = SAFE_MMAP(NULL, sizeof(*protected_buffer),
 			             tc[i].protection,
-				     MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+				     MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+
 	if (tc[i].pass_unmapped_buffer)
 		SAFE_MUNMAP(protected_buffer, sizeof(*protected_buffer));
 
-	struct stat sb;
-	SAFE_STAT(IN_FILE, &sb);
-	in_fd = SAFE_OPEN(IN_FILE, O_RDONLY);
-
-	TST_EXP_FAIL(sendfile(out_fd, in_fd, protected_buffer, sb.st_size),
+	TST_EXP_FAIL(sendfile(out_fd, in_fd, protected_buffer, 1),
 		     EFAULT, "sendfile(..) with %s, protection=%d",
 		     tc[i].desc, tc[i].protection);
 
 	if (!tc[i].pass_unmapped_buffer)
 		SAFE_MUNMAP(protected_buffer, sizeof(*protected_buffer));
-	SAFE_CLOSE(in_fd);
 }
 
 static struct tst_test test = {

-- 
Cyril Hrubis
chrubis@suse.cz
