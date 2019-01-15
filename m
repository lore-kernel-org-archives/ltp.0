From: Jia Zhang <zhang.jia@linux.alibaba.com>
Date: Tue, 15 Jan 2019 10:14:30 +0800
Subject: [LTP] [PATCH v2 0/6] LTP IMA fix bundle
Message-ID: <1547518476-34008-1-git-send-email-zhang.jia@linux.alibaba.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Mimi and Petr,

Here is the v2 patch series.

Changelogs since V1: 
- Don't use the word "policy" in patch 4's commit header.
- Drop patch 6 ("ima: Use ima tcb policy files for test") because it
  bases on a faulty misjudgement.
- Add a new patch to address ima_violations failure.

The latest test result is attached.

Test Start Time: Tue Jan 15 10:09:14 2019
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

Thanks,
Jia
