From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 10 Nov 2020 09:52:25 +0100
Subject: [LTP] [PATCH v3 2/2] syscalls/iopl,
 ioperm: Check for SecureBoot lockdown
In-Reply-To: <CAEemH2egUaO=ebaRFOZDNCZYi1QKZN168xE=_J_U_yoBH5PyLQ@mail.gmail.com>
References: <20201109164605.25965-1-mdoucha@suse.cz>
 <20201109164605.25965-2-mdoucha@suse.cz>
 <CAEemH2egUaO=ebaRFOZDNCZYi1QKZN168xE=_J_U_yoBH5PyLQ@mail.gmail.com>
Message-ID: <20201110085225.GA3767@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > ...
> >
> >  include $(top_srcdir)/include/mk/testcases.mk
> >
> > +CFLAGS                 += $(EFIVAR_CFLAGS)
> > +LDLIBS                 += $(EFIVAR_LIBS)
> >
> 
> Where can we get the value of these two variables? Shouldn't we
> add AC_SUBST() in the m4 file?

These are exported by the PKG_CHECK_MODULES() pkgconfig autotools macro.

> > --- a/testcases/kernel/syscalls/ioperm/ioperm02.c
> > +++ b/testcases/kernel/syscalls/ioperm/ioperm02.c
> > @@ -22,6 +22,7 @@
> >  #include <pwd.h>
> >  #include "tst_test.h"
> >  #include "tst_safe_macros.h"
> > +#include "tst_secureboot.h"
> >
> >  #if defined __i386__ || defined(__x86_64__)
> >  #include <sys/io.h>
> > @@ -45,6 +46,10 @@ static struct tcase_t {
> >
> >  static void setup(void)
> >  {
> > +       /* ioperm() is restricted under kernel lockdown. */
> > +       if (tst_lockdown_enabled() || tst_secureboot_enabled() > 0)
> > +               tst_brk(TCONF, "Kernel is locked down, skip this test");
> >
> 
> The ioperm02 is an error test for ioperm(), it doesn't matter without the
> lockdown/secure-boot status. Better to remove this from setup().
> 
> iopl02 as well.

Actually I think that this is correct, since there is no imposed order
on the checks in kernel, so we may not get the errors we expect to get.


What we are actually missing are tests that iopl() and ioperm() does
fail with EPERM when either of lockdown or secureboot are enabled.

-- 
Cyril Hrubis
chrubis@suse.cz
