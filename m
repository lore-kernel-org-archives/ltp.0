From: Jia Zhang <zhang.jia@linux.alibaba.com>
Date: Wed, 16 Jan 2019 10:57:35 +0800
Subject: [LTP] [PATCH v3 0/6] LTP IMA fix bundle
Message-ID: <1547607461-11233-1-git-send-email-zhang.jia@linux.alibaba.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Changelog since V2:
- Rework patch 6. Here is a quick diff against V2:

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh b/testcases/kernel/security/int
index a1360b8..74223c2 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
@@ -20,6 +20,7 @@
 # Test whether ToMToU and open_writer violations invalidatethe PCR and are logged.
 
 TST_SETUP="setup"
+TST_CLEANUP="cleanup"
 TST_CNT=3
 TST_NEEDS_DEVICE=1
 
@@ -46,10 +47,12 @@ setup()
        tst_res TINFO "using log $LOG"
 }
 
-reset_printk_ratelimit()
+cleanup()
 {
        [ "$PRINTK_RATE_LIMIT" != "0" ] && \
                sysctl -wq kernel.printk_ratelimit=$PRINTK_RATE_LIMIT
+
+       ima_cleanup
 }
 
 open_file_read()
@@ -163,8 +166,6 @@ test3()
 
        validate $num_violations $count $search
 
-       reset_printk_ratelimit
-
        # wait for ima_mmap to exit, so we can umount
        tst_sleep 2s
 }

The latest test results are attached:

Test Start Time: Wed Jan 16 10:44:10 2019
-----------------------------------------
Testcase                                           Result     Exit Value
--------                                           ------     ----------
ima_measurements                                   PASS       0    
ima_policy                                         PASS       0    
ima_tpm                                            CONF       32   
ima_violations                                     PASS       0    

-----------------------------------------------
Total Tests: 4
Total Skipped Tests: 1
Total Failures: 0
Kernel Version: 5.0.0-rc1+
Machine Architecture: x86_64
Hostname: test-machine

Jia

