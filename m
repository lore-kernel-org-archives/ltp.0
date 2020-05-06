From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 6 May 2020 15:49:35 +0200
Subject: [LTP] [PATCH v4 1/2] pty04: Use guarded buffers for transmission
In-Reply-To: <20200506124910.GA3198@yuki.lan>
References: <20200505101625.25020-1-rpalethorpe@suse.com>
 <20200505133746.GB21884@dell5510>
 <87d07isaka.fsf@our.domain.is.not.set>
 <877dxpsb4n.fsf@our.domain.is.not.set>
 <1106041841.11477901.1588762195733.JavaMail.zimbra@redhat.com>
 <CAEemH2coDuWHPt8SMosAtpjNd4VxmkGw3FWWajUOYXaNN7o0og@mail.gmail.com>
 <1352538726.11479675.1588763647954.JavaMail.zimbra@redhat.com>
 <20200506124910.GA3198@yuki.lan>
Message-ID: <20200506134935.GA22200@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> Hi!
> > -#if defined(HAVE_LINUX_IF_PACKET_H) && defined(HAVE_LINUX_IF_ETHER_H)
> > +#include <linux/version.h>
> > +
> > +#if defined(HAVE_LINUX_IF_PACKET_H) && defined(HAVE_LINUX_IF_ETHER_H) \
> > +       && LINUX_VERSION_CODE >= KERNEL_VERSION(4, 10, 0)

> Wouldn't it be just easier to define the structure in the test instead?
That's what Richard suggested.
I've sent a patch for that.

Kind regards,
Petr
