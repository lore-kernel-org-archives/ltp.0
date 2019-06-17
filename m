From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 17 Jun 2019 08:00:00 +0530
Subject: [LTP] Linux-4.4: pwritev201.c:62: FAIL: pwritev2() failed: EINVAL
Message-ID: <CA+G9fYvg9va027oZELWkVVp5_YSyL0bZMy0iMVYweT2hh89xVg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Newly added tests pwritev201 and pwritev201_64 from LTP version
20190517 got failed on all devices for Linux 4.4
do you test this on linux stable  4.4 branch ? do you notice this failure ?

Test PASS on stable 4.9, 4.14 and 4.19 branches.

tst_test.c:1096: INFO: Timeout per run is 0h 15m 00s
pwritev201.c:96: PASS: pwritev2() wrote 64 bytes successfully with
content 'a' expectedly
pwritev201.c:96: PASS: pwritev2() wrote 64 bytes successfully with
content 'a' expectedly
pwritev201.c:96: PASS: pwritev2() wrote 64 bytes successfully with
content 'a' expectedly
pwritev201.c:62: FAIL: pwritev2() failed: EINVAL
pwritev201.c:62: FAIL: pwritev2() failed: EINVAL
pwritev201.c:62: FAIL: pwritev2() failed: EINVAL
Summary:
passed   3
failed   3
skipped  0
warnings 0

tst_test.c:1096: INFO: Timeout per run is 0h 15m 00s
pwritev201.c:96: PASS: pwritev2() wrote 64 bytes successfully with
content 'a' expectedly
pwritev201.c:96: PASS: pwritev2() wrote 64 bytes successfully with
content 'a' expectedly
pwritev201.c:96: PASS: pwritev2() wrote 64 bytes successfully with
content 'a' expectedly
pwritev201.c:62: FAIL: pwritev2() failed: EINVAL
pwritev201.c:62: FAIL: pwritev2() failed: EINVAL
pwritev201.c:62: FAIL: pwritev2() failed: EINVAL
Summary:
passed   3
failed   3
skipped  0
warnings 0

Full test log,
https://lkft.validation.linaro.org/scheduler/job/751027#L9608

Test results comparison link,
https://qa-reports.linaro.org/_/comparetest/?project=22&project=6&project=58&project=135&project=40&project=23&project=167&suite=ltp-syscalls-tests&test=pwritev201

Best regards
Naresh Kamboju
