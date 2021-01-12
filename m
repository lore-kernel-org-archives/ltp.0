From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 12 Jan 2021 12:15:36 +0100
Subject: [LTP] [PATCH 1/1] autoconf: Use pkg-config for keyutils
 detection
In-Reply-To: <CAEemH2eTEEZVZc71=HF+251t_d7Rnu7XdFY2t54u=ORwY3M-7A@mail.gmail.com>
References: <20210111123626.28932-1-pvorel@suse.cz>
 <CAEemH2eTEEZVZc71=HF+251t_d7Rnu7XdFY2t54u=ORwY3M-7A@mail.gmail.com>
Message-ID: <X/2E2GD/wimgo5Hi@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

> > diff --git a/m4/ltp-keyutils.m4 b/m4/ltp-keyutils.m4
> > deleted file mode 100644
> > index 451c549f3..000000000
> > --- a/m4/ltp-keyutils.m4
> > +++ /dev/null
> > @@ -1,10 +0,0 @@
> > -dnl SPDX-License-Identifier: GPL-2.0-or-later
> > -dnl Copyright (c) 2016 Fujitsu Ltd.
> > -dnl Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
> > -dnl Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
> > -
> > -AC_DEFUN([LTP_CHECK_KEYUTILS_SUPPORT], [
> > -       AC_CHECK_LIB([keyutils], [add_key],
> > -       [AC_DEFINE(HAVE_LIBKEYUTILS, 1, [Define to 1 if you have
> > libkeyutils installed.])
> > -             AC_SUBST(KEYUTILS_LIBS, "-lkeyutils")])
> > -])
> > diff --git a/m4/ltp-libkeyutils.m4 b/m4/ltp-libkeyutils.m4
> > new file mode 100644
> > index 000000000..f5d128969
> > --- /dev/null
> > +++ b/m4/ltp-libkeyutils.m4
> > @@ -0,0 +1,8 @@
> > +dnl SPDX-License-Identifier: GPL-2.0-or-later
> > +dnl Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
> > +
> > +AC_DEFUN([LTP_CHECK_LIBKEYUTILS], [
> > +    PKG_CHECK_MODULES([LIBKEYUTILS], [libkeyutils], [


> I guess the list-of-modules should be [keyutils-libs] but not [libkeyutils]?
No problem to change that, but can you explain why?

Thanks for your review.

Kind regards,
Petr
