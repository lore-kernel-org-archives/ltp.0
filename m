From: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Date: Tue,  8 Jun 2021 10:27:23 -0300
Subject: [LTP] [PATCH] futex_wake04: avoid tst_ts_from_ns overflow on 32-bit
 platforms
Message-ID: <20210608132723.255996-1-cascardo@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When multiplying 30 with NSEC_PER_SEC, the result would overflow on 32-bit
platforms, unless cast to long long, which is what tst_ts_from_ns expects.

Though we could change NSEC_PER_SEC to be a long long constant, it was
considered a risk for regressions, as it would affect every use of it.

After this change, futex_wake04 passes on i386.

Reported-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
---
 testcases/kernel/syscalls/futex/futex_wake04.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/futex/futex_wake04.c b/testcases/kernel/syscalls/futex/futex_wake04.c
index 2260a3936d6e..479001e2e59a 100644
--- a/testcases/kernel/syscalls/futex/futex_wake04.c
+++ b/testcases/kernel/syscalls/futex/futex_wake04.c
@@ -56,7 +56,7 @@ static void setup(void)
 	tst_res(TINFO, "Testing variant: %s", tv->desc);
 	futex_supported_by_kernel(tv->fntype);
 
-	to = tst_ts_from_ns(tv->tstype, 30 * NSEC_PER_SEC);
+	to = tst_ts_from_ns(tv->tstype, (long long) 30 * NSEC_PER_SEC);
 }
 
 static void *wait_thread1(void *arg LTP_ATTRIBUTE_UNUSED)
-- 
2.30.2

