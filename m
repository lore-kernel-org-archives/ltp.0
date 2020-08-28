From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 28 Aug 2020 10:43:34 +0200
Subject: [LTP] [PATCH] tst_af_alg: fix build error when
 ALG_SET_AEAD_ASSOCLEN undefined
In-Reply-To: <1598005119-2147-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1598005119-2147-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20200828084334.GA1648@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

>  configure.ac          |  6 ++++++
>  include/lapi/if_alg.h | 39 ++++++++++++++++++++++++++++++---------
>  2 files changed, 36 insertions(+), 9 deletions(-)

> diff --git a/configure.ac b/configure.ac
> index 382963d8b..f711ac123 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -193,6 +193,12 @@ AC_CHECK_TYPES([struct xt_entry_match, struct xt_entry_target],,,[
>  #include <linux/netfilter_ipv4/ip_tables.h>
>  ])

> +AC_CHECK_TYPES([struct sockaddr_alg, struct af_alg_iv],,,[
> +#ifdef HAVE_LINUX_IF_ALG_H
> +# include <linux/if_alg.h>
> +#endif
> +])
nit: This list was meant to be sorted. I'll handle that during merge.
> +
>  # Tools knobs

>  # Expect
> diff --git a/include/lapi/if_alg.h b/include/lapi/if_alg.h
> index 5a74df99b..9c04a444c 100644
> --- a/include/lapi/if_alg.h
> +++ b/include/lapi/if_alg.h
> @@ -8,9 +8,10 @@

>  #ifdef HAVE_LINUX_IF_ALG_H
>  #  include <linux/if_alg.h>
> -#else
> +#endif
>  #  include <stdint.h>
BTW <stdint.h> is needed only for "#ifndef HAVE_STRUCT_SOCKADDR_ALG" and "#ifndef
HAVE_STRUCT_AF_ALG_IVL" (for uint*_t) but we can ignore that as a detail (better
than have complicated guarder:
#if ! (defined(HAVE_STRUCT_SOCKADDR_ALG) && defined(HAVE_STRUCT_AF_ALG_IVL)

(and later forgot to update it).

> +#ifndef HAVE_STRUCT_SOCKADDR_ALG
>  struct sockaddr_alg {
>  	uint16_t	salg_family;
>  	uint8_t		salg_type[14];
> @@ -18,21 +19,41 @@ struct sockaddr_alg {
>  	uint32_t	salg_mask;
>  	uint8_t		salg_name[64];
>  };
> +#endif

The rest lgtm:
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
