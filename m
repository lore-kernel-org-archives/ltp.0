From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 8 Oct 2018 18:51:31 +0530
Subject: [LTP] LTP: futex_wake04 hangs forever on i386
Message-ID: <CA+G9fYs13QZtsREe3dvic+G6VPQ1dJroKH0sguBiNdtizRTeNQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

LTP syscall test case futex_wake04 hangs forever on i386 kernel
running on x86_64 server machine.

Test PASS on qemu_i386 and other devices.
Test HANGs on i386 (i386 kernel booting on x86_64 machine).

output,
incrementing stop
futex_wake04    0  TINFO  :  Hugepagesize 4194304

LAVA job id,
https://lkft.validation.linaro.org/scheduler/job/399913

strace output of this test case,
https://lkft.validation.linaro.org/scheduler/job/405706

Best regards
Naresh Kamboju
