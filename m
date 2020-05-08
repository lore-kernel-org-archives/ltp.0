From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 8 May 2020 10:30:36 +0200
Subject: [LTP] [PATCH V2 01/17] syscalls/timer_gettime: Add support for
 time64 tests
In-Reply-To: <d115c3ad61a422e5cadd3617c554c91a242defad.1588911607.git.viresh.kumar@linaro.org>
References: <cover.1588911607.git.viresh.kumar@linaro.org>
 <d115c3ad61a422e5cadd3617c554c91a242defad.1588911607.git.viresh.kumar@linaro.org>
Message-ID: <CAK8P3a0_MAOyEXjdGJ0YAwKwn-j9Y+3apfM1W4SUnwVQRBC2MA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, May 8, 2020 at 6:24 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:

> +#if defined(TST_ABI32)
> +       { .func = sys_timer_gettime, .type = TST_LIBC_TIMESPEC, .desc = "syscall with libc spec"},
> +#endif

> +#if defined(TST_ABI64)
> +       { .func = sys_timer_gettime, .type = TST_KERN_TIMESPEC, .desc = "syscall with kernel spec64"},
> +#endif

I think these are both invalid: timer_gettime() does not take a libc timespec or
a __kernel_timespec but takes a __kernel_old_timespec. You should only
use the libc data structure with the libc timer_gettime, and the
__kernel_timespec
with the kernel's timer_gettime64().

        Arnd
