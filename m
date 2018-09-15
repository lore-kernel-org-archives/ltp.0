From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 15 Sep 2018 15:44:40 +0530
Subject: [LTP] LTP master: arm64: execveat03: execveat() returned unexpected
	errno: EINVAL
Message-ID: <CA+G9fYsEqrXhTK=TJ0m8aTDonEG39HT1aLnV4GnsZuHB7c38ow@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

LTP master testing on Hikey (arm64) device reported newly added
execveat03 failed.

Test output,
execveat03.c:74: FAIL: execveat() returned unexpected errno: EINVAL

Full log link,
https://lkft.validation.linaro.org/scheduler/job/420924#L2941

FYI,
LTP Version: 20180515-270-ge7bab6188

Best regards

Naresh Kamboju
