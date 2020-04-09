From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 9 Apr 2020 18:50:53 +0800
Subject: [LTP] [PATCH v2 01/10] lapi/loop.h: Add fallback for loop ioctl
 and flag
In-Reply-To: <1586429086-22975-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <20200409075506.GA2828@yuki.lan>
 <1586429086-22975-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <e0ebbfe0-a264-a969-ecfa-0db2ab9a41c3@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi All

> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> ---
>   include/lapi/loop.h | 35 +++++++++++++++++++++++++++++++++++
>   1 file changed, 35 insertions(+)
>   create mode 100644 include/lapi/loop.h
> 
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
Sorry, this should be removed.
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
> 


