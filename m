From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 13 Apr 2016 09:07:49 -0400 (EDT)
Subject: [LTP] Pre-release LTP build
In-Reply-To: <20160412142449.GC2875@rei.suse.cz>
References: <20160411172305.GC3466@rei.lan>
 <1944071328.394698.1460449773165.JavaMail.zimbra@redhat.com>
 <20160412084049.GA24915@rei.lan>
 <1180846583.442810.1460462279148.JavaMail.zimbra@redhat.com>
 <20160412122307.GA2562@rei.suse.cz>
 <1314010537.480730.1460468377766.JavaMail.zimbra@redhat.com>
 <20160412142449.GC2875@rei.suse.cz>
Message-ID: <166413638.832919.1460552869855.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Tuesday, 12 April, 2016 4:24:50 PM
> Subject: Re: [LTP] Pre-release LTP build
> 
> Hi!
> > > > +++ b/lib/tst_atomic.c
> > > > @@ -0,0 +1,8 @@
> > > > +#if defined(__i386__)
> > > > +unsigned int __sync_add_and_fetch_4(unsigned int *v, unsigned value)
> > > > +{
> > > > +       register int val = value;
> > > > +       __asm__ __volatile__ ( "lock xadd %1,%0" : "=m" (*v), "=r"
> > > > (val) :
> > > > "1" (val) : "memory");
> > > > +       return val + value;
> > > > +}
> > > > +#endif
> > > > 
> > > > According to gcc docs it should only make external call to above
> > > > function,
> > > > when it's not provided natively, so it works as fallback.
> 
> This does not work with gcc-3.3 where no redirection from
> __sync_add_and_fetch -> __sync_add_and_fetch_4 happens. I would say that
> if we are adding fallback definition it should work with 3.3 as well. So
> I guess we should go with configure check and defining
> sync_add_and_fetch() directly. We can also print nice #error message in
> case that there is no fallback implementation if we decide to go this
> way.

I'll post a series that goes this way shortly. I've based it on kernel
atomic_add_return for architectures that are accessible for me. I tested
it only on RHEL5.6 (gcc 4.1.2), which I think is the oldest active
RHEL release at the moment.

What arches do you care about, that have gcc-3.3?
