From: Li Wang <liwang@redhat.com>
Date: Sat, 4 Jul 2020 15:14:06 +0800
Subject: [LTP] [PATCH V4 5/6] syscalls: Don't pass struct timespec to
 tst_syscall()
In-Reply-To: <20200703125927.GA11556@yuki.lan>
References: <c47220ecab3c7570f5387cd71894c977009ad3d8.1590572545.git.viresh.kumar@linaro.org>
 <9562fdf4debd759439ee7f468008177003db9513.1592457867.git.viresh.kumar@linaro.org>
 <CAEemH2cu_o2eCHQB1_Bo0aQiR2WK6knbBtD83-5_77gZZbA-Ow@mail.gmail.com>
 <20200703125927.GA11556@yuki.lan>
Message-ID: <CAEemH2cN735haDmyqbNa_LwDgumFqAspYfJaKRpsOg0Rij9tEA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

On Fri, Jul 3, 2020 at 8:59 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> I guess that we need:
>

This method works for me, plz could you correct some typos as below.


>
> diff --git a/lib/tst_clocks.c b/lib/tst_clocks.c
> index bc0bef273..c0727a34c 100644
> --- a/lib/tst_clocks.c
> +++ b/lib/tst_clocks.c
> @@ -14,11 +14,11 @@
>
>  typedef int (*mysyscall)(clockid_t clk_id, void *ts);
>
> -int syscall_supported_by_kernel(mysyscall func)
> +int syscall_supported_by_kernel(long sysnr)
>  {
>         int ret;
>
> -       ret = func(0, NULL);
> +       ret = syscall(sysnr, func(0, NULL);
>

This line should be: ret = syscall(sysnr, 0, NULL);


>         if (ret == -1 && errno == ENOSYS)
>                 return 0;
>
> @@ -32,13 +32,13 @@ int tst_clock_getres(clockid_t clk_id, struct timespec
> *res)
>         int ret;
>
>  #if (__NR_clock_getres_time64 != __LTP__NR_INVALID_SYSCALL)
> -       if (!func && syscall_supported_by_kernel(sys_clock_getres64)) {
> +       if (!func && syscall_supported_by_kernel(__NR_clock_getres64)) {


if (!func && syscall_supported_by_kernel(__NR_clock_getres_time64 )) {


>

                func = sys_clock_getres64;
>                 tts.type = TST_KERN_TIMESPEC;
>         }
>  #endif
>
> -       if (!func && syscall_supported_by_kernel(sys_clock_getres)) {
> +       if (!func && syscall_supported_by_kernel(__NR_clock_getres)) {
>                 func = sys_clock_getres;
>                 tts.type = TST_KERN_OLD_TIMESPEC;
>         }
> @@ -62,13 +62,13 @@ int tst_clock_gettime(clockid_t clk_id, struct
> timespec *ts)
>         int ret;
>
>  #if (__NR_clock_gettime64 != __LTP__NR_INVALID_SYSCALL)
> -       if (!func && syscall_supported_by_kernel(sys_clock_gettime64)) {
> +       if (!func && syscall_supported_by_kernel(__NR_clock_gettime64)) {
>                 func = sys_clock_gettime64;
>                 tts.type = TST_KERN_TIMESPEC;
>         }
>  #endif
>
> -       if (!func && syscall_supported_by_kernel(sys_clock_gettime)) {
> +       if (!func && syscall_supported_by_kernel(__NR_clock_gettime)) {
>                 func = sys_clock_gettime;
>                 tts.type = TST_KERN_OLD_TIMESPEC;
>         }
> @@ -91,13 +91,13 @@ int tst_clock_settime(clockid_t clk_id, struct
> timespec *ts)
>         static mysyscall func;
>
>  #if (__NR_clock_settime64 != __LTP__NR_INVALID_SYSCALL)
> -       if (!func && syscall_supported_by_kernel(sys_clock_settime64)) {
> +       if (!func && syscall_supported_by_kernel(__NR_clock_settime64)) {
>                 func = sys_clock_settime64;
>                 tts.type = TST_KERN_TIMESPEC;
>         }
>  #endif
>
> -       if (!func && syscall_supported_by_kernel(sys_clock_settime)) {
> +       if (!func && syscall_supported_by_kernel(__NR_clock_settime)) {
>                 func = sys_clock_settime;
>                 tts.type = TST_KERN_OLD_TIMESPEC;
>         }
>
> --
> Cyril Hrubis
> chrubis@suse.cz
>
>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200704/a2a1894b/attachment-0001.htm>
