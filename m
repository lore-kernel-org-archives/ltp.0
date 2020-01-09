From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 9 Jan 2020 10:59:40 +0100
Subject: [LTP] [PATCH] tst_device: use raw syscall in the tst_device.h
In-Reply-To: <20200109095239.GB31981@rei.lan>
References: <20200109071510.11223-1-liwang@redhat.com>
 <20200109095239.GB31981@rei.lan>
Message-ID: <20200109095940.GA23230@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril, Li,

> Hi!
> > +#define _GNU_SOURCE
> >  #include <unistd.h>
> > +#include <sys/syscall.h>

> Defining _GNU_SOURCE anywhere but at the top of the test source is
> meaningless. It has to be defined before we include any libc headers
> otherwise it's ignored.

> >  struct tst_device {
> >  	const char *dev;
> > @@ -75,9 +77,9 @@ int tst_detach_device(const char *dev_path);
> >   * simply before the tst_dev_bytes_written invocation. For easy to use,
> >   * we create this inline function tst_dev_sync.
> >   */
> > -static inline void tst_dev_sync(int fd)
> > +static inline int tst_dev_sync(int fd)
> >  {
> > -	syncfs(fd);
> > +	return syscall(__NR_syncfs, fd);
> >  }

> > diff --git a/testcases/kernel/syscalls/fadvise/posix_fadvise01.c b/testcases/kernel/syscalls/fadvise/posix_fadvise01.c

> > +#define _GNU_SOURCE
> >  #define _XOPEN_SOURCE 600
> >  #include <fcntl.h>

> Why do we need the _GNU_SOURCE here? We switched to a syscall() in the
> header, hence we do not need the syncfs() prototype anymore.

Correct, both. Sorry for a complete wrong review.

Kind regards,
Petr
