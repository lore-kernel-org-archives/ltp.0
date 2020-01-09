From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 9 Jan 2020 13:49:27 +0100
Subject: [LTP] [PATCH] tst_device: use raw syscall in the tst_device.h
In-Reply-To: <CAEemH2eBO5WywEvBJKyEpVCky05CHp-JpwpFUSgAUjTx8GAKtQ@mail.gmail.com>
References: <20200109071510.11223-1-liwang@redhat.com>
 <20200109095239.GB31981@rei.lan>
 <CAEemH2eBO5WywEvBJKyEpVCky05CHp-JpwpFUSgAUjTx8GAKtQ@mail.gmail.com>
Message-ID: <20200109124927.GA22952@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > > diff --git a/testcases/kernel/syscalls/fadvise/posix_fadvise01.c
> > b/testcases/kernel/syscalls/fadvise/posix_fadvise01.c
> > > index 2af040840..f5d7ca8ac 100644
> > > --- a/testcases/kernel/syscalls/fadvise/posix_fadvise01.c
> > > +++ b/testcases/kernel/syscalls/fadvise/posix_fadvise01.c
> > > @@ -20,6 +20,7 @@
> > >   *   None
> > >   */
> > >
> > > +#define _GNU_SOURCE
> > >  #define _XOPEN_SOURCE 600
> > >  #include <fcntl.h>
> >
> > Why do we need the _GNU_SOURCE here? We switched to a syscall() in the
> > header, hence we do not need the syncfs() prototype anymore.
> >
> >
> But shouldn't we define the _GNU_SOURCE for syscall()?  Otherwise,
> the _XOPEN_SOURCE 600 definitions will take effect and makes the compiler
> print new errors[1].
> 
> Here I fee a little confused, or do we need to delete the _XOPEN_SOURCE
> definition directly for the test posix_fadvise01.c?

Sigh, looks like the _XOPEN_SOURCE 600 disables syscall() definition
from being exposed, which is otherwise exposed by default.

Also it looks like things works fine for me when I remove the
_XOPEN_SOURCE 600.

So I guess that we should try to remove the _XOPEN_SOURCE from the
posix_fadvise() tests and try to compile the code on old enough
distribution. If that works we should do it that way.

-- 
Cyril Hrubis
chrubis@suse.cz
