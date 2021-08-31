From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 31 Aug 2021 14:12:50 +0200
Subject: [LTP] [PATCH 1/1] lib/tests: Remove tst_fuzzy_sync02
Message-ID: <20210831121250.17557-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

tst_fuzzy_sync02 is not stable enough [1]:

../../include/tst_fuzzy_sync.h:346: TINFO: loop = 10001, delay_bias = 3960
../../include/tst_fuzzy_sync.h:335: TINFO: start_a - start_b: { avg = -8859ns, avg_dev =    66ns, dev_ratio = 0.01 }
../../include/tst_fuzzy_sync.h:335: TINFO: end_a - start_a  : { avg = 17160ns, avg_dev =    85ns, dev_ratio = 0.00 }
../../include/tst_fuzzy_sync.h:335: TINFO: end_b - start_b  : { avg = 18474ns, avg_dev =    55ns, dev_ratio = 0.00 }
../../include/tst_fuzzy_sync.h:335: TINFO: end_a - end_b    : { avg = -10173ns, avg_dev =   124ns, dev_ratio = 0.01 }
../../include/tst_fuzzy_sync.h:335: TINFO: spins            : { avg =  2751  , avg_dev =    31  , dev_ratio = 0.01 }
../../include/tst_fuzzy_sync.h:685: TINFO: Exceeded execution loops, requesting exit
tst_fuzzy_sync02.c:169: TFAIL: 2| =:48
...
runtest TINFO: === C TEST RESULTS ===
...
runtest TINFO: 1x TFAIL: tst_fuzzy_sync02

Both tst_fuzzy_sync0{1,2} occasionally fails (restart helps). But
tst_fuzzy_sync03 is stable thus we have at least smoke test for fuzzy
sync.

[1] https://github.com/linux-test-project/ltp/runs/3471271675

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/newlib_tests/runtest.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/newlib_tests/runtest.sh b/lib/newlib_tests/runtest.sh
index 70fbffb6c..05c76228b 100755
--- a/lib/newlib_tests/runtest.sh
+++ b/lib/newlib_tests/runtest.sh
@@ -2,8 +2,8 @@
 # Copyright (c) 2021 Petr Vorel <pvorel@suse.cz>
 
 LTP_C_API_TESTS="${LTP_C_API_TESTS:-test05 test07 test09 test12 test15 test18
-tst_bool_expr test_exec test_timer tst_res_hexd tst_strstatus tst_fuzzy_sync02
-tst_fuzzy_sync03 test_zero_hugepage.sh}"
+tst_bool_expr test_exec test_timer tst_res_hexd tst_strstatus tst_fuzzy_sync03
+test_zero_hugepage.sh}"
 
 LTP_SHELL_API_TESTS="${LTP_SHELL_API_TESTS:-shell/tst_check_driver.sh shell/net/*.sh}"
 
-- 
2.33.0

