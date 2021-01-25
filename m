From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 25 Jan 2021 20:18:16 +0530
Subject: [LTP] LTP: madvise08.c:203: TFAIL: No sequence in dump after
 MADV_DODUMP.
Message-ID: <CA+G9fYsvDWDogC+xgeG2V9MMofV5svTipDigDiUBje+2jSRK8g@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

LTP syscalls madvise08 test case failed on all devices from
Linux next 20210118 to till day.
strace log attached to this email and link provided below.

BAD: next-20210118
GOOD: next-20210115

This failure is easily reproducible on Linux next tag 20210118 above.

tst_test.c:1250: TINFO: Timeout per run is 0h 15m 00s
madvise08.c:73: TINFO: Temporary core pattern is
'/scratch/ltp-2nftQzNI1K/HclFMH/dump-%p'
madvise08.c:112: TINFO: Dump file should be dump-10109
madvise08.c:196: TPASS: madvise(..., MADV_DONTDUMP)
madvise08.c:112: TINFO: Dump file should be dump-10110
madvise08.c:203: TFAIL: No sequence in dump after MADV_DODUMP.

strace log,
https://lkft.validation.linaro.org/scheduler/job/2184866#L1257

Full test log link,
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20210118/testrun/3771572/suite/ltp-syscalls-tests/test/madvise08/log

Test case link,
https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/madvise/madvise08.c#L203

metadata:
  git branch: master
  git repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git describe: next-20210118
  kernel-config: https://builds.tuxbuild.com/1nERt1Y6o3JSvLbiPXYTb9PMo1O/config

-- 
Linaro LKFT
https://lkft.linaro.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: madvise08-strace.log
Type: text/x-log
Size: 13165 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210125/c3142108/attachment-0001.bin>
