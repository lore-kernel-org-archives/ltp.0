From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 13 May 2019 12:34:00 +0530
Subject: [LTP] LTP: Syscalls: 274 failures: EROFS(30): Read-only file system
Message-ID: <CA+G9fYuLXPnCmpnnLqBf5qinV6wrFx=HBH2KrB8s1HmCxLM=Zw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We have noticed 274 syscall test failures on x86_64 and i386 due to
Make the temporary directory in one shot using mkdtemp failed.
tst_tmpdir.c:264: BROK: tst_tmpdir:
mkdtemp(/scratch/ltp-7D8vAcYeFG/OXuquJ) failed: EROFS

Failed log:
------------
pread01     1  TBROK  :  tst_tmpdir.c:264: tst_tmpdir:
mkdtemp(/scratch/ltp-7D8vAcYeFG/preAUvXAE) failed: errno=EROFS(30):
Read-only file system
pread01     2  TBROK  :  tst_tmpdir.c:264: Remaining cases broken

full test log,
--------------
https://lkft.validation.linaro.org/scheduler/job/711826#L7834

LTP Version: 20190115

Kernel bad commit:
------------
git branch master
git commit dd5001e21a991b731d659857cd07acc7a13e6789
git describe v5.1-3486-gdd5001e21a99
git repo https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

Kernel good commit:
------------
git branch master
git commit d3511f53bb2475f2a4e8460bee5a1ae6dea2a433
git describe v5.1-3385-gd3511f53bb24
git repo https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

Best regards
Naresh Kamboju
