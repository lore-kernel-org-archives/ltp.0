From: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Date: Wed, 9 Jun 2021 08:20:39 -0300
Subject: [LTP] [PATCH] futex_wake04: avoid tst_ts_from_ns overflow on
 32-bit platforms
In-Reply-To: <YMB6aoVvTKJQ6wif@yuki>
References: <20210608132723.255996-1-cascardo@canonical.com>
 <YMB6aoVvTKJQ6wif@yuki>
Message-ID: <YMCkB/iS54OJaby4@mussarela>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Jun 09, 2021 at 10:23:06AM +0200, Cyril Hrubis wrote:
> Hi!
> Good catch, I guess that it would be slightly cleaner to fix the
> NSEC_PER_SEC size instead with:
> 
> diff --git a/include/lapi/common_timers.h b/include/lapi/common_timers.h
> index b783beff4..e50f698d6 100644
> --- a/include/lapi/common_timers.h
> +++ b/include/lapi/common_timers.h
> @@ -12,7 +12,7 @@
>  #include "lapi/posix_clocks.h"
> 
>  #ifndef NSEC_PER_SEC
> -#define NSEC_PER_SEC (1000000000L)
> +#define NSEC_PER_SEC (1000000000LL)
>  #endif
> 
>  static const clock_t clock_list[] = {
> 
> 
> What do you think?
> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz

Yeah, I even wrote and tested that it would build, but I wasn't able to go
through any build logs or run complete tests.

But maybe I am just overthinking this, and any promotions due to this would
only fix issues and not introduce any new ones.

Well, on second thought, on 32-bit, in cases like variadic functions, it could
cause a problem. So, I am just afraid that applying this fix without looking
for every use of NSEC_PER_SEC might lead to new bugs.

Cascardo.
