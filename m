From: Zhao Gongyi <zhaogongyi@huawei.com>
Date: Tue, 13 Apr 2021 19:54:22 +0800
Subject: [LTP] [PATCH] lib/tst_test.c: Bugfix for heartbeat
Message-ID: <20210413115422.4087-1-zhaogongyi@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When main process has been killed, its son process will be reaped by
init, and son process will send SIGUSR1 to the init process.

In busybox, send SIGUSR1 to the init process will trig shutdown.

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
v1->v2: add exit(TBROK) after kill
---
 lib/tst_test.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 45753d1ca..446887c31 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1156,6 +1156,16 @@ static void heartbeat(void)
 	if (tst_clock_gettime(CLOCK_MONOTONIC, &tst_start_time))
 		tst_res(TWARN | TERRNO, "tst_clock_gettime() failed");

+	if (getppid() == 1) {
+		tst_res(TFAIL, "Main test process might have exit!");
+		/*
+		 * We need kill the task group immediately since the
+		 * main process has exit.
+		 */
+		kill(0, SIGKILL);
+		exit(TBROK);
+	}
+
 	kill(getppid(), SIGUSR1);
 }

--
2.17.1

