From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 27 Dec 2017 09:42:13 +0100
Subject: [LTP] [RFC PATCH v2 2/4] lapi/socket.h: Move definitions from
 netstress.c
In-Reply-To: <8186d043-06db-94a3-1da3-c2e57e42597b@oracle.com>
References: <20171221192739.4868-1-pvorel@suse.cz>
 <20171221192739.4868-3-pvorel@suse.cz>
 <8186d043-06db-94a3-1da3-c2e57e42597b@oracle.com>
Message-ID: <20171227084211.GA17258@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

thanks for your review.

> >  #ifndef SOCK_CLOEXEC
> >  # define SOCK_CLOEXEC 02000000
> >  #endif

> > +#ifndef SOCK_DCCP
> > +# define SOCK_DCCP		6
> > +#endif

> I would move it above SOCK_CLOEXEC, so we can keep the order
> of these flags similarly to bits/socket.h.
You probably mean bits/socket_type.h. Sure.

> The other patches in this set look good, thanks!
Just one exception, if you don't mind:
I use lapi/netinet_in.h instead of lapi/in.h. I don't like inconsistency (other headers in
lapi don't use prefix), but using just in.h is confusing, as there is also linux/in.h, as
Cyril pointed out.


Kind regards,
Petr
