From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 18 Nov 2020 14:52:06 +0100
Subject: [LTP] [PATCH] syscalls: select: Add test to verify clearing of
 fd sets
In-Reply-To: <4b831a20278083623bce96f9c4171b6cff9c4e46.1605698312.git.viresh.kumar@linaro.org>
References: <4b831a20278083623bce96f9c4171b6cff9c4e46.1605698312.git.viresh.kumar@linaro.org>
Message-ID: <20201118135206.GA5216@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with minor changes, thanks.

- moved the code that enables the bits to the run() function
  so that the test actually checks the condition on -i 2

- shortened the timeout so that the test runs fast enough

- formatted the top level comment properly, since we merged the docparse
  patchset special comments are exported into the generated documentation


Full diff:

diff --git a/testcases/kernel/syscalls/select/select04.c b/testcases/kernel/syscalls/select/select04.c
index 8106dea8b..dd042562d 100644
--- a/testcases/kernel/syscalls/select/select04.c
+++ b/testcases/kernel/syscalls/select/select04.c
@@ -2,10 +2,18 @@
 /*
  * Copyright (c) 2020 Linaro Limited. All rights reserved.
  * Author: Viresh Kumar <viresh.kumar@linaro.org>
- *
- * Test to check if fd sets are cleared by select() or not.
  */
 
+/*\
+ * [DESCRIPTION]
+ *
+ * Test to check if fd set bits are cleared by select().
+ *
+ * [ALGORITHM]
+ *  - Check that writefds flag is cleared on full pipe
+ *  - Check that readfds flag is cleared on empty pipe
+\*/
+
 #include <unistd.h>
 #include <errno.h>
 #include <sys/time.h>
@@ -29,12 +37,12 @@ static struct tcases {
 static void run(unsigned int n)
 {
 	struct tcases *tc = &tests[n];
-	struct timeval timeout;
+	struct timeval timeout = {.tv_sec = 0, .tv_usec = 1000};
 
-	timeout.tv_sec = 0;
-	timeout.tv_usec = 100000;
+	FD_SET(fd_empty[0], &readfds_pipe);
+	FD_SET(fd_full[1], &writefds_pipe);
 
-	TEST(do_select(*tc->fd + 1, tc->readfds, tc->writefds, 0, &timeout));
+	TEST(do_select(*tc->fd + 1, tc->readfds, tc->writefds, NULL, &timeout));
 
 	if (TST_RET) {
 		tst_res(TFAIL, "%s: select() should have timed out", tc->desc);
@@ -58,11 +66,9 @@ static void setup(void)
 
 	SAFE_PIPE(fd_empty);
 	FD_ZERO(&readfds_pipe);
-	FD_SET(fd_empty[0], &readfds_pipe);
 
 	SAFE_PIPE2(fd_full, O_NONBLOCK);
 	FD_ZERO(&writefds_pipe);
-	FD_SET(fd_full[1], &writefds_pipe);
 
 	/* Make the write buffer full for fd_full */
 	do {

-- 
Cyril Hrubis
chrubis@suse.cz
