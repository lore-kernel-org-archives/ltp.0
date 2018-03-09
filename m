From: Jan Stancek <jstancek@redhat.com>
Date: Fri,  9 Mar 2018 08:29:26 +0100
Subject: [LTP] [PATCH v2] times03: don't assume process initial [us]time is 0
Message-ID: <e39d28a819f83b5dcad9a9a2606bd657ac34f597.1520580525.git.jstancek@redhat.com>
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

This patch replaces zero check with a comparison against a small
enough number < 5 (which should be between 5ms and 50ms depending
on CONFIG_HZ).

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/times/times03.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/times/times03.c b/testcases/kernel/syscalls/times/times03.c
index 78d72d259ec1..c34faf5a2ff9 100644
--- a/testcases/kernel/syscalls/times/times03.c
+++ b/testcases/kernel/syscalls/times/times03.c
@@ -96,15 +96,15 @@ static void verify_times(void)
 	if (times(&buf1) == -1)
 		tst_brk(TBROK | TERRNO, "times()");
 
-	if (buf1.tms_utime != 0)
+	if (buf1.tms_utime > 5)
 		tst_res(TFAIL, "buf1.tms_utime = %li", buf1.tms_utime);
 	else
-		tst_res(TPASS, "buf1.tms_utime = 0");
+		tst_res(TPASS, "buf1.tms_utime > 5");
 
-	if (buf1.tms_stime != 0)
+	if (buf1.tms_stime > 5)
 		tst_res(TFAIL, "buf1.tms_stime = %li", buf1.tms_stime);
 	else
-		tst_res(TPASS, "buf1.tms_stime = 0");
+		tst_res(TPASS, "buf1.tms_stime > 5");
 
 	generate_utime();
 	generate_stime();
-- 
1.8.3.1

