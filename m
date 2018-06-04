From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 4 Jun 2018 17:28:42 +0530
Subject: [LTP] LTP CVE "cve-2011-2183" failed on x86_64, arm32 beaglebone x15
Message-ID: <CA+G9fYuUAPvwBjXjw_EATrMoLPtS5imGo7foqchmAFD=TUdVXQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

LTP CVE "cve-2011-2183" failed on x86_64, (arm32) beaglebone x15.

Please check the history here,
https://qa-reports.linaro.org/lkft/linux-mainline-oe/tests/ltp-cve-tests/cve-2011-2183

Test log:
----------
tst_test.c:980: INFO: Timeout per run is 0h 15m 00s
ksm05.c:98: CONF: KSM configuration is not enabled
safe_file_ops.c:238: WARN: Failed to open FILE
'/sys/kernel/mm/ksm/run' at ksm05.c:110
Summary:
passed   0
failed   0
skipped  0
warnings 1

Analysis:
The required config is not set on x86_64 and arm32 x15 device.
# CONFIG_KSM is not set
This config should be enabled.

Bug report:
LKFT: LTP: CVE cve-2011-2183 test failed on x86_64 and arm32 x15 devices
https://bugs.linaro.org/show_bug.cgi?id=3857

Best regards
Naresh Kamboju
