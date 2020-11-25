From: Li Wang <liwang@redhat.com>
Date: Wed, 25 Nov 2020 10:16:33 +0000
Subject: [LTP] [PATCH] fzsync: skip test when avaliable CPUs less than 2
Message-ID: <20201125101633.30154-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

It makes no sense to run parallel thread to simulate race conditions on
system with CPU number less than two, especially for kvm guest, it does
not have any chance to get real parallel running and probably encounter
failure as below:

=== 100% reproducible on a 1cpu guest ===

cmdline="af_alg07"
contacts=""
analysis=exit
<<<test_output>>>
tst_test.c:1248: TINFO: Timeout per run is 0h 05m 00s
../../../include/tst_fuzzy_sync.h:507: TINFO: Minimum sampling period ended
../../../include/tst_fuzzy_sync.h:330: TINFO: loop = 1024, delay_bias = 0
../../../include/tst_fuzzy_sync.h:318: TINFO: start_a - start_b: { avg = -137522ns, avg_dev = 854248ns, dev_ratio = 6.21 }
../../../include/tst_fuzzy_sync.h:318: TINFO: end_a - start_a  : { avg =  1915ns, avg_dev =   535ns, dev_ratio = 0.28 }
../../../include/tst_fuzzy_sync.h:318: TINFO: end_b - start_b  : { avg =  1885ns, avg_dev =    42ns, dev_ratio = 0.02 }
../../../include/tst_fuzzy_sync.h:318: TINFO: end_a - end_b    : { avg = -137492ns, avg_dev = 854818ns, dev_ratio = 6.22 }
../../../include/tst_fuzzy_sync.h:318: TINFO: spins            : { avg = 554786  , avg_dev =  7355  , dev_ratio = 0.01 }
../../../include/tst_fuzzy_sync.h:636: TINFO: Exceeded execution time, requesting exit
af_alg07.c:96: TFAIL: fchownat() failed to fail, kernel may be vulnerable

Signed-off-by: Li Wang <liwang@redhat.com>
CC: Richard Palethorpe <rpalethorpe@suse.de>
---
 include/tst_fuzzy_sync.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/tst_fuzzy_sync.h b/include/tst_fuzzy_sync.h
index 4141f5c64..2e864b312 100644
--- a/include/tst_fuzzy_sync.h
+++ b/include/tst_fuzzy_sync.h
@@ -281,6 +281,9 @@ static void tst_init_stat(struct tst_fzsync_stat *s)
 static void tst_fzsync_pair_reset(struct tst_fzsync_pair *pair,
 				  void *(*run_b)(void *))
 {
+	if (get_nprocs() < 2)
+		tst_brk(TCONF, "Fuzzy Sync requires@least two CPUs available");
+
 	tst_fzsync_pair_cleanup(pair);
 
 	tst_init_stat(&pair->diff_ss);
-- 
2.21.3

