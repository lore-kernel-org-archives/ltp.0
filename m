From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 20 Jun 2018 12:14:22 +0530
Subject: [LTP] LTP CVE cve-2017-17053 test failed on x86_64 device
Message-ID: <CA+G9fYsRgGsmi-tE8dU=pfSDDLg3bUuii_0KUPZ71jFLNre-5g@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

LTP CVE cve-2017-17053 test failed on x86_64 device.
FAIL on linux-next, mainline, and stable-rc-4.17.
PASS on stable-rc 4.16, 4.14, 4.9 and 4.4 kernel.

Test FAIL case output,
tst_test.c:1015: INFO: Timeout per run is 0h 15m 00s
tst_taint.c:88: BROK: Kernel is already tainted: 512
Summary:
passed   0
failed   0
skipped  0
warnings 0

Test comments,
/* Regression test for CVE-2017-17053, original reproducer can be found
 * here:
 * https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ccd5b3235180eef3cfec337df1c8554ab151b5cc
 *
 * Be careful! This test may crash your kernel!
 */

Full test log:
https://lkft.validation.linaro.org/scheduler/job/290429#L9581
https://lkft.validation.linaro.org/scheduler/job/259217#L10308

History of the test case shows failed on
Linux next kernel,
https://qa-reports.linaro.org/lkft/linux-next-oe/tests/ltp-cve-tests/cve-2017-17053

Linux mainline kernel,
https://qa-reports.linaro.org/lkft/linux-mainline-oe/tests/ltp-cve-tests \
/cve-2017-17053
^ Please join link

Linux stable rc 4.17,
https://qa-reports.linaro.org/lkft/linux-stable-rc-4.17-oe/tests/ltp-cve-tests \
/cve-2017-17053
^ Please join link

Test PASS on 4.16 kernel.
https://qa-reports.linaro.org/lkft/linux-stable-rc-4.16-oe/tests/ltp-cve-tests \
/cve-2017-17053
^ Please join link

Best regards
Naresh Kamboju
