From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 11 Apr 2019 09:46:40 +0200
Subject: [LTP] [PATCH] syscalls/clock_adjtime: Fix compiler error
In-Reply-To: <1554965824-2374-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1554965824-2374-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20190411074640.GA1498@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> 'ADJ_OFFSET_SS_READ' 'ADJ_NANO' 'STA_NANO' and 'ADJ_MICRO' are not defined on
> some old distros, so add them into 'include/lapi/posix_clocks.h' to fix it.
> 
> These macros are introduced by the following commit:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=52bfb36
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=eea83d8
> 
> sys_clock_adjtime are introduced by the following commit:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=339dc50
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> ---
>  include/lapi/posix_clocks.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/include/lapi/posix_clocks.h b/include/lapi/posix_clocks.h
> index b1f7a7c55..1d29107d8 100644
> --- a/include/lapi/posix_clocks.h
> +++ b/include/lapi/posix_clocks.h
> @@ -39,4 +39,20 @@
>  # define CLOCK_BOOTTIME_ALARM 9
>  #endif
>  
> +#ifndef ADJ_OFFSET_SS_READ
> +# define ADJ_OFFSET_SS_READ 0xa001
> +#endif
> +
> +#ifndef ADJ_NANO
> +# define ADJ_NANO 0x2000
> +#endif
> +
> +#ifndef STA_NANO
> +# define STA_NANO 0x2000
> +#endif
> +
> +#ifndef ADJ_MICRO
> +# define ADJ_MICRO 0x1000
> +#endif

Can we start a new header in the lapi called timex.h and put these
there? Other than that this looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
