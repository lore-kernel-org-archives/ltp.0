From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 10 Nov 2020 11:23:55 +0100
Subject: [LTP] [PATCH v3 2/2] syscalls/iopl,
 ioperm: Check for SecureBoot lockdown
In-Reply-To: <20201110085225.GA3767@yuki.lan>
References: <20201109164605.25965-1-mdoucha@suse.cz>
 <20201109164605.25965-2-mdoucha@suse.cz>
 <CAEemH2egUaO=ebaRFOZDNCZYi1QKZN168xE=_J_U_yoBH5PyLQ@mail.gmail.com>
 <20201110085225.GA3767@yuki.lan>
Message-ID: <20201110102355.GA10788@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

...
> > >  include $(top_srcdir)/include/mk/testcases.mk

> > > +CFLAGS                 += $(EFIVAR_CFLAGS)
> > > +LDLIBS                 += $(EFIVAR_LIBS)


> > Where can we get the value of these two variables? Shouldn't we
> > add AC_SUBST() in the m4 file?

> These are exported by the PKG_CHECK_MODULES() pkgconfig autotools macro.
FYI: I added a fix for old pkg-config (< 0.24) into m4/ltp-tirpc.m4
(the first m4 file which started to use pkg-config)
https://autotools.io/pkgconfig/pkg_check_modules.html

But 0.24 is probably old enough (2010; 0.23 was released 2008), thus we should
probably remove it.

Kind regards,
Petr
