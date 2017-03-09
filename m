From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu,  9 Mar 2017 16:13:08 +0100
Subject: [LTP] [COMMITTED] [PATCH 6/6] syscalls/alarm06: Reduce test runtime
	from 15s to 3s
In-Reply-To: <20170309151308.17512-1-chrubis@suse.cz>
References: <20170309151308.17512-1-chrubis@suse.cz>
Message-ID: <20170309151308.17512-6-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

There is no need to sleep for 5s when 1s would do the same, etc.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/alarm/alarm06.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/alarm/alarm06.c b/testcases/kernel/syscalls/alarm/alarm06.c
index 60451b7..8634128 100644
--- a/testcases/kernel/syscalls/alarm/alarm06.c
+++ b/testcases/kernel/syscalls/alarm/alarm06.c
@@ -56,23 +56,23 @@ static void verify_alarm(void)
 {
 	int ret;
 
-	alarm(10);
-	sleep(5);
+	alarm(2);
+	sleep(1);
 
 	ret = alarm(0);
 
 	/* Wait for signal SIGALRM */
-	sleep(10);
+	sleep(2);
 
 	if (alarms_received)
 		tst_res(TFAIL, "Received %i alarms", alarms_received);
 	else
 		tst_res(TPASS, "Received 0 alarms");
 
-	if (ret == 5)
-		tst_res(TPASS, "alarm(0) returned 5");
+	if (ret == 1)
+		tst_res(TPASS, "alarm(0) returned 1");
 	else
-		tst_res(TFAIL, "alarm(0) returned %i, expected 5", ret);
+		tst_res(TFAIL, "alarm(0) returned %i, expected 1", ret);
 }
 
 static struct tst_test test = {
-- 
2.10.2

