From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 15 May 2019 14:10:43 +0530
Subject: [LTP] LTP: mm: overcommit_memory01, 03...06 failed
Message-ID: <CA+G9fYu254sYc77jOVifOmxrd_jNmr4wNHTrqnW54a8F=EQZ6Q@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

ltp-mm-tests failed on Linux mainline kernel  5.1.0,
  * overcommit_memory01 overcommit_memory
  * overcommit_memory03 overcommit_memory -R 30
  * overcommit_memory04 overcommit_memory -R 80
  * overcommit_memory05 overcommit_memory -R 100
  * overcommit_memory06 overcommit_memory -R 200

mem.c:814: INFO: set overcommit_memory to 0
overcommit_memory.c:185: INFO: malloc 8094844 kB successfully
overcommit_memory.c:204: PASS: alloc passed as expected
overcommit_memory.c:189: INFO: malloc 32379376 kB failed
overcommit_memory.c:210: PASS: alloc failed as expected
overcommit_memory.c:185: INFO: malloc 16360216 kB successfully
overcommit_memory.c:212: FAIL: alloc passed, expected to fail

Failed test log,
https://lkft.validation.linaro.org/scheduler/job/726417#L22852

LTP version 20190115

Test case link,
https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/mem/tunable/overcommit_memory.c#L212

First bad commit:
git branch master
git commit e0654264c4806dc436b291294a0fbf9be7571ab6
git describe v5.1-10706-ge0654264c480
git repo https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

Last good commit:
git branch master
git commit 7e9890a3500d95c01511a4c45b7e7192dfa47ae2
git describe v5.1-10326-g7e9890a3500d
git repo https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

Best regards
Naresh Kamboju
