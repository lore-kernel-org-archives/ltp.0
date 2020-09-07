From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Mon,  7 Sep 2020 14:30:06 +0530
Subject: [LTP] [PATCH V2 3/3] syscalls: select: Verify that data is
 available to read
In-Reply-To: <fa29d6d05e385170a74a06fbe752fbaac3965358.1599469171.git.viresh.kumar@linaro.org>
References: <fa29d6d05e385170a74a06fbe752fbaac3965358.1599469171.git.viresh.kumar@linaro.org>
Message-ID: <3966837943d2ad3e74a69d6c34f18cc152c09536.1599469171.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

select() returns a positive value on success if timeout hasn't happened,
else returns 0. Check that and send some data to the write file
descriptor for the same.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 testcases/kernel/syscalls/select/select01.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/select/select01.c b/testcases/kernel/syscalls/select/select01.c
index 4f8afb4e6bd6..4cf139b09598 100644
--- a/testcases/kernel/syscalls/select/select01.c
+++ b/testcases/kernel/syscalls/select/select01.c
@@ -25,24 +25,31 @@ static struct select_info {
 	int *nfds;
 	fd_set *readfds;
 	fd_set *writefds;
+	int *writefd;
 } tests[] = {
-	{&fd_reg, &readfds_reg, NULL},
-	{&fds_pipe[1], &readfds_pipe, &writefds_pipe},
-	{&fd_npipe, &readfds_npipe, &writefds_npipe},
+	{&fd_reg, &readfds_reg, NULL, NULL},
+	{&fds_pipe[1], &readfds_pipe, &writefds_pipe, &fds_pipe[1]},
+	{&fd_npipe, &readfds_npipe, &writefds_npipe, &fd_npipe},
 };
 
 static void run(unsigned int n)
 {
 	struct select_info *tc = &tests[n];
 	struct timeval timeout;
+	char buf;
 
 	timeout.tv_sec = 0;
 	timeout.tv_usec = 100000;
 
+	if (tc->writefd)
+		SAFE_WRITE(0, *tc->writefd, &buf, sizeof(buf));
+
 	TEST(do_select(*tc->nfds + 1, tc->readfds, tc->writefds, 0, &timeout));
 
 	if (TST_RET == -1)
 		tst_res(TFAIL | TTERRNO, "select() failed");
+	else if (!TST_RET)
+		tst_res(TFAIL, "select() timed out");
 	else
 		tst_res(TPASS, "select() passed");
 }
-- 
2.25.0.rc1.19.g042ed3e048af

