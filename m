From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 2 Sep 2021 15:12:19 +0530
Subject: [LTP] [PATCH] syscalls/aarch64: Remove 32 bit only syscalls
In-Reply-To: <20210902093655.6104-1-lkml@jv-coder.de>
References: <20210902093655.6104-1-lkml@jv-coder.de>
Message-ID: <20210902094219.xy73hs5ccafkrysr@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

+Arnd

On 02-09-21, 11:36, Joerg Vehlow wrote:
> From: Joerg Vehlow <joerg.vehlow@aox-tech.de>
> 
> These syscalls are not available in 64 bit builds of linux.
> See: <linux>/include/uapi/asm-generic/unistd.h
> 
> With the syscall defined, the test clock_gettim04 fails with
> ../../../../include/tst_timer.h:216: TCONF: syscall(403) __NR_clock_gettime64 not supported
> 
> Fixes: 59d278d61ed90117607f389326e0816a14dbf53c ("lapi/syscalls: Update syscall numbers")
> Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
> ---
> 
> I am not 100% sure, how the syscall table for aarch64 is generated.
> There are also compat version for some of the 32 bit only 64 bit syscalls,
> but I think they are only available, when running an 32 bit arm application.
> 
>  include/lapi/syscalls/aarch64.in | 20 --------------------
>  1 file changed, 20 deletions(-)
> 
> diff --git a/include/lapi/syscalls/aarch64.in b/include/lapi/syscalls/aarch64.in
> index 5a2816099..a47185954 100644
> --- a/include/lapi/syscalls/aarch64.in
> +++ b/include/lapi/syscalls/aarch64.in
> @@ -278,26 +278,6 @@ statx 291
>  io_pgetevents 292
>  rseq 293
>  kexec_file_load 294
> -clock_gettime64 403
> -clock_settime64 404
> -clock_adjtime64 405
> -clock_getres_time64 406
> -clock_nanosleep_time64 407
> -timer_gettime64 408
> -timer_settime64 409
> -timerfd_gettime64 410
> -timerfd_settime64 411
> -utimensat_time64 412
> -pselect6_time64 413
> -ppoll_time64 414
> -io_pgetevents_time64 416
> -recvmmsg_time64 417
> -mq_timedsend_time64 418
> -mq_timedreceive_time64 419
> -semtimedop_time64 420
> -rt_sigtimedwait_time64 421
> -futex_time64 422
> -sched_rr_get_interval_time64 423
>  pidfd_send_signal 424
>  io_uring_setup 425
>  io_uring_enter 426
> -- 
> 2.25.1

-- 
viresh
