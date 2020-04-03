From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 3 Apr 2020 13:44:18 +0200
Subject: [LTP] [PATCH v1 01/10] lapi: Add a configure check and fallback
 for loop ioctl and flag
In-Reply-To: <1585839990-19923-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1585839990-19923-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1585839990-19923-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20200403114418.GB26355@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> ---
>  configure.ac        |  1 +
>  include/lapi/loop.h | 35 +++++++++++++++++++++++++++++++++++
>  2 files changed, 36 insertions(+)
>  create mode 100644 include/lapi/loop.h
> 
> diff --git a/configure.ac b/configure.ac
> index e1069b57e..e088cb564 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -50,6 +50,7 @@ AC_CHECK_HEADERS([ \
>      linux/if_ether.h \
>      linux/if_packet.h \
>      linux/keyctl.h \
> +    linux/loop.h \

I do wonder if there is actually a distrbution without the linux/loop.h
header, have you seen one?

>      linux/mempolicy.h \
>      linux/module.h \
>      linux/netlink.h \
> diff --git a/include/lapi/loop.h b/include/lapi/loop.h
> new file mode 100644
> index 000000000..bc6d9950d
> --- /dev/null
> +++ b/include/lapi/loop.h
> @@ -0,0 +1,35 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2020 FUJITSU LIMITED. All rights reserved.
> + * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> + */
> +#ifndef LAPI_LOOP_H
> +#define LAPI_LOOP_H
> +
> +#include <linux/types.h>
> +#ifdef HAVE_LINUX_LOOP_H
> +# include <linux/loop.h>
> +#endif
> +
> +#ifndef LO_FLAGS_PARTSCAN
> +# define LO_FLAGS_PARTSCAN 8
> +#endif
> +
> +#ifndef LO_FLAGS_DIRECT_IO
> +# define LO_FLAGS_DIRECT_IO 16
> +#endif
> +
> +#ifndef LOOP_SET_CAPACITY
> +# define LOOP_SET_CAPACITY 0x4C07
> +#endif
> +
> +#ifndef LOOP_SET_DIRECT_IO
> +# define LOOP_SET_DIRECT_IO 0x4C08
> +#endif
> +
> +#ifndef LOOP_SET_BLOCK_SIZE
> +# define LOOP_SET_BLOCK_SIZE 0x4C09
> +#endif
> +
> +#endif
> +
> -- 
> 2.23.0
> 
> 
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
