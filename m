From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 26 Apr 2021 07:42:36 +0200
Subject: [LTP] [PATCH] Fix the 64-bit macro definition of mips
 architecture
In-Reply-To: <20210422072609.9938-1-sujiaxun@uniontech.com>
References: <20210422072609.9938-1-sujiaxun@uniontech.com>
Message-ID: <YIZSzNd9uK8kItYb@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi sujiaxun,

[ Cc: Viresh, the original author ]

> https://github.com/torvalds/linux/blob/master/arch/mips/include/uapi/asm/shmbuf.h
> The mips 64-bit macro definition in the kernel is "__mips64",
>  and the mips 64-bit macro definition in the ltp is "__arch64__".

> Signed-off-by: sujiaxun <sujiaxun@uniontech.com>
> ---
>  include/lapi/msgbuf.h | 2 +-
>  include/lapi/sembuf.h | 2 +-
>  include/lapi/shmbuf.h | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

> diff --git a/include/lapi/msgbuf.h b/include/lapi/msgbuf.h
> index f3277270d..f010695f1 100644
> --- a/include/lapi/msgbuf.h
> +++ b/include/lapi/msgbuf.h
> @@ -17,7 +17,7 @@
>  #if defined(__mips__)
>  #define HAVE_MSQID64_DS

> -#if defined(__arch64__)
> +#if defined(__mips64)
So __arch64__ is not defined for mips 64 bit? (as it's defined for sparc 64bit?)
__mips64 is obviously correct and better readable, but is it really required?
(you can check it with: echo | gcc -dM -E -).

Kind regards,
Petr
