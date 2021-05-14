From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 14 May 2021 10:55:02 +0200
Subject: [LTP] [PATCH v2 1/1] lapi: Add missing IFA_FLAGS
In-Reply-To: <YJ4qsVYYYfW3lldj@yuki>
References: <20210514080630.11273-1-pvorel@suse.cz>
 <YJ4qsVYYYfW3lldj@yuki>
Message-ID: <YJ465pWpCSdaYCvZ@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> Hi!
> >  configure.ac             |  1 +
> >  include/lapi/rtnetlink.h | 17 +++++++++++++++++
> >  lib/tst_netdevice.c      |  3 ++-
> >  3 files changed, 20 insertions(+), 1 deletion(-)
> >  create mode 100644 include/lapi/rtnetlink.h

> > diff --git a/configure.ac b/configure.ac
> > index 136d82d09..95c6d2e72 100644
> > --- a/configure.ac
> > +++ b/configure.ac
> > @@ -59,6 +59,7 @@ AC_CHECK_HEADERS_ONCE([ \
> >      linux/mempolicy.h \
> >      linux/module.h \
> >      linux/netlink.h \
> > +    linux/rtnetlink.h \

> I wonder if this is really needed, if that header is not present we will
> have to add much more stuff to lapi/rtnetlink.h, so I would just avoid
> configure check here.
Sure, we save some time during configure.

Sending v3 (being conservative as there is a git freeze).

Kind regards,
Petr
