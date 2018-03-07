From: Jan Stancek <jstancek@redhat.com>
Date: Wed,  7 Mar 2018 09:34:37 +0100
Subject: [LTP] [PATCH] times03: don't assume process initial [us]time is 0
Message-ID: <8385516ec732e57976aeef8789480c6bf0199bcb.1520411634.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

times() runs immediately after fork(), but syscall alone
seems to be enough for some systems to already account ticks.

For example on arm64 with 4.14:
  tst_test.c:980: INFO: Timeout per run is 0h 05m 00s
  times03.c:102: PASS: buf1.tms_utime = 0
  times03.c:105: FAIL: buf1.tms_stime = 1
  ...

This patch drops the initial zero check for [us]time.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/times/times03.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/testcases/kernel/syscalls/times/times03.c b/testcases/kernel/syscalls/times/times03.c
index 78d72d259ec1..c23ea541ab34 100644
--- a/testcases/kernel/syscalls/times/times03.c
+++ b/testcases/kernel/syscalls/times/times03.c
@@ -96,16 +96,6 @@ static void verify_times(void)
 	if (times(&buf1) == -1)
 		tst_brk(TBROK | TERRNO, "times()");
 
-	if (buf1.tms_utime != 0)
-		tst_res(TFAIL, "buf1.tms_utime = %li", buf1.tms_utime);
-	else
-		tst_res(TPASS, "buf1.tms_utime = 0");
-
-	if (buf1.tms_stime != 0)
-		tst_res(TFAIL, "buf1.tms_stime = %li", buf1.tms_stime);
-	else
-		tst_res(TPASS, "buf1.tms_stime = 0");
-
 	generate_utime();
 	generate_stime();
 
-- 
1.8.3.1

