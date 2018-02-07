From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 8 Feb 2018 00:20:58 +0530
Subject: [LTP] X15: LTP getrandom02 Test timeouted, sending SIGKILL
Message-ID: <CA+G9fYuOYvXra+qKLYuJqHaNKYortPG0Quka=j8Me9RVztoobQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

LTP getrandom02 Test timeouted, sending SIGKILL on x15 running 4.4 kernel.

tst_test.c:934: INFO: Timeout per run is 0h 15m 00s
getrandom02.c:72: PASS: getrandom returned 256
getrandom02.c:72: PASS: getrandom returned 6
getrandom02.c:72: PASS: getrandom returned 256
Test timeouted, sending SIGKILL!
tst_test.c:984: INFO: If you are running on slow machine, try
exporting LTP_TIMEOUT_MUL > 1
tst_test.c:985: BROK: Test killed! (timeout?)

LAVA job id:
https://lkft.validation.linaro.org/scheduler/job/53470#L3370

Few more observations,
1. Test case passed on 4.4.95, failed on 4.4.96 and passed on stable-rc-4.4.96.
2. Same test case failed 7 times out of 10 times.
3. This failure is only on x15 linux-4.4 on other boards arm64 (Hikey
and Juno) and x86_64 test PASSED.

To make the CPU fast, the cpu governor changed to "performance" from
"ondemand" governor. But it did not helped.
https://lkft.validation.linaro.org/scheduler/job/53713

linux-stable-4.14
https://qa-reports.linaro.org/staging-lkft/linux-stable-4.14/tests/ltp-syscalls-tests/getrandom02

linux-stable-4.4
https://qa-reports.linaro.org/staging-lkft/linux-stable-4.4/tests/ltp-syscalls-tests/getrandom02

Manually disabled timessyncd and re-tested multiple times and still
test failed intermittently on x15 running 4.15.0-rc7-00111-g5f615b9.
And I have added more swap space and tested still it is the same case
of intermittent failure.

Run:
----
If you are using Linaro Open Embedded build.
cd /opt/ltp
./runltp -p -s getrandom02

cd /opt/ltp/testcases/bin
export PATH=`pwd`:$PATH
./getrandom02

Build and run.
---------------
# export LTP_TIMEOUT_MUL=3
# LTP_VERSION="20180118"
# wget https://github.com/linux-test-project/ltp/releases/download/"${LTP_VERSION}"/ltp-full-"${LTP_VERSION}".tar.xz
# tar --strip-components=1 -Jxf ltp-full-"${LTP_VERSION}".tar.xz
# ./configure
#  make -j8 all
# make SKIP_IDCHECK=1 install
# ./runltp -p -s getrandom02
If you want to run 10 iterations
# ./runltp -p -s getrandom02 -I  10

Please refer open bugs in bugzillla
https://bugs.linaro.org/show_bug.cgi?id=3401

Best regards
Naresh Kamboju
