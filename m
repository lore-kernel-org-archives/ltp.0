From: Jia Zhang <zhang.jia@linux.alibaba.com>
Date: Mon,  7 Jan 2019 10:26:23 +0800
Subject: [LTP] [PATCH 0/6] LTP IMA fix bundle
Message-ID: <1546827989-43569-1-git-send-email-zhang.jia@linux.alibaba.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Mimi & Petr,

This fix bundle fixes and cleans up IMA-related testcases in LTP.

My test result is attached here.

#cat LTP_RUN_ON-2019_01_07-10h_05m_16s.log 
Test Start Time: Mon Jan  7 10:05:18 2019
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
Kernel Version: 4.20.0+
Machine Architecture: x86_64
Hostname: test-machine

Note:
- The original PR is available at https://github.com/linux-test-project/ltp/pull/459
- The test2() in ima_tpm requires /sys/class/tpm/tpm0/device/pcrs but this interface
  is not available if TPM2 device used. So the test result showed above is expected.

Jia
