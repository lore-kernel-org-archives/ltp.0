From: Alexander Egorenkov <egorenar@linux.ibm.com>
Date: Tue,  1 Jun 2021 11:36:13 +0200
Subject: [LTP] [PATCH 1/2] clock_settime03: fix type of time
Message-ID: <20210601093614.245873-1-egorenar@linux.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

tst_ts_set_sec() accepts a signed long value.
And Unix time is always a signed value.

Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>
---
 testcases/kernel/syscalls/clock_settime/clock_settime03.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/clock_settime/clock_settime03.c b/testcases/kernel/syscalls/clock_settime/clock_settime03.c
index c25277d92..f196a257c 100644
--- a/testcases/kernel/syscalls/clock_settime/clock_settime03.c
+++ b/testcases/kernel/syscalls/clock_settime/clock_settime03.c
@@ -45,7 +45,7 @@ static void setup(void)
 static void run(void)
 {
 	struct time64_variants *tv = &variants[tst_variant];
-	unsigned long long time = 0x7FFFFFFE; /* Time just before y2038 */
+	long long time = 0x7FFFFFFE; /* Time just before y2038 */
 	struct sigevent ev = {
 		.sigev_notify = SIGEV_SIGNAL,
 		.sigev_signo = SIGABRT,
-- 
2.31.1

