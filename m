From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 27 Jun 2018 14:36:06 +0200
Subject: [LTP] [RFC] [PATCH] tst_test: Fail the test subprocess cannot be
	killed
Message-ID: <20180627123606.27726-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

If there are any leftover children the main test process will likely be
killed while sleeping in wait(). That is because all child processes are
either waited explicitely by the test code or implicitly by the test
library.

We also send SIGKILL to the whole process group, so if one of the
children continues to live for long enough it very likely means that
it has ended up stuck in the kernel.

So if there are any processes left with in the process group for the
test processes once the process group leader i.e. main test process has
been waited for we loop for a short while to give the init daemon chance
to reap the process after it has been reparented and if that does not
happen for a few seconds we declare the process to be stuck in the
kernel.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
CC: Eric Biggers <ebiggers3@gmail.com>
---
 lib/tst_test.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 80808854e..6316ac865 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1047,6 +1047,21 @@ static int fork_testrun(void)
 	alarm(0);
 	SAFE_SIGNAL(SIGINT, SIG_DFL);
 
+	unsigned int sleep = 100;
+	unsigned int retries = 0;
+
+	while (kill(-test_pid, 0) == 0) {
+
+		usleep(sleep);
+		sleep*=2;
+
+		if (retries++ <= 14)
+			continue;
+
+		tst_res(TINFO, "Test process child stuck in the kernel!");
+		tst_brk(TFAIL, "Congratulation, likely test hit a kernel bug.");
+	}
+
 	if (WIFEXITED(status) && WEXITSTATUS(status))
 		return WEXITSTATUS(status);
 
-- 
2.13.6

