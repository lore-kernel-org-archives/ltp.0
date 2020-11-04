From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 4 Nov 2020 16:55:12 +0530
Subject: [LTP] [stable-rc 4.14] shmctl04.c:115: TFAIL: SHM_INFO haven't
 returned a valid index: SUCCESS (0)
Message-ID: <CA+G9fYu4RdH7zdd5MU=E-o+azMRx-EqR-7VYuJCUastKRd0KCA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

LTP syscalls test shmctl04 test modified in latest LTP release 20200930
and this test reported as fail. so reporting to LTP mailing list.
Failed on stable-rc 4.14, 4.9 and 4.4 branches but
passed on stable-rc 4.19, 5.4 and 5.9 branches for arm64, arm, x86_64 and i386.

shmctl04.c:115: TFAIL: SHM_INFO haven't returned a valid index: SUCCESS (0)
shmctl04.c:131: TFAIL: Counted used = 0, used_ids = 1
shmctl04.c:72: TPASS: used_ids = 1
shmctl04.c:79: TPASS: shm_rss = 0
shmctl04.c:86: TPASS: shm_swp = 0
shmctl04.c:93: TPASS: shm_tot = 1

Reported-by: Naresh Kamboju  <naresh.kamboju@linaro.org>

Test log link,
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.14.y/build/v4.14.203-126-g8c25e7a92b2f/testrun/3392140/suite/ltp-syscalls-tests/test/shmctl04/log

kernel: 4.14.204-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.14.y
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.14.y/build/v4.14.203-126-g8c25e7a92b2f

-- 
Linaro LKFT
https://lkft.linaro.org
