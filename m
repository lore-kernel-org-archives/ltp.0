From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 12 Jun 2020 13:47:38 +0530
Subject: [LTP] [PATCH V3 2/2] syscalls/clock_gettime: Add test to check
 bug during successive readings
In-Reply-To: <CAK8P3a3EQ2wbM=XKHaUQCK=_bhSc1pxGKCd9+oEf9y02GFs9_g@mail.gmail.com>
References: <cc75beb4074b62e94b8ac92cba17af41b8f5fbdc.1591864369.git.viresh.kumar@linaro.org>
 <0fb91044431a04c2787bfa121a7e5f969664fc8b.1591948595.git.viresh.kumar@linaro.org>
 <CAK8P3a3EQ2wbM=XKHaUQCK=_bhSc1pxGKCd9+oEf9y02GFs9_g@mail.gmail.com>
Message-ID: <20200612081738.humjvvgikhzq6lf7@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 12-06-20, 10:07, Arnd Bergmann wrote:
> There was one more thing I had originally suggested as an optional
> thing to test for:
> 
> - ensure that CLOCK_REALTIME_COARSE/CLOCK_MONOTONIC_COARSE
>   is at most clock_getres() nanoseconds behind
>   CLOCK_REALTIME/CLOCK_MONOTONIC, and never ahead of it.
> 
> It's probably too much to put into this test, and I'm not sure we really
> need to test for it. Are you still looking into this, or do you think we should
> stop here?

Sorry, I missed replying to it. When you suggest something, you
suggest too much (which is good) and I get lost implementing all of it
:)

Can you have a look at the attached test? This is already merged in
LTP and does what you are asking to some level (not exactly though)
and so I thought we don't need to do it again.

-- 
viresh
-------------- next part --------------
A non-text attachment was scrubbed...
Name: clock_gettime03.c
Type: text/x-csrc
Size: 3613 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200612/5971a5bc/attachment.c>
