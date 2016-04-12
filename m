From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 12 Apr 2016 09:39:37 -0400 (EDT)
Subject: [LTP] Pre-release LTP build
In-Reply-To: <20160412122307.GA2562@rei.suse.cz>
References: <20160411172305.GC3466@rei.lan>
 <1944071328.394698.1460449773165.JavaMail.zimbra@redhat.com>
 <20160412084049.GA24915@rei.lan>
 <1180846583.442810.1460462279148.JavaMail.zimbra@redhat.com>
 <20160412122307.GA2562@rei.suse.cz>
Message-ID: <1314010537.480730.1460468377766.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Tuesday, 12 April, 2016 2:23:07 PM
> Subject: Re: [LTP] Pre-release LTP build
> 
> Hi!
> > As for RHEL5.6 it's only i386. I was able to compile x86_64, ia64,
> > ppc/ppc64
> > and s390/s390x with no changes.
> > 
> > Any of these two allow it to compile on x86:
> > 1. -march=i486 (or higher)
> > 2.
> > diff --git a/lib/tst_atomic.c b/lib/tst_atomic.c
> > new file mode 100644
> > index 0000000..601fd6c
> > --- /dev/null
> > +++ b/lib/tst_atomic.c
> > @@ -0,0 +1,8 @@
> > +#if defined(__i386__)
> > +unsigned int __sync_add_and_fetch_4(unsigned int *v, unsigned value)
> > +{
> > +       register int val = value;
> > +       __asm__ __volatile__ ( "lock xadd %1,%0" : "=m" (*v), "=r" (val) :
> > "1" (val) : "memory");
> > +       return val + value;
> > +}
> > +#endif
> > 
> > According to gcc docs it should only make external call to above function,
> > when it's not provided natively, so it works as fallback.
> 
> Accordingly to:
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=34115
> 
> It does not work with gcc 4.1 when the builtin is returned directly at
> the end of the function.
> 
> So storing the return value to a variable may fix that as well.

It made no difference for me:

../../lib/libltp.a(tst_test.o): In function `tst_atomic_inc':
/root/ltp/lib/../include/tst_atomic.h:23: undefined reference to `__sync_add_and_fetch_4'
/root/ltp/lib/../include/tst_atomic.h:23: undefined reference to `__sync_add_and_fetch_4'
/root/ltp/lib/../include/tst_atomic.h:23: undefined reference to `__sync_add_and_fetch_4'
collect2: ld returned 1 exit status
make[1]: *** [test01] Error 1
make[1]: Leaving directory `/root/ltp/lib/newlib_tests'
make: *** [all] Error 2

> But I would prefer having fallback definition over working around
> compiler bugs.

Agreed.
