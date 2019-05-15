From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 15 May 2019 05:03:55 -0400 (EDT)
Subject: [LTP] LTP: mm: overcommit_memory01, 03...06 failed
In-Reply-To: <CA+G9fYu254sYc77jOVifOmxrd_jNmr4wNHTrqnW54a8F=EQZ6Q@mail.gmail.com>
References: <CA+G9fYu254sYc77jOVifOmxrd_jNmr4wNHTrqnW54a8F=EQZ6Q@mail.gmail.com>
Message-ID: <543317293.22835729.1557911035979.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> ltp-mm-tests failed on Linux mainline kernel  5.1.0,
>   * overcommit_memory01 overcommit_memory
>   * overcommit_memory03 overcommit_memory -R 30
>   * overcommit_memory04 overcommit_memory -R 80
>   * overcommit_memory05 overcommit_memory -R 100
>   * overcommit_memory06 overcommit_memory -R 200
> 
> mem.c:814: INFO: set overcommit_memory to 0
> overcommit_memory.c:185: INFO: malloc 8094844 kB successfully
> overcommit_memory.c:204: PASS: alloc passed as expected
> overcommit_memory.c:189: INFO: malloc 32379376 kB failed
> overcommit_memory.c:210: PASS: alloc failed as expected
> overcommit_memory.c:185: INFO: malloc 16360216 kB successfully
> overcommit_memory.c:212: FAIL: alloc passed, expected to fail
> 
> Failed test log,
> https://lkft.validation.linaro.org/scheduler/job/726417#L22852
> 
> LTP version 20190115
> 
> Test case link,
> https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/mem/tunable/overcommit_memory.c#L212
> 
> First bad commit:
> git branch master
> git commit e0654264c4806dc436b291294a0fbf9be7571ab6
> git describe v5.1-10706-ge0654264c480
> git repo https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> 
> Last good commit:
> git branch master
> git commit 7e9890a3500d95c01511a4c45b7e7192dfa47ae2
> git describe v5.1-10326-g7e9890a3500d
> git repo https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

Heuristic changed a bit in:
  commit 8c7829b04c523cdc732cb77f59f03320e09f3386
  Author: Johannes Weiner <hannes@cmpxchg.org>
  Date:   Mon May 13 17:21:50 2019 -0700
    mm: fix false-positive OVERCOMMIT_GUESS failures

LTP tries to allocate "mem_total + swap_total":
  alloc_and_check(sum_total, EXPECT_FAIL);
which now presumably falls short to trigger failure.

> 
> Best regards
> Naresh Kamboju
> 
