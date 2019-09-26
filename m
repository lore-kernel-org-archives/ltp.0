From: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Date: Thu, 26 Sep 2019 11:45:07 -0300
Subject: [LTP] [PATCH] timer_create01: accept ENOTSUP
Message-ID: <20190926144507.15765-1-cascardo@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

CLOCK_REALTIME_ALARM and CLOCK_BOOTTIME_ALARM require an RTC with alarm
support, which may not be present on a system. In that case, the kernel
will return EOPNOTSUPP, which is defined as ENOTSUP in userspace.

As these clocks are already possibly unsupported, accept that as an error
code besides the EINVAL code.

Note that previously the kernel would incorrectly return the ENOTSUPP code,
which is undefined in userspace. With these unfixed kernels, the test will
fail when those RTCs are not present.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
---
 testcases/kernel/syscalls/timer_create/timer_create01.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/timer_create/timer_create01.c b/testcases/kernel/syscalls/timer_create/timer_create01.c
index 258b6444c362..1ae5b9b2d1c2 100644
--- a/testcases/kernel/syscalls/timer_create/timer_create01.c
+++ b/testcases/kernel/syscalls/timer_create/timer_create01.c
@@ -77,7 +77,8 @@ static void run(unsigned int n)
 				&created_timer_id));
 
 		if (TST_RET != 0) {
-			if (possibly_unsupported(clock) && TST_ERR == EINVAL) {
+			if (possibly_unsupported(clock) &&
+			    (TST_ERR == EINVAL || TST_ERR == ENOTSUP)) {
 				tst_res(TPASS | TTERRNO,
 					"%s unsupported, failed as expected",
 					get_clock_str(clock));
-- 
2.20.1

