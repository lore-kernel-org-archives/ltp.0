From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 5 May 2021 13:26:44 +0200
Subject: [LTP] [PATCH v3 4/6] Add rtnetlink helper library
In-Reply-To: <20210505081845.7024-4-mdoucha@suse.cz>
References: <20210505081845.7024-1-mdoucha@suse.cz>
 <20210505081845.7024-4-mdoucha@suse.cz>
Message-ID: <YJKA9LQsiFDeuPUT@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> This library provides simple interface for creating arbitrary rtnetlink
> messages with complex attributes, sending requests and receiving results.

> Changes since v1:
> - fixed error handling in tst_rtnl_create_context()
> - renamed tst_rtnl_free_context() to tst_rtnl_destroy_context()
> - switched from select() to poll() in tst_rtnl_wait()
> - use tst_rtnl_add_message() for adding NLMSG_DONE
> - receive all pending messages in tst_rtnl_recv(), not just one
> - use inline struct initialization where possible

>  include/tst_rtnetlink.h | 106 +++++++++++
>  lib/tst_rtnetlink.c     | 407 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 513 insertions(+)
>  create mode 100644 include/tst_rtnetlink.h
>  create mode 100644 lib/tst_rtnetlink.c

> diff --git a/include/tst_rtnetlink.h b/include/tst_rtnetlink.h
> new file mode 100644
> index 000000000..12ec258f2
> --- /dev/null
> +++ b/include/tst_rtnetlink.h
> @@ -0,0 +1,106 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later
> + * Copyright (c) 2021 Linux Test Project
> + */
> +
> +#ifndef TST_RTNETLINK_H
> +#define TST_RTNETLINK_H

I guess this header will always be internal, right?  (only tst_netdevice.h is
going to be used in tests) Otherwise it might need to include headers
(<linux/netlink.h>, and also <unistd.h> or <sys/types.h> for ssize_t which are
now only in C library sources).

...
> +int tst_rtnl_add_message(const char *file, const int lineno,
> +	struct tst_rtnl_context *ctx, const struct nlmsghdr *header,
> +	const void *payload, size_t payload_size)
> +{
> +	size_t size;
> +	unsigned int extra_flags = 0;
> +
> +	if (!tst_rtnl_grow_buffer(file, lineno, ctx, NLMSG_SPACE(payload_size)))
Shouldn't there be an error message?
Or maybe at tst_rtnl_grow_buffer() on if (!buf)

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Nice code, thanks!

Kind regards,
Petr
