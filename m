From: Li Wang <liwang@redhat.com>
Date: Tue, 12 Jan 2021 20:53:50 +0800
Subject: [LTP] [PATCH 1/1] autoconf: Use pkg-config for keyutils
 detection
In-Reply-To: <X/2E2GD/wimgo5Hi@pevik>
References: <20210111123626.28932-1-pvorel@suse.cz>
 <CAEemH2eTEEZVZc71=HF+251t_d7Rnu7XdFY2t54u=ORwY3M-7A@mail.gmail.com>
 <X/2E2GD/wimgo5Hi@pevik>
Message-ID: <CAEemH2cmHrUGx3WXWfh6huNh-sv_GY56A+EvGVj-BiXT3WQ32A@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

Petr Vorel <pvorel@suse.cz> wrote:

> > +
> > > +AC_DEFUN([LTP_CHECK_LIBKEYUTILS], [
> > > +    PKG_CHECK_MODULES([LIBKEYUTILS], [libkeyutils], [
>
>
> > I guess the list-of-modules should be [keyutils-libs] but not
> [libkeyutils]?
> No problem to change that, but can you explain why?
>

From what I understanding, this macro runs the pkg-config tool to check
for the presence of packages against keyutils-libs and sets two variables:
LIBKEYUTILS_CFLAGS, LIBKEYUTILS_LIBS accordingly.

So the list-of-modules should be the precise name(or version) of the
library, am I right?
See: https://autotools.io/pkgconfig/pkg_check_modules.html



> Tested: https://travis-ci.org/github/pevik/ltp/builds/753925166


The reason for test all get passed is the "include/lapi/keyctl.h" has the
second choice to include <linux/keyctl.h> I guess.

#if defined(HAVE_KEYUTILS_H) && defined(HAVE_LIBKEYUTILS)
# include <keyutils.h>
#else
# ifdef HAVE_LINUX_KEYCTL_H
#  include <linux/keyctl.h>
# endif /* HAVE_LINUX_KEYCTL_H */

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210112/188d5d54/attachment.htm>
