From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 3 Mar 2016 15:00:55 +0100
Subject: [LTP] Test library API changes
In-Reply-To: <322891927.4705109.1457010820487.JavaMail.zimbra@redhat.com>
References: <20160105111136.GA32659@rei.lan> <20160216211958.GC2515@rei.lan>
 <1799339064.21851637.1455719961718.JavaMail.zimbra@redhat.com>
 <20160217155406.GA12574@rei>
 <1752902661.22105327.1455786359593.JavaMail.zimbra@redhat.com>
 <20160218110752.GB19157@rei.lan>
 <1610317133.22142649.1455794774969.JavaMail.zimbra@redhat.com>
 <20160302144421.GC25763@rei>
 <322891927.4705109.1457010820487.JavaMail.zimbra@redhat.com>
Message-ID: <20160303140054.GB3055@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> In that case, tst_vbrk_() should also call update_results(), so TBROK
> during cleanup doesn't get lost/ignored.

Yes, that is what I did when I was experimenting with this change.

> > 
> >   - plus point is that writing cleanup is bit easier
> > 
> >   - minus point is that tst_brk() can now return and as a side effect
> >     tst_brkm() has to return as well (since tst_brkm() from safe macros
> >     is redirected to tst_brk()) and because of that we have to drop
> >     the __attribute__((noreturn)) since that causes gcc to optimize out
> >     return statements from the function which generates compilation
> >     warnings in some cases
> 
> I assume if we drop noreturn, we still have a different way to suppress
> those warnings, right?

All I can come up is to fix all occurences. I've recompiled LTP with the
changes and I got 1090 instances of:

"warning: control reaches end of non-void function [-Wreturn-type]"

Fortunately 1037 seems to come from including compat_16.h header and
it's syscall wrappers. Then there is still 53 cases scattered around the
code base.

This is why I'm not 100% sure we should do the change...

> > 
> > 
> > Is there anything else?
> 
> I ran into number of compilation errors on RHEL5.6, but they will
> likely happen on other distros too:
> 
> 1. lib/ltp_priv.h and va_list
> Adding "#include <stdarg.h>" fixed it.

Ack, will add it.

> 2. preadv/preadv.h:27: undefined reference to `tst_brkm'
> pread01 and pread02 share predv.h, which is using ltp_syscall

Ack, will fix that once second test is converted.

> 3. recvmsg02.c:68: error: ???SOCK_CLOEXEC??? undeclared (first use in this function)
> I'm guessing some old api header used to include also lapi/fcntl.h

Fixed in main git repo meanwhile, will be fixed once I rebase the
patchset.

-- 
Cyril Hrubis
chrubis@suse.cz
