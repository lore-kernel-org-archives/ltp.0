From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 8 Oct 2018 14:45:41 +0200
Subject: [LTP] rt_sigqueueinfo: Invalid argument
In-Reply-To: <CA+G9fYtxvj0j6BVVZ_YoBkZn6m6ZpEMmDjBjwqY7uvpgMbNQbQ@mail.gmail.com>
References: <CA+G9fYtxvj0j6BVVZ_YoBkZn6m6ZpEMmDjBjwqY7uvpgMbNQbQ@mail.gmail.com>
Message-ID: <20181008124541.GB13162@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> rt_sigqueueinfo01 failed on all device (x86_64, i386, arm / arm64)
> started failing from Linux version 4.19.0-rc6-next-20181004.
> Do you see this failure at your end?
>
> rt_sigqueueinfo01: rt_sigqueueinfo: Invalid argument
> rt_sigqueueinfo01: rt_sigqueueinfo: Invalid argument
> rt_sigqueueinfo01    1  TFAIL  :  rt_sigqueueinfo01.c:97: Test Failed
> rt_sigqueueinfo01    0  TINFO  :  Failed to record test working dir
> rt_sigqueueinfo01    1  TFAIL  :  rt_sigqueueinfo01.c:97: Test Failed
> rt_sigqueueinfo01    0  TINFO  :  Failed to record test working dir
> rt_sigqueueinfo01    2  TFAIL  :  rt_sigqueueinfo01.c:97: Test Failed
> 
> Full log  details.
> https://lkft.validation.linaro.org/scheduler/job/451548#L10339

I do not recall seeing this test to fail.

However the test is old messy code, one thing that I guess may happen is
that there is random garbage in the siginfo_t structure we pass to the
syscall and in you case you were unlucky enough so that kernel rejects
the value, but that is just wild guess.

Btw, I've opened an issue to clean up the test in:

https://github.com/linux-test-project/ltp/issues/404

-- 
Cyril Hrubis
chrubis@suse.cz
