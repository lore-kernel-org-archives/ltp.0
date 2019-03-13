From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 13 Mar 2019 19:17:00 +0530
Subject: [LTP] LTP: mount02 was expected EINVAL(22) but got ENOENT(2): No
 such file or directory
Message-ID: <CA+G9fYudJC07HfrU1fVptCEvgCuBsF9G2N76PiGG5Z258z0Dzg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

LTP syscalls mount02 failed on mainline (Linux version 5.0.0) for all devices.

Results comparison link,
https://qa-reports.linaro.org/lkft/linux-mainline-oe/tests/ltp-syscalls-tests/mount02
you could see good and bad commit id in the above link.

Error log,
mount02 5 TFAIL : mount02.c:117: mount() was expected to fail with
EINVAL(22): TEST_ERRNO=ENOENT(2): No such file or directory

Failure full log on x15 armv7,
https://lkft.validation.linaro.org/scheduler/job/638009#L7462

structure Inputs,
{&null, &mntpoint, &fs_type, 0, EINVAL, NULL, NULL},

Snippet  test code:
--------------------------
TEST(mount(*tc->device, *tc->mntpoint, *tc->fs_type, tc->flag, NULL));

if (TEST_RETURN != -1) {
tst_resm(TFAIL, "mount() succeded unexpectedly (ret=%li)",
         TEST_RETURN);
goto cleanup;
}

if (TEST_ERRNO != tc->exp_errno) {
tst_resm(TFAIL | TTERRNO,
         "mount() was expected to fail with %s(%i)",
         tst_strerrno(tc->exp_errno), tc->exp_errno);
goto cleanup;
}

do you notice this mount02 failure on mainline kernel ?

Best regards
Naresh Kamboju
