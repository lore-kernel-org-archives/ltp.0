From: Li Wang <liwang@redhat.com>
Date: Tue, 19 Mar 2019 17:38:58 +0800
Subject: [LTP] [PATCH RFC 3/3] min_free_kbytes: allow MemFree to fluctuate
	nearby min_pages
In-Reply-To: <20190319093858.584-2-liwang@redhat.com>
References: <20190319093858.584-1-liwang@redhat.com>
 <20190319093858.584-2-liwang@redhat.com>
Message-ID: <20190319093858.584-3-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

After enabling the check_monitor in last commit, I got many failures in this
test, that's because it detects the system MemFree is less than min_free_kbytes
at some moments then reprot FAIL.

  ----ERROR LOG----
  min_free_kbytes.c:197: INFO: MemFree is 180032 kB, min_free_kbytes is 180224 kB
  min_free_kbytes.c:198: FAIL: MemFree < min_free_kbytes
  min_free_kbytes.c:197: INFO: MemFree is 179520 kB, min_free_kbytes is 180224 kB
  min_free_kbytes.c:198: FAIL: MemFree < min_free_kbytes
  min_free_kbytes.c:197: INFO: MemFree is 176704 kB, min_free_kbytes is 180224 kB
  min_free_kbytes.c:198: FAIL: MemFree < min_free_kbytes
  min_free_kbytes.c:197: INFO: MemFree is 176448 kB, min_free_kbytes is 180224 kB
  min_free_kbytes.c:198: FAIL: MemFree < min_free_kbytes
  min_free_kbytes.c:197: INFO: MemFree is 178880 kB, min_free_kbytes is 180224 kB
  min_free_kbytes.c:198: FAIL: MemFree < min_free_kbytes
  min_free_kbytes.c:197: INFO: MemFree is 174656 kB, min_free_kbytes is 180224 kB
  min_free_kbytes.c:198: FAIL: MemFree < min_free_kbytes
  -----------------

But I dont' think it's a kernel bug, since to compare MemFree with min_free_kbytes
is NOT accurate in memory testing.

Theoretically, min_free_kbytes is using for memory watermark setting. When memory
in a certain zone drops below 'low' watermark, the kernel starts to reclaim memory,
until there is again more than 'high' available memory. However, while the memory
is less than 'min' watermark, only GFP_ATOMIC allocations are satisfied, everything
else results in OOM.

In this patch, the MemFree is allowed to fluctuate nearby min_free_kbytes, the main
idea is to give a little accessible range (min_free_kbytes - 1/10*min_free_kbytes)
for MemFree comparing. Otherwise this testcase is meaningless, or we can remove it
from LTP.

MORE REFERENCE INFO:

Those watermarks behave accordingly to the picture below:

    ^
    |
  f | \                  /
  r |  \                /[3]
  e |...\............../................
  e |    \ [0]        /       high_pages
    |     \          /
  p |......\......../...................
  a |       \[1]   /           low_pages
  g |        \    /
  e |.........\../......................
  s |          \/[2]           min_pages
    |
    +------------------------------------>
                    time

Memory is being allocated normally at [0] and [1]. When hash of free pages within a zone
decreases below low_pages [1], kswapd is woken up to start scanning memory for reclamation.

If the allocation load out-paces kswapd and the free memory level drops below min_pages [2]
only ATOMIC allocations are granted and every other task in the system requesting memory
starts doing the same work kswapd does -- putting the system into direct reclaim mode.
Direct reclaim ceases as soon as the free memory level is restored to above min_pages [2]

high_pages [3] marks the point where kswapd goes back to sleep as there's no more reclaim
work to be done.

Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Rafael Aquini <aquini@redhat.com>
---
 testcases/kernel/mem/tunable/min_free_kbytes.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/mem/tunable/min_free_kbytes.c b/testcases/kernel/mem/tunable/min_free_kbytes.c
index 2eb51bf66..6b7da2215 100644
--- a/testcases/kernel/mem/tunable/min_free_kbytes.c
+++ b/testcases/kernel/mem/tunable/min_free_kbytes.c
@@ -169,7 +169,10 @@ static void check_monitor(void)
 		memfree = SAFE_READ_MEMINFO("MemFree:");
 		tune = get_sys_tune("min_free_kbytes");
 
-		if (memfree < tune) {
+		/* The MemFree is allowed to fluctuate nearby min_free_kbytes,
+		 * here is to give a little accessible range(min_free_kbytes -
+		 * 1/10 * min_free_kbytes) for MemFree comparing. */
+		if ((memfree + 1/10*tune) < tune) {
 			tst_res(TINFO, "MemFree is %lu kB, "
 				 "min_free_kbytes is %lu kB", memfree, tune);
 			tst_res(TFAIL, "MemFree < min_free_kbytes");
-- 
2.20.1

