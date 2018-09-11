From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 11 Sep 2018 13:21:02 +0200
Subject: [LTP] [PATCH] alarm02: fix for 32-bit kernels
Message-ID: <fb2cefb44d91e346c7947a76c3131913008b0db0.1536664816.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Test fails on 32-bit kernels with:
  alarm02.c:55: FAIL: alarm(4294967295) returned 2147483647 as unexpected

because kernel alarm_setitimer() limits seconds to INT_MAX to avoid
negative timeval settings which would cause immediate expiry:

  static unsigned int alarm_setitimer(unsigned int seconds)
  {
        struct itimerval it_new, it_old;

  #if BITS_PER_LONG < 64
        if (seconds > INT_MAX)
                seconds = INT_MAX;
  #endif

Don't test UINT_MAX.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/alarm/alarm02.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/alarm/alarm02.c b/testcases/kernel/syscalls/alarm/alarm02.c
index d318c8b14637..94239060c4ef 100644
--- a/testcases/kernel/syscalls/alarm/alarm02.c
+++ b/testcases/kernel/syscalls/alarm/alarm02.c
@@ -21,7 +21,7 @@ static struct tcase {
 	char *str;
 	unsigned int sec;
 } tcases[] = {
-	{"UINT_MAX", UINT_MAX},
+	{"INT_MAX", INT_MAX},
 	{"UINT_MAX/2", UINT_MAX/2},
 	{"UINT_MAX/4", UINT_MAX/4},
 };
-- 
1.8.3.1

