From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 8 Oct 2018 18:05:44 +0530
Subject: [LTP] LTP: keyctl05: unexpected error adding 'dns_resolver' key:
	EINVAL
Message-ID: <CA+G9fYvWRJ-+B_vXzFdnT2c9f0+o8p=RP23ZNAxMMzMd3TMbYQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

keyctl05 failed on all device (x86_64, i386, arm / arm64)
started failing from Linux version 4.19.0-rc6-next-20181005
Do you see this failure at your end?

tst_test.c:1015: INFO: Timeout per run is 0h 15m 00s
keyctl05.c:135: INFO: Try to update the 'asymmetric' key...
keyctl05.c:148: PASS: updating 'asymmetric' key expectedly failed with
EOPNOTSUPP
keyctl05.c:119: BROK: unexpected error adding 'dns_resolver' key: EINVAL
tst_test.c:884: BROK: Test 1 haven't reported results!

Full test log,
https://lkft.validation.linaro.org/scheduler/job/452884#L5182

Best regards
Naresh Kamboju
