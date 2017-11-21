From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 21 Nov 2017 12:45:29 +0100
Subject: [LTP] [RFC PATCH 2/4] lapi/socket.h: Move definitions from
	netstress.c
In-Reply-To: <e1337cca-539c-54ea-9af1-d27db3ee7db1@oracle.com>
References: <20171109113947.24609-1-pvorel@suse.cz>
 <20171109113947.24609-3-pvorel@suse.cz>
 <e1337cca-539c-54ea-9af1-d27db3ee7db1@oracle.com>
Message-ID: <20171121114529.sytz7dj7kjqsjx7k@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> On 11/09/2017 02:39 PM, Petr Vorel wrote:
> > + remove sys/socket.h from netstress.c

> What about including it in lapi/socket.h?

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> >  include/lapi/socket.h                   | 18 +++++++++++++++++-
> >  testcases/network/netstress/netstress.c | 18 ++----------------
> >  2 files changed, 19 insertions(+), 17 deletions(-)

> > diff --git a/include/lapi/socket.h b/include/lapi/socket.h
> > index 98263105e..af9448804 100644
> > --- a/include/lapi/socket.h
> > +++ b/include/lapi/socket.h
> > @@ -19,8 +19,24 @@
> >  #ifndef __LAPI_SOCKET_H__
> >  #define __LAPI_SOCKET_H__

> > +#ifndef MSG_FASTOPEN
> > +#define MSG_FASTOPEN	0x20000000 /* Send data in TCP SYN */
> > +#endif
> > +
> > +#ifndef SO_BUSY_POLL
> > +#define SO_BUSY_POLL	46
> > +#endif
> > +
> >  #ifndef SOCK_CLOEXEC
> > -# define SOCK_CLOEXEC 02000000
> > +#define SOCK_CLOEXEC 02000000
> > +#endif
> > +
> > +#ifndef SOCK_DCCP
> > +#define SOCK_DCCP		6
> > +#endif

> The two above should probably be in ascending order...
Thanks, I'll fix it.

> SOCK_CLOEXEC along with SOCK_NONBLOCK already defined in
> lapi/fcntl.h. I guess we should move them to lapi/socket.h instead.
Good point. include/lapi/fcntl.h defines:
#ifndef O_CLOEXEC
# define O_CLOEXEC 02000000
#endif

#ifndef SOCK_CLOEXEC
# define SOCK_CLOEXEC O_CLOEXEC
#endif

This actually makes sense as these both have the same value on the same architecture, but
in glibc headers are these defined separately (in /usr/include/bits/socket_type.h and
/usr/include/asm-generic/fcntl.h).
Both musl and uclibc-ng use the same approach, so I propose to split these definitions in
according to (g)libc headers.


Kind regards,
Petr
