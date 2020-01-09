From: Li Wang <liwang@redhat.com>
Date: Thu, 9 Jan 2020 20:56:29 +0800
Subject: [LTP] [PATCH] tst_device: use raw syscall in the tst_device.h
In-Reply-To: <20200109124927.GA22952@rei.lan>
References: <20200109071510.11223-1-liwang@redhat.com>
 <20200109095239.GB31981@rei.lan>
 <CAEemH2eBO5WywEvBJKyEpVCky05CHp-JpwpFUSgAUjTx8GAKtQ@mail.gmail.com>
 <20200109124927.GA22952@rei.lan>
Message-ID: <CAEemH2dBSgBvVHf_rRbeKgwoPqsSQoafqo0LPx8qmH9=KMAn_A@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Jan 9, 2020 at 8:49 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > > > diff --git a/testcases/kernel/syscalls/fadvise/posix_fadvise01.c
> > > b/testcases/kernel/syscalls/fadvise/posix_fadvise01.c
> > > > index 2af040840..f5d7ca8ac 100644
> > > > --- a/testcases/kernel/syscalls/fadvise/posix_fadvise01.c
> > > > +++ b/testcases/kernel/syscalls/fadvise/posix_fadvise01.c
> > > > @@ -20,6 +20,7 @@
> > > >   *   None
> > > >   */
> > > >
> > > > +#define _GNU_SOURCE
> > > >  #define _XOPEN_SOURCE 600
> > > >  #include <fcntl.h>
> > >
> > > Why do we need the _GNU_SOURCE here? We switched to a syscall() in the
> > > header, hence we do not need the syncfs() prototype anymore.
> > >
> > >
> > But shouldn't we define the _GNU_SOURCE for syscall()?  Otherwise,
> > the _XOPEN_SOURCE 600 definitions will take effect and makes the compiler
> > print new errors[1].
> >
> > Here I fee a little confused, or do we need to delete the _XOPEN_SOURCE
> > definition directly for the test posix_fadvise01.c?
>
> Sigh, looks like the _XOPEN_SOURCE 600 disables syscall() definition
> from being exposed, which is otherwise exposed by default.
>
> Also it looks like things works fine for me when I remove the
> _XOPEN_SOURCE 600.
>
> So I guess that we should try to remove the _XOPEN_SOURCE from the
> posix_fadvise() tests and try to compile the code on old enough
> distribution. If that works we should do it that way.
>

Ok, I will have a try (remove the _XOPEN_SOURCE) to build it on more
distros. If works fine will send patch v2.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200109/9e1d1ba2/attachment-0001.htm>
