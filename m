From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 8 Oct 2018 17:56:35 +0530
Subject: [LTP] rt_sigqueueinfo: Invalid argument
Message-ID: <CA+G9fYtxvj0j6BVVZ_YoBkZn6m6ZpEMmDjBjwqY7uvpgMbNQbQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

rt_sigqueueinfo01 failed on all device (x86_64, i386, arm / arm64)
started failing from Linux version 4.19.0-rc6-next-20181004.
Do you see this failure at your end?

rt_sigqueueinfo01: rt_sigqueueinfo: Invalid argument
rt_sigqueueinfo01: rt_sigqueueinfo: Invalid argument
rt_sigqueueinfo01    1  TFAIL  :  rt_sigqueueinfo01.c:97: Test Failed
rt_sigqueueinfo01    0  TINFO  :  Failed to record test working dir
rt_sigqueueinfo01    1  TFAIL  :  rt_sigqueueinfo01.c:97: Test Failed
rt_sigqueueinfo01    0  TINFO  :  Failed to record test working dir
rt_sigqueueinfo01    2  TFAIL  :  rt_sigqueueinfo01.c:97: Test Failed

Full log  details.
https://lkft.validation.linaro.org/scheduler/job/451548#L10339

Best regards
Naresh Kamboju
