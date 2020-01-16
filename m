From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 16 Jan 2020 23:02:06 +0530
Subject: [LTP] LTP: statx06: FAIL: Birth time < before time
Message-ID: <CA+G9fYuBdcZvE6VPm9i2=F0mK5u3j6Z+RHbFBQ1zh9qbN_4kaw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

LTP syscalls statx06 test case getting failed from linux next 20200115
tag onwards on all x86_64, i386, arm and arm64 devices

Test output:
statx06.c:152: FAIL: Birth time < before time
statx06.c:156: PASS: Modified time Passed
statx06.c:156: PASS: Access time Passed
statx06.c:156: PASS: Change time Passed

strace output snippet:
[pid   498] clock_getres(CLOCK_REALTIME_COARSE, {tv_sec=0, tv_nsec=1000000}) = 0
[pid   498] nanosleep({tv_sec=0, tv_nsec=1000000}, NULL) = 0
[pid   498] openat(AT_FDCWD, \"mount_ext/test_file.txt\",
O_RDWR|O_CREAT, 0666) = 3
[pid   498] clock_getres(CLOCK_REALTIME_COARSE, {tv_sec=0, tv_nsec=1000000}) = 0
[pid   498] nanosleep({tv_sec=0, tv_nsec=1000000}, NULL) = 0
[pid   498] statx(AT_FDCWD, \"mount_ext/test_file.txt\",
AT_STATX_SYNC_AS_STAT, STATX_ALL, {stx_mask=STATX_BASIC_STATS,
stx_attributes=0, stx_mode=S_IFREG|0644, stx_size=0, ...}) = 0
[pid   498] write(2, \"statx06.c:152: \33[1;31mFAIL: \33[0m\"...,
57statx06.c:152: [1;31mFAIL: [0mBirth time < before time
) = 57

Full test log link,
https://lkft.validation.linaro.org/scheduler/job/1107634#L2276

Test results comparison link,
https://qa-reports.linaro.org/lkft/linux-next-oe/tests/ltp-syscalls-tests/statx06

Test case link,
https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/statx/statx06.c

--
Linaro LKFT
https://lkft.linaro.org
