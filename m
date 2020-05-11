From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 11 May 2020 09:20:57 +0200
Subject: [LTP] [PATCH V2 15/17] syscalls/semtimedop: Add support for
 semtimedop and its time64 version
In-Reply-To: <20200511064929.pa4lydt2vfryl7ve@vireshk-i7>
References: <cover.1588911607.git.viresh.kumar@linaro.org>
 <8a675726b6e553e740016390c774bce19efc5a12.1588911607.git.viresh.kumar@linaro.org>
 <CAK8P3a1x+uK_WgVn9O8LVcLoZH=oJ_jQcePwcwzqpyhewApX9w@mail.gmail.com>
 <20200511064929.pa4lydt2vfryl7ve@vireshk-i7>
Message-ID: <CAK8P3a2y+8kv0Wa4iiU+vGeNTudmx3aJJQ87zfi9WyfWKJ7WYg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, May 11, 2020 at 8:49 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 08-05-20, 09:18, Arnd Bergmann wrote:
> >
> > Similarly, the line
> >
> >  { .semop = semop, .type = TST_LIBC_TIMESPEC, .desc = "semop: vDSO or syscall"},
> >
> > should apply to both 32 and 64 bit machines
>
> This is how I modified this and all other time64 tests, I hope this looks fine now ?
>
> diff --git a/testcases/kernel/syscalls/ipc/semop/semop.h b/testcases/kernel/syscalls/ipc/semop/semop.h
> index 8d1245b65ec0..8647fa686bd3 100644
> --- a/testcases/kernel/syscalls/ipc/semop/semop.h
> +++ b/testcases/kernel/syscalls/ipc/semop/semop.h
> @@ -26,17 +26,13 @@ struct test_variants {
>         char *desc;
>  } variants[] = {
>         { .semop = semop, .type = TST_LIBC_TIMESPEC, .desc = "semop: vDSO or syscall"},
> -#if defined(TST_ABI32)
> -       { .semtimedop = sys_semtimedop, .type = TST_LIBC_TIMESPEC, .desc = "semtimedop: syscall with libc spec"},
> -       { .semtimedop = sys_semtimedop, .type = TST_KERN_OLD_TIMESPEC, .desc = "semtimedop: syscall with kernel spec32"},
> -#endif
>
> -#if defined(TST_ABI64)
> -       { .semtimedop = sys_semtimedop, .type = TST_KERN_TIMESPEC, .desc = "semtimedop: syscall with kernel spec64"},
> +#if (__NR_semtimedop != __LTP__NR_INVALID_SYSCALL)
> +       { .semtimedop = sys_semtimedop, .type = TST_KERN_OLD_TIMESPEC, .desc = "semtimedop: syscall with old kernel spec"},
>  #endif
>
>  #if (__NR_semtimedop_time64 != __LTP__NR_INVALID_SYSCALL)
> -       { .semtimedop = sys_semtimedop_time64, .type = TST_KERN_TIMESPEC, .desc = "semtimedop: syscall time64 with kernel spec64"},
> +       { .semtimedop = sys_semtimedop_time64, .type = TST_KERN_TIMESPEC, .desc = "semtimedop: syscall time64 with kernel spec"},
>  #endif
>  };

Yes, much better. Please do it like this for all the tests.

It looks like you are still missing a test for the libc semtimedop function with
TST_LIBC_TIMESPEC, but perhaps this is in a different place?

There is one more complication regarding semtimedop, and that is how some
architectures never had this as a separate syscall but instead require calling
sys_ipc(SEMTIMEDOP, ...). All architectures that have sys_ipc() let you use
both SEMOP and SEMTIMEDOP with __kernel_old_timespec. Some
architectures define more than one of __NR_ipc, __NR_semtimedop and
__NR_semop.

As of linux-5.1, all 64-bit architectures at least have __NR_semtimedop, and
all 32-bit architectures at least have __NR_semtimedop64, plus whatever
other variants they supported before then.

      Arnd
