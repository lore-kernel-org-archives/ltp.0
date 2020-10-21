From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 21 Oct 2020 10:02:03 +0530
Subject: [LTP] [PATCH V4 2/3] syscalls: select: Verify that data is
 available to read
In-Reply-To: <fb31dd18ad396ab602ba8957ee01a666f79ad9bb.1599558175.git.viresh.kumar@linaro.org>
References: <fb31dd18ad396ab602ba8957ee01a666f79ad9bb.1599558175.git.viresh.kumar@linaro.org>
Message-ID: <63646c1ba9e1a3061b44be4f1f9a29d9d6d03f2e.1603254560.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

select() returns a positive value on success if timeout hasn't happened,
else returns 0. Check that and send some data to the write file
descriptor for the same.

Acked-by: Li Wang <liwang@redhat.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V4:
- test individual bits in the fd_sets to verify properly.

 testcases/kernel/syscalls/select/select01.c | 23 +++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/select/select01.c b/testcases/kernel/syscalls/select/select01.c
index 74538026adbe..68f813bb24b5 100644
--- a/testcases/kernel/syscalls/select/select01.c
+++ b/testcases/kernel/syscalls/select/select01.c
@@ -25,27 +25,42 @@ static struct tcases {
 	int *nfds;
 	fd_set *readfds;
 	fd_set *writefds;
+	int *readfd;
+	int *writefd;
 	char *desc;
 } tests[] = {
-	{&fd_reg, &readfds_reg, NULL, "with regular file"},
-	{&fds_pipe[1], &readfds_pipe, &writefds_pipe, "with system pipe"},
-	{&fd_npipe, &readfds_npipe, &writefds_npipe, "with named pipe (FIFO)"},
+	{&fd_reg, &readfds_reg, NULL, &fd_reg, NULL, "with regular file"},
+	{&fds_pipe[1], &readfds_pipe, &writefds_pipe, &fds_pipe[0], &fds_pipe[1], "with system pipe"},
+	{&fd_npipe, &readfds_npipe, &writefds_npipe, &fd_npipe, &fd_npipe, "with named pipe (FIFO)"},
 };
 
 static void run(unsigned int n)
 {
 	struct tcases *tc = &tests[n];
 	struct timeval timeout;
+	char buf;
+	int exp_ret = 1;
 
 	timeout.tv_sec = 0;
 	timeout.tv_usec = 100000;
 
+	if (tc->writefd) {
+		SAFE_WRITE(0, *tc->writefd, &buf, sizeof(buf));
+		exp_ret++;
+	}
+
 	TEST(do_select(*tc->nfds + 1, tc->readfds, tc->writefds, 0, &timeout));
 
 	if (TST_RET == -1)
 		tst_res(TFAIL | TTERRNO, "select() failed %s", tc->desc);
-	else
+	else if (!TST_RET)
+		tst_res(TFAIL, "select() timed out %s", tc->desc);
+	else if (TST_RET != exp_ret)
+		tst_res(TFAIL, "select() returned incorrect value %s, expected: %d, got: %lu", tc->desc, exp_ret, TST_RET);
+	else if (FD_ISSET(*tc->readfd, tc->readfds) && (!tc->writefd || FD_ISSET(*tc->writefd, tc->writefds)))
 		tst_res(TPASS, "select() passed %s", tc->desc);
+	else
+		tst_res(TFAIL, "select() returned expected value %s, but all file descriptors aren't ready", tc->desc);
 }
 
 static void setup(void)
-- 
2.25.0.rc1.19.g042ed3e048af

