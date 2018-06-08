From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 8 Jun 2018 14:11:09 +0530
Subject: [LTP] LTP syscall fcntl36 test is fails intermittently on arm32
 qemu and beagleboard x15
Message-ID: <CA+G9fYu9CyOrQajZ-iupDwshydg=pLiQVyzTs96e-A4HFNrMPA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

LTP syscall fcntl36 test is failing intermittently on arm32 qemu and
beagleboard x15 device. We have to find a solution to fix this test
case on arm32.

Test output:
tst_test.c:1015: INFO: Timeout per run is 0h 15m 00s
fcntl36.c:303: INFO: OFD read lock vs OFD write lock
fcntl36.c:381: PASS: Access between threads synchronized
fcntl36.c:303: INFO: OFD write lock vs POSIX write lock
fcntl36.c:381: PASS: Access between threads synchronized
fcntl36.c:303: INFO: OFD read lock vs POSIX write lock
fcntl36.c:381: PASS: Access between threads synchronized
fcntl36.c:303: INFO: OFD write lock vs POSIX read lock
fcntl36.c:265: FAIL: Unexpected data offset 4128 value 211
fcntl36.c:303: INFO: OFD write lock vs OFD write lock
fcntl36.c:381: PASS: Access between threads synchronized
fcntl36.c:303: INFO: OFD r/w lock vs POSIX write lock
fcntl36.c:381: PASS: Access between threads synchronized
fcntl36.c:303: INFO: OFD r/w lock vs POSIX read lock
fcntl36.c:381: PASS: Access between threads synchronized
Summary:
passed   6
failed   1
skipped  0
warnings 0

Complete test log:
https://lkft.validation.linaro.org/scheduler/job/262388#L2809

Test case:
if (buf[i] != buf[j]) {

tst_res(TFAIL, "Unexpected data "
"offset %ld value %d",
pa->offset + i, buf[i]);
fail_flag = 1;
break;
}

https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/fcntl/fcntl36.c#L265

Current status of intermittent failures,
Test case run was explicitly skipped on x15 device and we are still
running test case on qemu_arm.

https://qa-reports.linaro.org/lkft/linux-next-oe/tests/ltp-syscalls-tests/fcntl36
https://qa-reports.linaro.org/lkft/linux-mainline-oe/tests/ltp-syscalls-tests/fcntl36
https://qa-reports.linaro.org/lkft/linux-stable-rc-4.16-oe/tests/ltp-syscalls-tests/fcntl36
https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/tests/ltp-syscalls-tests/fcntl36
https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/tests/ltp-syscalls-tests/fcntl36
https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/tests/ltp-syscalls-tests/fcntl36

Previous discussion reference link,
https://lists.linaro.org/pipermail/kernel-build-reports/2017-November/025512.html
