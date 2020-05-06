From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 6 May 2020 08:20:44 -0400 (EDT)
Subject: [LTP] [PATCH v4 1/2] pty04: Use guarded buffers for transmission
In-Reply-To: <20200506121704.GA8586@dell5510>
References: <20200505101625.25020-1-rpalethorpe@suse.com>
 <877dxpsb4n.fsf@our.domain.is.not.set>
 <1106041841.11477901.1588762195733.JavaMail.zimbra@redhat.com>
 <CAEemH2coDuWHPt8SMosAtpjNd4VxmkGw3FWWajUOYXaNN7o0og@mail.gmail.com>
 <1352538726.11479675.1588763647954.JavaMail.zimbra@redhat.com>
 <20200506113817.GA5409@dell5510>
 <1139985312.11485617.1588766778300.JavaMail.zimbra@redhat.com>
 <20200506121704.GA8586@dell5510>
Message-ID: <885202649.11490925.1588767644801.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi Jan,
> 
> > > > -#if defined(HAVE_LINUX_IF_PACKET_H) && defined(HAVE_LINUX_IF_ETHER_H)
> > > > +#include <linux/version.h>
> > > Shouldn't we also check for <linux/version.h> with autotools? Or are
> > > kernel
> > > headers mandatory for LTP build?
> 
> > We already include this header in some syscalls tests, so I assumed it
> > won't be an issue.
> 
> OK, no problem.
> 
> > > > +
> > > > +#if defined(HAVE_LINUX_IF_PACKET_H) && defined(HAVE_LINUX_IF_ETHER_H)
> > > > \
> > > > +       && LINUX_VERSION_CODE >= KERNEL_VERSION(4, 10, 0)
> 
> > > >  #include <linux/if_packet.h>
> > > >  #include <linux/if_ether.h>
> > > > @@ -373,6 +376,6 @@ static struct tst_test test = {
> 
> > > >  #else
> 
> > > > -TST_TEST_TCONF("Need <linux/if_packet.h> and <linux/if_ether.h>");
> > > > +TST_TEST_TCONF("Need <linux/if_packet.h> and <linux/if_ether.h> and
> > > > 4.10+");
> 
> > > +1.
> 
> > > BTW, why this tests requires 4.10 for runtime?
> 
> > It's for compilation. struct can_frame fields it's using were introduced in
> > 4.10.
> 
> Do you mean a2f11835994e ("can.h: make padding given by gcc explicit") from
> v4.2-rc1? + there is no change for include/uapi/linux/can.h in 4.10.

You're right, I didn't sort the tags correctly.

