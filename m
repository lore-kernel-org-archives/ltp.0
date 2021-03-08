From: Li Wang <liwang@redhat.com>
Date: Mon,  8 Mar 2021 06:53:29 +0000
Subject: [LTP] [PATCH] clock_gettime04: print more info to help debugging
Message-ID: <20210308065329.25824-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We get some sporadically failures like below, but we don't know which
loop it comes from. So adding more prints to help locate issue.

  tst_test.c:1286: TINFO: Timeout per run is 0h 05m 00s
  vdso_helpers.c:76: TINFO: Couldn't find vdso_gettime64()
  clock_gettime04.c:157: TPASS: CLOCK_REALTIME: Difference between successive readings is reasonable
  clock_gettime04.c:150: TFAIL: CLOCK_REALTIME_COARSE: Difference between successive readings greater than 5 ms (1): 8
  clock_gettime04.c:157: TPASS: CLOCK_MONOTONIC: Difference between successive readings is reasonable
  clock_gettime04.c:150: TFAIL: CLOCK_MONOTONIC_COARSE: Difference between successive readings greater than 5 ms (0): 5
  clock_gettime04.c:157: TPASS: CLOCK_MONOTONIC_RAW: Difference between successive readings is reasonable
  clock_gettime04.c:157: TPASS: CLOCK_BOOTTIME: Difference between successive readings is reasonable

Btw, it occurs on a x86_64 (not virtualized) with kernel 5.11.0.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/syscalls/clock_gettime/clock_gettime04.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/kernel/syscalls/clock_gettime/clock_gettime04.c b/testcases/kernel/syscalls/clock_gettime/clock_gettime04.c
index 5f8264cc6..4dc9093c7 100644
--- a/testcases/kernel/syscalls/clock_gettime/clock_gettime04.c
+++ b/testcases/kernel/syscalls/clock_gettime/clock_gettime04.c
@@ -108,6 +108,9 @@ static void run(unsigned int i)
 			if (tv->clock_gettime == my_gettimeofday && clks[i] != CLOCK_REALTIME)
 				continue;
 
+			if (tv->clock_gettime && count == 10000)
+				tst_res(TINFO, "%s", tv->desc);
+
 			ret = tv->clock_gettime(clks[i], tst_ts_get(&ts));
 			if (ret) {
 				/*
-- 
2.21.3

