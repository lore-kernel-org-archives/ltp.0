From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 28 Aug 2020 10:48:18 +0200
Subject: [LTP] [PATCH] tst_af_alg: fix build error when
 ALG_SET_AEAD_ASSOCLEN undefined
In-Reply-To: <1598005119-2147-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1598005119-2147-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20200828084818.GB1648@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

...
> --- a/configure.ac
> +++ b/configure.ac
> @@ -193,6 +193,12 @@ AC_CHECK_TYPES([struct xt_entry_match, struct xt_entry_target],,,[
>  #include <linux/netfilter_ipv4/ip_tables.h>
>  ])

> +AC_CHECK_TYPES([struct sockaddr_alg, struct af_alg_iv],,,[
> +#ifdef HAVE_LINUX_IF_ALG_H
> +# include <linux/if_alg.h>
> +#endif
IMHO <linux/if_alg.h> does not need to be guarded.
(as the definitions are in it it either fail because missing or fail because not
loaded)
> +])
> +
>  # Tools knobs
...

Kind regards,
Petr
