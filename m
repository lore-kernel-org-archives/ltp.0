From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 12 Jun 2020 10:07:57 +0200
Subject: [LTP] [PATCH V3 2/2] syscalls/clock_gettime: Add test to check
 bug during successive readings
In-Reply-To: <0fb91044431a04c2787bfa121a7e5f969664fc8b.1591948595.git.viresh.kumar@linaro.org>
References: <cc75beb4074b62e94b8ac92cba17af41b8f5fbdc.1591864369.git.viresh.kumar@linaro.org>
 <0fb91044431a04c2787bfa121a7e5f969664fc8b.1591948595.git.viresh.kumar@linaro.org>
Message-ID: <CAK8P3a3EQ2wbM=XKHaUQCK=_bhSc1pxGKCd9+oEf9y02GFs9_g@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Jun 12, 2020 at 9:58 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> An issue was reported recently where a bug was found during successive
> reading of 64 bit time on arm32 platforms. Add a test for that.
>
> https://github.com/richfelker/musl-cross-make/issues/96
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>

There was one more thing I had originally suggested as an optional
thing to test for:

- ensure that CLOCK_REALTIME_COARSE/CLOCK_MONOTONIC_COARSE
  is at most clock_getres() nanoseconds behind
  CLOCK_REALTIME/CLOCK_MONOTONIC, and never ahead of it.

It's probably too much to put into this test, and I'm not sure we really
need to test for it. Are you still looking into this, or do you think we should
stop here?

     Arnd
