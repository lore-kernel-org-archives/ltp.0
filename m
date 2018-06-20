From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 20 Jun 2018 11:45:56 +0530
Subject: [LTP] LTP cve-2017-5754 meltdown intermittent failure on mainline
	kernel
Message-ID: <CA+G9fYv8iPW3vtntqtatTLesf+StRkcP7AixVMPmEOSjTTtAwA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

LTP cve-2017-5754 meltdown test failed intermittently on qemu_x86_64
running mainline kernel. Not easy to reproduce.

Linux kernel version: 4.18.0-rc1
qemu-system-x86 version: 2.12

Test output:
tst_test.c:1015: INFO: Timeout per run is 0h 15m 00s
meltdown.c:259: INFO:
 access time: cached = 48, uncached = 378, threshold = 134
meltdown.c:309: INFO: linux_proc_banner is at ffffffffaac00020
meltdown.c:332: INFO: read ffffffffaac00020 = 0x21 !
meltdown.c:332: INFO: read ffffffffaac00021 = 0x73 s
meltdown.c:332: INFO: read ffffffffaac00022 = 0x20
meltdown.c:332: INFO: read ffffffffaac00023 = 0x76 v
meltdown.c:332: INFO: read ffffffffaac00024 = 0x5
meltdown.c:332: INFO: read ffffffffaac00025 = 0x72 r
meltdown.c:332: INFO: read ffffffffaac00026 = 0x53 S
meltdown.c:332: INFO: read ffffffffaac00027 = 0x69 i
meltdown.c:332: INFO: read ffffffffaac00028 = 0x61 a
meltdown.c:332: INFO: read ffffffffaac00029 = 0x6e n
meltdown.c:332: INFO: read ffffffffaac0002a = 0x20
meltdown.c:332: INFO: read ffffffffaac0002b = 0x25 %
meltdown.c:332: INFO: read ffffffffaac0002c = 0x73 s
meltdown.c:342: FAIL: I was able to read your kernel memory!!!
Summary:
passed   0
failed   1
skipped  0
warnings 0

Failed full log can be found here in these links,
https://lkft.validation.linaro.org/scheduler/job/261698#L8280
https://lkft.validation.linaro.org/scheduler/job/290417#L10464

Best regards
Naresh Kamboju
