From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 19 May 2020 14:23:47 +0200
Subject: [LTP] [PATCH 3/5] syscalls: Don't use tst_syscall()
 unnecessarily
In-Reply-To: <3f3b7d669d47ae701385b43deb8280a353dd231e.1589877853.git.viresh.kumar@linaro.org>
References: <cover.1589877853.git.viresh.kumar@linaro.org>
 <3f3b7d669d47ae701385b43deb8280a353dd231e.1589877853.git.viresh.kumar@linaro.org>
Message-ID: <20200519122347.GC16008@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> These syscall are old enough and must have support in libc for everyone.
> Don't use tst_syscall() for them unnecessarily.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  lib/parse_opts.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/lib/parse_opts.c b/lib/parse_opts.c
> index a9d50589a3f9..b3ab69c0a539 100644
> --- a/lib/parse_opts.c
> +++ b/lib/parse_opts.c
> @@ -45,7 +45,6 @@
>  #include "test.h"
>  #include "ltp_priv.h"
>  #include "usctest.h"
> -#include "tst_clocks.h"
>  
>  #ifndef UNIT_TEST
>  #define UNIT_TEST	0
> @@ -472,7 +471,7 @@ static uint64_t get_current_time(void)
>  {
>  	struct timespec ts;
>  
> -	tst_clock_gettime(CLOCK_MONOTONIC, &ts);
> +	clock_gettime(CLOCK_MONOTONIC, &ts);

I guess that this will reintroduce LTP compilation failures on older
glibc, which was the primary reason we used the tst_clock_gettime()
instead of clock_gettime().

-- 
Cyril Hrubis
chrubis@suse.cz
