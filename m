From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 5 May 2021 22:24:11 +0200
Subject: [LTP] [PATCH v3 4/6] Add rtnetlink helper library
In-Reply-To: <3042e4a5-453a-80aa-be65-f606a7c4ed45@suse.cz>
References: <20210505081845.7024-1-mdoucha@suse.cz>
 <20210505081845.7024-4-mdoucha@suse.cz> <YJKA9LQsiFDeuPUT@pevik>
 <3042e4a5-453a-80aa-be65-f606a7c4ed45@suse.cz>
Message-ID: <YJL+6//cEZKGz3ke@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> On 05. 05. 21 13:26, Petr Vorel wrote:
> >> diff --git a/include/tst_rtnetlink.h b/include/tst_rtnetlink.h
> >> new file mode 100644
> >> index 000000000..12ec258f2
> >> --- /dev/null
> >> +++ b/include/tst_rtnetlink.h
> >> @@ -0,0 +1,106 @@
> >> +/* SPDX-License-Identifier: GPL-2.0-or-later
> >> + * Copyright (c) 2021 Linux Test Project
> >> + */
> >> +
> >> +#ifndef TST_RTNETLINK_H
> >> +#define TST_RTNETLINK_H

> > I guess this header will always be internal, right?  (only tst_netdevice.h is
> > going to be used in tests) Otherwise it might need to include headers
> > (<linux/netlink.h>, and also <unistd.h> or <sys/types.h> for ssize_t which are
> > now only in C library sources).

> No, I expect that someone will use it for rtnetlink tests sooner or
> later. But I don't think those extra #includes matter all that much. If
> they get #included in the test itself in the right order, it'll work
> just fine.
Sure.

> > ...
> >> +int tst_rtnl_add_message(const char *file, const int lineno,
> >> +	struct tst_rtnl_context *ctx, const struct nlmsghdr *header,
> >> +	const void *payload, size_t payload_size)
> >> +{
> >> +	size_t size;
> >> +	unsigned int extra_flags = 0;
> >> +
> >> +	if (!tst_rtnl_grow_buffer(file, lineno, ctx, NLMSG_SPACE(payload_size)))
> > Shouldn't there be an error message?
> > Or maybe at tst_rtnl_grow_buffer() on if (!buf)

> As Cyril already pointed out, the only way this call can fail is when
> safe_realloc() fails and prints a TWARN because we're in cleanup().
> There's no need to print a second error message.
You're right, thanks for info.

Kind regards,
Petr
