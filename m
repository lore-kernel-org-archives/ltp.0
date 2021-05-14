From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 14 May 2021 09:23:13 +0200
Subject: [LTP] [PATCH 1/1] lapi: Add missing IFA_FLAGS
In-Reply-To: <20210513182638.5514-1-pvorel@suse.cz>
References: <20210513182638.5514-1-pvorel@suse.cz>
Message-ID: <YJ4lYU5PC4d9Yc+0@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> and use them in tst_netdevice.c. This fixes on older toolchains
> (e.g. sourcery-arm from Buildroot):
> 
> tst_netdevice.c: In function 'modify_address':
> tst_netdevice.c:218:44: error: 'IFA_FLAGS' undeclared (first use in this function)
>   if (!tst_rtnl_add_attr(file, lineno, ctx, IFA_FLAGS, &addr_flags,
> 
> Fixes: bc2151a65 ("lib: Add helper functions for managing network interfaces")
> 
> Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
> ---
>  configure.ac           |  1 +
>  include/lapi/if_addr.h | 15 +++++++++++++++
>  lib/tst_netdevice.c    |  2 ++
>  3 files changed, 18 insertions(+)
>  create mode 100644 include/lapi/if_addr.h
> 
> diff --git a/configure.ac b/configure.ac
> index 136d82d09..08a56f9ef 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -51,6 +51,7 @@ AC_CHECK_HEADERS_ONCE([ \
>      linux/dccp.h \
>      linux/fs.h \
>      linux/genetlink.h \
> +    linux/if_addr.h \
>      linux/if_alg.h \
>      linux/if_ether.h \
>      linux/if_packet.h \
> diff --git a/include/lapi/if_addr.h b/include/lapi/if_addr.h
> new file mode 100644
> index 000000000..c1acfe4fb
> --- /dev/null
> +++ b/include/lapi/if_addr.h
> @@ -0,0 +1,15 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/* Copyright (c) 2021 Petr Vorel <petr.vorel@gmail.com> */
> +
> +#ifndef LAPI_IF_ADDR_H__
> +# define LAPI_IF_ADDR_H__
> +
> +# ifdef HAVE_LINUX_IF_ADDR_H
> +#  include <linux/if_addr.h>

This file is usually included from the rtnetlink.h, shouldn't we rather
add lapi/rtnetlink.h that would include linux/rtnetlink.h and simply
adds the IFA_FLAGS definition if it's missing?

> +# endif
> +
> +#ifndef IFA_FLAGS
> +# define IFA_FLAGS 8
> +#endif
> +
> +#endif	/* LAPI_IF_ADDR_H__ */
> diff --git a/lib/tst_netdevice.c b/lib/tst_netdevice.c
> index 5ca523759..a95f19d35 100644
> --- a/lib/tst_netdevice.c
> +++ b/lib/tst_netdevice.c
> @@ -9,6 +9,8 @@
>  #include <linux/veth.h>
>  #include <sys/socket.h>
>  #include <net/if.h>
> +#include "lapi/if_addr.h"
> +
>  #define TST_NO_DEFAULT_MAIN
>  #include "tst_test.h"
>  #include "tst_rtnetlink.h"
> -- 
> 2.31.1
> 

-- 
Cyril Hrubis
chrubis@suse.cz
