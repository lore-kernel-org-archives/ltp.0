From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 6 May 2019 22:19:48 +0200
Subject: [LTP] [PATCH v4] syscalls/copy_file_range: add/restructured
	tests
In-Reply-To: <1ef7d8ee-ae31-b44c-71e6-7d09da55eda2@suse.com>
References: <20190506105457.22350-1-camann@suse.com>
 <1ef7d8ee-ae31-b44c-71e6-7d09da55eda2@suse.com>
Message-ID: <20190506201948.GA9828@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Christian,

...
> > +++ b/configure.ac
> > @@ -197,6 +197,7 @@ LTP_CHECK_BUILTIN_CLEAR_CACHE
> >  LTP_CHECK_CAPABILITY_SUPPORT
> >  LTP_CHECK_CC_WARN_OLDSTYLE
> >  LTP_CHECK_CLONE_SUPPORTS_7_ARGS
> > +LTP_CHECK_COPY_FILE_RANGE
> >  LTP_CHECK_CRYPTO
> >  LTP_CHECK_FIDEDUPE
> >  LTP_CHECK_FORTIFY_SOURCE
> > diff --git a/m4/ltp-copy_file_range.m4 b/m4/ltp-copy_file_range.m4
> > new file mode 100644
> > index 000000000..2d87e8900
> > --- /dev/null
> > +++ b/m4/ltp-copy_file_range.m4
> > @@ -0,0 +1,7 @@
> > +dnl SPDX-License-Identifier: GPL-2.0-or-later
> > +dnl Copyright (c) 2019 SUSE LLC
> > +dnl Author: Christian Amann <camann@suse.com>
> > +
> > +AC_DEFUN([LTP_CHECK_COPY_FILE_RANGE],[
> > +AC_CHECK_FUNCS(copy_file_range,,)
> > +])
Instead of putting AC_CHECK_FUNCS into separate file (m4/ltp-copy_file_range.m4)
since 8fd49cebd ("configure.ac: Simplify the check for libc function implementations")
we add copy_file_range into AC_CHECK_FUNCS in configure.ac.

So I'd be for applying it with following diff after LTP release.
Nice work, thanks for your patch.

Kind regards,
Petr

diff --git configure.ac configure.ac
index 3fec68ede..0763346f3 100644
--- configure.ac
+++ configure.ac
@@ -60,6 +60,7 @@ AC_CHECK_HEADERS([ \
 ])
 
 AC_CHECK_FUNCS([ \
+    copy_file_range \
     epoll_pwait \
     execveat \
     fallocate \
@@ -197,7 +198,6 @@ LTP_CHECK_BUILTIN_CLEAR_CACHE
 LTP_CHECK_CAPABILITY_SUPPORT
 LTP_CHECK_CC_WARN_OLDSTYLE
 LTP_CHECK_CLONE_SUPPORTS_7_ARGS
-LTP_CHECK_COPY_FILE_RANGE
 LTP_CHECK_CRYPTO
 LTP_CHECK_FIDEDUPE
 LTP_CHECK_FORTIFY_SOURCE
diff --git m4/ltp-copy_file_range.m4 m4/ltp-copy_file_range.m4
deleted file mode 100644
index 2d87e8900..000000000
--- m4/ltp-copy_file_range.m4
+++ /dev/null
@@ -1,7 +0,0 @@
-dnl SPDX-License-Identifier: GPL-2.0-or-later
-dnl Copyright (c) 2019 SUSE LLC
-dnl Author: Christian Amann <camann@suse.com>
-
-AC_DEFUN([LTP_CHECK_COPY_FILE_RANGE],[
-AC_CHECK_FUNCS(copy_file_range,,)
-])
