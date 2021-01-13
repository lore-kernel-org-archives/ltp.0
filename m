From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 13 Jan 2021 10:53:52 +0800
Subject: [LTP] [PATCH 1/1] Fix struct __kernel_old_timeval redefinition
 on 64bit sparc
In-Reply-To: <20210112233758.11658-1-petr.vorel@gmail.com>
References: <20210112233758.11658-1-petr.vorel@gmail.com>
Message-ID: <5FFE60C0.1010706@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

HI Petr

This patch is obviously ok, merged.

Best Regards
Yang Xu
> 64bit sparc is the only arch which defines struct __kernel_old_timeval
> in it's asm/posix_types.h header, thus guard it.
> 
> NOTE: previously it was guarded with __kernel_timex, which worked as well.
> 
> Fixes: a6607b81b ("syscalls: Don't pass struct timeval to tst_syscall()")
> 
> Signed-off-by: Petr Vorel<petr.vorel@gmail.com>
> ---
>   include/tst_timer.h | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/include/tst_timer.h b/include/tst_timer.h
> index d2c3f3cb1..657c0824f 100644
> --- a/include/tst_timer.h
> +++ b/include/tst_timer.h
> @@ -99,10 +99,12 @@ static inline long long tst_timeval_diff_ms(struct timeval t1,
> 
>   typedef __kernel_long_t	__kernel_old_time_t;
> 
> +#ifndef __kernel_old_timeval
>   struct __kernel_old_timeval {
>   	__kernel_old_time_t	tv_sec;		/* seconds */
>   	__kernel_suseconds_t	tv_usec;	/* microseconds */
>   };
> +#endif
> 
>   struct __kernel_old_timespec {
>   	__kernel_old_time_t	tv_sec;		/* seconds */



