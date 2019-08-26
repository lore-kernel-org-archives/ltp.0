From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 26 Aug 2019 15:17:16 +0530
Subject: [LTP] Linux-next-20190823: x86_64/i386: prot_hsymlinks.c:325:
 Failed to run cmd: useradd hsym
Message-ID: <CA+G9fYtN2tjHZtjtc8isdsD5hF76teeh2-pngUp+uj3WYdj7jA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Do you see this LTP prot_hsymlinks failure on linux next 20190823 on
x86_64 and i386 devices?

test output log,
useradd: failure while writing changes to /etc/passwd
useradd: /home/hsym was created, but could not be removed
userdel: user 'hsym' does not exist
prot_hsymlinks    1  TBROK  :  prot_hsymlinks.c:325: Failed to run
cmd: useradd hsym
prot_hsymlinks    2  TBROK  :  prot_hsymlinks.c:325: Remaining cases broken
prot_hsymlinks    3  TBROK  :  prot_hsymlinks.c:325: Failed to run
cmd: userdel -r hsym
prot_hsymlinks    4  TBROK  :  tst_sig.c:234: unexpected signal
SIGIOT/SIGABRT(6) received (pid = 8324).
prot_hsymlinks    5  TBROK  :  tst_sig.c:234: unexpected signal
SIGIOT/SIGABRT(6) received (pid = 8324).
prot_hsymlinks    6  TBROK  :  tst_sig.c:234: unexpected signal
SIGIOT/SIGABRT(6) received (pid = 8324).
prot_hsymlinks    7  TBROK  :  tst_sig.c:234: unexpected signal
SIGIOT/SIGABRT(6) received (pid = 8324).
prot_hsymlinks    8  TBROK  :  tst_sig.c:234: unexpected signal
SIGIOT/SIGABRT(6) received (pid = 8324).
prot_hsymlinks    9  TBROK  :  tst_sig.c:234: unexpected signal
SIGIOT/SIGABRT(6) received (pid = 8324).
prot_hsymlinks   10  TBROK  :  tst_sig.c:234: unexpected signal
SIGIOT/SIGABRT(6) received (pid = 8324).

Full test log,
https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20190823/testrun/886412/log

Linux version:
Linux version 5.3.0-rc5-next-20190823 (oe-user@oe-host) (gcc version
7.3.0 (GCC)) #1 SMP Fri Aug 23 09:35:54 UTC 2019

steps to reproduce:
   cd /opt/ltp
   ./runltp -s prot_hsymlinks

metadata:
metadata:
  git branch: master
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
  git commit: 9733a7c62c66722bcfdb1a6fe4d35c497312d59a
  git describe: next-20190823
  make_kernelversion: 5.3.0-rc5
  kernel-config:
http://snapshots.linaro.org/openembedded/lkft/lkft/sumo/intel-corei7-64/lkft/linux-next/591/config
  build-location:
http://snapshots.linaro.org/openembedded/lkft/lkft/sumo/intel-corei7-64/lkft/linux-next/591
  toolchain: x86_64-linaro-linux 7.%
  series: lkft
  ltp-syscalls-tests__url: git://github.com/linux-test-project/ltp.git
  ltp-syscalls-tests__version: '20190517'

Best regards
Naresh Kamboju
